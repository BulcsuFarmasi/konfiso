import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/shared/app_colors.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({super.key});

  static const routeName = '/no-connection';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_connected_no_internet_4,
                  size: 60,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.noInternetConnection,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 25, color: AppColors.primaryColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.toUseTheAppPleaseConnectYourDeviceToTheInternet,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
