import 'package:flutter/material.dart';

void main() {
  runApp(const SalatStreakApp());
}

class PrayerEntry {
  const PrayerEntry({
    required this.name,
    required this.arabic,
    required this.icon,
  });

  final String name;
  final String arabic;
  final IconData icon;
}

const prayers = [
  PrayerEntry(name: 'Fajr', arabic: 'الفجر', icon: Icons.wb_twilight_outlined),
  PrayerEntry(name: 'Dhuhr', arabic: 'الظهر', icon: Icons.wb_sunny_outlined),
  PrayerEntry(name: 'Asr', arabic: 'العصر', icon: Icons.brightness_5_outlined),
  PrayerEntry(name: 'Maghrib', arabic: 'المغرب', icon: Icons.brightness_4_outlined),
  PrayerEntry(name: 'Isha', arabic: 'العشاء', icon: Icons.dark_mode_outlined),
];

const motivations = [
  'Petite régularité, grand impact.',
  'Une journée structurée autour du rappel vaut beaucoup.',
  'La constance bat l’intensité courte.',
  'Chaque prière cochée renforce la suivante.',
  'Protège ta journée, une salat à la fois.',
];

class SalatStreakApp extends StatelessWidget {
  const SalatStreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salat Streak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1F6F5F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F3EE),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> completedPrayers = {'Fajr', 'Dhuhr'};
  final int currentStreak = 6;
  final int bestStreak = 18;
  final List<int> last30Days = const [
    5, 5, 4, 5, 3, 5, 5, 4, 5, 5,
    4, 5, 5, 5, 2, 4, 5, 5, 5, 5,
    4, 5, 3, 5, 5, 4, 5, 5, 2, 5,
  ];

  int get todayCount => completedPrayers.length;

  double get todayProgress => todayCount / prayers.length;

  void togglePrayer(String name) {
    setState(() {
      if (completedPrayers.contains(name)) {
        completedPrayers.remove(name);
      } else {
        completedPrayers.add(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final motivation = motivations[todayCount % motivations.length];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Salat Streak',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Une app simple, locale et sans pub pour suivre ta régularité.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            _HeroCard(
              progress: todayProgress,
              completed: todayCount,
              total: prayers.length,
              motivation: motivation,
              currentStreak: currentStreak,
              bestStreak: bestStreak,
            ),
            const SizedBox(height: 20),
            Text(
              'Prières du jour',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...prayers.map((prayer) {
              final done = completedPrayers.contains(prayer.name);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PrayerTile(
                  entry: prayer,
                  done: done,
                  onTap: () => togglePrayer(prayer.name),
                ),
              );
            }),
            const SizedBox(height: 8),
            Text(
              '30 derniers jours',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _HistoryCard(days: last30Days),
            const SizedBox(height: 20),
            _MonetizationCard(),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.progress,
    required this.completed,
    required this.total,
    required this.motivation,
    required this.currentStreak,
    required this.bestStreak,
  });

  final double progress;
  final int completed;
  final int total;
  final String motivation;
  final int currentStreak;
  final int bestStreak;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1F6F5F), Color(0xFF2C8C76)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aujourd’hui',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completed / $total prières validées',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _MetricChip(label: 'Streak', value: '$currentStreak j'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricChip(label: 'Best', value: '$bestStreak j'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            motivation,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerTile extends StatelessWidget {
  const _PrayerTile({
    required this.entry,
    required this.done,
    required this.onTap,
  });

  final PrayerEntry entry;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: done ? const Color(0xFFDFF3EB) : Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: done ? const Color(0xFF1F6F5F) : const Color(0xFFEDE7DC),
                child: Icon(
                  entry.icon,
                  color: done ? Colors.white : const Color(0xFF1F6F5F),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      entry.arabic,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                done ? Icons.check_circle : Icons.radio_button_unchecked,
                color: done ? const Color(0xFF1F6F5F) : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.days});

  final List<int> days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chaque barre représente le nombre de prières cochées sur 5.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: days.map((count) {
                final ratio = (count / 5).clamp(0, 1).toDouble();
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      height: 18 + (ratio * 62),
                      decoration: BoxDecoration(
                        color: count >= 5
                            ? const Color(0xFF1F6F5F)
                            : count >= 3
                                ? const Color(0xFF72B39D)
                                : const Color(0xFFD7E7E0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonetizationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0D9A8)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Idée de monétisation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            'Vendre une version premium simple: thèmes, export local, objectifs personnalisés, rappels intelligents et statistiques étendues. Sans pub, sans backend, sans contenu douteux.',
          ),
        ],
      ),
    );
  }
}
