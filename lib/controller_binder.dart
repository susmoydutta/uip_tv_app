import 'package:get/get.dart';
import 'package:uip_tv_app/domain/controller/user_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(UipController());
  }
}
