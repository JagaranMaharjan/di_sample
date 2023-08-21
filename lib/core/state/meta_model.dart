class MetaModel {
  MetaModel({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  MetaModel.fromJson(dynamic json) {
    if (json['current_page'] != null) currentPage = json['current_page'];
    if (json['from'] != null) from = json['from'];
    if (json['last_page'] != null) lastPage = json['last_page'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    if (json['path'] != null) path = json['path'];
    if (json['per_page'] != null) perPage = json['per_page'];
    if (json['to'] != null) to = json['to'];
    if (json['total'] != null) total = json['total'];
  }

  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaModel copyWith({
    int? currentPage,
    int? from,
    int? lastPage,
    List<Links>? links,
    String? path,
    int? perPage,
    int? to,
    int? total,
  }) =>
      MetaModel(
        currentPage: currentPage ?? this.currentPage,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        links: links ?? this.links,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['from'] = from;
    map['last_page'] = lastPage;
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList();
    }
    map['path'] = path;
    map['per_page'] = perPage;
    map['to'] = to;
    map['total'] = total;
    return map;
  }
}

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  dynamic url;
  String? label;
  bool? active;

  Links copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? this.url,
        label: label ?? this.label,
        active: active ?? this.active,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['active'] = active;
    return map;
  }
}
