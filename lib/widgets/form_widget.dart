import 'package:barber_booking/bloc/form_bloc/form_bloc.dart';
import 'package:barber_booking/model/booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final int index;

  FormWidget({
    required this.index,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController _numberProduct = new TextEditingController();
  final TextEditingController _nameProduct = new TextEditingController();

  List<DynamicModel?> dynamicModel = [null];
  DynamicModel? dynamicMass;
  String? _selectedItem;
  FormBloc? formBloc;

  @override
  void initState() {
    dynamicModel.forEach((element) {
      element?.getItemMass();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return newMethod(context);
  }

  newMethod(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<FormBloc, FormOrderState>(
              builder: (context, state) {
                return TextFormField(
                  onChanged: (val) {
                    context
                        .read<FormBloc>()
                        .add(ListDynamicEvent(index: widget.index, value: val));
                  },
                  onSaved: (value) {
                    dynamicMass!.numberProduct = value;
                  },
                  controller: _nameProduct,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      context.read<FormBloc>().add(
                          ListDynamicEvent(index: widget.index, value: val));
                    },
                    onSaved: (value) {
                      dynamicMass!.numberProduct = value;
                    },
                    controller: _numberProduct,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 1,
                  child: BlocBuilder<FormBloc, FormOrderState>(
                    builder: (context, state) {
                      if (state is LoadDataMass) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border:
                                  Border.all(width: 1.0, color: Colors.grey)),
                          child: ListTile(
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton<String?>(
                                onChanged: (value) {
                                  setState(() {
                                    _selectedItem = value;
                                  });
                                },
                                value: _selectedItem,
                                items: state.listDropdown.map((dropdownItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownItem.item,
                                    child: Text(dropdownItem.item!),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Text("Error");
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
