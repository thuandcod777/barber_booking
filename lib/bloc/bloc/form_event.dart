part of 'form_bloc.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object?> get props => [];
}

class ChangeNameEvent extends FormEvent {
  final String name;

  ChangeNameEvent({required this.name});

  @override
  List<Object> get props => [name];

  String toString() => 'NameChanged: {name:$name}';
}

class ChangeDateEvent extends FormEvent {
  final DateTime? date;

  ChangeDateEvent({required this.date});

  @override
  List<Object?> get props => [date];

  String toString() => 'DateChanged: {date:$date}';
}

class ChangeNameProductEvent extends FormEvent {
  final String nameProduct;

  ChangeNameProductEvent({required this.nameProduct});

  @override
  List<Object> get props => [nameProduct];

  String toString() => 'NameProductChanged: {nameProduct:$nameProduct}';
}

class ChangeNumberProductEvent extends FormEvent {
  final String numberProduct;

  ChangeNumberProductEvent({required this.numberProduct});

  @override
  List<Object> get props => [numberProduct];

  String toString() => 'NumberProductChanged: {numberProduct:$numberProduct}';
}

/* class ChangeDropDownMassEvent extends FormEvent {
  final String dropDownMass;

  ChangeDropDownMassEvent({required this.dropDownMass});

  @override
  List<Object> get props => [dropDownMass];

  String toString() => 'ChangeDropDownMass: {dropDownMass:$dropDownMass}';
} */

class ChangeDropDownEvent extends FormEvent {
  final DynamicModel model;

  ChangeDropDownEvent({required this.model});

  @override
  List<Object?> get props => [model];

  String toString() => 'Data: {data:$model}';
}

class ListDynamicEvent extends FormEvent {
  final int index;
  final String? nameProduct;
  final String? numberProduct;

  ListDynamicEvent({required this.index, this.nameProduct, this.numberProduct});

  @override
  List<Object?> get props => [index, nameProduct, numberProduct];

  String toString() => 'Data: {data:$index}';
}
