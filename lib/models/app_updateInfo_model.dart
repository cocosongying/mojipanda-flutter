class AppUpdateInfo {
  String buildBuildVersion;
  String forceUpdateVersion;
  String forceUpdateVersionNo;
  bool needForceUpdate;
  String downloadURL;
  bool buildHaveNewVersion;
  String buildVersionNo;
  String buildVersion;
  String buildShortcutUrl;
  String buildUpdateDescription;

  AppUpdateInfo.fromJson(Map<String, dynamic> json)
      : buildBuildVersion = json['version'];
  Map<String, dynamic> toJson() => {
    'buildBuildVersion': buildBuildVersion,
  };
}