part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
class HomeNameInput extends StatelessWidget {
  const HomeNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          decoration: InputDecoration(
            labelText: 'Home Name',
            hintText: 'e.g., Mountain Retreat',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.home),
            errorText: state.name.displayError != null
                ? 'Home name is required'
                : null,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              context.read<HomeFormCubit>().nameChanged(value),
        );
      },
    );
  }
}
