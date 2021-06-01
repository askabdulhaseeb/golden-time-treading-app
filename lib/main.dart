import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'adminPanel/screens/homeScreen/adminHomeScreen.dart';
import 'adminPanel/screens/liveFeedSignalScreen/addNewLiveFeedSignal.dart';
import 'adminPanel/screens/liveFeedSignalScreen/liveFeedSignalScreen.dart';
import 'adminPanel/screens/localSignalScreen/addNewLocalSignal.dart';
import 'adminPanel/screens/localSignalScreen/localSignalScreen.dart';
import 'Screens/UpgradeToVIPScreen/UpgradeToVIPScreen.dart';
import 'Screens/blogPostScreen/blogPostScreen.dart';
import 'Screens/goldenAlgorithemScreen/goldenAlgorithemScreen.dart';
import 'Screens/homeScreen/homeScreen.dart';
import 'Screens/liveInfoPage/liveInfoPage.dart';
import 'Screens/loginScreen/loginScreen.dart';
import 'Screens/profilePage/profileScreen.dart';
import 'Screens/signupScreen/signupScreen.dart';
import 'Screens/splashScreen/splashScreen.dart';
import 'Screens/technicalAnalyticsScreen.dart/technicalAnalyticsScreen.dart';

void main() async {
  // To tell flutter to run few things before app lunch
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initalization
  runApp(MyApp()); // run the main app
  SystemChannels.textInput
      .invokeMethod('TextInput.hide'); // hide keyboard if not hiden
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golden Time-Trading App', // show when the app is pause
      debugShowCheckedModeBanner: false, // to revove the debuger lable from app
      theme: ThemeData(
        primarySwatch: Colors.blue, // by defacult app buttons'c colors
        // adapte the device theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // starting page
      routes: {
        // all the pages using in this app
        SplashScreen.routeName: (ctx) => SplashScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        LiveInfoPage.routeName: (ctx) => LiveInfoPage(),

        // Drawer Screens
        UpgradeToVIPScreen.routeName: (ctx) => UpgradeToVIPScreen(),
        TechnicalAnalyticsScreen.routeName: (ctx) => TechnicalAnalyticsScreen(),
        GoldenAlgorithemScreen.routeName: (ctx) => GoldenAlgorithemScreen(),
        BlogPostScreen.routeName: (ctx) => BlogPostScreen(),

        //
        // Admin Panel
        //
        AdminHomeScreen.routeName: (ctx) => AdminHomeScreen(),

        //local Signal
        LocalSignalScreen.routeName: (ctx) => LocalSignalScreen(),
        AddNewLocalSignal.routeName: (ctx) => AddNewLocalSignal(),

        //Live Feed Signal
        LiveFeedSignalScreen.routeName: (ctx) => LiveFeedSignalScreen(),
        AddNewLiveFeedSignal.routeName: (ctx) => AddNewLiveFeedSignal(),
      },
    );
  }
}

// SHA1: 35:8D:BE:C2:0A:25:C8:DB:5E:20:99:CF:45:9B:3A:E6:F7:AD:F7:A1
// SHA256: 75:88:59:16:CF:F5:CA:00:6E:8F:75:2A:66:E0:EA:BA:F1:BB:09:E1:3D:D4:70:06:3D:85:E8:5A:1B:14:04:C2
