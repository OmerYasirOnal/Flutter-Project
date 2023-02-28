import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Beklenilmeyen bir hata oluştu.'));
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyCards = <Mycard, Route<dynamic>>{
    Mycard(
      Icons.hearing,
      'Koleksiyon Dinleme',
      true,
    ): MaterialPageRoute(builder: (_) => KoleksiyonDinleme()),
    Mycard(Icons.document_scanner, 'Doküman Dinleme', false):
    MaterialPageRoute(builder: (_) => DokumanDinleme()),
    Mycard(Icons.add, 'Veri Ekleme', false):
    MaterialPageRoute(builder: (_) => VeriEkleme()),
    Mycard(Icons.delete, 'Veri Silme', false):
    MaterialPageRoute(builder: (_) => VeriSilme()),
    Mycard(Icons.update, 'Veri Güncelemme', false):
    MaterialPageRoute(builder: (_) => VeriGunceleme()),
    Mycard(Icons.chrome_reader_mode, 'Veri Okuma', false):
    MaterialPageRoute(builder: (_) => VeriOkuma()),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Firebase Entegrasyon'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choose your area',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: MyCards.keys
                    .map(
                      (e) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MyCards[e]!,
                      );
                    },
                    child: Card(
                      color: e.isActive ? Colors.deepPurple : null,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            e.icon,
                            size: 50,
                            color: e.isActive
                                ? Colors.white
                                : Colors.deepPurple,
                          ),
                          SizedBox(height: 10),
                          Text(
                            e.title,
                            style: TextStyle(
                              color:
                              e.isActive ? Colors.white : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
