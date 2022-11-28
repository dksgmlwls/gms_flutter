import 'package:flutter/material.dart';
import 'package:flutter_web/controllers/login_controller.dart';
import 'package:flutter_web/locator.dart';
import 'package:flutter_web/model/user_model.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/services/navigation_service.dart';
import 'package:get/get.dart' hide Response;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutView extends StatelessWidget {
  String? returnPage;

  LogoutView({Key? key, this.returnPage=HomeRoute}) : super(key: key);

  // LoginController controller = Get.find();
  final controller = Get.put(LoginController());
  // final LoginController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: buildLogoutBtn(),
      ),

    );
  }

  Widget buildLogoutBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      height: 50,
      child: ElevatedButton.icon(
          onPressed: () async{
            LoginController loginController = Get.find();
            loginController.myInfo.value = User();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            locator<NavigationService>().navigateTo(HomeRoute);
          },
          icon: Icon(Icons.login),
          label: Text("Logout")
      ),
    );
  }

  Widget buildForgotPassBtn(){
    return Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => {
                locator<NavigationService>().navigateTo(RegisterRoute)
              },
              child: Text(
                "Register?",
                style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => {
                locator<NavigationService>().navigateTo(ForgetRoute)
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ]
    );
  }
}
