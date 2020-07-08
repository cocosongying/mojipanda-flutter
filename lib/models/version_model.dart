class VersionModel {
  String version;
  String name;
  String description;
  VersionModel.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        name = json['name'],
        description = json['description'];
  @override
  String toString() {
    return 'name: $name, version: $version, description: $description';
  }
}
