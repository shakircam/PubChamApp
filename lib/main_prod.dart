import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/my_app.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

void main() async {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter Prod",
    baseUrl: "https://pubchem.ncbi.nlm.nih.gov/rest/pug/",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
