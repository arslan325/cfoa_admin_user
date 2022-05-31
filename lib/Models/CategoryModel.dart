class CategoryModel{
  static const CatID = "Category Id";
  static const CatIMAGE = "Category Image";
  static const CatTITLE = "Category Title";
  String cateImg;
   String cateTitle;
   String categoryId;
   CategoryModel({
    this.cateImg,
    this.cateTitle,
     this.categoryId
});
  CategoryModel.fromMap(Map<String, dynamic> data){
    categoryId = data[CatID];
    cateImg = data[CatIMAGE];
    cateTitle = data[CatTITLE];
  }
}