part of 'widgets.dart';

/// A widget that displays a submit button for a home form.
///
/// This widget shows a submit button for a home form, which allows the user to add or update a home.
/// The button is disabled if the form is not valid or if the form is in progress.
class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) =>
          previous.isValid != current.isValid ||
          previous.formStatus != current.formStatus ||
          previous.isEditing != current.isEditing,
      builder: (context, state) {
        return ElevatedButton(
          // key: const Key('homeForm_submit_elevatedButton'),
          onPressed: state.isValid
              ? () => context.read<HomeFormCubit>().submitForm()
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: state.formStatus == FormzSubmissionStatus.inProgress
              ? const CircularProgressIndicator()
              : Text(
                  state.isEditing ? 'Update Home' : 'Add Home',
                  style: const TextStyle(fontSize: 16),
                ),
        );
      },
    );
  }
}
