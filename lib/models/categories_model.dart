import 'dart:convert';

class CategoriesModel
{
  bool status;
  CategoriesDataModel data;
  CategoriesModel.fromMap(Map<String, dynamic> jason)
  {
    status = jason['status'];
    data = CategoriesDataModel.fromMap(jason['data']);

  }
}

class CategoriesDataModel
{
  int currentpage;
  List<DataModel> data = [];

  CategoriesDataModel.fromMap(Map<String, dynamic> jason)
  {
    currentpage = jason['current_page'];

    jason['data'].forEach((element)
    {
      data.add(DataModel.fromMap(element));
    });

  }
}

class DataModel
{
  int id;
  String name;
  String image;

  DataModel.fromMap(Map<String, dynamic> jason)
  {
    id = jason['id'];
    name = jason['name'];
    image = jason['image'];
  }
}