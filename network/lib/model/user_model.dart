class UserModel {
  UserModel({
    this.idUser,
    this.username,
    this.password,
    this.fullName,
    this.status,
    this.image,
    this.deviceid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json['id_user'],
        username: json['username'],
        password: json['password'],
        fullName: json['full_name'],
        status: json['status'],
        image: json['image'],
        deviceid: json['deviceid'],
      );

  Map<String, String> toJson() => {
        'id_user': idUser,
        'username': username,
        'password': password,
        'full_name': fullName,
        'status': status,
        'image': image,
        'deviceid': deviceid,
      };
  String idUser;
  String username;
  String password;
  String fullName;
  String status;
  String image;
  String deviceid;
}
