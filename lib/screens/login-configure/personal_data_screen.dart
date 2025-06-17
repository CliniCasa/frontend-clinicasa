import 'package:flutter/material.dart';
import 'address_screen.dart';
import '../../widgets/logo_clinicasa.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _lastPhoneValue = '';
  String? _selectedGender;
  final TextEditingController _otherGenderController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otherGenderController.dispose();
    super.dispose();
  }

  String? _validateOnlyLetters(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'Digite seu $field';
    }
    if (!RegExp(r'^[A-Za-zÀ-ÿ\s]+$').hasMatch(value)) {
      return 'Digite apenas letras';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu telefone';
    }
    // Remove tudo que não for número
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length != 11) {
      return 'Digite um telefone válido';
    }
    // Verifica se está no formato (99) 99999-9999
    if (!RegExp(r'^\(\d{2}\) \d{5}-\d{4}$').hasMatch(value)) {
      return 'Formato: (99) 99999-9999';
    }
    return null;
  }

  void _onPhoneChanged(String value) {
    // Detecta se está apagando
    final isDeleting = value.length < _lastPhoneValue.length;
    _lastPhoneValue = value;
    if (isDeleting) {
      // Não aplica máscara ao apagar, deixa o usuário apagar normalmente
      return;
    }
    // Ao digitar, aplica a máscara
    String digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 11) digits = digits.substring(0, 11);
    String formatted = '';
    if (digits.isNotEmpty) {
      formatted += '(';
      formatted += digits.substring(0, digits.length >= 2 ? 2 : digits.length);
      if (digits.length >= 2) formatted += ') ';
      if (digits.length > 2) {
        formatted += digits.substring(
          2,
          digits.length >= 7 ? 7 : digits.length,
        );
      }
      if (digits.length >= 7) {
        formatted += '-';
        formatted += digits.substring(7, digits.length);
      }
    }
    if (formatted != value) {
      _phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu e-mail';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite sua senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha';
    }
    if (value != _passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const AddressScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF217346),
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Dados pessoais',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nome completo',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Ex: João Pedro',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (value) =>
                              _validateOnlyLetters(value, 'nome'),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sexo',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          hint: const Text('Selecione'),
                          items: const [
                            DropdownMenuItem(
                              value: 'masculino',
                              child: Text('Masculino'),
                            ),
                            DropdownMenuItem(
                              value: 'feminino',
                              child: Text('Feminino'),
                            ),
                            DropdownMenuItem(
                              value: 'nao_binario',
                              child: Text('Não binário'),
                            ),
                            DropdownMenuItem(
                              value: 'prefiro_nao_dizer',
                              child: Text('Prefiro não dizer'),
                            ),
                            DropdownMenuItem(
                              value: 'outro',
                              child: Text('Outro'),
                            ),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione o gênero';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                              if (value != 'outro') {
                                _otherGenderController.clear();
                              }
                            });
                          },
                        ),
                        if (_selectedGender == 'outro') ...[
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _otherGenderController,
                            decoration: const InputDecoration(
                              hintText: 'Especifique (opcional)',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Text(
                          'Telefone',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            hintText: 'Ex: (19) 99999-9999',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                          onChanged: _onPhoneChanged,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'E-mail',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Ex: exemplo@email.com',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Senha',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: '********',
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Confirmar senha',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            hintText: '********',
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          validator: _validateConfirmPassword,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Avançar'),
          ),
        ),
      ),
    );
  }
}
