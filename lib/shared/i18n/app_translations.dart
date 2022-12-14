import 'package:get/get_navigation/src/root/internacionalization.dart';

import '/shared/i18n/en.dart';
import '/shared/i18n/vi.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enEN,
        'vi_VN': viVN,
      };
}
