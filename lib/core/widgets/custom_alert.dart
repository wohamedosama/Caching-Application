import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  static showAlert(BuildContext context, String message) {
    return showAlertBanner(
      context,
      () {},

      Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: Colors.white),
          ),
        ),
      ),
      alertBannerLocation: AlertBannerLocation.top,
      safeAreaTopEnabled: true,
    );
  }
}
