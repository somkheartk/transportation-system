import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Warehouse, WarehouseDocument } from './schemas/warehouse.schema';
import { CreateWarehouseDto } from './dto/create-warehouse.dto';
import { UpdateWarehouseDto } from './dto/update-warehouse.dto';

@Injectable()
export class WarehousesService {
  constructor(
    @InjectModel(Warehouse.name)
    private warehouseModel: Model<WarehouseDocument>,
  ) {}

  async create(createWarehouseDto: CreateWarehouseDto): Promise<Warehouse> {
    const createdWarehouse = new this.warehouseModel(createWarehouseDto);
    return createdWarehouse.save();
  }

  async findAll(): Promise<Warehouse[]> {
    return this.warehouseModel.find().sort({ createdAt: -1 }).exec();
  }

  async findOne(id: string): Promise<Warehouse> {
    const warehouse = await this.warehouseModel.findById(id).exec();
    if (!warehouse) {
      throw new NotFoundException(`Warehouse with ID ${id} not found`);
    }
    return warehouse;
  }

  async findActive(): Promise<Warehouse[]> {
    return this.warehouseModel
      .find({ isActive: true })
      .sort({ name: 1 })
      .exec();
  }

  async update(
    id: string,
    updateWarehouseDto: UpdateWarehouseDto,
  ): Promise<Warehouse> {
    const updatedWarehouse = await this.warehouseModel
      .findByIdAndUpdate(id, updateWarehouseDto, { new: true })
      .exec();
    if (!updatedWarehouse) {
      throw new NotFoundException(`Warehouse with ID ${id} not found`);
    }
    return updatedWarehouse;
  }

  async remove(id: string): Promise<void> {
    const result = await this.warehouseModel.findByIdAndDelete(id).exec();
    if (!result) {
      throw new NotFoundException(`Warehouse with ID ${id} not found`);
    }
  }
}
