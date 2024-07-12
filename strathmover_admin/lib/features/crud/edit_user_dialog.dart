import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/models/user_model.dart';
import 'package:flutter_admin_dashboard_template/services/firestore_service.dart';
import 'package:provider/provider.dart';

class EditUserDialog extends StatefulWidget {
  final UserModel user;

  const EditUserDialog({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _fullName;
  late String _email;
  late String _phoneNo;
  late String _profilePicture;

  @override
  void initState() {
    super.initState();
    _fullName = widget.user.fullName;
    _email = widget.user.email;
    _phoneNo = widget.user.phoneNo;
    _profilePicture = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return AlertDialog(
      title: Text('Edit User'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _fullName,
              decoration: InputDecoration(labelText: 'Full Name'),
              onSaved: (value) => _fullName = value!,
              validator: (value) => value!.isEmpty ? 'Full Name is required' : null,
            ),
            TextFormField(
              initialValue: _email,
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value!,
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
            ),
            TextFormField(
              initialValue: _phoneNo,
              decoration: InputDecoration(labelText: 'Phone Number'),
              onSaved: (value) => _phoneNo = value!,
              validator: (value) => value!.isEmpty ? 'Phone Number is required' : null,
            ),
            TextFormField(
              initialValue: _profilePicture,
              decoration: InputDecoration(labelText: 'Profile Picture URL'),
              onSaved: (value) => _profilePicture = value!,
              validator: (value) => value!.isEmpty ? 'Profile Picture URL is required' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final updatedUser = widget.user.copyWith(
                fullName: _fullName,
                email: _email,
                phoneNo: _phoneNo,
                profilePicture: _profilePicture,
              );
              await firestoreService.updateUser(updatedUser);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
