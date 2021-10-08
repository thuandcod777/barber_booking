import 'package:barber_booking/bloc/bloc/form_bloc.dart';
import 'package:barber_booking/widgets/dynamic_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicsWidget extends StatelessWidget {
  const DynamicsWidget({Key? key}) : super(key: key);

  static List<String?> dropdownData = [null];

  static List<String?> numberProductData = [null];
  static List<String?> nameProductData = [null];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [..._getFields(context)],
    );
  }

  List<Widget> _getFields(BuildContext context) {
    List<Widget> firndsTextFields = [];

    for (int i = 0; i < dropdownData.length; i++) {
      firndsTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0),
          child: Row(
            children: [
              /*  DynamicFieldsWidget(
                index: i,
              ), */
              SizedBox(
                width: 17,
              ),
              _addRemoveButton(context, i == dropdownData.length - 1, i)
            ],
          ),
        ),
      );
    }

    return firndsTextFields;
  }

  Widget _addRemoveButton(BuildContext context, bool add, int index) {
    print('index:' + index.toString());
    return InkWell(
      onTap: () {
        if (add) {
          dropdownData.insert(0, null);
          numberProductData.insert(0, null);
          nameProductData.insert(0, null);
        } else {
          dropdownData.removeAt(index);
          numberProductData.removeAt(index);
          nameProductData.removeAt(index);
        }

        //instead for setState it is not statefullWidget
        (context as Element).markNeedsBuild();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: (add) ? Colors.green : Colors.red),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}
