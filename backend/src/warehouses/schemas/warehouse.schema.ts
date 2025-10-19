import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type WarehouseDocument = Warehouse & Document;

export enum WarehouseType {
  WAREHOUSE = 'warehouse',
  STORE = 'store',
  DISTRIBUTION_CENTER = 'distribution_center',
}

@Schema({ timestamps: true })
export class Warehouse {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  address: string;

  @Prop({ required: true })
  city: string;

  @Prop({ required: true })
  province: string;

  @Prop({ required: true })
  postalCode: string;

  @Prop({ required: true })
  phone: string;

  @Prop()
  email: string;

  @Prop({
    required: true,
    enum: WarehouseType,
    default: WarehouseType.WAREHOUSE,
  })
  type: WarehouseType;

  @Prop({ type: { lat: Number, lng: Number } })
  coordinates: {
    lat: number;
    lng: number;
  };

  @Prop({ default: true })
  isActive: boolean;

  @Prop()
  capacity: number;

  @Prop()
  manager: string;

  @Prop()
  notes: string;
}

export const WarehouseSchema = SchemaFactory.createForClass(Warehouse);
