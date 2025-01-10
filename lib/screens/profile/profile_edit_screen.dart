import 'package:provider/provider.dart';

import '../../providers/session_provider.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _cardExpiryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final session = context.read<SessionProvider>();
    _nameController.text = session.userName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _cardExpiryController.dispose();
    super.dispose();
  }

  void _showAddCardDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Cartão'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(
                labelText: 'Número do Cartão',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(
                labelText: 'Nome no Cartão',
              ),
            ),
            TextField(
              controller: _cardExpiryController,
              decoration: const InputDecoration(
                labelText: 'Validade (MM/YY)',
              ),
              keyboardType: TextInputType.datetime,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final card = CreditCard(
                id: DateTime.now().toString(),
                number: _cardNumberController.text,
                holderName: _cardHolderController.text,
                expiryDate: _cardExpiryController.text,
              );
              context.read<SessionProvider>().addCreditCard(card);
              Navigator.pop(context);
              
              // Clear controllers
              _cardNumberController.clear();
              _cardHolderController.clear();
              _cardExpiryController.clear();
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User name
          const Text(
            'Dados Pessoais',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SessionProvider>().updateUserName(value);
            },
          ),

          const SizedBox(height: 32),

          // Saved cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cartões Salvos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: _showAddCardDialog,
                icon: const Icon(Icons.add),
                label: const Text('Adicionar'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Consumer<SessionProvider>(
            builder: (context, session, child) {
              if (session.savedCards.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum cartão salvo',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              return Column(
                children: session.savedCards.map((card) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: Text(card.maskedNumber),
                    subtitle: Text('${card.holderName} - ${card.expiryDate}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        context.read<SessionProvider>().removeCreditCard(card.id);
                      },
                    ),
                  ),
                )).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}