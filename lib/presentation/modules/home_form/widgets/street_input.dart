part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
class StreetInput extends StatelessWidget {
  const StreetInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.street != current.street,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('homeForm_streetInput_textField'),
          initialValue: state.street.value,
          decoration: InputDecoration(
            labelText: 'Street Address',
            hintText: 'e.g., 123 Main St',
            border: const OutlineInputBorder(),
            errorText: state.street.displayError != null
                ? 'Street address is required'
                : null,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              context.read<HomeFormCubit>().streetChanged(value),
        );
      },
    );
  }
}
