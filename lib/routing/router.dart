import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web/estrus/estrus_barchart_scroll.dart';
import 'package:flutter_web/estrus/estrus_page.dart';
import 'package:flutter_web/overlay/camera_overlay_maternity.dart';
import 'package:flutter_web/overlay/camera_overlay_pregnant.dart';
import 'package:flutter_web/page/graph_page.dart';
import 'package:flutter_web/page/maternity_list_page.dart';
import 'package:flutter_web/page/pregnant_list_page.dart';
import 'package:flutter_web/routing/route_names.dart';
import 'package:flutter_web/views/pages/baseform.dart';
import 'package:flutter_web/views/chats/chat_view.dart';
import 'package:flutter_web/views/pages/forget_view.dart';
import 'package:flutter_web/views/pages/home_view.dart';
import 'package:flutter_web/views/pages/login_view.dart';
import 'package:flutter_web/views/pages/profile_update.dart';
import 'package:flutter_web/views/pages/register_view.dart';
import 'package:flutter_web/views/pages/result_view.dart';
import 'package:flutter_web/views/pages/user_list.dart';
import 'package:flutter_web/views/pages/test_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controllers/chat_controller.dart';
import '../controllers/login_controller.dart';
import 'package:get/get.dart' hide Response;

import '../views/pages/login_fail_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomeView());
    case LoginRoute:
      return _getPageRoute(LoginView());
    case LoginFailRoute:
      return _getPageRoute(LoginFailView());
    case UserListRoute:
      return _getPageRoute(UserList());
    case ForgetRoute:
      return _getPageRoute(ForgetView());
    case ProfileUpdateRoute:
      return _getPageRoute(ProfileUpdate());
    case BaseFormRoute:
      return _getPageRoute(BaseForm());
    case ChatRoute:
      return _getPageRoute(checkAuth());
    case RegisterRoute:
      return _getPageRoute(RegisterView());
    case ResultRoute:
      return _getPageRoute(ResultView());
    case EstrusPiechartRoute:
      return _getPageRoute(EstrusPage());
    case EstrusBarchartViewRoute:
      return _getPageRoute(EstrusBarchartScroll());
    case OcrApiRoute:
      return _getPageRoute(ocrCheckAuth());
    case OcrGraphRoute:
      return _getPageRoute(GraphPage());
    case OcrPreRoute:
      return _getPageRoute(CameraOverlayPregnant());
    case OcrPreListRoute:
      return _getPageRoute(PregnantListPage());
    case OcrMatRoute:
      return _getPageRoute(CameraOverlayMaternity());
    case OcrMatListRoute:
      return _getPageRoute(MaternityListPage());
    case TestViewRoute:
      return _getPageRoute(TestView());
    case LogoutRoute:
      ChatController chatController = Get.find();
      chatController.clearChatData();
      return
        _getPageRoute(HomeView());
    default:
      return _getPageRoute(HomeView());

  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({required this.child})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => child,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}

Widget checkAuth() {
  LoginController loginController = Get.find();
  if(loginController.myInfo.value.email == null) {
    Fluttertoast.showToast(
        msg: "????????? ??? ?????? ?????? ?????????.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: 16.0
    );
    return LoginView(returnPage: ChatRoute);
  } else {
    // ????????? ??? ??? ????????? ?????? ??????
    ChatController chatController = Get.find();
    chatController.memberList();
    chatController.getRooms();
    return ChatView();
  }
}

Widget ocrCheckAuth() {
  LoginController loginController = Get.find();
  if(loginController.myInfo.value.email == null) {
    Fluttertoast.showToast(
        msg: "????????? ??? ?????? ?????? ?????????.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        fontSize: 16.0
    );
    return LoginView(returnPage: OcrApiRoute);
  } else {
    return HomeView();
  }
}