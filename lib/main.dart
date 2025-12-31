import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change this to any color you want
      statusBarIconBrightness: Brightness.light, // for white icons
    ),
  );

  Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]).then((value) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          top: false,
          bottom: true,
          left: false,
          right: false,
          maintainBottomViewPadding: true,

          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            // Use builder only if you need to use library outside ScreenUtilInit context
            builder: (_, child) {
              return MaterialApp.router(
                // localizationsDelegates: context.localizationDelegates,
                // supportedLocales: context.supportedLocales,
                // locale: context.locale,
                title: 'HomeKru-owner',
                debugShowCheckedModeBanner: false,

                // theme: appTheme.main,
                // theme: provider.themeData,s
                // navigatorKey: NavigatorService.navigatorKey,
                // initialRoute: AppRoutes.bottomNavigationScreen,
                // routes: AppRoutes.route,
                routerConfig: AppRoutes.router,
              );
            },
          ),
        );
      },
    );
  }
}
