part of 'form_bloc.dart';

class FormOrderState extends Equatable {
  final String? name;
  final DateTime? date;
  final String? nameProduct;
  final String? numberProduct;

  FormOrderState(
      {this.name, this.date, this.nameProduct, this.numberProduct, dynamic});

  FormOrderState copyWith(
      {String? name,
      DateTime? date,
      String? nameProduct,
      String? numberProduct,
      Map<String, DynamicModel>? purchaseOrder}) {
    return FormOrderState(
      name: name ?? this.name,
      date: date ?? this.date,
      nameProduct: nameProduct ?? this.nameProduct,
      numberProduct: numberProduct ?? this.numberProduct,
    );
  }

  @override
  List<Object?> get props => [name, date, nameProduct, numberProduct];
}

class FormInitial extends FormOrderState {}

class LoadDataMass extends FormOrderState {
  final List<DynamicModel> listDropdown;

  LoadDataMass({required this.listDropdown});

  @override
  List<Object?> get props => [listDropdown];

  String toString() => 'listDropdownChanged: {listDropdown:$listDropdown}';
}

class ListDynamic extends FormOrderState {
  final List<Map<String, dynamic>> dynamicList;

  ListDynamic({required this.dynamicList});
  @override
  List<Object?> get props => [dynamicList];

  String toString() => 'dynamicChanged: {dynamic:$dynamicList}';
}
