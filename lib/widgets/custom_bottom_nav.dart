import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  // Lista de configurações para cada item da navegação
  static const List<({IconData icon, IconData selectedIcon, String label, String route})> _navItems = [
    (
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Início',
      route: '/home'
    ),
    (
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
      label: 'Buscar',
      route: '/search'
    ),
    (
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      label: 'Carrinho',
      route: '/cart'
    ),
    (
      icon: Icons.history_outlined,
      selectedIcon: Icons.history,
      label: 'Pedidos',
      route: '/history'
    ),
    (
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: 'Perfil',
      route: '/profile'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              final item = _navItems[index];
              return _NavItem(
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                label: item.label,
                isSelected: currentIndex == index,
                onTap: () => _handleNavigation(context, index, item.route),
              );
            }),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index, String route) {
    if (currentIndex != index) {
      onTap(index);
      Navigator.pushReplacementNamed(context, route);
    }
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.orange : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}