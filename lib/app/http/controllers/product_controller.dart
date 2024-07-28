import 'package:todo/app/models/product.dart';
import 'package:todo/app/models/user.dart';
import 'package:vania/vania.dart';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:uuid/uuid.dart';
class ProductController extends Controller{
  Future <Response> index(Request request) async{
    final products = await Product().query().get();

    return Response.json(products);
  }

  Future<Response> store(Request request) async {

    final token = request.header('Authorization');

   if(token==null){
    return Response.json({"message":"Unauthorized"},400);
   }
   
 final pem = File('private_key.pem').readAsStringSync();

final jwt = JWT.verify(token, SecretKey(pem));

 final user = await User().query().where('id','=',jwt.payload['id']).first();

 if(user==null){
  return Response.json({"message":"User does not exist"},400);
 }
     final name = request.input('name');
    final price = request.input('price');

    if(!request.has('name') || !request.has('price')){
      return Response.json({"message":"Missing fields"},400);
    }
 
    request.validate({
      'name':'required|string',
      'price':'required|number'
    },{
      'name.required':'Name is required',
      'name.string':'Name must be a string',
      'price.required':'price is required',
      'price.string':'price must be a string'

    });

    final isAvailable = await Product().query().where('name','=',name).first();
   final userId = user['id'];
    if(isAvailable != null){
      return Response.json({'message':"Product with that name exists"},400);
    }
    final id = Uuid().v4();

    final productData = {
  'id': id,
  'name': name,
  'price': price,
  'userId': userId, 
  'createdAt': DateTime.now(), 
  'updatedAt': DateTime.now()
};
   
    final product = await Product().query().create(
 productData
      );
    return Response.json(product);
  }

    Future<Response> show(String id) async {

     final product = await Product().query().where('id','=',id).first();
   
    if(product==null){
      return Response.json({'message':"User does not exists"},400);
    }

    return Response.json(product);
  }

    Future<Response> update(Request request, String id) async {
       final name = request.input('name');
       final price = request.input('price');

    if(!request.has('name')|| !request.has('price')){
      return Response.json({"message":"Missing fields"},400);
    }
 
    request.validate({
      'name':'required|string',
      'price':'required|number'
    },{
      'name.required':'Name is required',
      'name.string':'Name must be a string',
       'price.required':'price is required',
      'price.string':'price must be a string'

    });
    final product = await Product().query().where('id','=',id).update(
      {
        'name':name,
        'price':price
      }
    );
    return Response.json({"message":"Updated Successfully"});
  }

  Future<Response> destroy(String id) async {
     final product = await Product().query().where('id','=',id).first();
   
    if(product==null){
      return Response.json({'message':"User does not exists"},400);
    }

Product().query().where('id','=',id).delete();

    return Response.json({"message":"Product delete successfully"});
  }
}

final ProductController productController = ProductController();