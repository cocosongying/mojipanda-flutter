class Mzitu {
  int id;
  String url;
  String title;
  int type;
  String createTime;

  static Mzitu fromJsonMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    Mzitu m = Mzitu();
    m.id = map['id'];
    m.url = map['url'];
    m.title = map['title'];
    m.type = map['type'];
    m.createTime = map['createTime'].toString();
    return m;
  }
}
