import 'package:get/get.dart';
import 'package:solyticket/modules/authentication_module/login/bindings/login_binding.dart';
import 'package:solyticket/modules/authentication_module/login/view/login_page.dart';
import 'package:solyticket/modules/authentication_module/otp/bindings/otp_binding.dart';
import 'package:solyticket/modules/authentication_module/otp/view/otp_page.dart';
import 'package:solyticket/modules/authentication_module/registration/bindings/registration_binding.dart';
import 'package:solyticket/modules/authentication_module/registration/view/regsitration_page.dart';
import 'package:solyticket/modules/booking_module/bindings/seat_category_binding.dart';
import 'package:solyticket/modules/booking_module/bindings/seat_selection_binding.dart';
import 'package:solyticket/modules/booking_module/view/seat_category_page.dart';
import 'package:solyticket/modules/booking_module/view/seat_selection_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/dashboard/bindings/customer_dashboard_binding.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/dashboard/view/customer_dashboard_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/bindings/event_binding.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/event_detail_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/events/view/event_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/bindings/customer_home_binding.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/home/view/customer_home_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/bindings/collection_bindings.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/collection/view/collection_page.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/bindings/profile_binding.dart';
import 'package:solyticket/modules/dashboard_module/customer_dashboard/profile/view/profile_page.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/dashboard/bindings/organizer_dashboard_binding.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/dashboard/view/organizer_dashboard_page.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/bindings/organizer_home_binding.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/home/view/organizer_home_page.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/bindings/my_activity_binding.dart';
import 'package:solyticket/modules/dashboard_module/organizer_dashboard/my_activity/view/my_activity_page.dart';
import 'package:solyticket/modules/splash_module/bindings/splash_binding.dart';
import 'package:solyticket/modules/splash_module/view/splash_page.dart';

class Routes {
  static String splash = '/splash';
  static String login = '/login';
  static String customerDashboard = '/customer-dashboard';
  static String organizerDashboard = '/organizer-dashboard';
  static String registration = '/registration';
  static String otp = '/otp';
  static String customerHome = '/customer-home';
  static String events = '/events';
  static String eventDetails = '/event-detail';
  static String collection = '/collection';
  static String profile = '/profile';
  static String organizerHome = '/organizer-home';
  static String myActivity = '/my-activity';
  static String seatCategorySelc = '/seat-category-selection';
  static String seatSelection = '/seat-selection';
}

final getPages = [
  GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding()),
  GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding()),
  GetPage(
      name: Routes.registration,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding()),
  GetPage(name: Routes.otp, page: () => OtpPage(), binding: OtpBinding()),
  GetPage(
      name: Routes.customerHome,
      page: () => CustomerHomePage(),
      binding: CustomerHomeBinding()),
  GetPage(
      name: Routes.events,
      page: () => const EventPage(
            isFromTab: false,
          ),
      binding: EventBinding()),
  GetPage(
      name: Routes.eventDetails,
      page: () => EventDetailPage(),
      binding: EventBinding()),
  GetPage(
    name: Routes.collection,
    page: () => CollectionPage(),
    binding: CollectionBindings(),
  ),
  GetPage(
    name: Routes.profile,
    page: () => ProfilePage(),
    binding: ProfileBinding(),
  ),
  GetPage(
      name: Routes.organizerHome,
      page: () => OrganizerHomePage(),
      binding: OrganizerHomeBinding()),
  GetPage(
      name: Routes.myActivity,
      page: () => MyActivityPage(),
      binding: MyActivityBinding()),
  GetPage(
      name: Routes.customerDashboard,
      page: () => const CustomerDashboardPage(),
      binding: CustomerDashboardBinding()),
  GetPage(
      name: Routes.organizerDashboard,
      page: () => const OrganizerDashboardPage(),
      binding: OrganizerDashboardBinding()),
  GetPage(
      name: Routes.seatCategorySelc,
      page: () => const SeatCategoryPage(),
      binding: SeatCategoryBinding()),
  GetPage(
    name: Routes.seatSelection,
    page: () => SeatSelectionPage(),
    binding: SeatSelectionBinding()
  ),
];
