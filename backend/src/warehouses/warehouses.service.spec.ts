import { Test, TestingModule } from '@nestjs/testing';
import { getModelToken } from '@nestjs/mongoose';
import { WarehousesService } from './warehouses.service';
import { Warehouse } from './schemas/warehouse.schema';

describe('WarehousesService', () => {
  let service: WarehousesService;

  const mockWarehouseModel = {
    new: jest.fn(),
    constructor: jest.fn(),
    find: jest.fn(),
    findById: jest.fn(),
    findOne: jest.fn(),
    findByIdAndUpdate: jest.fn(),
    findByIdAndDelete: jest.fn(),
    create: jest.fn(),
    save: jest.fn(),
    exec: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        WarehousesService,
        {
          provide: getModelToken(Warehouse.name),
          useValue: mockWarehouseModel,
        },
      ],
    }).compile();

    service = module.get<WarehousesService>(WarehousesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
