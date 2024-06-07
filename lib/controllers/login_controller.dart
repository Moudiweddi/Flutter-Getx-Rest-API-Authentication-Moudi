import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:login_registration/screens/home.dart';
import 'package:login_registration/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text,
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        // Successful login
        final json = jsonDecode(response.body);
        var token = json['token'];
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', token);
        //emailController.clear();
        //passwordController.clear();
        Get.offAll(() => const HomeScreen()); //(const HomeScreen());
      } else if (response.statusCode == 400) {
        // Error handling for missing password or other errors
        var error = jsonDecode(response.body);
        print("login failed");
        print(error);
      } else if (response.statusCode == 404) {
        // User not found
        var error = jsonDecode(response.body);
        print("User not found");
        print(error);
      } else {
        // Handle other status codes
        throw jsonDecode(response.body)['message'];
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}


/*

      if (response.statusCode == 200) {
        print("login successful");
        final json = jsonDecode(response.body);

        var token = json['token'];
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', token);
        //emailController.clear();
        //passwordController.clear();
        Get.off(() => const HomeScreen()); //(const HomeScreen());
      }
      if (response.statusCode == 400) {
        var error = jsonDecode(response.body);
        print("login failed");
        print(error);

        //throw jsonDecode(response.body)['message'];
      } else {
        throw jsonDecode(response.body)['message'];
      }

      
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
*/
/*

try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        print("login successful");

        print(response.body);

        final json = jsonDecode(response.body);

        var token = json['Token'];

        Get.off(() => (const HomeScreen()));
      } else {
        print("login failed");
        throw jsonDecode(response.body)['message'];
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

*/