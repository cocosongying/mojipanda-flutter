class Tree {
  int id;
  String name;
  int order;
  // int parentId;
  int visible;
  // List<Tree> children;

  Tree(this.id, this.name, this.order, this.visible);

  Tree.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        order = map['order'],
        visible = map['visible'];
}
