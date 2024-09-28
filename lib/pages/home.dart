import 'package:fluent_ui/fluent_ui.dart';

import '../components/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with PageMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('Fluent UI for Flutter Showcase App'),
      ),
      children: const [],
    );
  }
}
