import 'package:ecommerce_app/app/app.dart';
import 'package:ecommerce_app/bootstrap.dart';

void main() {
  bootstrap(
    (isLogin) => App(login: isLogin),
    baseUrl: 'http://localhost:3000',
  );
}
