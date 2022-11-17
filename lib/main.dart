import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zupaytask/controller/cart_controller.dart';
import 'package:zupaytask/model/products.dart';
import 'package:zupaytask/view/cart_screen.dart';
import 'package:zupaytask/view/home_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(appDirectory.path)
    ..registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => CartController(),
        ),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Bottom Nav Bar")),
      body: SafeArea(
        child: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: const<Widget>[HomePage(), CartScreen()],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        //backgroundColor: Colors.,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items:<BottomNavyBarItem>[
          BottomNavyBarItem(title:const Text('Home'), icon: const Icon(Icons.home), activeColor: Colors.black),
          BottomNavyBarItem(
            activeColor: Colors.black,
              title: const Text('Cart'), icon: const Icon(Icons.shopping_bag_outlined)),
        ],
      ),
    );
  }
}
