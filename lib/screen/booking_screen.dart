import 'package:barber_booking/bloc/bloc/form_bloc.dart';
import 'package:barber_booking/bloc/truck_bloc/truck_bloc_bloc.dart';
import 'package:barber_booking/model/booking.dart';
import 'package:barber_booking/model/truck.dart';
import 'package:barber_booking/widgets/date_picker_widget.dart';
import 'package:barber_booking/widgets/dynamic_form_widget.dart';
import 'package:barber_booking/widgets/form_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingScreen extends StatefulWidget {
  final BookingModel? book;
  BookingScreen({Key? key, this.book}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _name = TextEditingController();

  BookingModel? bookingModel = BookingModel();

  TruckModel? truck;

  int _currentStep = 0;

  StepperType stepperType = StepperType.horizontal;

  tapped(int step) => setState(() {
        _currentStep = step;
      });

  continued() => _currentStep < 2
      ? setState(() {
          _currentStep += 1;
        })
      : null;

  cancel() => _currentStep > 0
      ? setState(() {
          _currentStep -= 1;
        })
      : null;

  @override
  void initState() {
    //formbloc!.add(ListDynamicEvent(index: null));
    super.initState();
  }

  @override
  void dispose() {
    clearText();
    _name.dispose();
    super.dispose();
  }

  void clearText() {
    _name.clear();
  }

  /*  Future<String?> getDatePreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    forDates = pref.getString("date");
    return forDates;
  }

  @override
  void initState() {
    super.initState();
    //date = getDatePreference();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      date = (await getDatePreference()) ?? '';
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Booking'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                      final isLastStep = _currentStep == getSteps().length - 1;
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: onStepContinue,
                                child: Text(isLastStep ? 'Confirm' : 'Next'),
                              ),
                            ),
                            SizedBox(
                              width: 17.0,
                            ),
                            if (_currentStep != 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: onStepCancel,
                                  child: Text('Back'),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                    steps: getSteps()))
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text('Selected Truck'),
            content: gridDataTruck(context),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0 ? StepState.complete : StepState.disabled),
        Step(
            title: Text('Input'),
            content: inputOrder(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 1 ? StepState.complete : StepState.disabled),
        Step(
            title: Text('Finish'),
            content: finishOrder(),
            isActive: _currentStep >= 0,
            state: _currentStep >= 2 ? StepState.complete : StepState.disabled)
      ];

  Widget finishOrder() => Container(
      height: 430.0,
      child: Column(
        children: [
          Container(
            height: 150,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                nameTruck(),
                licensePlate(),
                dates(),
                name(),
                BlocBuilder<FormBloc, FormOrderState>(
                  builder: (context, state) {
                    if (state is ListDynamic) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.dynamicList.length,
                          itemBuilder: (context, index) {
                            return listDynamic(index);
                          });
                    } else {
                      return Text('Error');
                    }
                  },
                )
              ],
            ),
          )
        ],
      ));

  Widget listDynamic(int index) {
    return Column(
      children: [
        Row(
          children: [
            Text('textNameProduct'),
            Builder(
              builder: (context) {
                String? textNameProduct = context.select<FormBloc, String?>(
                    (bloc) => (bloc.state is ListDynamic)
                        ? (bloc.state as ListDynamic).nameProduct
                        : null);

                return Text('$textNameProduct');
              },
            ),
          ],
        ),
        Row(
          children: [
            Text('textNumberProduct'),
            Builder(
              builder: (context) {
                String? textNumberProduct = context.select<FormBloc, String?>(
                    (bloc) => (bloc.state is ListDynamic)
                        ? (bloc.state as ListDynamic).numberProduct
                        : null);

                return Text('$textNumberProduct');
              },
            ),
          ],
        ),
      ],
    );
  }

  /* Widget numberProduct() {
    return BlocBuilder<FormBloc, FormOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('Number Product: '),
            Builder(
              builder: (context) {
                String? numberProduct = context
                    .select((FormBloc bloc) => bloc.state.numberProduct!);

                return Text(numberProduct!);
              },
            )
          ],
        );
      },
    );
  } */

  /* Widget nameProduct() {
    return BlocBuilder<FormBloc, FormOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('Name Product: '),
            Builder(
              builder: (context) {
                String? nameProduct =
                    context.select((FormBloc bloc) => bloc.state.nameProduct!);

                return Text(nameProduct!);
              },
            )
          ],
        );
      },
    );
  } */

  Widget dates() {
    return BlocBuilder<FormBloc, FormOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('Date : '),
            /* bookingModel != null
                                ? Text('${bookingModel!.time}')
                                : Text('No Date'),*/

            //Text(date!)

            /* Builder(
              builder: (context) {
                DateTime? date =
                    context.select((FormBloc bloc) => bloc.state.date!);

                return Text(date!.toUtc().toIso8601String());
              },
            ), */
          ],
        );
      },
    );
  }

  Widget name() {
    return BlocBuilder<FormBloc, FormOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('Name : '),
            Builder(
              builder: (context) {
                /* String textName = context.select(
                    (FormBloc bloc) => (bloc.state as ChangeNameState).name); */

                String? textName =
                    context.select((FormBloc bloc) => bloc.state.name);

                return Text(textName!);
              },
            ),
          ],
        );
      },
    );
  }

  Widget licensePlate() {
    return BlocBuilder<TruckBloc, TruckBlocState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('License Plate : '),
            Builder(
              builder: (context) {
                String? textLicensePlate = context.select<TruckBloc, String?>(
                    (bloc) => (bloc.state is ChangedTruckState)
                        ? (bloc.state as ChangedTruckState)
                            .selectedTrucks
                            .licensePlate
                        : null);

                return Text('$textLicensePlate');
              },
            ),
          ],
        );
      },
    );
  }

  Widget nameTruck() {
    return BlocBuilder<TruckBloc, TruckBlocState>(
      builder: (context, state) {
        return Row(
          children: [
            Text('Name Truck : '),
            Builder(
              builder: (context) {
                String? textNameTruck = context.select<TruckBloc, String?>(
                    (bloc) => (bloc.state is ChangedTruckState)
                        ? (bloc.state as ChangedTruckState)
                            .selectedTrucks
                            .nameTruck
                        : null);

                return Text('$textNameTruck');
              },
            ),
          ],
        );
      },
    );
  }

  Widget inputOrder() => Container(
        height: 430.0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name '),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                onChanged: (name) {
                  print(name);
                  context.read<FormBloc>().add(ChangeNameEvent(name: name));
                },
                onSaved: (value) {
                  bookingModel!.name = value;
                },
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('Date'),
              SizedBox(
                height: 10.0,
              ),
              DatePickerWidget(),
              SizedBox(
                height: 10.0,
              ),
              DynamicFormWidget(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      );

  Widget gridDataTruck(BuildContext context) {
    return Container(
      height: 430.0,
      child: BlocBuilder<TruckBloc, TruckBlocState>(
        builder: (context, state) {
          if (state is TruckLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TruckLoadedState) {
            final truckData = state.trucks;
            return GridView.builder(
                shrinkWrap: true,
                itemCount: truckData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Card(
                        color: truckData[index].value
                            ? Colors.orange
                            : Colors.white,
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              truckData[index].nameTruck!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              truckData[index].typeTruck!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              truckData[index].licensePlate!,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        context.read<TruckBloc>().add(
                              ChangedTruckEvent(
                                selectedTrucks: truckData[index].copyWith(
                                  value: !truckData[index].value,
                                ),
                              ),
                            );
                      });
                });
          } else {
            return Text('something went wrong.');
          }
        },
      ),
    );
  }

  swithStepType() {
    setState(() {
      stepperType == StepperType.horizontal
          ? stepperType = StepperType.vertical
          : stepperType = StepperType.horizontal;
    });
  }

  tappeds(int step) => setState(() {
        _currentStep = step;
      });

  continueds() => _currentStep < 2
      ? setState(() {
          _currentStep += 1;
        })
      : null;

  cancels() => _currentStep > 2
      ? setState(() {
          _currentStep -= 1;
        })
      : null;
}
