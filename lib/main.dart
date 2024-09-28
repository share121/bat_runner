import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter_acrylic/flutter_acrylic.dart' as acrylic;
import 'package:get/get.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'components/window_buttons.dart';
import 'helpers/is_desktop.dart';
import 'helpers/theme.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemTheme.fallbackColor = Colors.blue;
  SystemTheme.accentColor.load();
  if (isDesktop) {
    await acrylic.Window.initialize();
    if (GetPlatform.isWindows) {
      await acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(240, 280));
      await windowManager.setSize(const Size(450, 600));
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

const appTitle = 'Bat Runner';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(
      builder: (context, accent) {
        return FluentApp(
          title: appTitle,
          debugShowCheckedModeBanner: false,
          color: accent.accent,
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: getAccentColor(accent),
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          theme: FluentThemeData(
            accentColor: getAccentColor(accent),
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen(context) ? 2.0 : 0.0,
            ),
          ),
          locale: Get.deviceLocale,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool bgcIsTransparent = false;

  @override
  Widget build(BuildContext context) {
    return NavigationPaneTheme(
      data: NavigationPaneThemeData(
        backgroundColor:
            bgcIsTransparent && FluentTheme.of(context).brightness.isDark
                ? Colors.transparent
                : null,
      ),
      child: NavigationView(
        appBar: NavigationAppBar(
          title: const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          ),
          automaticallyImplyLeading: false,
          actions: isDesktop ? const WindowButtons() : null,
        ),
        content: const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void onWindowBlur() => setState(() => bgcIsTransparent = false);

  @override
  void onWindowFocus() {
    /// Make sure to call once.
    setState(() {});
    setEffect(acrylic.WindowEffect.mica).then((_) {
      setState(() {
        bgcIsTransparent = true;
      });
    });
  }
}
