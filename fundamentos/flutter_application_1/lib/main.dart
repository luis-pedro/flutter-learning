import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = [
        Permission.storage,
    ].request();
    SystemChrome.setEnabledSystemUIMode;
    return MaterialApp(
      title: 'Primeiro App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.red),
      ),
      home: const MyHomePage(title: 'Hello, World!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  final PageController pageController = PageController(
    initialPage: 0,
  );

  Widget build(BuildContext context) {
    final pages = PageView(
      controller: _pageController,
      children: [
        HomeWidget(),
        PhotosWidget(),
      ],
    )
  }

  class HomeWidget extends StatelessWidget{
    final children = new Scaffold(
      body: new Image.asset("images/home1.png"),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    )
  }

    class PhotosWidget extends StatelessWidget{
    final children = new Scaffold(
      body: new Image.asset("images/home1.png"),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
    return new GestureDetector(
      onTapDown: _onTapDown,
      child: children,
    );
  }

  _onTapDown(TapDownDetails details){

    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;

    print(details.localPosition);

    int dx = (x / 80).floor();
    int dy = ((y - 180) / 100).floor();
    int posicao = dy * 5 + dx;
    print("results: x=$x y=$y $dy $posicao");
    _save(posicao);
  }

  _save(int position) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/efeito-$position.jpg";
    print(savePath);
    await Dio().download(
      "https://github.com/guillhermesilveira/flutter-magic/raw/main/efeito-$position.jpn"
      (savePath);
    print("saved!");
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
    )
  }
}
