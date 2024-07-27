

import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:uuid/uuid.dart';
import 'package:vania/vania.dart';

import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../models/user.dart';

String hashPassword(String password) {
  var bytes = utf8.encode(password); 
  var digest = sha256.convert(bytes);
  return digest.toString(); 
}

bool verifyPassword(String password, String hashedPassword) {
  return hashPassword(password) == hashedPassword;
}



class HomeController extends Controller {
  Future<Response> index(Request request) async {

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

 return Response.json(user);

  }

  Future<Response> create(Request request) async {
   final name = request.input('name');
    final password = request.input('password');

      request.validate({
      'name':'required|string',
      'password':'required|string'
    },{
      'name.required':'Name is required',
      'name.string':'Name must be a string',
      'password.required':'Password is required',
      'password.string':'Password must be a string'

    });

     final user = await User().query().where('name','=',name).first();

      if(user==null){
      return Response.json({"message":"User does not exist"},400);
     }

     final isMatch = verifyPassword(password, user['password']);

     if(!isMatch){
      return Response.json({"message":"Incorrect credentials"},400);
     }
     
final userLogin = {
     'id': user['id'],
     'name': user['name'],
};

 final jwt = JWT({
    'id': user['id']
 });

  final pem = File('private_key.pem').readAsStringSync();

final token = jwt.sign(SecretKey(pem));

    return Response.json(token);
   
  }

  Future<Response> store(Request request) async {
     final name = request.input('name');
    final password = request.input('password');

    if(!request.has('name') || !request.has('password')){
      return Response.json({"message":"Missing fields"},400);
    }
 
    request.validate({
      'name':'required|string',
      'password':'required|string'
    },{
      'name.required':'Name is required',
      'name.string':'Name must be a string',
      'password.required':'Password is required',
      'password.string':'Password must be a string'

    });

    final isAvailable = await User().query().where('name','=',name).first();
   
    if(isAvailable != null){
      return Response.json({'message':"User with that name exists"},400);
    }
    final id = Uuid().v4();
   
    final user = await User().query().create(
      {
        'id':id,
        'name':name,
      'password':hashPassword(password),
      'createdAt':DateTime.now(),
      'updatedAt':DateTime.now()
      }
      );
    return Response.json(user);

  }

  Future<Response> show(String id) async {

     final user = await User().query().where('id','=',id).first();
   
    if(user==null){
      return Response.json({'message':"User does not exists"},400);
    }
final userLogin = {
      'id':user['id'],
      'name':user['name'],
     };

    return Response.json(userLogin);
  }

  Future<Response> edit(int id) async {
    
    return Response.json({});
  }

  Future<Response> update(Request request, String id) async {
       final name = request.input('name');

    if(!request.has('name')){
      return Response.json({"message":"Missing fields"},400);
    }
 
    request.validate({
      'name':'required|string',
      'password':'required|string'
    },{
      'name.required':'Name is required',
      'name.string':'Name must be a string',

    });
    final user = await User().query().where('id','=',id).update(
      {
        'name':name
      }
    );
    return Response.json({"message":"Updated Successfully"});
  }

  Future<Response> destroy(String id) async {
     final user = await User().query().where('id','=',id).first();
   
    if(user==null){
      return Response.json({'message':"User does not exists"},400);
    }

User().query().where('id','=',id).delete();

    return Response.json({"message":"User delete successfully"});
  }
}

final HomeController homeController = HomeController();
