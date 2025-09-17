import 'package:ecommerce_app/features/home/presentations/bloc/dashboard_bloc.dart';
import 'package:ecommerce_app/features/home/presentations/bloc/dashboard_event.dart';
import 'package:ecommerce_app/features/home/presentations/bloc/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()..add(LoadDashboard()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            const CircleAvatar(
              // backgroundImage: AssetImage('assets/admin_avatar.png'),
            ),
            const SizedBox(width: 16),
          ],
        ),
        drawer: _buildDrawer(context),
        body: const _DashboardBody(),
      ),
    );
  }
}

Drawer _buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            'Admin Menu',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.dashboard),
          title: const Text('Dashboard'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text('Users'),
          onTap: () => Navigator.pushNamed(context, '/users'),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    ),
  );
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final adminActions = <DashboardItem>[
          DashboardItem(
            title: 'Add Product',
            icon: Icons.add_box,
            color: Colors.blue,
            onTap: () => Navigator.pushNamed(context, '/add-product'),
          ),
          DashboardItem(
            title: 'Add Category',
            icon: Icons.category,
            color: Colors.green,
            onTap: () => Navigator.pushNamed(context, '/add-category'),
          ),  
          DashboardItem(
            title: 'Add Brand',
            icon: Icons.branding_watermark,
            color: Colors.orange,
            onTap: () => Navigator.pushNamed(context, '/add-brand'),
          ),
          DashboardItem(
            title: 'Add Specification',
            icon: Icons.list_alt,
            color: Colors.purple,
            onTap: () => Navigator.pushNamed(context, '/add-specification'),
          ),
          DashboardItem(
            title: 'View Orders',
            icon: Icons.shopping_cart,
            color: Colors.red,
            onTap: () => Navigator.pushNamed(context, '/orders'),
          ),
        ];

        switch (state) {
          case DashboardLoading():
            return const Center(child: CircularProgressIndicator());
          case DashboardLoaded():
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Admin Action Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // int crossAxisCount;
                      // if (constraints.maxWidth > 1200) {
                      //   crossAxisCount = 4;
                      // } else if (constraints.maxWidth > 800) {
                      //   crossAxisCount = 3;
                      // } else {
                      //   crossAxisCount = 2;
                      // }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: adminActions.length,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250, // Max width per card
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                            itemBuilder: (context, index) {
                              final item = adminActions[index];
                              return DashboardCard(item: item);
                            },
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Recent Activity Table
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('User')),
                        DataColumn(label: Text('Action')),
                        DataColumn(label: Text('Date')),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            const DataCell(Text('John Doe')),
                            const DataCell(Text('Logged In')),
                            DataCell(Text(DateTime.now().toString())),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text('Alice Smith')),
                            const DataCell(Text('Purchased Plan')),
                            DataCell(Text(DateTime.now().toString())),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case DashboardError():
            final error = state;
            return Center(child: Text('Error: ${error.message}'));
        }
        return const SizedBox();
      },
    );
  }
}

/// Dashboard Item Model
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

/// Dashboard Card Widget
class DashboardCard extends StatelessWidget {
  final DashboardItem item;

  const DashboardCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: item.color.withOpacity(0.15),
                child: Icon(item.icon, color: item.color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
