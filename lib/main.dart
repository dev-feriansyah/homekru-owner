import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homekru_owner/shared/utils/size_utils.dart';
import 'package:homekru_owner/features/auth/provider/create_household_provider.dart';
import 'package:homekru_owner/features/auth/provider/login_provider.dart';
import 'package:homekru_owner/features/home_screen/provider/home_screen_provider.dart';
import 'package:homekru_owner/features/member/provider/add_member_provider.dart';
import 'package:homekru_owner/features/member/provider/day_off_eligibility_provider.dart';
import 'package:homekru_owner/features/member/provider/member_provider.dart';
import 'package:homekru_owner/features/overtime_tracker/provider/overtime_tracker_provider.dart';
import 'package:homekru_owner/features/profile_scren/provider/profile_provider.dart';
import 'package:homekru_owner/features/settings/provider/settings_provider.dart';
import 'package:homekru_owner/features/task/provider/task_management_provider.dart';
import 'package:homekru_owner/features/task/provider/task_provider.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';
import 'package:homekru_owner/core/theme/provider/theme_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' hide Consumer;

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(
              create: (context) => CreateHouseholdProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => OvertimeTrackerProvider(),
            ),
            ChangeNotifierProvider(create: (context) => ProfileProvider()),
            ChangeNotifierProvider(create: (context) => SettingsProvider()),
            ChangeNotifierProvider(create: (context) => MemberProvider()),
            ChangeNotifierProvider(create: (context) => AddMemberProvider()),
            ChangeNotifierProvider(
              create: (context) => DayOffEligibilityProvider(),
            ),
            ChangeNotifierProvider(create: (context) => TaskProvider()),
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(isDark: false),
            ),
            ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
            ChangeNotifierProvider(
              create: (context) => TaskManagementProvider(),
            ),
          ],
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
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
          ),
        );
      },
    );
  }
}
