import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/core/flavors/flavors.dart';
import 'package:homekru_owner/core/l10n/generated/app_localizations.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/l10n/locale_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme/app_theme.dart';

void main() async {
  // setup flavor environment
  AppFlavor.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp.router(
          title: 'HomeKru-owner',
          theme: AppTheme.lightTheme,
          routerConfig: AppRoutes.router,
          locale: locale,
          supportedLocales: const [Locale('en', ''), Locale('id', '')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return _flavorBanner(
              child: child ?? const SizedBox.shrink(),
              show: kDebugMode,
            );
          },
        );
      },
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) =>
      show
          ? Banner(
            location: BannerLocation.topStart,
            message: AppFlavor.name,
            color: Colors.green.withAlpha(150),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
          : Container(child: child);
}
