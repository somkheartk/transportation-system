import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Shipment, ShipmentDocument } from './schemas/shipment.schema';
import { CreateShipmentDto } from './dto/create-shipment.dto';
import { UpdateShipmentDto } from './dto/update-shipment.dto';
import { UpdateTrackingDto } from './dto/update-tracking.dto';

@Injectable()
export class ShipmentsService {
  constructor(
    @InjectModel(Shipment.name) private shipmentModel: Model<ShipmentDocument>,
  ) {}

  async create(createShipmentDto: CreateShipmentDto): Promise<Shipment> {
    const createdShipment = new this.shipmentModel(createShipmentDto);
    return createdShipment.save();
  }

  async findAll(): Promise<Shipment[]> {
    return this.shipmentModel
      .find()
      .populate('destinationWarehouse')
      .sort({ createdAt: -1 })
      .exec();
  }

  async findOne(id: string): Promise<Shipment> {
    const shipment = await this.shipmentModel
      .findById(id)
      .populate('destinationWarehouse')
      .exec();
    if (!shipment) {
      throw new NotFoundException(`Shipment with ID ${id} not found`);
    }
    return shipment;
  }

  async findByTrackingNumber(trackingNumber: string): Promise<Shipment> {
    const shipment = await this.shipmentModel
      .findOne({ trackingNumber })
      .populate('destinationWarehouse')
      .exec();
    if (!shipment) {
      throw new NotFoundException(
        `Shipment with tracking number ${trackingNumber} not found`,
      );
    }
    return shipment;
  }

  async update(id: string, updateShipmentDto: UpdateShipmentDto): Promise<Shipment> {
    const updatedShipment = await this.shipmentModel
      .findByIdAndUpdate(id, updateShipmentDto, { new: true })
      .populate('destinationWarehouse')
      .exec();
    if (!updatedShipment) {
      throw new NotFoundException(`Shipment with ID ${id} not found`);
    }
    return updatedShipment;
  }

  async updateTracking(id: string, updateTrackingDto: UpdateTrackingDto): Promise<Shipment> {
    const shipment = await this.shipmentModel.findById(id);
    if (!shipment) {
      throw new NotFoundException(`Shipment with ID ${id} not found`);
    }

    if (!shipment.trackingHistory) {
      shipment.trackingHistory = [];
    }

    shipment.trackingHistory.push({
      location: updateTrackingDto.location,
      timestamp: updateTrackingDto.timestamp,
      notes: updateTrackingDto.notes || '',
    });

    return shipment.save();
  }

  async remove(id: string): Promise<void> {
    const result = await this.shipmentModel.findByIdAndDelete(id).exec();
    if (!result) {
      throw new NotFoundException(`Shipment with ID ${id} not found`);
    }
  }
}
