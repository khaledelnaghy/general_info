import 'package:flutter/material.dart';
import 'package:general_information/core/providers/app_lang_provider.dart';
import 'package:general_information/core/providers/app_theme_provider.dart';
import 'package:general_information/core/theme/app_theme.dart';
import 'package:general_information/feature/home/presentation/view/home_view.dart';
import 'package:general_information/feature/search/presentation/view/search_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:timeago/timeago.dart' as timeago;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AppLangProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AppThemeProvider(),
    ),
  ], child: const GeneralInformation()));
}

class GeneralInformation extends StatelessWidget {
  const GeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLangProvider>(context);
      var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.routeName,
      routes: {
        HomeView.routeName: (context) => HomeView(),
        SearchView.routeName: (context) => SearchView(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      locale: Locale(langProvider.appLang),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
