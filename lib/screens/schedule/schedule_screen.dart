import 'package:flutter/material.dart';
import '../../models/worker.dart';
import '../../models/appointment.dart';
import '../../services/appointment_service.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  int _displayedMonth = DateTime.now().month;
  int _displayedYear = DateTime.now().year;
  String? _selectedTime;

  List<String> _horarios = [];
  bool isLoadingHorarios = false;
  String? errorHorarios;
  bool isLoadingAppointment = false;

  final List<String> _meses = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  String? selectedServico;
  final List<String> servicos = [
    'Quiropraxia',
    'Massagem',
    'Fisioterapia',
    'Acupuntura',
    'Terapia Ocupacional',
  ];

  Worker? worker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Worker) {
        setState(() {
          worker = args;
        });
        _fetchHorarios();
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      if (_displayedMonth == 1) {
        _displayedMonth = 12;
        _displayedYear--;
      } else {
        _displayedMonth--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (_displayedMonth == 12) {
        _displayedMonth = 1;
        _displayedYear++;
      } else {
        _displayedMonth++;
      }
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedTime = null;
    });
    _fetchHorarios();
  }

  Future<void> _fetchHorarios() async {
    if (worker == null) return;
    setState(() {
      isLoadingHorarios = true;
      errorHorarios = null;
      _horarios = [];
    });
    try {
      final dateStr =
          "${_selectedDate.year.toString().padLeft(4, '0')}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
      final horarios = await AppointmentService.getAvailableSlots(
        worker!.id,
        dateStr,
      );
      setState(() {
        _horarios = horarios;
        isLoadingHorarios = false;
      });
    } catch (e) {
      setState(() {
        errorHorarios = 'Erro ao buscar horários: $e';
        isLoadingHorarios = false;
      });
    }
  }

  Future<void> _createAppointment() async {
    if (worker == null || _selectedTime == null || selectedServico == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecione um serviço e um horário'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoadingAppointment = true;
    });

    try {
      // Parse o horário selecionado para criar a data completa
      final timeParts = _selectedTime!.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      final appointmentDate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        hour,
        minute,
      );

      // Criar o agendamento
      final appointment = await AppointmentService.createAppointment(
        workerId: worker!.id,
        userId: '2', // Sempre usar userId 2 como solicitado
        date: appointmentDate,
        service: _mapServiceToBackend(
          selectedServico!,
        ), // Mapeado para o enum do backend
      );

      setState(() {
        isLoadingAppointment = false;
      });

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agendamento criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navegar para a tela de pagamento
      Navigator.of(context).pushNamed('/payment');
    } catch (e) {
      setState(() {
        isLoadingAppointment = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao criar agendamento: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<Widget> _buildCalendarDays(BuildContext context) {
    final theme = Theme.of(context);
    final firstDayOfMonth = DateTime(_displayedYear, _displayedMonth, 1);
    final lastDayOfMonth = DateTime(_displayedYear, _displayedMonth + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday
    final daysInMonth = lastDayOfMonth.day;
    final days = <Widget>[];
    // Dias do mês anterior para preencher o início
    for (int i = 0; i < firstWeekday; i++) {
      days.add(Container());
    }
    // Dias do mês atual
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_displayedYear, _displayedMonth, day);
      final isSelected =
          _selectedDate.year == date.year &&
          _selectedDate.month == date.month &&
          _selectedDate.day == date.day;

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final isToday = today == DateTime(date.year, date.month, date.day);
      days.add(
        GestureDetector(
          onTap: () => _onDateSelected(date),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
                  : isToday
                  ? const Color(0xFFF2F2F2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : isToday
                      ? const Color(0xFF35393C)
                      : const Color(0xFF35393C),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
        ),
      );
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final green = Theme.of(context).colorScheme.primary;
    const black = Color(0xFF35393C);
    const gray = Color(0xFF878787);
    final now = DateTime.now();
    final monthName = _meses[_displayedMonth - 1];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                    'Agendamento',
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                      const SizedBox(height: 16),
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
                          setState(() {
                            selectedServico = value;
                          });
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
                      const SizedBox(height: 24),
                      Text(
                        'Datas disponíveis',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.chevron_left),
                                  onPressed: _goToPreviousMonth,
                                ),
                                Text(
                                  '${monthName[0].toUpperCase()}${monthName.substring(1)} $_displayedYear',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: black,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.chevron_right),
                                  onPressed: _goToNextMonth,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Text(
                                  'Dom',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Seg',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Ter',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Qua',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Qui',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Sex',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                                Text(
                                  'Sab',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            GridView.count(
                              crossAxisCount: 7,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: _buildCalendarDays(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Horários disponíveis',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (isLoadingHorarios)
                        const Center(child: CircularProgressIndicator()),
                      if (errorHorarios != null)
                        Center(
                          child: Text(
                            errorHorarios!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      if (!isLoadingHorarios && errorHorarios == null)
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: _horarios.map((horario) {
                            final isSelected = _selectedTime == horario;
                            return SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width -
                                      48 -
                                      48) /
                                  4,
                              height: 56,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedTime = horario;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected ? green : Colors.white,
                                    border: Border.all(
                                      color: green,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      horario,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      const SizedBox(height: 24),
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
            onPressed: _selectedTime != null && !isLoadingAppointment
                ? _createAppointment
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedTime != null && !isLoadingAppointment
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
            child: isLoadingAppointment
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Continuar'),
          ),
        ),
      ),
    );
  }

  // Mapeamento dos serviços do frontend para os valores do enum ServiceType do backend
  String _mapServiceToBackend(String frontendService) {
    switch (frontendService) {
      case 'Quiropraxia':
        return 'Fisioterapia Motora';
      case 'Massagem':
        return 'Massagem Relaxante';
      case 'Fisioterapia':
        return 'Fisioterapia Motora';
      case 'Acupuntura':
        return 'Shiatsu';
      case 'Terapia Ocupacional':
        return 'Suporte Administrativo';
      default:
        return 'Fisioterapia Motora'; // Valor padrão
    }
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
