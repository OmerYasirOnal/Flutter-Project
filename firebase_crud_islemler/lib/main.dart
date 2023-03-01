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
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      routes: {
        '/koleksiyon-dinleme': (_) => KoleksiyonDinleme(),
        '/dokuman-dinleme': (_) => DokumanDinleme(),
        '/veri-ekleme': (_) => VeriEkleme(),
        '/veri-silme': (_) => VeriSilme(),
        '/veri-guncelleme': (_) => VeriGuncelleme(),
        '/veri-okuma': (_) => VeriOkuma(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Mycard> myCards = [    Mycard(Icons.hearing, 'Koleksiyon Dinleme', true),    Mycard(Icons.document_scanner, 'Dokuman Dinleme', false),    Mycard(Icons.add, 'Veri Ekleme', false),    Mycard(Icons.delete, 'Veri Silme', false),    Mycard(Icons.update, 'Veri Guncelleme', false),    Mycard(Icons.chrome_reader_mode, 'Veri Okuma', false),  ];

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
            child: ListView.builder(
              itemCount: myCards.length,
              itemBuilder: (context, index) {
                final myCard = myCards[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      for(int i = 0; i<myCards.length; i++){
                        myCards[i].isActive =false;
                      }
                      myCards[index].isActive =true;
                    });

                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushNamed(
                      context,
                      '/${myCard.title.toLowerCase().replaceAll(' ', '-')}',
                    );
                  },
                  child: Card(
                    color: myCard.isActive ? Colors.deepPurple : null,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(
                            myCard.icon,
                            size: 50,
                            color: myCard.isActive
                                ? Colors.white
                                : Colors.deepPurple,
                          ),
                          SizedBox(width: 16),
                          Text(
                            myCard.title,
                            style: TextStyle(
                              color: myCard.isActive
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
