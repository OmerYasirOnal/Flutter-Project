import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'crud_folder/crudoperations.dart';


CollectionReference users = crudoperations().firestore.collection('Users');
var ahmet = users.doc('Ahmet');

class KoleksiyonDinleme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Koleksiyon Dinleme')),
      body: Center(
          child: Container(
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(
            // Neyi dinledimiz bilgisi
            stream: users.snapshots(),
            //Streamden her yen veri aktığında çalışıcak
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Center(
                  child: Text('Bir hata oluştu tekrar deneyiniz'),
                );
              } else {
                if (asyncSnapshot.hasData) {
                  List<DocumentSnapshot> listOfDocumentSnap =
                      asyncSnapshot.data.docs;
                  return Flexible(
                    child: ListView.builder(
                      itemCount: listOfDocumentSnap.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                                '${listOfDocumentSnap[index].get('name')}',
                                style: TextStyle(fontSize: 24)),
                            subtitle: Text(
                                '${listOfDocumentSnap[index].get('age')}',
                                style: TextStyle(fontSize: 24)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await listOfDocumentSnap[index]
                                    .reference
                                    .delete();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
          ElevatedButton(
              child: Text('Geri Dön'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]),
      )),
    );
  }
}

class DokumanDinleme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Koleksiyon Dinleme')),
      body: Center(
          child: Container(
            child: Column(children: [
              StreamBuilder<DocumentSnapshot>(
                // Neyi dinledimiz bilgisi
                stream: ahmet.snapshots(),
                //Streamden her yen veri aktığında çalışıcak
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                 return    Text('${asyncSnapshot.data.data()}',
                 style: TextStyle(fontSize: 24));
                 },
             ),
            ]
            ),
          ),
      ),
    );
  }
}

class VeriEkleme extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(title: Text('Firestore CRUD İşlemleri')),
        body: Center(
          child: Container(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  // Neyi dinledimiz bilgisi
                  stream: users.snapshots(),
                  //Streamden her yen veri aktığında çalışıcak
                  builder:  (BuildContext context , AsyncSnapshot asyncSnapshot){

                    if(asyncSnapshot.hasError){
                      return Center(child: Text('Bir hata oluştu tekrar deneyiniz'),);
                    }
                    else{
                      if(asyncSnapshot.hasData){
                        List<DocumentSnapshot> listOfDocumentSnap =asyncSnapshot.data.docs;
                        return Flexible(
                          child: ListView.builder(
                            itemCount: listOfDocumentSnap.length,
                            itemBuilder: (context,index){
                              return Card(
                                child: ListTile(
                                  title:  Text('${listOfDocumentSnap[index].get('name')}',
                                      style: TextStyle(fontSize: 24)),
                                  subtitle:  Text('${listOfDocumentSnap[index].get('age')}',
                                      style: TextStyle(fontSize: 24)),
                                  trailing: IconButton(icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      await listOfDocumentSnap[index].reference.delete();
                                    },),
                                ),
                              );

                            },),
                        );
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 200),
                  child: Form(child: Column(children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: 'isim Giriniz'),
                    ),
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(hintText: 'yaş Giriniz'),
                    ),
                  ],)),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(child: Text('Ekle'), onPressed: () async {
          print(nameController.text);
          print(ageController.text);
          ///Text alanlarındaki veriden bir map oluşturukması
          Map<String, dynamic> userData = {
            'name': nameController.text,
            'age': ageController.text
          };
          ///Veriyi yazmak istediğimiz referansa ulaşacağız ve ildili metodu çağıracağız
          await users.doc(nameController.text).set(userData);


        },),
      ),
    );
  }
}

class VeriSilme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Veri Silme')),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            child: Text('Geri Dön'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ])),
    );
  }
}

class VeriGunceleme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Veri Güncelleme')),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            child: Text('Geri Dön'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ])),
    );
  }
}

class VeriOkuma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Veri Okuma')),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            child: Text('Geri Dön'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ])),
    );
  }
}
