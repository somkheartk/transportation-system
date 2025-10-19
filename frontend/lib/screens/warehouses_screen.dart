import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/warehouse_provider.dart';
import '../widgets/warehouse_card.dart';

class WarehousesScreen extends StatefulWidget {
  const WarehousesScreen({super.key});

  @override
  State<WarehousesScreen> createState() => _WarehousesScreenState();
}

class _WarehousesScreenState extends State<WarehousesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WarehouseProvider>().loadWarehouses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warehouses & Stores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WarehouseProvider>().loadWarehouses();
            },
          ),
        ],
      ),
      body: Consumer<WarehouseProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.warehouses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null && provider.warehouses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadWarehouses(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.warehouses.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No warehouses found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadWarehouses(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.warehouses.length,
              itemBuilder: (context, index) {
                final warehouse = provider.warehouses[index];
                return WarehouseCard(warehouse: warehouse);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create warehouse feature coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
