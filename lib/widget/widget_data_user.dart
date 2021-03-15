import 'package:flutter/material.dart';

class DataUser extends StatelessWidget {
  final String idUser;
  final String name;
  final String email;

  DataUser({
    this.idUser = "",
    this.name = "name",
    this.email = "email",
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID.0" +idUser),
            SizedBox(
              height: 8,
            ),
            Text(name),
            SizedBox(
              height: 8,
            ),
            Text(email),
          ],
        ),
      ),
    );
  }
}
