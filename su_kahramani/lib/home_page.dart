import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:su_kahramani/story_levels/story_brush.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:su_kahramani/profile/profile_tab.dart';

class HomePage extends StatefulWidget {
  final String? initialName;

  const HomePage({Key? key, this.initialName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 1;
  String _userName = "";
  int _selectedAvatarIndex = 0;

  // Yeni: görev listesi
  late List<Task> _tasks;

  final List<Map<String, dynamic>> kAvatars = [
    {'icon': Icons.water_drop, 'color': Colors.blue, 'name': 'Su Damlası'},
    {'icon': Icons.eco, 'color': Colors.green, 'name': 'Doğa Dostu'},
    {'icon': Icons.wb_sunny, 'color': Colors.orange, 'name': 'Güneş'},
    {'icon': Icons.star, 'color': Colors.purple, 'name': 'Yıldız'},
    {'icon': Icons.favorite, 'color': Colors.pink, 'name': 'Kalp'},
    {'icon': Icons.flash_on, 'color': Colors.yellow, 'name': 'Şimşek'},
  ];

  // Tamamlanan görevlerin puanları
  int get totalPoints => _tasks.where((t) => t.done).fold(0, (sum, t) => sum + t.points);
  int get tasksDoneCount => _tasks.where((t) => t.done).length;
  int get badgeCount => 0; // Şimdilik 0, rozet sistemi eklenince güncellenir.
  int get ranking => (totalPoints ~/ 50) + 1; // Örn: her 50 puan = +1 seviye



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // main.dart'tan gelen initial değerleri kullan
    _userName = widget.initialName ?? "";

    // Görevleri oluştur (puanları istediğin gibi ayarlayabilirsin)
    _tasks = [
      Task(title: 'Dişimi fırçalarken çeşmeyi kapattım.', points: 10),
      Task(title: 'Bol su içtim ve hiç dökmedim.', points: 8),
      Task(title: 'Arabayı hortumla değil, kova ile yıkadık.', points: 12),
      Task(title: 'Banyo yaparken suyu uzun süre boşa akıtmadım.', points: 10),
      Task(title: 'Kirli kıyafetleri az az değil, biriktirip makinede yıkadık.', points: 10),
      // İstersen daha fazla ekle
    ];

    _loadChecklistStates(); // checkbox/görev durumlarını yükle
  }


  /// Görevlerin tamamlanma durumlarını kalıcı depodan (SharedPreferences) yükler
  Future<void> _loadChecklistStates() async {
    final prefs = await SharedPreferences.getInstance();

    // Okunan değerleri state'e yaz ve UI'yi yeniden çiz
    setState(() {
      for (int i = 0; i < _tasks.length; i++) {
        // Eğer daha önce kayıt yoksa varsayılan false (işaretli değil)
        _tasks[i].done = prefs.getBool('task_done_$i') ?? false;
      }
    });
  }

  /// Mevcut görevlerin tamamlanma durumlarını kalıcı depoya yazar.
  Future<void> _saveChecklistStates() async {
    final prefs = await SharedPreferences.getInstance();

    // Her görev için tamamlanma durumunu 'task_done_i' anahtarıyla sakla
    for (int i = 0; i < _tasks.length; i++) {
      await prefs.setBool('task_done_$i', _tasks[i].done);
    }
  }


  // İsim kaydet
  Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('playerName', name);
    setState(() {
      _userName = name;
      print('Kaydedilen isim: $name');
    });
  }

  /// Kullanıcı bir checkbox'ı değiştirdiğinde çağrılır.
  void _toggleTask(int index, bool? value) {

    // UI'yi anında güncelle: null değer gelirse false'a düşür.
    // totalPoints getter olduğu için otomatik güncellenecek
    setState(() {
      _tasks[index].done = value ?? false;
    });

    // Kalıcı depoya yaz
    _saveChecklistStates();

  }


  /// Skor çubuğu tasarımı
  Widget _scoreBar() {
    final int maxDaily = _tasks.fold(0, (sum, t) => sum + t.points);
    final double ratio = maxDaily == 0 ? 0 : totalPoints / maxDaily;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 50, 50, 89), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 138, 205, 215),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Puan: $totalPoints',
                  style: TextStyle(
                    fontFamily: "Grandstander",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Günlük hedef: $maxDaily',
                style: TextStyle(fontFamily: "Grandstander", fontSize: 16, color: Color.fromARGB(255, 50, 50, 89)),
              ),
            ],
          ),
          SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: ratio.clamp(0, 1),
              minHeight: 10,
              backgroundColor: Color.fromARGB(255, 224, 244, 255),
              valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 0, 162, 206)),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _speechText(
                  _userName.isEmpty
                      ? "Hey, senin için günlük plan hazırladım. \n Her gün tamamla, \n her gün kahraman ol!"
                      : "Hey $_userName, senin için günlük plan hazırladım. \n Her gün tamamla, \n her gün kahraman ol!",
                  150,
                  300,
                ),
                _mainCharImg(_animation, "assets/character/world_joyful.png"),
                _checkList(),
              ],
            ),
          ],
        ),
      ),
      Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _speechText(
                  _userName.isEmpty
                      ? "Merhaba! \n Su Kahramanı olmaya hazır mısın?"
                      : "Merhaba $_userName! \n Su Kahramanı olmaya hazır mısın?",
                  100,
                  300,
                ),
                _mainCharImg(_animation, "assets/character/main_char.png"),
                _startButton(),
              ],
            ),
          ],
        ),
      ),
      // 3. SAYFA: Profil sekmesi
      ProfileTab(
        userName: _userName,
        totalPoints: totalPoints,
        tasksDoneCount: tasksDoneCount,
        badgeCount: badgeCount,
        avatar: kAvatars[_selectedAvatarIndex],
        ranking: ranking,
        onNameChanged: (newName) async {
          setState(() { _userName = newName; });
          await _saveName(newName); // Zaten sende var
        },
        onResetToday: _resetAllTasks, // Aşağıda veriyoruz
      ),

    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 224, 244, 255),
      appBar: _appBar(),
      body: pages[_currentIndex],
      bottomNavigationBar: _navigationBar(context),
    );
  }

  /// Tüm görevleri 'tamamlanmadı' durumuna çeker ve kalıcı kaydeder.
  /// Profil sekmesindeki "Bugünü Sıfırla" butonu bunu çağırır.
  void _resetAllTasks() {
    setState(() {
      for (final t in _tasks) {
        t.done = false;
      }
    });
    _saveChecklistStates();
  }


  Column _checkList() {
    return Column(
      children: [
        _scoreBar(), //  Üstte puan çubuğu

        // ✅ Her görev için bir satır oluştur
        ...List.generate(_tasks.length, (index) {
          final task = _tasks[index];

          return Padding(
            padding: const EdgeInsets.only(left: 4, right: 8, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 6),

                // Görevin tamamlanma durumu (işaretli mi?)
                Checkbox(
                  value: task.done,
                  onChanged: (val) => _toggleTask(index, val), // Tıklandığında state + kalıcı kayıt
                  checkColor: Colors.white,

                  // Checkbox kutusunun dolgu rengi: seçiliyse lacivert, değilse beyaz
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Color.fromARGB(255, 50, 50, 89);
                    }
                    return Colors.white;
                  }),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${task.title}\n', // Görev cümlesi
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Grandstander",
                            color: Colors.black,
                            decoration: task.done ? TextDecoration.lineThrough : TextDecoration.none,
                            decorationThickness: 5,
                            decorationColor: Color.fromARGB(255, 50, 50, 89),
                          ),
                        ),
                        TextSpan(
                          text: '+${task.points} puan',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Grandstander",
                            color: Color.fromARGB(255, 0, 162, 206),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    softWrap: true, // Metin satır sonuna gelince düzgün taşsın
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }


  Center _mainCharImg(Animation<double> animation, String path) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, animation.value),
            child: child,
          );
        },
        child: Container(
          height: 400,
          width: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }

  Center _startButton() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (_userName.isEmpty) {
            String? name = await showDialog<String>(
              context: context,
              builder: (context) {
                String tempName = "";
                return AlertDialog(
                  title: Text(
                    "Adın Nedir?",
                    style: TextStyle(fontFamily: "Grandstander"),
                  ),
                  content: TextField(
                    onChanged: (value) {
                      tempName = value;
                    },
                    decoration: InputDecoration(hintText: "Damla"),
                    style: TextStyle(fontFamily: "Grandstander"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "İptal",
                        style: TextStyle(fontFamily: "Grandstander"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, tempName);
                      },
                      child: Text(
                        "Tamam",
                        style: TextStyle(fontFamily: "Grandstander"),
                      ),
                    ),
                  ],
                );
              },
            );
            if (name != null && name.isNotEmpty) {
              setState(() {
                _userName = name[0].toUpperCase() + name.substring(1).toLowerCase();
              });

              await _saveName(_userName);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryBrush(userName: _userName),
                ),
              );
            }
          } else if (_userName.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryBrush(userName: _userName),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 50,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 50, 50, 89),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10.0),
            gradient: RadialGradient(
              radius: 3.0,
              colors: [
                Color.fromARGB(255, 190, 241, 255),
                Color.fromARGB(255, 0, 162, 206),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "Hikayeye Başla",
              style: TextStyle(
                color: Color.fromARGB(255, 50, 50, 89),
                fontFamily: "Grandstander",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Center _speechText(String txt, double hght, double wdth) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.all(10.0),
        height: hght,
        width: wdth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color.fromARGB(255, 50, 50, 89),
        ),
        child: TypeWriter.text(
          txt,
          key: ValueKey(txt),
          maintainSize: true,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: "Grandstander",
            color: Colors.white,
          ),
          duration: const Duration(milliseconds: 50),
        ),
      ),
    );
  }

  Theme _navigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.white)),
      child: CurvedNavigationBar(
        index: _currentIndex,
        animationCurve: Easing.standardDecelerate,
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Color.fromARGB(255, 224, 244, 255),
        color: Color.fromARGB(255, 138, 205, 215),
        buttonBackgroundColor: Color.fromARGB(255, 0, 162, 206),
        items: [
          Icon(Icons.check_box, size: 30),
          SvgPicture.asset('assets/drop.svg', width: 35, height: 35),
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      actions: [ // Rozet
        Container(
          margin: EdgeInsets.only(right: 12),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Text(
            '⭐ $totalPoints',
            style: TextStyle(
              fontFamily: "Grandstander",
              color: Color.fromARGB(255, 50, 50, 89),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],

      backgroundColor: Color.fromARGB(255, 138, 205, 215),
      title: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 3.0,
              colors: [
                Color.fromARGB(255, 0, 162, 206),
                Color.fromARGB(255, 138, 205, 215),
              ],
            ),
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            "Su Kahramanı",
            style: TextStyle(
              fontFamily: "Grandstander",
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Tek bir kontrol listesi (görev) öğesini temsil eder.
/// Başlık, puan ve tamamlanma durumunu birlikte tutar.
class Task {
  /// Görev metni (çocuklara gösterilen cümle)
  final String title;

  /// Görev tamamlanınca verilecek puan
  final int points;

  /// İşaretlenme durumu (varsayılan: tamamlanmadı)
  bool done;

  /// Yeni bir görev oluşturur. [done] varsayılanı false'tur.
  Task({required this.title, required this.points, this.done = false});
}
