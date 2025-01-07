import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.orange,
                          child: Text(
                            'JM',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Joana Morais',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Premium UBR',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Stats
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatItem(
                      value: '28',
                      label: 'Pedidos',
                    ),
                    _StatItem(
                      value: '12',
                      label: 'Restaurantes',
                    ),
                    _StatItem(
                      value: '138',
                      label: 'Pontos',
                    ),
                  ],
                ),
              ),

              // Profile Options
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ProfileOptionTile(
                      icon: Icons.person_outline,
                      title: 'Editar perfil',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.location_on_outlined,
                      title: 'Endereços salvos',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.payment_outlined,
                      title: 'Métodos de pagamento',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.notifications_none,
                      title: 'Notificações',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.language,
                      title: 'Idioma',
                      subtitle: 'Português',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.help_outline,
                      title: 'Ajuda & Suporte',
                      onTap: () {},
                    ),
                    ProfileOptionTile(
                      icon: Icons.info_outline,
                      title: 'Sobre',
                      onTap: () {},
                    ),
                    const SizedBox(height: 24),
                    LogoutButton(
                      onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {},
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const ProfileOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(color: Colors.grey),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.logout, color: Colors.red),
      ),
      title: const Text(
        'Sair',
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}