import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState(components: [FormComponent(label: '', infoText: '', isRequired: false, isReadonly: false, isHidden: false)])) {
    on<AddComponent>(_onAddComponent);
    on<RemoveComponent>(_onRemoveComponent);
    on<UpdateComponent>(_onUpdateComponent);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onAddComponent(AddComponent event, Emitter<FormState> emit) {
    final updatedComponents = List<FormComponent>.from(state.components)
      ..add(FormComponent(label: '', infoText: '', isRequired: false, isReadonly: false, isHidden: false));
    emit(state.copyWith(components: updatedComponents));
  }

  void _onRemoveComponent(RemoveComponent event, Emitter<FormState> emit) {
    final updatedComponents = List<FormComponent>.from(state.components)
      ..removeAt(event.index);
    emit(state.copyWith(components: updatedComponents));
  }

  void _onUpdateComponent(UpdateComponent event, Emitter<FormState> emit) {
    final updatedComponents = List<FormComponent>.from(state.components)
      ..[event.index] = state.components[event.index].copyWith(
        label: event.label,
        infoText: event.infoText,
        isRequired: event.isRequired,
        isReadonly: event.isReadonly,
        isHidden: event.isHidden,
      );
    emit(state.copyWith(components: updatedComponents));
  }

  void _onSubmitForm(SubmitForm event, Emitter<FormState> emit) {
    // Handle form submission logic here
  }
}
