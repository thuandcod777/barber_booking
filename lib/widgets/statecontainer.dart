import 'package:barber_booking/model/booking.dart';
import 'package:flutter/material.dart';

class StateContainer extends StatefulWidget {
  final Widget? child;
  final BookingModel? event;

  StateContainer({Key? key, required this.child, this.event}) : super(key: key);

  static _StateContainerState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedContainer>()
            as InheritedContainer)
        .data;
  }

  @override
  _StateContainerState createState() => _StateContainerState();
}

class _StateContainerState extends State<StateContainer> {
  BookingModel? event;

  void updateEventInfo({eventDate}) {
    if (event == null) {
      event = new BookingModel(date: eventDate);
      setState(() {
        event = event;
      });
    } else {
      setState(() {
        // event?.name = eventName ?? event?.name;
        event!.date = eventDate ?? event!.date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedContainer(
      data: this,
      child: widget.child!,
    );
  }
}

class InheritedContainer extends InheritedWidget {
  final _StateContainerState data;

  InheritedContainer({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
