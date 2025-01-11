import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/session_provider.dart';
import '../../providers/user_settings_provider.dart';
import '../../widgets/custom_bottom_nav.dart';
import 'widgets/adress_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Sair da conta'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/', 
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            title: Text('Perfil'),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const ProfileHeader(),
                const SizedBox(height: 24),
                const ProfileStats(),
                const SizedBox(height: 24),
                ProfileOptions(onLogout: () => _handleLogout(context)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (index != 5) {
            final routes = ['/home', '/cart', '/saved', '/history', '/profile'];
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        },
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              Consumer<SessionProvider>(
                builder: (context, session, child) => CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.orange,
                  child: Text(
                    session.userName.isNotEmpty
                        ? session.userName.substring(0, 1).toUpperCase()
                        : 'A',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/profile/edit');
                  },
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
              ),
            ],
          ),
          const SizedBox(height: 16),
          Consumer<SessionProvider>(
            builder: (context, session, child) => Text(
              session.userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            'Premium Tuga',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItem(value: '28', label: 'Pedidos'),
          StatItem(value: '12', label: 'Restaurantes'),
          StatItem(value: '138', label: 'Pontos'),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({
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

class ProfileOptions extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileOptions({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  void _handleAddressSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Endereços Salvos'),
        content: SizedBox(
          width: double.maxFinite,
          child: Consumer<UserSettingsProvider>(
            builder: (context, settings, child) {
              if (settings.addresses.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum endereço salvo',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: settings.addresses.length,
                itemBuilder: (context, index) {
                  final address = settings.addresses[index];
                  return Card(
                    color: const Color(0xFF2E2E2E),
                    child: ListTile(
                      leading: Icon(
                        address.isDefault ? Icons.home : Icons.location_on,
                        color: Colors.orange,
                      ),
                      title: Text(address.name),
                      subtitle: Text(
                        '${address.street}, ${address.number}${address.complement.isNotEmpty ? ' - ${address.complement}' : ''}\n${address.city}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!address.isDefault)
                            IconButton(
                              icon: const Icon(Icons.star_border),
                              onPressed: () {
                                settings.setDefaultAddress(address.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Endereço principal atualizado'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AddressDialog(address: address),
                              );
                            },
                          ),
                          if (!address.isDefault)
                            IconButton(
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () {
                                settings.removeAddress(address.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Endereço removido'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => const AddressDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Novo Endereço'),
          ),
        ],
      ),
    );
  }
  void _handlePaymentSettings(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text('Métodos de Pagamento'),
      content: Consumer<SessionProvider>(
        builder: (context, session, child) {
          if (session.savedCards.isEmpty) {
            return const SizedBox(
              height: 100,
              child: Center(
                child: Text(
                  'Nenhum cartão salvo',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          return SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: session.savedCards.length,
              itemBuilder: (context, index) {
                final card = session.savedCards[index];
                return Card(
                  color: const Color(0xFF2E2E2E),
                  child: ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.orange),
                    title: Text(card.maskedNumber),
                    subtitle: Text('${card.holderName} - ${card.expiryDate}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!card.isDefault)
                          TextButton(
                            onPressed: () {
                              session.setDefaultCard(card.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Cartão definido como principal')),
                              );
                            },
                            child: const Text('Tornar Principal'),
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            session.removeCreditCard(card.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Cartão removido')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
        ElevatedButton(
          onPressed: () {
            _showAddCardDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text('Adicionar Cartão'),
        ),
      ],
    ),
  );
}

void _handleNotificationSettings(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text('Notificações'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Pedidos'),
                subtitle: const Text('Status e atualizações de pedidos'),
                value: true, // Em um app real, viria do provider
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    // Atualizar no provider
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Promoções'),
                subtitle: const Text('Cupons e ofertas especiais'),
                value: true, // Em um app real, viria do provider
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    // Atualizar no provider
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Restaurantes'),
                subtitle: const Text('Novos restaurantes próximos'),
                value: false, // Em um app real, viria do provider
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    // Atualizar no provider
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Atualizações'),
                subtitle: const Text('Novidades do app'),
                value: true, // Em um app real, viria do provider
                activeColor: Colors.orange,
                onChanged: (bool value) {
                  setState(() {
                    // Atualizar no provider
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    ),
  );
}

void _handleSupport(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1E1E1E),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Como podemos ajudar?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.chat_outlined, color: Colors.orange),
            title: const Text('Chat com Suporte'),
            subtitle: const Text('Tempo médio de resposta: 5 min'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Iniciando chat com suporte...')),
              );
              // Implementar navegação para o chat
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined, color: Colors.orange),
            title: const Text('Central de Atendimento'),
            subtitle: const Text('Disponível 24/7'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ligando para central...')),
              );
              // Implementar chamada telefônica
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.orange),
            title: const Text('Perguntas Frequentes'),
            subtitle: const Text('Respostas rápidas'),
            onTap: () {
              Navigator.pop(context);
              _showFAQ(context);
            },
          ),
        ],
      ),
    ),
  );
}

void _showFAQ(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text('Perguntas Frequentes'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFAQItem(
              'Como cancelar um pedido?',
              'Você pode cancelar um pedido através da tela de "Pedidos" enquanto ele estiver no status "Confirmando".',
            ),
            _buildFAQItem(
              'Tempo médio de entrega?',
              'O tempo médio de entrega varia de acordo com a distância e o restaurante, mas geralmente é entre 30-45 minutos.',
            ),
            _buildFAQItem(
              'Formas de pagamento aceitas?',
              'Aceitamos cartões de crédito, débito, MB WAY e dinheiro na entrega.',
            ),
            _buildFAQItem(
              'Área de entrega?',
              'A área de entrega varia de acordo com cada restaurante. Você pode verificar se entregamos em seu endereço na tela inicial.',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Fechar'),
        ),
      ],
    ),
  );
}

Widget _buildFAQItem(String question, String answer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          answer,
          style: const TextStyle(color: Colors.grey),
        ),
        const Divider(height: 16),
      ],
    ),
  );
}

  /*void _handleNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Notificações'),
        content: Consumer<UserSettingsProvider>(
          builder: (context, settings, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Pedidos'),
                  subtitle: const Text('Atualizações sobre seus pedidos'),
                  value: settings.notifications.orders,
                  onChanged: (value) {
                    settings.toggleOrderNotifications(value);
                  },
                ),
                SwitchListTile(
                  title: const Text('Promoções'),
                  subtitle: const Text('Ofertas e descontos especiais'),
                  value: settings.notifications.promotions,
                  onChanged: (value) {
                    settings.togglePromotionNotifications(value);
                  },
                ),
                SwitchListTile(
                  title: const Text('Novidades'),
                  subtitle: const Text('Novos restaurantes e funcionalidades'),
                  value: settings.notifications.news,
                  onChanged: (value) {
                    settings.toggleNewsNotifications(value);
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ProfileOptionTile(
            icon: Icons.person_outline,
            title: 'Editar perfil',
            onTap: () => Navigator.pushNamed(context, '/profile/edit'),
          ),
          ProfileOptionTile(
            icon: Icons.location_on_outlined,
            title: 'Endereços salvos',
            onTap: () => _handleAddressSettings(context),
          ),
          ProfileOptionTile(
            icon: Icons.payment_outlined,
            title: 'Métodos de pagamento',
            onTap: () => _handlePaymentSettings(context),
          ),
          ProfileOptionTile(
            icon: Icons.notifications_none,
            title: 'Notificações',
            onTap: () => _handleNotificationSettings(context),
          ),
          ProfileOptionTile(
            icon: Icons.help_outline,
            title: 'Ajuda & Suporte',
            onTap: () => _handleSupport(context),
          ),
          const SizedBox(height: 24),
          LogoutButton(onTap: onLogout),
        ],
      ),
    );
  }
}

class _showAddCardDialog {
  _showAddCardDialog(BuildContext context);
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    Key? key,
    required this.icon,
    required this.title,
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
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
        style: TextStyle(color: Colors.red),
      ),
      onTap: onTap,
    );
  }
}