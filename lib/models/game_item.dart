class GameItem{
  final String status;
  final dynamic message;
  final dynamic data;

  GameItem({
    required this.status,
    required this.message,
    required this.data
});

  factory GameItem.fromJson(Map<String, dynamic> json){
    return GameItem(
      status: json['status'],
      message: json['message'],
      data: json['data']
    );
  }

}