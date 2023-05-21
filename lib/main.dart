import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тренировочный дневник',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Тренировочный дневник'),
        ),
        body: WorkoutLog(),
      ),
    );
  }
}

class WorkoutLog extends StatefulWidget {
  @override
  _WorkoutLogState createState() => _WorkoutLogState();
}

class _WorkoutLogState extends State<WorkoutLog> {
  final List<String> _exercises = [
    'Жим лежа',
    'Приседания',
    'Тяга верхнего блока'
  ];
  final List<String> _days = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье'
  ];
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  List<List<int>> _data = List.generate(
      7, (i) => List.generate(3, (j) => 0)); // Изначально все значения равны 0

  void _updateData(int dayIndex, int exerciseIndex, int value) {
    setState(() {
      _data[dayIndex][exerciseIndex] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Упражнения'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_exercises[index]),
                    SizedBox(height: 8.0),
                    Table(
                      children: [
                        TableRow(
                          children: _days.map((day) {
                            final dayIndex = _days.indexOf(day);
                            final exerciseIndex = index;
                            return TableCell(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Подходы',
                                ),
                                onChanged: (value) {
                                  _updateData(dayIndex, exerciseIndex,
                                      int.parse(value));
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        TableRow(
                          children: _days.map((day) {
                            final dayIndex = _days.indexOf(day);
                            final exerciseIndex = index;
                            return TableCell(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Повторения',
                                ),
                                onChanged: (value) {
                                  _updateData(dayIndex, exerciseIndex,
                                      int.parse(value));
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
