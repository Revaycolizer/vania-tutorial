import 'package:todo/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller{
  Future <Response> index(Request request) async{
    final products = await Product().query().get();

    return Response.json(products);
  }
}

final ProductController productController = ProductController();