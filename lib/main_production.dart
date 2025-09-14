import 'package:ecommerce_app/app/app.dart';
import 'package:ecommerce_app/bootstrap.dart';

void main() {
   bootstrap((isLogin) => App(login: isLogin,), baseUrl: 'http://172.22.16.1:3000',);
}
