import 'package:flutter/material.dart';
import 'profile_tab.dart'; // Profil sekmesine geri dönmek istersen referans

class GameMenuPage extends StatefulWidget {
  final String playerName;
  final Map<String, dynamic> avatar;
  final int ranking;

  const GameMenuPage({
    super.key,
    required this.playerName,
    required this.avatar,
    required this.ranking,
  });

  @override
  State<GameMenuPage> createState() => _GameMenuPageState();
}

class _GameMenuPageState extends State<GameMenuPage> with TickerProviderStateMixin {
  late AnimationController _menuAnimationController;
  late List<Animation<Offset>> _cardAnimations;

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Su Tasarrufu\nOyunu', 'icon': Icons.water_drop, 'color': Colors.blue, 'description': 'Su tasarruf etmeyi öğren'},
    {'title': 'Günlük\nGörevler', 'icon': Icons.checklist, 'color': Colors.green, 'description': 'Günlük görevlerini tamamla'},
    {'title': 'Su Bilgisi\nQuiz', 'icon': Icons.quiz, 'color': Colors.orange, 'description': 'Bilgilerini test et'},
    {'title': 'Başarılar\nve Rozetler', 'icon': Icons.emoji_events, 'color': Colors.purple, 'description': 'Rozetlerini görüntüle'},
    {'title': 'Su Haritası\nKeşfet', 'icon': Icons.map, 'color': Colors.teal, 'description': 'Dünyayı keşfet'},
    {'title': 'Arkadaşlar\nve Liderlik', 'icon': Icons.people, 'color': Colors.pink, 'description': 'Arkadaşlarınla yarış'},
  ];

  @override
  void initState() {
    super.initState();
    _menuAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cardAnimations = List.generate(
      menuItems.length,
          (index) => Tween<Offset>(
        begin: Offset(0, 1 + (index * 0.1)),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _menuAnimationController,
          curve: Interval(index * 0.1, 0.8 + (index * 0.1), curve: Curves.easeOutBack),
        ),
      ),
    );

    _menuAnimationController.forward();
  }

  @override
  void dispose() {
    _menuAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.white, widget.avatar['color'].withOpacity(0.1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst profil barı
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: widget.avatar['color'], width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: widget.avatar['color'].withOpacity(0.1),
                          child: Icon(widget.avatar['icon'], color: widget.avatar['color'], size: 25),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Merhaba, ${widget.playerName}!",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          Text("Seviye ${widget.ranking} • Su Kahramanı",
                              style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined), color: Colors.grey),
                  ],
                ),
              ),

              // Hoşgeldin kartı
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue[400]!, Colors.blue[600]!]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Su Kahramanı Olmaya\nHazır mısın?",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                          SizedBox(height: 8),
                          Text("Oyunlar oynayarak su tasarrufu öğren!",
                              style: TextStyle(fontSize: 14, color: Colors.white70)),
                        ],
                      ),
                    ),
                    Icon(Icons.water_drop, size: 60, color: Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Oyun menü kartları
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.85,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return SlideTransition(
                        position: _cardAnimations[index],
                        child: _buildGameCard(context, menuItems[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _showGameDialog(context, item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: item['color'].withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70, height: 70,
              decoration: BoxDecoration(color: item['color'].withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(item['icon'], size: 35, color: item['color']),
            ),
            const SizedBox(height: 15),
            Text(item['title'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: item['color']),
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(item['description'], style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }

  void _showGameDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [item['color'].withOpacity(0.1), Colors.white],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(color: item['color'].withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(item['icon'], size: 40, color: item['color']),
              ),
              const SizedBox(height: 20),
              Text(item['title'].replaceAll('\n', ' '),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: item['color']),
                  textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Text(item['description'], style: const TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center),
              const SizedBox(height: 25),
              const Text(
                "Bu özellik yakında eklenecek!\nBizi takip etmeye devam edin 🚀",
                style: TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("Geri", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item['color'], foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                      ),
                      child: const Text("Bildirim Al", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
