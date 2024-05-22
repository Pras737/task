

import 'package:equatable/equatable.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class AddComponent extends FormEvent {}

class RemoveComponent extends FormEvent {
  final int index;

  const RemoveComponent(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateComponent extends FormEvent {
  final int index;
  final String label;
  final String infoText;
  final bool isRequired;
  final bool isReadonly;
  final bool isHidden;

  const UpdateComponent({
    required this.index,
    required this.label,
    required this.infoText,
    required this.isRequired,
    required this.isReadonly,
    required this.isHidden,
  });

  @override
  List<Object> get props => [index, label, infoText, isRequired, isReadonly, isHidden];
}

class SubmitForm extends FormEvent {}
