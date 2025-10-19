import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { ShipmentsService } from './shipments.service';
import { CreateShipmentDto } from './dto/create-shipment.dto';
import { UpdateShipmentDto } from './dto/update-shipment.dto';
import { UpdateTrackingDto } from './dto/update-tracking.dto';

@ApiTags('shipments')
@Controller('shipments')
export class ShipmentsController {
  constructor(private readonly shipmentsService: ShipmentsService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new shipment' })
  @ApiResponse({ status: 201, description: 'Shipment created successfully' })
  create(@Body() createShipmentDto: CreateShipmentDto) {
    return this.shipmentsService.create(createShipmentDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all shipments' })
  @ApiResponse({ status: 200, description: 'List of all shipments' })
  findAll() {
    return this.shipmentsService.findAll();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get shipment by ID' })
  @ApiResponse({ status: 200, description: 'Shipment found' })
  @ApiResponse({ status: 404, description: 'Shipment not found' })
  findOne(@Param('id') id: string) {
    return this.shipmentsService.findOne(id);
  }

  @Get('tracking/:trackingNumber')
  @ApiOperation({ summary: 'Get shipment by tracking number' })
  @ApiResponse({ status: 200, description: 'Shipment found' })
  @ApiResponse({ status: 404, description: 'Shipment not found' })
  findByTrackingNumber(@Param('trackingNumber') trackingNumber: string) {
    return this.shipmentsService.findByTrackingNumber(trackingNumber);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update shipment' })
  @ApiResponse({ status: 200, description: 'Shipment updated successfully' })
  @ApiResponse({ status: 404, description: 'Shipment not found' })
  update(
    @Param('id') id: string,
    @Body() updateShipmentDto: UpdateShipmentDto,
  ) {
    return this.shipmentsService.update(id, updateShipmentDto);
  }

  @Patch(':id/tracking')
  @ApiOperation({ summary: 'Add tracking update to shipment' })
  @ApiResponse({ status: 200, description: 'Tracking updated successfully' })
  @ApiResponse({ status: 404, description: 'Shipment not found' })
  updateTracking(
    @Param('id') id: string,
    @Body() updateTrackingDto: UpdateTrackingDto,
  ) {
    return this.shipmentsService.updateTracking(id, updateTrackingDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete shipment' })
  @ApiResponse({ status: 204, description: 'Shipment deleted successfully' })
  @ApiResponse({ status: 404, description: 'Shipment not found' })
  remove(@Param('id') id: string) {
    return this.shipmentsService.remove(id);
  }
}
