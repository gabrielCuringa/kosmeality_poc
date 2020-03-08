class ApiResponse {
  ApiResponse({this.data});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    serverTime = json['serverTime'];
    statusCode = json['statusCode'];
    data = json['data'];
  }
  int serverTime;
  int statusCode;
  dynamic data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}
