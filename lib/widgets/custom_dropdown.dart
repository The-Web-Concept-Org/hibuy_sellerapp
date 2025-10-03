import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hibuy/Bloc/droupdown_list/dropdown_bloc.dart';
import 'package:hibuy/Bloc/droupdown_list/dropdown_event.dart';
import 'package:hibuy/Bloc/droupdown_list/dropdown_state.dart';


class ReusableDropdown extends StatelessWidget {
  final List<String> items;
  final Function(String) onItemSelected;

  const ReusableDropdown({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    context.read<DropdownBloc>().add(LoadDropdownItems(items));

    return BlocBuilder<DropdownBloc, DropdownState>(
      builder: (context, state) {
        if (state is DropdownLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final value = state.items[index];
              return ListTile(
                title: Text(value),
                onTap: () {
                  context.read<DropdownBloc>().add(SelectDropdownItem(value));
                  onItemSelected(value);
                  Navigator.pop(context); // close dialog when selected
                },
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
