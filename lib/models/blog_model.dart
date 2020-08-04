class Blog {
  int id;
  String link;
  String title;
  String author;
  String niceDate;
  String envelopePic;
  String desc;

  static Blog fromJsonMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    Blog blog = Blog();
    blog.id = map['id'];
    blog.link = map['link'];
    blog.title = map['title'];
    blog.author = map['author'];
    blog.niceDate = map['niceDate'];
    blog.envelopePic = map['envelopePic'];
    blog.desc = map['desc'];
    return blog;
  }
}
