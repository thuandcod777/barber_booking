import 'package:barber_booking/model/booking.dart';
import 'package:barber_booking/widgets/form_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DynamicFormWidget extends StatelessWidget {
  DynamicFormWidget({Key? key}) : super(key: key);

  List<DynamicModel?> dynamics = [null];

  static DynamicModel? nameProducts;
  static DynamicModel? numberProdcts;
  static DynamicModel? dropdownMass;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [..._getForm(context)],
    );
  }

  List<Widget> _getForm(BuildContext context) {
    List<Widget>? forms = [];

    for (int i = 0; i < dynamics.length; i++) {
      forms.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _addFormDynamic(
                context,
                i,
                i == dynamics.length - 1,
              ),
            ),
            FormWidget(
              index: i,
              // add: i == dynamic.length - 1,
            ),
          ],
        ),
      );
    }

    return forms;
  }

  Widget _addFormDynamic(
    BuildContext context,
    int index,
    bool add,
  ) {
    return GestureDetector(
      onTap: () {
        if (add) {
          dynamics.insert(0, null);
        } else {
          dynamics.removeAt(index);
        }

        (context as Element).markNeedsBuild();
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: (add) ? Colors.green : Colors.red),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}



/* Widget _dynamicList(DynamicModel index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
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
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  } */
