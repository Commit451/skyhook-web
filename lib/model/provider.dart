class Provider {
  final String name;
  final String path;

  Provider(this.name, this.path);

  Provider.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        path = json['path'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'path': path,
      };
}
