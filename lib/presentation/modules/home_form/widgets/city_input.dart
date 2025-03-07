part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
class CityInput extends StatelessWidget {
  const CityInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('homeForm_cityInput_textField'),
          initialValue: state.city.value,
          decoration: InputDecoration(
            labelText: 'City',
            hintText: 'e.g., San Francisco',
            border: const OutlineInputBorder(),
            errorText:
                state.city.displayError != null ? 'City is required' : null,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              context.read<HomeFormCubit>().cityChanged(value),
        );
      },
    );
  }
}
