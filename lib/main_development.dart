import 'package:ecommerce_app/app/app.dart';
import 'package:ecommerce_app/bootstrap.dart';

void main() {
  bootstrap(
    (isLogin) => App(login: isLogin),
    // baseUrl: 'http://172.31.144.1:3000',
    baseUrl: 'http://localhost:3000',
  );
}
