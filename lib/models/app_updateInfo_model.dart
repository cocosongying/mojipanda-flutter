class AppUpdateInfo {
  String version;
  String description;
  bool forceUpdate;
  String downloadUrl;

  AppUpdateInfo.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        description = json['description'],
        forceUpdate = json['forceUpdate'],
        downloadUrl = json['downloadUrl'];

  Map<String, dynamic> toJson() => {
        'version': version,
        'description': description,
        'forceUpdate': forceUpdate,
        'downloadUrl': downloadUrl,
      };
}
