class ChangeFavoritesModel
{
  bool status;
  String message;

  ChangeFavoritesModel.fromMap(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}