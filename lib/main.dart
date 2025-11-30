import 'package:flutter/material.dart';
import 'package:newsapp/Provider/Category_provider.dart';
import 'package:newsapp/Provider/LocalProvider.dart';
import 'package:newsapp/Provider/themeprovider.dart';
import 'package:newsapp/Provider/themeprovider.dart';
import 'package:newsapp/UI/Screens/initPage.dart';
import 'package:newsapp/utils/app_routes.dart';
import 'package:newsapp/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart'; // الملف اللي اتولد بعد generate



void main() {
  runApp(
    MultiProvider(
      providers: [
    ChangeNotifierProvider(
      create: (_) => Categoryprovider(),

    ),
    //step2
ChangeNotifierProvider(create: (_) => ThemeProvider()),
ChangeNotifierProvider(create: (_) => LocaleProvider()),

    ],     child: const MyApp(),

    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); 

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'App news',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: theme.currentTheme,
      home: initPage(),
    );
  }
}
