class Template {
  final String title;
  final String body;
  final int template_id;
  
  Template(
      this.title,
      this.body,
      this.template_id
      );

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      json['title'],
      json['body'],
      json['template_id']
    );
  }

  Map toJson() => { 
      'title': title,
      'body': body,
      'template_id': template_id
      };

  static List<Template> getListFromJson(Map<String, dynamic> json) {
    var templatesJson = json['templates'] as List;
    List<Template> resumeList =
        templatesJson.map((i) => Template.fromJson(i)).toList();
    return resumeList;
  }
}
