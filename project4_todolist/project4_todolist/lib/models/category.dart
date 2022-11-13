// Define a Category class
class Category {
  int? id;
  String? name;
  String? description;

  //transfer the data as Map
  toMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['description'] = description;

    return mapping;
  }
}
