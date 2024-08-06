import 'package:expenditure_management/language/en_language.dart';
import 'package:expenditure_management/language/vi_language.dart';
import 'package:expenditure_management/language/zh_language.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': ZhLanguage().zhLanguage,
        'en_US': EnLanguage().enLanguage,
        'vi_VN': ViLanguage().viLanguage,
      };
}
