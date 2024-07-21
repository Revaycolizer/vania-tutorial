
import 'package:todo/app/http/controllers/product_controller.dart';
import 'package:vania/vania.dart';
import 'package:todo/app/http/controllers/home_controller.dart';
import 'package:todo/app/http/middleware/authenticate.dart';
import 'package:todo/app/http/middleware/home_middleware.dart';
import 'package:todo/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.any("/greeting",(){
      return "Hello World";
    });

     Router.get("/home", homeController.index);

      Router.post("/register", homeController.store).middleware([Throttle(maxAttempts: 3,duration:Duration(seconds: 60))]);

      Router.post("/login", homeController.create).middleware([Throttle(maxAttempts: 3,duration:Duration(seconds: 60))]);

       Router.get("/user/{id}", homeController.show).middleware([Throttle(maxAttempts: 3,duration:Duration(seconds: 60))]);

       Router.patch("/user/{id}", homeController.update).middleware([Throttle(maxAttempts: 3,duration:Duration(seconds: 60))]);

           Router.delete("/user/{id}", homeController.destroy).middleware([Throttle(maxAttempts: 3,duration:Duration(seconds: 60))]);

    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);


   Router.get("/products", productController.index);
    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}
