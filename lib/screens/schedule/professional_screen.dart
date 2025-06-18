import 'package:flutter/material.dart';

class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  final List<String> servicos = [
    'Quiropraxia',
    'Massagem',
    'Fisioterapia',
    'Acupuntura',
    'Terapia Ocupacional',
  ];
  String selectedServico;

  _ProfessionalScreenState() : selectedServico = 'Quiropraxia';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = theme.colorScheme.primary;
    const black = Color(0xFF35393C);
    const gray = Color(0xFF878787);

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
                    'Profissional',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Foto do profissional
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/women/28.jpg',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Nome
                      Text(
                        'Ana Maria',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Descrição
                      Text(
                        'Especialista em quiropraxia e terapias manuais. Atendimento humanizado e focado no bem-estar do paciente.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF878787),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Estrelas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '5.0',
                            style: TextStyle(
                              color: Color(0xFFFFC107),
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      // Serviços
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Serviços',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedServico,
                        items: servicos
                            .map(
                              (servico) => DropdownMenuItem(
                                value: servico,
                                child: Text(
                                  servico,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedServico = value;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: gray.withOpacity(0.5),
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF878787),
                        ),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                      ),
                      const SizedBox(height: 32),
                      // Avaliações
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Avaliações',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Card de avaliação
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: gray.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                'https://randomuser.me/api/portraits/men/12.jpg',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'João Pedro',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      ...List.generate(
                                        5,
                                        (index) => const Icon(
                                          Icons.star,
                                          color: Color(0xFFFFC107),
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '5.0',
                                        style: TextStyle(
                                          color: Color(0xFFFFC107),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Atendimento excelente, uma ótima profissional e merece o seu reconhecimento.',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Adicione mais cards de avaliação se necessário
                    ],
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
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed('/schedule', arguments: selectedServico);
            },
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
            child: const Text('Agendar'),
          ),
        ),
      ),
    );
  }
}
