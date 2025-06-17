import 'package:flutter/material.dart';
import '../../widgets/logo_clinicasa.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    const black = Color(0xFF35393C);
    const gray = Color(0xFF878787);
    final green10 = green.withOpacity(0.10);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                height: 110,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                _CategoryButton(
                                  icon: Icons.healing_rounded,
                                  label: 'Fisioterapeutas',
                                  color: green,
                                  background: green10,
                                ),
                                const SizedBox(width: 12),
                                _CategoryButton(
                                  icon: Icons.elderly_rounded,
                                  label: 'Cuidadores',
                                  color: green,
                                  background: green10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: Row(
                              children: [
                                _CategoryButton(
                                  icon: Icons.spa_rounded,
                                  label: 'Massagistas',
                                  color: green,
                                  background: green10,
                                ),
                                const SizedBox(width: 12),
                                _CategoryButton(
                                  icon: Icons.psychology_rounded,
                                  label: 'Psicólogos',
                                  color: green,
                                  background: green10,
                                ),
                                const SizedBox(width: 12),
                                _CategoryButton(
                                  icon: Icons.medical_services_rounded,
                                  label: 'Exames',
                                  color: green,
                                  background: green10,
                                ),
                                const SizedBox(width: 12),
                                _CategoryButton(
                                  icon: Icons.more_horiz,
                                  label: 'Diversos',
                                  color: green,
                                  background: green10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Seus últimos serviços
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Seus últimos serviços',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    'Ver todos >',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: green,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _ServiceAvatar(
                    name: 'Ana Maria',
                    role: 'Fisioterapia',
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _ServiceAvatar(
                    name: 'João Silva',
                    role: 'Fisioterapia',
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _ServiceAvatar(
                    name: 'Ana Maria',
                    role: 'Fisioterapia',
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _ServiceAvatar(
                    name: 'Miguel de Oliveira',
                    role: 'Cuidador',
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                ],
              ),
            ),
            // Os melhores perto de você
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Os melhores perto de você!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    'Ver todos >',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: green,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _BestNearYouTile(
                    name: 'Ana Maria',
                    role: 'Fisioterapia',
                    rating: 5.0,
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _BestNearYouTile(
                    name: 'João Silva',
                    role: 'Fisioterapia',
                    rating: 5.0,
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _BestNearYouTile(
                    name: 'Miguel de Oliveira',
                    role: 'Cuidador',
                    rating: 5.0,
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                  _BestNearYouTile(
                    name: 'Mariana Fernandes',
                    role: 'Psicóloga',
                    rating: 5.0,
                    image: null,
                    color: green,
                    black: black,
                    gray: gray,
                  ),
                ],
              ),
            ),
            // Bottom navigation
            _BottomNavBar(green: green, black: black, gray: gray),
          ],
        ),
      ),
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
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: image == null
                ? Icon(Icons.person, color: color, size: 28)
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            role,
            style: TextStyle(
              color: gray,
              fontWeight: FontWeight.w400,
              fontSize: 11,
              fontFamily: 'Inter',
            ),
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(0.15),
            child: image == null
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
                        fontSize: 15,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                Text(
                  role,
                  style: TextStyle(
                    color: gray,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
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
  const _BottomNavBar({
    required this.green,
    required this.black,
    required this.gray,
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
          ),
          _NavBarItem(
            icon: Icons.search_rounded,
            label: 'Busca',
            selected: false,
            color: green,
            black: black,
            gray: gray,
          ),
          _NavBarItem(
            icon: Icons.calendar_today_rounded,
            label: 'Consultas',
            selected: false,
            color: green,
            black: black,
            gray: gray,
          ),
          _NavBarItem(
            icon: Icons.person_rounded,
            label: 'Perfil',
            selected: false,
            color: green,
            black: black,
            gray: gray,
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
  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.black,
    required this.gray,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: selected ? color : gray, size: 28),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: selected ? color : gray,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
