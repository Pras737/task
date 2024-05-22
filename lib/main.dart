import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/form_bloc.dart';
import 'bloc/form_event.dart';
import 'bloc/form_state.dart' as bloc;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => FormBloc(),
        child: DynamicFormPage(),
      ),
    );
  }
}

class DynamicFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              context.read<FormBloc>().add(SubmitForm());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Objekt',
                        hintText: 'Enter the address',
                        border: InputBorder.none,
                      ),
                      initialValue: 'Kosterangerstr. 5, 83629 Weyarn',
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Zählernummer',
                            hintText: 'Enter the meter number',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: DynamicForm(),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<FormBloc>().add(AddComponent());
              },
              child: Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}

class DynamicForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, bloc.FormState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.components.length,
          itemBuilder: (context, index) {
            return ComponentItem(index: index);
          },
        );
      },
    );
  }
}

class ComponentItem extends StatelessWidget {
  final int index;

  ComponentItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, bloc.FormState>(
      builder: (context, state) {
        final component = state.components[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CheckboxListTile(
                  value: true,
                  onChanged: (value) {},
                  title: Text('Checkbox'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Label',
                        hintText: 'Enter the label text',
                        border: InputBorder.none,
                      ),
                      initialValue: component.label,
                      onChanged: (value) {
                        context.read<FormBloc>().add(UpdateComponent(
                              index: index,
                              label: value,
                              infoText: component.infoText,
                              isRequired: component.isRequired,
                              isReadonly: component.isReadonly,
                              isHidden: component.isHidden,
                            ));
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Info-Text',
                        hintText: 'Enter the info text',
                        border: InputBorder.none,
                      ),
                      initialValue: component.infoText,
                      onChanged: (value) {
                        context.read<FormBloc>().add(UpdateComponent(
                              index: index,
                              label: component.label,
                              infoText: value,
                              isRequired: component.isRequired,
                              isReadonly: component.isReadonly,
                              isHidden: component.isHidden,
                            ));
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: component.isRequired,
                      onChanged: (value) {
                        context.read<FormBloc>().add(UpdateComponent(
                              index: index,
                              label: component.label,
                              infoText: component.infoText,
                              isRequired: value!,
                              isReadonly: component.isReadonly,
                              isHidden: component.isHidden,
                            ));
                      },
                    ),
                    Text('Required'),
                    Checkbox(
                      value: component.isReadonly,
                      onChanged: (value) {
                        context.read<FormBloc>().add(UpdateComponent(
                              index: index,
                              label: component.label,
                              infoText: component.infoText,
                              isRequired: component.isRequired,
                              isReadonly: value!,
                              isHidden: component.isHidden,
                            ));
                      },
                    ),
                    Text('Readonly'),
                    Checkbox(
                      value: component.isHidden,
                      onChanged: (value) {
                        context.read<FormBloc>().add(UpdateComponent(
                              index: index,
                              label: component.label,
                              infoText: component.infoText,
                              isRequired: component.isRequired,
                              isReadonly: component.isReadonly,
                              isHidden: value!,
                            ));
                      },
                    ),
                    Text('Hidden Field'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<FormBloc>().add(RemoveComponent(index));
                      },
                      child: Text('Remove'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
