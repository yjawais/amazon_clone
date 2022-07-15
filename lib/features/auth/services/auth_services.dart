import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  //signup func
  void signUpUser({
required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    User user = User(
      id: '',
      name: name,
      email: email,
      password: password,
      address: '',
      type: '',
      token: '',
    );
    try {
    http.Response res=await http.post(
        Uri.parse('$uri/api/signin'),
        body: user.toJson(),
         headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Account Created! Please Login.');
      });
    } catch (e) {
              showSnackBar(context, e.toString());

    }
  }
}
