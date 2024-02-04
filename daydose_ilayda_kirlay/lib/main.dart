import 'package:flutter/material.dart';
import 'package:flutter_application_1/giris_kayit.dart';
import 'package:flutter_application_1/ilac_bilgi.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAYDOSE',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Color.fromARGB(255, 255, 228, 230),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _selectedDay = DateTime.now();
  List<Medication> medications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DAYDOSE', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              showNotificationMenu(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                  12,
                  (index) => MedicationImageCard(index: index),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Colors.pink,
              child: Center(
                child: medications.isEmpty
                    ? SizedBox()
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: medications.length,
                        itemBuilder: (context, index) {
                          return MedicationCard(medication: medications[index]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.medication, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationsListPage(
                      medications: medications,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ilacbilgi(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.how_to_reg, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GirisKayit(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMedicationPage(
                onMedicationAdded: (medication) {
                  setState(() {
                    medications.add(medication);
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void showNotificationMenu(BuildContext context) async {
    final RenderBox appBar = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        appBar.localToGlobal(appBar.size.bottomLeft(Offset.zero), ancestor: overlay),
        appBar.localToGlobal(appBar.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    await showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('Bildirimleri Aç'),
            onTap: () {
              
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.notifications_off),
            title: Text('Bildirimleri Kapat'),
            onTap: () {
              
              Navigator.pop(context);
            },
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  bool isSameDay(DateTime selectedDay, day) {
    
    return false; 
  }
  
  TableCalendar({required bool Function(dynamic day) selectedDayPredicate, required Null Function(dynamic selectedDay, dynamic focusedDay) onDaySelected}) {}
}

class MedicationImageCard extends StatelessWidget {
  final int index;

  MedicationImageCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          'assets/image_$index.png',
          height: 60.0,
          width: 60.0,
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;

  MedicationCard({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              medication.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              medication.dosage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              medication.schedule,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMedicationPage extends StatefulWidget {
  final Function(Medication) onMedicationAdded;

  AddMedicationPage({required this.onMedicationAdded});

  @override
  _AddMedicationPageState createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dosageController = TextEditingController();
  TextEditingController _scheduleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlaç Ekle', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'İlaç Adı', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _dosageController,
                decoration: InputDecoration(labelText: 'Dozaj', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _scheduleController,
                decoration: InputDecoration(labelText: 'Zamanlama', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  String dosage = _dosageController.text;
                  String schedule = _scheduleController.text;

                  Medication newMedication = Medication(name, dosage, schedule, false, '');

                  widget.onMedicationAdded(newMedication);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('İlaç başarıyla eklendi.', style: TextStyle(color: Colors.white)),
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text('Ekle'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text('Ana Sayfa', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MedicationsListPage extends StatelessWidget {
  final List<Medication> medications;

  MedicationsListPage({required this.medications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlaçlarım', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return MedicationListItem(medications[index]);
        },
      ),
    );
  }
}

class MedicationListItem extends StatelessWidget {
  final Medication medication;

  MedicationListItem(this.medication);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              medication.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dozaj: ${medication.dosage}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Zamanlama: ${medication.schedule}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İlaç Bilgileri', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text('İlaç Bilgileri', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _adController = TextEditingController();
  TextEditingController _soyadController = TextEditingController();
  TextEditingController _kiloController = TextEditingController();
  TextEditingController _boyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hoşgeldiniz', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: TextField(
                controller: _adController,
                decoration: InputDecoration(labelText: 'Ad', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _soyadController,
                decoration: InputDecoration(labelText: 'Soyad', labelStyle: TextStyle(color: Colors.white)),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _kiloController,
                decoration: InputDecoration(labelText: 'Kilo', labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _boyController,
                decoration: InputDecoration(labelText: 'Boy', labelStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String ad = _adController.text;
                  String soyad = _soyadController.text;
                  double kilo = double.tryParse(_kiloController.text) ?? 0.0;
                  double boy = double.tryParse(_boyController.text) ?? 0.0;

                  

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Kayıt başarıyla tamamlandı.', style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
                child: Text('Kaydet'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Medication {
  String name;
  String dosage;
  String schedule;
  bool isTaken;
  String notes;

  Medication(this.name, this.dosage, this.schedule, this.isTaken, this.notes);
}
