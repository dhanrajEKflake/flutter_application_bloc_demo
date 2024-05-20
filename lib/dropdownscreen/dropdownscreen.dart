import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/dropdownscreen/bloc/dropdown_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownScreen extends StatelessWidget {
  DropDownScreen({super.key});

  TextEditingController menuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DropdownBloc()..add(LoadItemEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DropDown using Bloc Pattern'),
        ),
        body:
            BlocBuilder<DropdownBloc, DropdownState>(builder: (context, state) {
          if (state is DropdownLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DropdownSelectedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: DropdownMenu(
                    width: 300,
                    // requestFocusOnTap: true,
                    controller: menuController,
                    hintText: 'Select Item',
                    dropdownMenuEntries: state.myItems
                        .map((e) =>
                            DropdownMenuEntry(value: e.id, label: e.name))
                        .toList(),
                    onSelected: (value) {
                      log(value.toString());
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                AutofillGroup(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: menuController,
                      autofillHints: const [AutofillHints.username],
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('Check'))
                  ],
                ))
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
