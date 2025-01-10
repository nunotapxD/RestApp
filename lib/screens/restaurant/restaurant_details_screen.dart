import 'package:flutter/material.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  const RestaurantDetailsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailsScreen> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final Map<String, int> _quantities = {};
  String _selectedPayment = 'Cartão de Crédito';
  Map<String, dynamic>? _restaurant;
  List<Map<String, dynamic>> _menuItems = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _complementController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_restaurant == null) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['id'] != null) {
        _loadRestaurantData(args['id']);
      }
    }
  }

  void _loadRestaurantData(String id) {
    setState(() {
      switch(id) {
        case '2': // Tasquinha Europa
          _restaurant = {
            'id': '2',
            'name': 'Tasquinha Europa',
            'rating': 4.3,
            'reviews': 120,
            'deliveryTime': '25-40 min',
          };
          _menuItems = [
            {
              'id': '1',
              'category': 'Pratos Principais',
              'name': 'Bacalhau à Brás',
              'description': 'Bacalhau desfiado com batatas palha e ovos',
              'price': 85.90,
            },
            {
              'id': '2',
              'category': 'Pratos Principais',
              'name': 'Francesinha',
              'description': 'Sanduíche típico do Porto com molho especial',
              'price': 65.90,
            },
          ];
          break;
          
        default: // Mister Churrasco
          _restaurant = {
            'id': '1',
            'name': 'Mister Churrasco',
            'rating': 4.5,
            'reviews': 150,
            'deliveryTime': '30-45 min',
          };
          _menuItems = [
            {
              'id': '1',
              'category': 'Churrasco',
              'name': 'Picanha na Brasa',
              'description': 'Picanha grelhada com arroz, farofa e vinagrete',
              'price': 89.90,
            },
            {
              'id': '2',
              'category': 'Churrasco',
              'name': 'Costela Premium',
              'description': 'Costela assada lentamente com temperos especiais',
              'price': 79.90,
            },
          ];
      }
    });
  }

  double get _total {
    double sum = 0;
    _quantities.forEach((id, quantity) {
      final item = _menuItems.firstWhere((item) => item['id'] == id);
      sum += item['price'] * quantity;
    });
    return sum;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pedido Realizado!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Seu pedido foi confirmado com sucesso',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                String orderId = 'ORDER-${DateTime.now().millisecondsSinceEpoch}';
                Navigator.pushReplacementNamed(
                  context,
                  '/order-tracking',
                  arguments: orderId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Acompanhar Pedido'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
    String title,
    String subtitle,
    IconData icon,
    StateSetter setModalState,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setModalState(() {
            _selectedPayment = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _selectedPayment == title ? Colors.orange : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedPayment == title)
                const Icon(Icons.check_circle, color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_restaurant == null) return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );

    // Agrupar itens por categoria
    Map<String, List<Map<String, dynamic>>> menuByCategory = {};
    for (var item in _menuItems) {
      String category = item['category'];
      if (!menuByCategory.containsKey(category)) {
        menuByCategory[category] = [];
      }
      menuByCategory[category]!.add(item);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurant!['name']),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Restaurant info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                Text(' ${_restaurant!['rating']} '),
                Text('(${_restaurant!['reviews']} avaliações)'),
                const Spacer(),
                Text(_restaurant!['deliveryTime']),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (var entry in menuByCategory.entries) ...[
                  Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (var item in entry.value) _buildMenuItem(item),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _total > 0
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _showCheckoutModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Confirmar Pedido - €${_total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        : null,
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    final quantity = _quantities[item['id']] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['name'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['description'],
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '€${item['price'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: quantity > 0
                            ? () {
                                setState(() {
                                  if (quantity == 1) {
                                    _quantities.remove(item['id']);
                                  } else {
                                    _quantities[item['id']] = quantity - 1;
                                  }
                                });
                              }
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Text(
                        '$quantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: () {
                          setState(() {
                            _quantities[item['id']] = quantity + 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCheckoutModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              
              // Form e conteúdo
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        'Dados de Entrega',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome Completo',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu telefone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Endereço',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu endereço';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _complementController,
                        decoration: InputDecoration(
                          labelText: 'Complemento / Apartamento',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Métodos de pagamento
                      const Text(
                        'Forma de Pagamento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPaymentOption(
                        'Cartão de Crédito',
                        '****-****-****-1234',
                        Icons.credit_card,
                        setModalState,
                      ),
                      _buildPaymentOption(
                        'MBWAY',
                        'Pagar com QR Code',
                        Icons.qr_code,
                        setModalState,
                      ),
                      _buildPaymentOption(
                        'Dinheiro',
                        'Pagar na entrega',
                        Icons.payments,
                        setModalState,
                      ),
                      const SizedBox(height: 24),

                      // Resumo do pedido
                      const Text(
                        'Resumo do Pedido',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._quantities.entries.map((entry) {
                        final item = _menuItems.firstWhere((item) => item['id'] == entry.key);
                        final total = item['price'] * entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${entry.value}x ${item['name']}'),
                              Text('€${total.toStringAsFixed(2)}'),
                            ],
                          ),
                        );
                      }).toList(),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:'),
                          Text(
                            '€${_total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Botão de finalizar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pop(context);
                        _showSuccessDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text(
                      'Finalizar Pedido',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _complementController.dispose();
    super.dispose();
  }
}