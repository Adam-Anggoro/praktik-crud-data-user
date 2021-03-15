import 'dart:convert';

import 'package:data_user/model/user_model.dart';
import 'package:data_user/pages/form_add_user.dart';
import 'package:data_user/widget/widget_data_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<UserModel> listUser = [];
  getListUser() async {
    listUser.clear();
    final response =
        await http.get("http://192.168.43.3/data_users/get_data_user.php");
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map item in data) {
          listUser.add(UserModel.fromJson(item));
        }
      });
    }
  }

  Future<void> refresh() async {
    return getListUser();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getListUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplikasi CRUD User"),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
              child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Data User"),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return FormAddUser(refresh);
                    }));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Tambah Data"),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                final x = listUser[index];
                return DataUser(
                  idUser: x.userID,
                  name: x.name,
                  email: x.email,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
