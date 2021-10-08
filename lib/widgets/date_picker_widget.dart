import 'package:barber_booking/bloc/bloc/form_bloc.dart';
import 'package:barber_booking/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController _dateController = TextEditingController();

  BookingModel? bookingModel;

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        /* _date.value =
            TextEditingValue(text: DateFormat('dd/MM/yyyy').format(picked)); */
        /*  var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}"; */
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _dateController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormOrderState>(
      builder: (context, state) {
        return Container(
          child: GestureDetector(
            onTap: () => _selectedDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                onChanged: (date) {
                  print(date);
                  context
                      .read<FormBloc>()
                      .add(ChangeDateEvent(date: date as DateTime?));
                },
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Date',
                  prefixIcon: Icon(Icons.date_range_outlined),
                ),
                onSaved: (value) {
                  print('date: ${value.toString()}');
                  bookingModel!.date = selectedDate;
                  // saveDatePreference(value!);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
