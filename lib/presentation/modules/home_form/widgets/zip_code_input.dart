part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
class ZipCodeInput extends StatelessWidget {
  const ZipCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.zipCode != current.zipCode,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('homeForm_zipCodeInput_textField'),
          initialValue: state.zipCode.value,
          decoration: InputDecoration(
            labelText: 'ZIP Code',
            hintText: 'e.g., 94105',
            border: const OutlineInputBorder(),
            errorText: state.zipCode.displayError != null
                ? state.zipCode.displayError == ZipCodeValidationError.empty
                    ? 'ZIP code is required'
                    : 'Enter a valid ZIP code'
                : null,
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              context.read<HomeFormCubit>().zipCodeChanged(value),
        );
      },
    );
  }
}

