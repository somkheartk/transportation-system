import {
  IsString,
  IsNotEmpty,
  IsEnum,
  IsOptional,
  IsBoolean,
  IsNumber,
  IsObject,
} from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { WarehouseType } from '../schemas/warehouse.schema';

export class CreateWarehouseDto {
  @ApiProperty({ description: 'Name of the warehouse or store' })
  @IsString()
  @IsNotEmpty()
  name: string;

  @ApiProperty({ description: 'Address of the warehouse' })
  @IsString()
  @IsNotEmpty()
  address: string;

  @ApiProperty({ description: 'City where the warehouse is located' })
  @IsString()
  @IsNotEmpty()
  city: string;

  @ApiProperty({ description: 'Province where the warehouse is located' })
  @IsString()
  @IsNotEmpty()
  province: string;

  @ApiProperty({ description: 'Postal code' })
  @IsString()
  @IsNotEmpty()
  postalCode: string;

  @ApiProperty({ description: 'Contact phone number' })
  @IsString()
  @IsNotEmpty()
  phone: string;

  @ApiPropertyOptional({ description: 'Contact email' })
  @IsString()
  @IsOptional()
  email?: string;

  @ApiPropertyOptional({ description: 'Type of facility', enum: WarehouseType })
  @IsEnum(WarehouseType)
  @IsOptional()
  type?: WarehouseType;

  @ApiPropertyOptional({ description: 'GPS coordinates of the warehouse' })
  @IsObject()
  @IsOptional()
  coordinates?: {
    lat: number;
    lng: number;
  };

  @ApiPropertyOptional({ description: 'Whether the warehouse is active' })
  @IsBoolean()
  @IsOptional()
  isActive?: boolean;

  @ApiPropertyOptional({ description: 'Storage capacity' })
  @IsNumber()
  @IsOptional()
  capacity?: number;

  @ApiPropertyOptional({ description: 'Name of the warehouse manager' })
  @IsString()
  @IsOptional()
  manager?: string;

  @ApiPropertyOptional({ description: 'Additional notes' })
  @IsString()
  @IsOptional()
  notes?: string;
}
