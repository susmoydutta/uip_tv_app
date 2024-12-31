import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:uip_tv_app/domain/models/network_response.dart';
import 'package:uip_tv_app/presentation/widget/crafty_bay.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({
    required String url,
    bool fromAuth = false,
    String? token,
  }) async {
    try {
      log(url);

      final Response response = await get(
        Uri.parse(url),
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        if (!fromAuth) {
          _goToMainScreen();
        }
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> _goToMainScreen() async {
    BuildContext context = CraftyBay.navigatorKey.currentState!.context;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Session Expired'),
          content: Text('Your session has expired. The app will now close.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                SystemNavigator.pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
