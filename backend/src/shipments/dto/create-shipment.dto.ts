import {
  IsString,
  IsNotEmpty,
  IsNumber,
  IsEnum,
  IsOptional,
  IsDateString,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { ShipmentStatus } from '../schemas/shipment.schema';

export class CreateShipmentDto {
  @ApiProperty({ description: 'Tracking number for the shipment' })
  @IsString()
  @IsNotEmpty()
  trackingNumber: string;

  @ApiProperty({ description: 'Name of the sender' })
  @IsString()
  @IsNotEmpty()
  senderName: string;

  @ApiProperty({ description: 'Address of the sender' })
  @IsString()
  @IsNotEmpty()
  senderAddress: string;

  @ApiProperty({ description: 'Phone number of the sender' })
  @IsString()
  @IsNotEmpty()
  senderPhone: string;

  @ApiProperty({ description: 'Name of the receiver' })
  @IsString()
  @IsNotEmpty()
  receiverName: string;

  @ApiProperty({ description: 'Address of the receiver' })
  @IsString()
  @IsNotEmpty()
  receiverAddress: string;

  @ApiProperty({ description: 'Phone number of the receiver' })
  @IsString()
  @IsNotEmpty()
  receiverPhone: string;

  @ApiPropertyOptional({ description: 'ID of the destination warehouse' })
  @IsString()
  @IsOptional()
  destinationWarehouse?: string;

  @ApiProperty({ description: 'Description of the items being shipped' })
  @IsString()
  @IsNotEmpty()
  itemDescription: string;

  @ApiProperty({ description: 'Weight of the shipment in kg' })
  @IsNumber()
  @IsNotEmpty()
  weight: number;

  @ApiProperty({ description: 'Quantity of items' })
  @IsNumber()
  @IsNotEmpty()
  quantity: number;

  @ApiPropertyOptional({
    description: 'Status of the shipment',
    enum: ShipmentStatus,
  })
  @IsEnum(ShipmentStatus)
  @IsOptional()
  status?: ShipmentStatus;

  @ApiPropertyOptional({ description: 'Estimated delivery date' })
  @IsDateString()
  @IsOptional()
  estimatedDeliveryDate?: Date;

  @ApiPropertyOptional({ description: 'Additional notes' })
  @IsString()
  @IsOptional()
  notes?: string;
}
