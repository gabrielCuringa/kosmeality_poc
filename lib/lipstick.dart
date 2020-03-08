class Lipstick {
  String sId;
  String color;
  String serie;
  String name;

  Lipstick({this.sId, this.color, this.serie, this.name});

  Lipstick.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    color = json['color'];
    serie = json['serie'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['color'] = this.color;
    data['serie'] = this.serie;
    data['name'] = this.name;
    return data;
  }
}
