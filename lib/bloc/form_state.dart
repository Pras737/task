import 'package:equatable/equatable.dart';

class FormState extends Equatable {
  final List<FormComponent> components;

  const FormState({required this.components});

  @override
  List<Object> get props => [components];

  FormState copyWith({List<FormComponent>? components}) {
    return FormState(components: components ?? this.components);
  }
}

class FormComponent extends Equatable {
  final String label;
  final String infoText;
  final bool isRequired;
  final bool isReadonly;
  final bool isHidden;

  const FormComponent({
    required this.label,
    required this.infoText,
    required this.isRequired,
    required this.isReadonly,
    required this.isHidden,
  });

  FormComponent copyWith({
    String? label,
    String? infoText,
    bool? isRequired,
    bool? isReadonly,
    bool? isHidden,
  }) {
    return FormComponent(
      label: label ?? this.label,
      infoText: infoText ?? this.infoText,
      isRequired: isRequired ?? this.isRequired,
      isReadonly: isReadonly ?? this.isReadonly,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  List<Object> get props => [label, infoText, isRequired, isReadonly, isHidden];
}
