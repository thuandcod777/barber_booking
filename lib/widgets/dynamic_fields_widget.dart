/* import 'package:barber_booking/bloc/bloc/form_bloc.dart';
import 'package:barber_booking/model/booking.dart';
import 'package:barber_booking/widgets/dynamic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicFieldsWidget extends StatefulWidget {
  final int index;
  const DynamicFieldsWidget({Key? key, required this.index}) : super(key: key);

  @override
  _DynamicFieldsWidgetState createState() => _DynamicFieldsWidgetState();
}

class _DynamicFieldsWidgetState extends State<DynamicFieldsWidget> {
  final TextEditingController _numberProduct = TextEditingController();
  final TextEditingController _nameProduct = TextEditingController();

  String? forNumberProduct;
  String? forNameProduct;

  List<BookingModel> mass = [];

  FormBloc? formBloc;

  var _selectedValue;
  var _dropdownsValue;

  /*@override
  void initState() {
    mass = dropdown!.getItemMass();

    super.initState();
  }*/

  @override
  void dispose() {
    _numberProduct.dispose();
    _nameProduct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _numberProduct.text =
          DynamicsWidget.numberProductData[widget.index] ?? '';
      _nameProduct.text = DynamicsWidget.nameProductData[widget.index] ?? '';
      _selectedValue = DynamicsWidget.dropdownData[widget.index] ?? '';
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name Product'),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: _nameProduct,
          onChanged: (v) => DynamicsWidget.nameProductData[widget.index] = v,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onSaved: (value) => forNameProduct = value,
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Number Product'),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _numberProduct,
                    onChanged: (v) =>
                        DynamicsWidget.numberProductData[widget.index] = v,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    validator: (v) {
                      if (v!.trim().isEmpty) return 'Please enter input number';
                      return null;
                    },
                    onSaved: (value) => forNumberProduct = value,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<FormBloc, FormOrderState>(
                builder: (context, state) {
                  if (state is FormInitials) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mass'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.grey)),
                          child: ListTile(
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: state.listDropdown.map((dropdownItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownItem.item,
                                    child: Text(dropdownItem.item),
                                  );
                                }).toList(),
                                value:
                                    DynamicsWidget.dropdownData[widget.index],
                                onChanged: (valueSelected) {
                                  setState(() {
                                    _dropdownsValue = DynamicsWidget
                                        .dropdownData[widget.index];
                                    DynamicsWidget.dropdownData[widget.index] =
                                        valueSelected as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text('Error');
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
 */