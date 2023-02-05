import 'Soru.dart';

class TestVeri {
  int _index = 0;

  List<Soru> _SoruBankasi = [
    Soru(soruMetni: '1.Titanic gelmiş geçmiş en büyük gemidir', yanit: false),
    Soru(
        soruMetni: '2.Dünyadaki tavuk sayısı insan sayısından fazladır',
        yanit: true),
    Soru(soruMetni: '3.Kelebeklerin ömrü bir gündür', yanit: false),
    Soru(soruMetni: '4.Dünya düzdür', yanit: false),
    Soru(soruMetni: '5.Kaju fıstığı aslında bir meyvenin sapıdır', yanit: true),
    Soru(
        soruMetni: '6.Fatih Sultan Mehmet hiç patates yememiştir', yanit: true),
    Soru(soruMetni: '7.Fransızlar 80 demek için, 4 - 20 der', yanit: true),
  ];

  String getSoruMetni() {
    return _SoruBankasi[_index].soruMetni;
  }

  bool getYanit() {
    return _SoruBankasi[_index].yanit;
  }

  void sonrakiSoru() {
    if (_index < _SoruBankasi.length - 1) {
      _index++;
    }
  }

  void testiSifirla() {
    _index = 0;
  }

  bool testBittiMi() {
    if (_index >= _SoruBankasi.length - 1) {
      return true;
    } else {
      return false;
    }
  }
}
