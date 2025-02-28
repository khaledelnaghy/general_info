import 'package:flutter/material.dart';
import 'package:general_information/core/theme/app_theme.dart';
 import 'package:general_information/feature/home/presentation/view/home_view.dart';
// import 'package:timeago/timeago.dart' as timeago;
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    // timeago.setLocaleMessages('ar', timeago.ArMessages());
  runApp(const GeneralInformation());
}

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (context) => HomeView(),
       
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
