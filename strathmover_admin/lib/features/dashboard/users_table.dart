import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_dashboard_template/models/user_model.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({Key? key}) : super(key: key);

  Future<List<UserModel>> fetchUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    final users = snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
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
