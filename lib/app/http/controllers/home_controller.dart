

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
  Future<Response> index() async {
    return Response.json({'message': 'Hello Home'});
  }

  Future<Response> create(Request request) async {
  
    final name = request.input('name');
    final password = request.input('password');

    if(!request.has('name') || !request.has('password')){
      return Response.json({"message":"Missing fields"});
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

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final HomeController homeController = HomeController();
