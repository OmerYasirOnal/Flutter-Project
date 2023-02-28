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
            stream: users.snapshots(),
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
            width: 400,
            height: 400,
            child: Column(children: [

              StreamBuilder<DocumentSnapshot>(
                stream: ahmet.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                 return    Text('${asyncSnapshot.data.data()}',
                 style: TextStyle(fontSize: 20));
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
          child: Container(
            child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
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

class VeriGuncelleme extends StatelessWidget {
  final CollectionReference users = crudoperations().firestore.collection('Users');

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Yaş Güncelleme')),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Card(child: Text('Yaşını güncellemek istediğiniz kullanıcının ismini giriniz ve artından değiştirmek istediğiniz yaşı', style: TextStyle(fontSize: 23),)),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  hintText: 'Age',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Güncelle'),
                onPressed: () async {
                  if (nameController.text.isNotEmpty &&
                      ageController.text.isNotEmpty) {
                    await users.doc(nameController.text).update({
                      'name': nameController.text,
                      'age': ageController.text,
                    });
                    nameController.clear();
                    ageController.clear();
                  }
                },
              ),
              ElevatedButton(
                child: Text('Geri Dön'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
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
        ElevatedButton(
            child: Text('Geri Dön'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ])),
    );
  }
}
