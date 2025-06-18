import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPayment = 0;
  int _selectedAddress = 0;

  final List<Map<String, String>> _payments = [
    {'type': 'Crédito', 'label': 'Final 1234', 'icon': 'credit'},
    {'type': 'Débito', 'label': 'Final 3451', 'icon': 'debit'},
  ];

  final List<Map<String, String>> _addresses = [
    {
      'type': 'Meu endereço',
      'desc':
          'Rua das Acácias, 342, Bairro Jardim Primavera, Campinas – SP, 13050-125.',
    },
    {
      'type': 'Clínica do profissional',
      'desc':
          'Rua das Acácias, 200, Bairro Jardim Primavera, Campinas – SP, 13050-125.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    const black = Color(0xFF35393C);
    const gray = Color(0xFF878787);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
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
                    'Pagamento',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Métodos de pagamento
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Método de pagamento',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  '+ Adicionar',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(_payments.length, (i) {
                        final selected = _selectedPayment == i;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPayment = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected
                                    ? green
                                    : const Color(0xFFE0E0E0),
                                width: selected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.credit_card,
                                    color: Color(0xFF35393C),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _payments[i]['label']!,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              color: black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _payments[i]['type']!,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: gray,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  selected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: selected ? green : gray,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      // Endereço de atendimento
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Endereço de atendimento',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  '+ Adicionar',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: green,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(_addresses.length, (i) {
                        final selected = _selectedAddress == i;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAddress = i;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected
                                    ? green
                                    : const Color(0xFFE0E0E0),
                                width: selected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFF35393C),
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _addresses[i]['type']!,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              color: black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _addresses[i]['desc']!,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: gray,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  selected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: selected ? green : gray,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: (_selectedPayment != null || _selectedAddress != null)
                ? () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed('/payment_confirmation');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  (_selectedPayment != null || _selectedAddress != null)
                  ? green
                  : gray,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Finalizar agendamento'),
          ),
        ),
      ),
    );
  }
}
