import 'package:flutter/material.dart';

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

  final List<String> _horarios = ['08:00', '10:00', '14:00', '16:00', '18:00'];

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

      final now = DateTime.now().subtract(const Duration(days: 1));
      final today = DateTime(now.year, now.month, now.day);
      final isToday = today == DateTime(date.year, date.month, date.day);
      days.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
              _selectedTime = null;
            });
          },
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
                    'Agendamento',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Datas disponíveis',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
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
                          '${monthName[0].toUpperCase()}${monthName.substring(1)} ${_displayedYear}',
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
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _horarios.map((horario) {
                  final isSelected = _selectedTime == horario;
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 48 - 48) / 4,
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
                          border: Border.all(color: green, width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            horario,
                            style: TextStyle(
                              color: isSelected ? Colors.white : green,
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
            onPressed: _selectedTime != null ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedTime != null ? green : gray,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Confirmar'),
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
