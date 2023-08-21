class FaqModel {
  FaqModel({
    this.data,
  });

  FaqModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Faqs.fromJson(v));
      });
    }
  }
  List<Faqs>? data;
  FaqModel copyWith({
    List<Faqs>? data,
  }) =>
      FaqModel(
        data: data ?? this.data,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Faqs {
  Faqs({
    this.title,
    this.slug,
    this.content,
  });

  Faqs.fromJson(dynamic json) {
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
  }
  String? title;
  String? slug;
  String? content;
  Faqs copyWith({
    String? title,
    String? slug,
    String? content,
  }) =>
      Faqs(
        title: title ?? this.title,
        slug: slug ?? this.slug,
        content: content ?? this.content,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['slug'] = slug;
    map['content'] = content;
    return map;
  }
}
