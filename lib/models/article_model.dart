class Article {
  int id;
  String link;
  String title;
  String author;
  String niceDate;
  String envelopePic;
  String desc;

  static Article fromJsonMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    Article article = Article();
    article.id = map['id'];
    article.link = map['link'];
    article.title = map['title'];
    article.author = map['author'];
    article.niceDate = map['niceDate'];
    article.envelopePic = map['envelopePic'];
    article.desc = map['desc'];
    return article;
  }
}
