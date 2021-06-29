import 'package:get/get.dart';
import 'package:todoapp/src/modul/auth/controller/auth_controller.dart';
import 'package:todoapp/src/modul/user/model/user_model.dart';
import 'package:todoapp/src/services/fireDB.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel().obs; //Observable

//Getter

  UserModel get user => _userModel.value;

//Setter
  set user(UserModel userVal) => this._userModel.value = userVal;

  getUser() async {
    var fireuser = Get.find<AuthController>().user;
    if (fireuser != null) {
      this.user = await FireDb().getUser(fireuser.uid);
      //this._userModel.value = await FireDb().getUser(fireuser.uid);
    }
  }

//ClearModal
  void clear() {
    _userModel.value = UserModel();
  }
}