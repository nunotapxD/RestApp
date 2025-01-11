// address_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_settings_provider.dart';

class AddressDialog extends StatefulWidget {
  final Address? address;

  const AddressDialog({Key? key, this.address}) : super(key: key);

  @override
  State<AddressDialog> createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _cityController = TextEditingController();
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      _nameController.text = widget.address!.name;
      _streetController.text = widget.address!.street;
      _numberController.text = widget.address!.number;
      _complementController.text = widget.address!.complement;
      _cityController.text = widget.address!.city;
      _isDefault = widget.address!.isDefault;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: Text(widget.address != null ? 'Editar Endereço' : 'Novo Endereço'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Endereço',
                  hintText: 'Ex: Casa, Trabalho',
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um nome para o endereço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(
                  labelText: 'Rua',
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite a rua';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Número',
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o número';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _complementController,
                decoration: const InputDecoration(
                  labelText: 'Complemento (opcional)',
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  filled: true,
                  fillColor: Color(0xFF2E2E2E),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite a cidade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Endereço Principal'),
                value: _isDefault,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final address = Address(
                id: widget.address?.id ?? DateTime.now().toString(),
                name: _nameController.text,
                street: _streetController.text,
                number: _numberController.text,
                complement: _complementController.text,
                city: _cityController.text,
                isDefault: _isDefault,
              );

              final settings = context.read<UserSettingsProvider>();
              if (widget.address != null) {
                settings.updateAddress(address);
              } else {
                settings.addAddress(address);
              }

              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: Text(widget.address != null ? 'Salvar' : 'Adicionar'),
        ),
      ],
    );
  }
}