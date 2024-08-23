class Configuration {
  String id;
  String configurationName;
  String configurationValue;
  Configuration(
      {this.id = "",
      this.configurationName = "",
      this.configurationValue = ""});

  factory Configuration.fromJson(Map<String, dynamic> json) {
    return Configuration(
        id: json['ID'],
        configurationName: json['ConfigurationName'],
        configurationValue: json['ConfigurationValue']);
  }
}
