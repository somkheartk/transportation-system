import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shipment_provider.dart';
import '../widgets/shipment_card.dart';
import 'shipment_detail_screen.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({super.key});

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShipmentProvider>().loadShipments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ShipmentProvider>().loadShipments();
            },
          ),
        ],
      ),
      body: Consumer<ShipmentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.shipments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null && provider.shipments.isEmpty) {
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
                    onPressed: () => provider.loadShipments(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.shipments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No shipments found'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadShipments(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.shipments.length,
              itemBuilder: (context, index) {
                final shipment = provider.shipments[index];
                return ShipmentCard(
                  shipment: shipment,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShipmentDetailScreen(shipment: shipment),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create shipment screen
          // For now, show a message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create shipment feature coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
