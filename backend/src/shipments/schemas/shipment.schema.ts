import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

export type ShipmentDocument = Shipment & Document;

export enum ShipmentStatus {
  PENDING = 'pending',
  IN_TRANSIT = 'in_transit',
  DELIVERED = 'delivered',
  CANCELLED = 'cancelled',
}

@Schema({ timestamps: true })
export class Shipment {
  @Prop({ required: true })
  trackingNumber: string;

  @Prop({ required: true })
  senderName: string;

  @Prop({ required: true })
  senderAddress: string;

  @Prop({ required: true })
  senderPhone: string;

  @Prop({ required: true })
  receiverName: string;

  @Prop({ required: true })
  receiverAddress: string;

  @Prop({ required: true })
  receiverPhone: string;

  @Prop({ type: Types.ObjectId, ref: 'Warehouse' })
  destinationWarehouse: Types.ObjectId;

  @Prop({ required: true })
  itemDescription: string;

  @Prop({ required: true })
  weight: number;

  @Prop({ required: true })
  quantity: number;

  @Prop({ required: true, enum: ShipmentStatus, default: ShipmentStatus.PENDING })
  status: ShipmentStatus;

  @Prop()
  estimatedDeliveryDate: Date;

  @Prop()
  actualDeliveryDate: Date;

  @Prop({ type: [{ location: String, timestamp: Date, notes: String }] })
  trackingHistory: Array<{
    location: string;
    timestamp: Date;
    notes: string;
  }>;

  @Prop()
  notes: string;
}

export const ShipmentSchema = SchemaFactory.createForClass(Shipment);
