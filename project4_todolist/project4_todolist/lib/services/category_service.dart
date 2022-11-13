import '../repositories/repository.dart';

import '../models/category.dart';

class CategoryService {
  Repository? _repository;
  CategoryService() {
    _repository = Repository();
  }

  //Create data
  saveCategory(Category categ) async {
    return await _repository!.insertData('categories', categ.toMap());
  }

  //Read data
  readCategories() async {
    return await _repository!.readData('categories');
  }

  readCategoryById(categId) async {
    return await _repository!.readDataById('categories', categId);
  }

  updateCategory(Category category) async {
    return await _repository!.updateData('categories', category.toMap());
  }

  deleteCategory(categId) async {
    return await _repository!.deleteData('categories', categId);
  }
}
