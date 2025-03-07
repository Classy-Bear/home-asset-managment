part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
class StateInput extends StatelessWidget {
  const StateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.state != current.state,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('homeForm_stateInput_textField'),
          initialValue: state.state.value,
          decoration: InputDecoration(
            labelText: 'State',
            hintText: 'e.g., CA',
            border: const OutlineInputBorder(),
            errorText: state.state.displayError != null
                ? state.state.displayError == StateValidationError.empty
                    ? 'State is required'
                    : 'Must be 2 letters'
                : null,
          ),
          textCapitalization: TextCapitalization.characters,
          maxLength: 2,
          onChanged: (value) =>
              context.read<HomeFormCubit>().stateChanged(value),
        );
      },
    );
  }
}
