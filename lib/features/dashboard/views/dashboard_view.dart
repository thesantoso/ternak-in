import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Get.snackbar('Notifications', 'No new notifications');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refresh,
          child: CustomScrollView(
            slivers: [
              // Summary Cards
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              title: 'Total',
                              value: controller.totalCount.toString(),
                              icon: Icons.pets,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _SummaryCard(
                              title: 'Healthy',
                              value: controller.healthyCount.toString(),
                              icon: Icons.favorite,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Filter Chips
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Obx(() => Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        isSelected: controller.selectedFilter.value == 'All',
                        onSelected: () => controller.setFilter('All'),
                      ),
                      _FilterChip(
                        label: 'Cattle',
                        isSelected: controller.selectedFilter.value == 'Cattle',
                        onSelected: () => controller.setFilter('Cattle'),
                      ),
                      _FilterChip(
                        label: 'Goat',
                        isSelected: controller.selectedFilter.value == 'Goat',
                        onSelected: () => controller.setFilter('Goat'),
                      ),
                      _FilterChip(
                        label: 'Chicken',
                        isSelected: controller.selectedFilter.value == 'Chicken',
                        onSelected: () => controller.setFilter('Chicken'),
                      ),
                      _FilterChip(
                        label: 'Sheep',
                        isSelected: controller.selectedFilter.value == 'Sheep',
                        onSelected: () => controller.setFilter('Sheep'),
                      ),
                    ],
                  )),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Livestock List
              Obx(() {
                final filtered = controller.filteredLivestock;
                if (filtered.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No livestock found'),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = filtered[index];
                      return _LivestockCard(livestock: item);
                    },
                    childCount: filtered.length,
                  ),
                );
              }),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        );
      }),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Icon(icon, color: color, size: 24),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(),
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
        checkmarkColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _LivestockCard extends StatelessWidget {
  final dynamic livestock;

  const _LivestockCard({required this.livestock});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    
    Color healthColor;
    switch (livestock.health) {
      case 'Excellent':
        healthColor = Colors.green;
        break;
      case 'Good':
        healthColor = Colors.lightGreen;
        break;
      case 'Fair':
        healthColor = Colors.orange;
        break;
      default:
        healthColor = Colors.red;
    }

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            _getAnimalIcon(livestock.type),
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          livestock.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Count: ${livestock.count}'),
            const SizedBox(height: 2),
            Row(
              children: [
                Text('Health: '),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: healthColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    livestock.health,
                    style: TextStyle(
                      color: healthColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Last checkup: ${dateFormat.format(livestock.lastCheckup)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Get.snackbar(
            'Livestock Details',
            'Viewing ${livestock.name}',
          );
        },
      ),
    );
  }

  IconData _getAnimalIcon(String type) {
    switch (type.toLowerCase()) {
      case 'cattle':
        return Icons.pets;
      case 'goat':
        return Icons.pets;
      case 'chicken':
        return Icons.egg;
      case 'sheep':
        return Icons.pets;
      default:
        return Icons.pets;
    }
  }
}
