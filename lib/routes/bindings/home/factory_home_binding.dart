import 'package:get/get.dart';

class FactoryHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FactoryHomeBinding>(() => FactoryHomeBinding());
  }
}
