import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:homekru_owner/presentation/helper/add_helper_screen.dart';
import 'package:homekru_owner/presentation/helper/helper_list_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/attendence_log_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/add%20_member_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/helper_overview_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/live_in_helper_settings.dart';
import 'package:homekru_owner/presentation/member/helper/screen/member_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/member_tasks_screen.dart';
import 'package:homekru_owner/presentation/member/helper/screen/non_live_in_helper_settings.dart';
import 'package:homekru_owner/presentation/task/provider/task_provider.dart';
import 'package:homekru_owner/presentation/task/provider/task_management_provider.dart';
import 'package:homekru_owner/presentation/action_item/screen/action_screen.dart';
import 'package:homekru_owner/presentation/task/screens/task_detail_screen.dart';
import 'package:homekru_owner/presentation/task/screens/task_managment/clean_kitchhen_screen.dart';
import 'package:homekru_owner/presentation/task/screens/task_managment/task_management_screen.dart';
import 'package:homekru_owner/presentation/task/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:homekru_owner/presentation/attendance_screen/attendance_screen.dart';
import 'package:homekru_owner/presentation/attendance_screen/provider/attendance_provider.dart';
import 'package:homekru_owner/presentation/auth/confirm_password_screen.dart';
import 'package:homekru_owner/presentation/auth/create_household_screen.dart';
import 'package:homekru_owner/presentation/auth/forget_password_screen.dart';
import 'package:homekru_owner/presentation/auth/invite_link_screen.dart'
    show InviteLinkScreen;
import 'package:homekru_owner/presentation/auth/login_screen.dart';
import 'package:homekru_owner/presentation/auth/provider/create_household_provider.dart';
import 'package:homekru_owner/presentation/auth/provider/login_provider.dart';
import 'package:homekru_owner/presentation/auth/signUp_screen.dart';
import 'package:homekru_owner/presentation/auth/verify_otp.dart';
import 'package:homekru_owner/presentation/auth/would_you_like_screen.dart';
import 'package:homekru_owner/presentation/bottom_navigation_bar/dashboard.dart';
import 'package:homekru_owner/presentation/bottom_navigation_bar/provider/dashboard_provider.dart';
import 'package:homekru_owner/presentation/coowner/coowner_list_screen.dart';
import 'package:homekru_owner/presentation/coowner/add_coowner_screen.dart';
import 'package:homekru_owner/presentation/deduction/deduction_screen.dart';
import 'package:homekru_owner/presentation/deduction/provider/deduction_provider.dart';
import 'package:homekru_owner/presentation/notification/notification.dart';
import 'package:homekru_owner/presentation/notification/provider/notification_provider.dart';
import 'package:homekru_owner/presentation/onBoarding/onboarding_screen.dart';
import 'package:homekru_owner/presentation/onBoarding/provider/onBoarding_provider.dart';
import 'package:homekru_owner/presentation/overtime_detailed_screen/overtime_detailed_screen.dart';
import 'package:homekru_owner/presentation/overtime_tracker/overtime_tracker_screen.dart';
import 'package:homekru_owner/presentation/overtime_tracker/overtime_tracker_detailed_screen.dart';
import 'package:homekru_owner/presentation/overtime_tracker/provider/overtime_tracker_provider.dart';
import 'package:homekru_owner/presentation/profile_scren/profile_screen.dart';
import 'package:homekru_owner/presentation/profile_scren/provider/profile_provider.dart';
import 'package:homekru_owner/presentation/settings/provider/settings_provider.dart';
import 'package:homekru_owner/presentation/settings/settings_screen.dart';
import 'package:homekru_owner/presentation/subscription/screens/manage_subscription_screen.dart';
import 'package:homekru_owner/presentation/home_setup/home_setup_screen.dart';
import 'package:homekru_owner/presentation/reports/reports_screen.dart';
import 'package:homekru_owner/presentation/analytics/analytics_screen.dart';
import 'package:homekru_owner/presentation/feedback/feedback_screen.dart';
import 'package:homekru_owner/presentation/help_support/help_support_screen.dart';
import 'package:homekru_owner/presentation/splash_screens/splash_screen.dart';
import 'package:homekru_owner/presentation/splash_screens/provider/splash_provider.dart';
import 'package:homekru_owner/presentation/cms_pages/terms_conditions_screen.dart';
import 'package:homekru_owner/presentation/cms_pages/privacy_policy_screen.dart';
import 'package:homekru_owner/presentation/cms_pages/faqs_screen.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const String initialRoute = '/initial-route';
  static const String onBoarding = '/on-boarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget-password';
  static const String confirmPassword = '/confirm-password';
  static const String wouldYouLike = '/would-you-like';
  static const String inviteLink = '/invite-link';
  static const String createHousehold = '/create-household';
  static const String dashboard = '/dashboard';
  static const String attendance = '/attendance';
  static const String overtimeTracker = '/overtime-tracker';
  static const String overtimeTrackerDetailed = '/overtime-tracker-detailed';
  static const String verifyOtp = '/verify-otp';
  static const String overtimeDetailed = '/overtime-detailed';
  static const String coownerList = '/coowner-list';
  static const String helperList = '/helper-list';
  static const String addCoOwner = '/add-coowner';
  static const String addHelper = '/add-helper';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String deduction = '/deduction';
  static const String settings = '/settings';
  static const String manageSubscription = '/manage-subscription';
  static const String homeSetup = '/home-setup';
  static const String reports = '/reports';
  static const String analytics = '/analytics';
  static const String feedback = '/feedback';
  static const String helpSupport = '/help-support';
  static const String termsConditions = '/terms-conditions';
  static const String privacyPolicy = '/privacy-policy';
  static const String faqs = '/faqs';

  // Task
  static const String task = '/task';
  static const String taskDetail = '/task-detail';
  static const String action = '/action';
  static const String taskManagement = '/task-management';
  // Member
  static const String member = '/member';
  static const String addMember = '/add-member';
  static const String nonLiveInHelperSettings = '/non-live-in-helper-settings';
  static const String liveInHelperSettings = '/live-in-helper-settings';
  static const String helperOverview = '/helper-overview';
  static const String memberTasks = '/member-tasks';
  static const String attendenceLog = '/attendence-log';
  static const String cleanKitchen = '/clean-kitchen';

  static GoRouter router = GoRouter(
    navigatorKey: navigationKey,
    initialLocation: kDebugMode ? dashboard : initialRoute,
    // initialLocation: dashboard,
    routes: [
      GoRoute(
        name: initialRoute,
        path: initialRoute,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => SplashProvider(),
              child: const SplashScreen(),
            ),
      ),
      GoRoute(
        name: onBoarding,
        path: onBoarding,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => OnboardingProvider(),
              child: const OnBoardingScreen(),
            ),
      ),
      GoRoute(
        name: login,
        path: login,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        name: signup,
        path: signup,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const SignupScreen(),
            ),
      ),
      GoRoute(
        name: forgetPassword,
        path: forgetPassword,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const ForgetPasswordScreen(),
            ),
      ),
      GoRoute(
        name: confirmPassword,
        path: confirmPassword,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const ConfirmPasswordScreen(),
            ),
      ),
      GoRoute(
        name: wouldYouLike,
        path: wouldYouLike,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const WouldYouLikeScreen(),
            ),
      ),
      GoRoute(
        name: inviteLink,
        path: inviteLink,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const InviteLinkScreen(),
            ),
      ),
      GoRoute(
        name: createHousehold,
        path: createHousehold,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => CreateHouseholdProvider(),
              child: const CreateHouseholdScreen(),
            ),
      ),

      GoRoute(
        name: dashboard,
        path: dashboard,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => DashboardProvider(),
              child: const Dashboard(),
            ),
      ),
      GoRoute(
        name: attendance,
        path: attendance,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => AttendanceProvider(),
              child: const AttendanceScreen(),
            ),
      ),
      GoRoute(
        name: overtimeTracker,
        path: overtimeTracker,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => AttendanceProvider(),
              child: const OvertimeTrackerScreen(),
            ),
      ),
      GoRoute(
        name: overtimeTrackerDetailed,
        path: overtimeTrackerDetailed,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => OvertimeTrackerProvider(),
              child: const OvertimeTrackerDetailedScreen(),
            ),
      ),
      GoRoute(
        name: verifyOtp,
        path: verifyOtp,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => LoginProvider(),
              child: const VerifyOtpScreen(),
            ),
      ),
      GoRoute(
        name: overtimeDetailed,
        path: overtimeDetailed,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => OvertimeTrackerProvider(),
              child: const OvertimeDetailedScreen(),
            ),
      ),
      GoRoute(
        name: coownerList,
        path: coownerList,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => OvertimeTrackerProvider(),
              child: const CoownerListScreen(),
            ),
      ),
      GoRoute(
        name: helperList,
        path: helperList,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => OvertimeTrackerProvider(),
              child: const HelperListScreen(),
            ),
      ),
      GoRoute(
        name: addCoOwner,
        path: addCoOwner,
        builder: (context, state) => const AddCoOwnerScreen(),
      ),
      GoRoute(
        name: addHelper,
        path: addHelper,
        builder: (context, state) => const AddHelperScreen(),
      ),
      GoRoute(
        name: notification,
        path: notification,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => NotificationProvider(),
              child: const NotificationScreen(),
            ),
      ),
      GoRoute(
        name: profile,
        path: profile,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => ProfileProvider(),
              child: const ProfileScreen(),
            ),
      ),
      GoRoute(
        name: deduction,
        path: deduction,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => DeductionProvider(),
              child: const DeductionScreen(),
            ),
      ),

      GoRoute(
        name: settings,
        path: settings,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => SettingsProvider(),
              child: const SettingsScreen(),
            ),
      ),
      GoRoute(
        name: manageSubscription,
        path: manageSubscription,
        builder: (context, state) => const ManageSubscriptionScreen(),
      ),
      GoRoute(
        name: homeSetup,
        path: homeSetup,
        builder: (context, state) => const HomeSetupScreen(),
      ),
      GoRoute(
        name: reports,
        path: reports,
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        name: analytics,
        path: analytics,
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        name: feedback,
        path: feedback,
        builder: (context, state) => const FeedbackScreen(),
      ),
      GoRoute(
        name: helpSupport,
        path: helpSupport,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        name: termsConditions,
        path: termsConditions,
        builder: (context, state) => const TermsConditionsScreen(),
      ),
      GoRoute(
        name: privacyPolicy,
        path: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        name: faqs,
        path: faqs,
        builder: (context, state) => const FAQsScreen(),
      ),
      GoRoute(
        name: taskManagement,
        path: taskManagement,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => TaskManagementProvider(),
              child: const TaskManagementScreen(),
            ),
      ),

      // Tasks Section
      GoRoute(
        name: task,
        path: task,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => TaskProvider(),
              child: const TaskScreen(),
            ),
      ),
      GoRoute(
        name: taskDetail,
        path: taskDetail,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => TaskProvider(),
              child: const TaskDetailScreen(),
            ),
      ),
      GoRoute(
        name: action,
        path: action,
        builder:
            (context, state) => ChangeNotifierProvider(
              create: (context) => TaskProvider(),
              child: const ActionScreen(),
            ),
      ),

      // Member Section
      GoRoute(
        name: member,
        path: member,
        builder: (context, state) => const MemberScreen(),
      ),
      GoRoute(
        name: addMember,
        path: addMember,
        builder: (context, state) => AddMemberScreen(),
      ),
      GoRoute(
        name: nonLiveInHelperSettings,
        path: nonLiveInHelperSettings,
        builder: (context, state) => NonLiveInHelperSettings(),
      ),
      GoRoute(
        name: liveInHelperSettings,
        path: liveInHelperSettings,
        builder: (context, state) => LiveInHelperSettings(),
      ),
      GoRoute(
        name: helperOverview,
        path: helperOverview,
        builder: (context, state) => HelperOverviewScreen(),
      ),
      GoRoute(
        name: memberTasks,
        path: memberTasks,
        builder: (context, state) => MemberTasksScreen(),
      ),
      GoRoute(
        name: attendenceLog,
        path: attendenceLog,
        builder: (context, state) => AttendenceLogScreen(),
      ),
      GoRoute(
        name: cleanKitchen,
        path: cleanKitchen,
        builder:
            (context, state) => CleanKitchenScreen(
              provider: state.extra as TaskManagementProvider,
            ),
      ),
    ],
  );
}
