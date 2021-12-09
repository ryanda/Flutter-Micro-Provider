import 'package:flutter/material.dart';
import 'package:micro/obj.dart';
import 'package:micro/providers/user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    this._fetchUser();
  }

  _fetchUser() async {
    Provider.of<UserState>(context, listen: false).fetchUser();
  }

  Widget _userInfo() {
    return Consumer<UserState>(builder: (context, val, child) {
      if (val.userStatus == UserStatus.none) return Text("Empty User");

      if (val.userStatus == UserStatus.fetching)
        return CircularProgressIndicator();

      if (val.userStatus == UserStatus.done) {
        User user = val.user!;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.firstName),
            Text(user.lastName),
            Text(user.email),
          ],
        );
      }
      return Text("Alternative state: " + val.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                this._fetchUser();
              },
              child: Text("fetch user!"),
            ),
            this._userInfo(),
          ],
        ),
      ),
    );
  }
}
