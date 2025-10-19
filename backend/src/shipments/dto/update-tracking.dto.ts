import { IsString, IsNotEmpty, IsDateString, IsOptional } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class UpdateTrackingDto {
  @ApiProperty({ description: 'Current location of the shipment' })
  @IsString()
  @IsNotEmpty()
  location: string;

  @ApiProperty({ description: 'Timestamp of the tracking update' })
  @IsDateString()
  @IsNotEmpty()
  timestamp: Date;

  @ApiPropertyOptional({ description: 'Notes about this tracking update' })
  @IsString()
  @IsOptional()
  notes?: string;
}
