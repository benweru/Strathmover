import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/user_model.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../widgets/widgets.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  Future<Map<String, int>> fetchCounts() async {
    final usersSnapshot = await FirebaseFirestore.instance.collection('Users').get();
    final busesSnapshot = await FirebaseFirestore.instance.collection('buses').get();
    final routesSnapshot = await FirebaseFirestore.instance.collection('routes').get();

    return {
      'totalUsers': usersSnapshot.size,
      'totalBuses': busesSnapshot.size,
      'totalRoutes': routesSnapshot.size,
    };
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return ContentView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Dashboard',
            description: 'A summary of key data.',
          ),
          const Gap(16),
          FutureBuilder<Map<String, int>>(
            future: fetchCounts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              }

              final counts = snapshot.data!;
              final summaryCards = [
                SummaryCard(title: 'Total Users', value: counts['totalUsers'].toString()),
                SummaryCard(title: 'Total Buses', value: counts['totalBuses'].toString()),
                SummaryCard(title: 'Total Routes', value: counts['totalRoutes'].toString()),
              ];

              if (responsive.isMobile) {
                return Column(
                  children: summaryCards
                );
              } else {
                return Row(
                  children: summaryCards
                      .map<Widget>((card) => Expanded(child: card))
                      .intersperse(const Gap(16))
                      .toList(),
                );
              }
            },
          ),
          const Gap(16),
          const Expanded(
            child: _TableView(),
          ),
        ],
      ),
    );
  }
}

class _TableView extends StatelessWidget {
  const _TableView();

  Future<List<UserModel>> fetchUsers() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Users').get();
    final users = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    print("Fetched ${users.length} users");
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final decoration = TableSpanDecoration(
      border: TableSpanBorder(
        trailing: BorderSide(color: theme.dividerColor),
      ),
    );

    return FutureBuilder<List<UserModel>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final users = snapshot.data!;

        return Card(
          clipBehavior: Clip.antiAlias,
          child: TableView.builder(
            columnCount: 3,  // Adjusted to 3 columns: Email, Full Name, Phone
            rowCount: users.length + 1,
            pinnedRowCount: 1,
            pinnedColumnCount: 1,
            columnBuilder: (index) {
              return TableSpan(
                foregroundDecoration: index == 0 ? decoration : null,
                extent: const FractionalTableSpanExtent(1 / 3),
              );
            },
            rowBuilder: (index) {
              return TableSpan(
                foregroundDecoration: index == 0 ? decoration : null,
                extent: const FixedTableSpanExtent(50),
              );
            },
            cellBuilder: (context, vicinity) {
              final isStickyHeader = vicinity.xIndex == 0 || vicinity.yIndex == 0;
              var label = '';
              if (vicinity.yIndex == 0) {
                switch (vicinity.xIndex) {
                  case 0:
                    label = 'Email';
                    break;
                  case 1:
                    label = 'Full Name';
                    break;
                  case 2:
                    label = 'Phone';
                    break;
                }
              } else {
                final user = users[vicinity.yIndex - 1];
                switch (vicinity.xIndex) {
                  case 0:
                    label = user.email;
                    break;
                  case 1:
                    label = user.fullName;
                    break;
                  case 2:
                    label = user.phoneNo;
                    break;
                }
              }
              return TableViewCell(
                child: ColoredBox(
                  color: isStickyHeader ? Colors.transparent : colorScheme.surface,
                  child: Center(
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontWeight: isStickyHeader ? FontWeight.w600 : null,
                            color: isStickyHeader ? null : colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
