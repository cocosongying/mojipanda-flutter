class Ids {
  static const String titleHome = 'title_home';
  static const String titleSetting = 'title_setting';
  static const String titleBlog = 'title_blog';
  static const String titleTheme = 'title_theme';
  static const String titleLanguage = 'title_language';
  static const String titleAbout = 'title_about';
  static const String checkUpdate = 'check_update';
  static const String languageAuto = 'language_auto';
  static const String languageZH = 'language_zh';
  static const String languageEN = 'language_en';
  static const String save = 'save';

  // 主页卡片
  static const String homeCardBlogTitle = 'home_card_blog_title';
  static const String homeCardBlogContent = 'home_card_blog_content';
  static const String homeCardBloglabel = 'home_card_blog_label';
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
    Ids.checkUpdate: 'Check for updates',

    // 主页卡片
    Ids.homeCardBlogTitle: 'Blog',
    Ids.homeCardBlogContent: 'Welcome to Mojipanda\'s home page. There are elaborate blogs and all kinds of fun. mojipanda ～\n',
    Ids.homeCardBloglabel: 'MojiPanda',
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
    Ids.checkUpdate: '检查新版本',

    // 主页卡片
    Ids.homeCardBlogTitle: '博客',
    Ids.homeCardBlogContent: '欢迎来到磨叽熊猫的主页，这里有精心制作的博客以及各种好玩的。mojipanda ～\n',
    Ids.homeCardBloglabel: '磨叽熊猫',
  }
};