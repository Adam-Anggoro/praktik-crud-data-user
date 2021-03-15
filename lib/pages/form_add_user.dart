import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormAddUser extends StatefulWidget {
  final VoidCallback method;
  FormAddUser(this.method);
  @override
  _FormAddUserState createState() => _FormAddUserState();
}

class _FormAddUserState extends State<FormAddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  submit() async {
    final response = await http
        .post("http://192.168.43.3/data_users/add_data_user.php", body: {
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Information ... "),
                content: Text(message),
                actions: [FlatButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  widget.method();
                }, child: Text("Ok"))],
              );
            });
      });
    } else {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Warning ... "),
                content: Text(message),
                actions: [FlatButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Ok"))],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Add User"),),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 6),
                  child: Text(
                      "Enter name, phone, and active email to add data users"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 6),
                  child: Text("Full Name"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Full Name",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 6),
                  child: Text("Email Address"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Email Address",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 6),
                  child: Text("Number Phone"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Number Phone",
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(24, 16, 24, 6),
                  child: Text("Address"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextField(
                    maxLines: 3,
                    controller: addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Address",
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          submit();
                        });
                      },
                      child: Text("SUBMIT"),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
