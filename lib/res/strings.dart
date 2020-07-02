class Ids {
  static const String titleHome = 'title_home';
  static const String titleSetting = 'title_setting';
  static const String titleBlog = 'title_blog';
  static const String titleTheme = 'title_theme';
  static const String titleLanguage = 'title_language';
  static const String titleAbout = 'title_about';
  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageEN = 'language_en';
  static const String save = 'save';
}

Map<String, Map<String, String>> localizedSimpleValues = {
  'en' :{
    Ids.titleHome: 'Home',
    Ids.titleSetting: 'Setting',
    Ids.titleBlog: 'Blog',
    Ids.titleTheme: 'Theme',
    Ids.titleLanguage: 'Language',
    Ids.languageAuto: 'Auto',
    Ids.save: 'Save',
    Ids.titleAbout: 'About',
  },
  'zh': {
    Ids.titleHome: '主页',
    Ids.titleSetting: '设置',
    Ids.titleBlog: '博客',
    Ids.titleTheme: '主题',
    Ids.titleLanguage: '语言',
    Ids.languageAuto: '跟随系统',
    Ids.languageZH: '简体中文',
    Ids.languageEN: 'English',
    Ids.save: '保存',
    Ids.titleAbout: '关于',
  }
};