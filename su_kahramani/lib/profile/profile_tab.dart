import 'package:flutter/material.dart';
import 'game_menu_page.dart'; // Aşağıda 2. adımda ekleyeceğiz

/// HomePage'in 3. sekmesinde gösterilecek profil içeriği.
/// Not: Burada Scaffold KULLANMIYORUZ; HomePage zaten bir Scaffold sağlıyor.
class ProfileTab extends StatefulWidget {
  /// Dışarıdan gelen veriler (HomePage'den):
  final String userName;                 // Mevcut kullanıcı adı
  final int totalPoints;                 // Toplam puan (görevlerden)
  final int tasksDoneCount;              // Tamamlanan görev sayısı (UI istatistiği için)
  final int badgeCount;                  // Rozet sayısı (şimdilik 0 olabilir)
  final Map<String, dynamic> avatar;     // Seçili avatar (renk+ikon+ad)
  final int ranking;                     // Seviye (örn: totalPoints/50 + 1)

  /// Profilde yapılan değişikliklerin HomePage'e bildirilmesi için callback'ler:
  final ValueChanged<String> onNameChanged; // Ad güncelleme
  final VoidCallback onResetToday;          // Bugünkü görevleri sıfırla

  const ProfileTab({
    Key? key,
    required this.userName,
    required this.totalPoints,
    required this.tasksDoneCount,
    required this.badgeCount,
    required this.avatar,
    required this.ranking,
    required this.onNameChanged,
    required this.onResetToday,
  }) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with TickerProviderStateMixin {
  late AnimationController _profileAnimationController;
  late Animation<double> _scaleAnimation;
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    // Profil kartı için giriş animasyonu
    _profileAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _profileAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    _profileAnimationController.forward();

    // Ad düzenleme alanı: mevcut kullanıcı adıyla doldur
    _nameCtrl = TextEditingController(text: widget.userName);
  }

  @override
  void dispose() {
    _profileAnimationController.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sekme içi: Arkaplan gradyanı + içerik listesi
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.avatar['color'].withOpacity(0.12), // avatar rengiyle uyumlu
            Colors.white,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Üst başlık satırı (sekme içi olduğu için sade)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profilim",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Ayarlar menüsü ileride eklenebilir
                  },
                  icon: const Icon(Icons.settings, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Profil kartı
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: widget.avatar['color'].withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.avatar['color'],
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.avatar['color'].withOpacity(0.25),
                            blurRadius: 18,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        widget.avatar['icon'],
                        size: 60,
                        color: widget.avatar['color'],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // İsim
                    Text(
                      widget.userName.isEmpty ? "İsimsiz Kahraman" : widget.userName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Avatar adı etiketi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.avatar['color'].withOpacity(0.16),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.avatar['name'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: widget.avatar['color'],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Seviye rozeti
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        "Seviye ${widget.ranking}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // İstatistikler
            Row(
              children: [
                Expanded(child: _buildStatCard("Puan", widget.totalPoints.toString(), Icons.star, Colors.amber)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard("Görevler", widget.tasksDoneCount.toString(), Icons.check_circle, Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard("Rozetler", widget.badgeCount.toString(), Icons.emoji_events, Colors.purple)),
              ],
            ),

            const SizedBox(height: 24),

            // Adı düzenleme kartı
            _buildNameEditCard(context),

            const SizedBox(height: 16),

            // İşlemler kartı
            _buildActionsCard(context),
          ],
        ),
      ),
    );
  }

  /// Küçük istatistik kartı (puan / görev / rozet)
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// Adı düzenlemeye yarayan kart (input + kaydet butonu).
  /// Kaydet'e basınca, düzeltip parent'a bildirir (onNameChanged).
  Widget _buildNameEditCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 50, 50, 89), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Adını Düzenle',
            style: TextStyle(
              fontFamily: "Grandstander",
              fontSize: 18,
              color: Color.fromARGB(255, 50, 50, 89),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _nameCtrl,
            decoration: const InputDecoration(
              hintText: 'Damla',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                final fixed = _fixCasing(_nameCtrl.text);
                widget.onNameChanged(fixed); // HomePage'e bildir
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ad güncellendi')),
                );
              },
              child: const Text('Kaydet'),
            ),
          ),
        ],
      ),
    );
  }

  /// İşlemler (Bugünü sıfırla + Oyuna Başla vb.)
  Widget _buildActionsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 50, 50, 89), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'İşlemler',
            style: TextStyle(
              fontFamily: "Grandstander",
              fontSize: 18,
              color: Color.fromARGB(255, 50, 50, 89),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              widget.onResetToday(); // HomePage'de görevleri sıfırlar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bugünkü görevler sıfırlandı')),
              );
            },
            child: const Text('Bugünü Sıfırla'),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {
              // Tam ekran bir menü sayfasına gidebilir (route)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GameMenuPage(
                    playerName: widget.userName,
                    avatar: widget.avatar,
                    ranking: widget.ranking,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Oyuna Başla'),
          ),
        ],
      ),
    );
  }

  /// Adın ilk harfini büyüt, kalanını küçült (TR karakterlerine saygılı)
  String _fixCasing(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    final first = trimmed.characters.first.toUpperCase();
    final rest = trimmed.substring(first.length).toLowerCase();
    return '$first$rest';
  }
}
