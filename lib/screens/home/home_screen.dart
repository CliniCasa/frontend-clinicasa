import 'package:flutter/material.dart';
import '../../models/worker.dart';
import '../../services/worker_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Worker> workers = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  Future<void> _loadWorkers() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final workersList = await WorkerService.getWorkers(
        page: 1,
        limit: 7,
        search: '', // sem busca por nome
      );

      setState(() {
        workers = workersList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Erro ao carregar profissionais: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    const black = Color(0xFF35393C);
    const gray = Color(0xFF878787);
    const grayNavbar = Color(0xFFA5A5A5);
    final green10 = green.withOpacity(0.10);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 32,
                bottom: 24,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rua das Flores, 123',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: green,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_rounded,
                    color: green,
                    size: 24,
                  ),
                ],
              ),
            ),
            // Categorias
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.fitness_center,
                          label: 'Fisioterapeutas',
                          color: green,
                          background: green10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.wash,
                          label: 'Massagistas',
                          color: green,
                          background: green10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.elderly_woman,
                          label: 'Cuidadores',
                          color: green,
                          background: green10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.self_improvement,
                          label: 'Psicólogos',
                          color: green,
                          background: green10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.medication,
                          label: 'Exames',
                          color: green,
                          background: green10,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _CategoryButton(
                          icon: Icons.more_horiz_outlined,
                          label: 'Diversos',
                          color: green,
                          background: green10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Agende outros serviços
            const SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Agende outros serviços!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Ver todos',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: green,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: 1),
                      Icon(Icons.chevron_right_rounded, color: green, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: _buildWorkersList(theme, green, black, gray)),
            // Bottom navigation
            _BottomNavBar(
              green: green,
              black: black,
              gray: gray,
              grayNavbar: grayNavbar,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkersList(
    ThemeData theme,
    Color green,
    Color black,
    Color gray,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadWorkers,
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    if (workers.isEmpty) {
      return const Center(child: Text('Nenhum profissional encontrado'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: workers.length,
      itemBuilder: (context, index) {
        final worker = workers[index];
        return GestureDetector(
          onTap: () async {
            try {
              final fetchedWorker = await WorkerService.getWorkerById(
                worker.id,
              );
              if (!mounted) return;
              Navigator.of(
                context,
              ).pushNamed('/professional', arguments: fetchedWorker);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao buscar profissional: $e')),
              );
            }
          },
          child: _BestNearYouTile(
            name: worker.name,
            role: worker.role,
            rating: 5.0, // Estrelas fixas em 5.0
            image: null, // Sem foto por enquanto
            color: green,
            black: black,
            gray: gray,
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color background;
  const _CategoryButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceAvatar extends StatelessWidget {
  final String name;
  final String role;
  final String? image;
  final Color color;
  final Color black;
  final Color gray;
  const _ServiceAvatar({
    required this.name,
    required this.role,
    this.image,
    required this.color,
    required this.black,
    required this.gray,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null && image!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SizedBox(
        height: 104,
        width: 96,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: color.withOpacity(0.15),
                backgroundImage: hasImage ? NetworkImage(image!) : null,
                child: !hasImage
                    ? Icon(Icons.person, color: color, size: 24)
                    : null,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                role,
                style: TextStyle(
                  color: gray,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BestNearYouTile extends StatelessWidget {
  final String name;
  final String role;
  final double rating;
  final String? image;
  final Color color;
  final Color black;
  final Color gray;
  const _BestNearYouTile({
    required this.name,
    required this.role,
    required this.rating,
    this.image,
    required this.color,
    required this.black,
    required this.gray,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = image != null && image!.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: color.withOpacity(0.15),
            backgroundImage: hasImage ? NetworkImage(image!) : null,
            child: !hasImage
                ? Icon(Icons.person, color: color, size: 28)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: Color(0xFFFFC107),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      role,
                      style: TextStyle(
                        color: gray,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final Color green;
  final Color black;
  final Color gray;
  final Color grayNavbar;
  const _BottomNavBar({
    required this.green,
    required this.black,
    required this.gray,
    required this.grayNavbar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            icon: Icons.home_rounded,
            label: 'Início',
            selected: true,
            color: green,
            black: black,
            gray: gray,
            grayNavbar: grayNavbar,
          ),
          _NavBarItem(
            icon: Icons.search_rounded,
            label: 'Busca',
            selected: false,
            color: green,
            black: black,
            gray: gray,
            grayNavbar: grayNavbar,
          ),
          _NavBarItem(
            icon: Icons.calendar_month_outlined,
            label: 'Consultas',
            selected: false,
            color: green,
            black: black,
            gray: gray,
            grayNavbar: grayNavbar,
          ),
          _NavBarItem(
            icon: Icons.person_outlined,
            label: 'Perfil',
            selected: false,
            color: green,
            black: black,
            gray: gray,
            grayNavbar: grayNavbar,
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final Color black;
  final Color gray;
  final Color grayNavbar;
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.black,
    required this.gray,
    required this.grayNavbar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: selected ? color : grayNavbar, size: 28),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: selected ? color : grayNavbar,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
