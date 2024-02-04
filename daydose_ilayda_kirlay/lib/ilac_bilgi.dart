import 'package:flutter/material.dart';

class ilacbilgi extends StatefulWidget {
  @override
  _IlacBilgiAppState createState() => _IlacBilgiAppState();
}

class _IlacBilgiAppState extends State<ilacbilgi> {
  // Favori ilaç listesi
  List<String> favoriIlacListesi = [
    'Parol',
    'Aspirin',
    'No-Spa',
    'Panadol',
    'Daleron',
    'Brufen',
    'Nurofen',
    'Strepsils',
    'Advil',
    'Actifed',
    'Vitamin C',
    'Allegra',
    'Majezik',
    'Augmentin',
    'Nexium',
    'Telfast',
    'Mucosolvan',
    'Voltaren',
    'Molipaxin',
    'Zyrtec',
    'Ritalin',
    'Claritin',
    'Prozac',
    'Lipitor',
    'Xanax',
    'Crestor',
    'Singulair',
    'Seroquel',
    'Lisinopril',
    'Metformin',
    'Plavix',
    'Synthroid',
    'Norvasc',
    'Prednisone',
    'Advair Diskus',
    'Abilify',
    'Lyrica',
    'Celebrex',
    'Zoloft',
    'Effexor',
    'Lipitor',
    'Cymbalta',
  ];

  // İlaç içerikleri
  Map<String, String> ilacIcerikleri = {
    'Parol': 'Ağrı kesici, ateş düşürücü',
    'Aspirin': 'Ağrı kesici, ateş düşürücü, iltihap giderici',
    'No-Spa': 'Kas gevşetici',
    'Panadol': 'Ağrı kesici, ateş düşürücü',
    'Daleron': 'Ağrı kesici, ateş düşürücü',
    'Brufen': 'Ağrı kesici, ateş düşürücü, iltihap giderici',
    'Nurofen': 'Ağrı kesici, ateş düşürücü, iltihap giderici',
    'Strepsils': 'Boğaz pastili, ağrı kesici',
    'Advil': 'Ağrı kesici, ateş düşürücü',
    'Actifed': 'Alerji ilacı, burun tıkanıklığı giderici',
    'Vitamin C': 'C vitamini takviyesi',
    'Allegra': 'Alerji ilacı',
    'Majezik': 'Ağrı kesici, kas gevşetici',
    'Augmentin': 'Antibiyotik',
    'Nexium': 'Mide ilacı, asit düşürücü',
    'Telfast': 'Alerji ilacı',
    'Mucosolvan': 'Balgam söktürücü',
    'Voltaren': 'Ağrı kesici, ateş düşürücü, iltihap giderici',
    'Molipaxin': 'Depresyon ilacı',
    'Zyrtec': 'Alerji ilacı',
    'Ritalin': 'Dikkat eksikliği ve hiperaktivite bozukluğu (DEHB) ilacı',
    'Claritin': 'Alerji ilacı',
    'Prozac': 'Antidepresan',
    'Lipitor': 'Kolesterol düşürücü',
    'Xanax': 'Anksiyete ilacı',
    'Crestor': 'Kolesterol düşürücü',
    'Singulair': 'Alerji ilacı',
    'Seroquel': 'Antipsikotik',
    'Lisinopril': 'Kan basıncı düşürücü',
    'Metformin': 'Şeker düşürücü',
    'Plavix': 'Kan pıhtısı önleyici',
    'Synthroid': 'Tiroid hormonu takviyesi',
    'Norvasc': 'Kan basıncı düşürücü',
    'Prednisone': 'Kortikosteroid',
    'Advair Diskus': 'Astım ilacı',
    'Abilify': 'Antipsikotik',
    'Lyrica': 'Ağrı kesici, nöropatik ağrı ilacı',
    'Celebrex': 'Ağrı kesici, iltihap giderici',
    'Zoloft': 'Antidepresan',
    'Effexor': 'Antidepresan',
    'Lipitor': 'Kolesterol düşürücü',
    'Cymbalta': 'Antidepresan',
  };

  TextEditingController _searchController = TextEditingController();
  List<String> filteredIlacListesi = [];

  @override
  void initState() {
    super.initState();
    filteredIlacListesi = favoriIlacListesi;
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          filteredIlacListesi = favoriIlacListesi;
        });
      } else {
        setState(() {
          filteredIlacListesi = favoriIlacListesi
              .where((ilac) =>
                  ilac.toLowerCase().contains(_searchController.text.toLowerCase()))
              .toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: Text("Ilac Bilgisi")),
      drawer: Drawer(
        child: ListView(
          children: [
           
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Favori Ilaçlar',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
            
            ListView.builder(
              shrinkWrap: true,
              itemCount: favoriIlacListesi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Tooltip(
                    message: 'İçerik bilgisi: ${ilacIcerikleri[favoriIlacListesi[index]]}',
                    child: Text(favoriIlacListesi[index]),
                  ),
                  
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IlacDetay(ilacAdi: favoriIlacListesi[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'İlaç Ara',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredIlacListesi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Tooltip(
                    message: 'İçerik bilgisi: ${ilacIcerikleri[filteredIlacListesi[index]]}',
                    child: Text(filteredIlacListesi[index]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IlacDetay(ilacAdi: filteredIlacListesi[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IlacDetay extends StatelessWidget {
  final String ilacAdi;

  IlacDetay({required this.ilacAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ilacAdi),
      ),
      body: Center(
        child: Text(
          'İlaç detay .',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ilacbilgi(),
  ));
}