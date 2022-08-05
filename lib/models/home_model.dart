class ShopHomeModel{
 bool status;
ShopHomeDetails data;

ShopHomeModel.fromMap(Map<String, dynamic>jason)
{
status = jason['status'];
data =(jason['data'] !=null ? ShopHomeDetails.fromMap(jason['data']):null);
}
}
class ShopHomeDetails
{
  List<ShopProducts> banners = [];
  List<ShopProducts> products = [];

  ShopHomeDetails.fromMap(Map<String, dynamic>jason)
  {
    jason['banners'].forEach((element) {
      banners.add(ShopProducts.fromMap(element));
    });

    jason['products'].forEach((element)
    {
      products.add(ShopProducts.fromMap(element));
    });
  }
}
class ShopProducts{
   int id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
   String image;
   String name;
   bool inFavorites;
   bool inCart;

  ShopProducts.fromMap(Map<String, dynamic>jason)
  {
    id = jason['id'] ?? 0;
    price = jason['price'] ?? 0;
    oldPrice = jason['old_price'] ?? 0;
    discount = jason['discount'] ?? 0;
    image =jason['image']??'';
    name = jason['name'] ?? '';
    inFavorites = jason['in_favorites'] ?? false;
    inCart = jason['in_cart']??false;
  }
}