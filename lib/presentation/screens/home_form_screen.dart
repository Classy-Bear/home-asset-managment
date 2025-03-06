import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home_form/home_form.dart';

class HomeFormScreen extends StatelessWidget {
  final int? homeId;

  const HomeFormScreen({super.key, this.homeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HomeCubit>(),
      child: BlocProvider(
        create: (context) => HomeFormCubit(
          homeCubit: context.read<HomeCubit>(),
          initialHome: homeId != null
              ? context.read<HomeCubit>().getHome(homeId!)
              : null,
        ),
        child: const HomeFormView(),
      ),
    );
  }
}

class HomeFormView extends StatelessWidget {
  const HomeFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeFormCubit, HomeFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == HomeFormStatus.success) {
          Navigator.of(context).pop();
        } else if (state.status == HomeFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to save home'),
              ),
            );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HomeFormCubit, HomeFormState>(
            buildWhen: (previous, current) =>
                previous.isEditing != current.isEditing,
            builder: (context, state) {
              return Text(state.isEditing ? 'Edit Home' : 'Add Home');
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NameInput(),
                SizedBox(height: 24),
                AddressSection(),
                SizedBox(height: 32),
                SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFormCubit, HomeFormState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('homeForm_nameInput_textField'),
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

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const StreetInput(),
            const SizedBox(height: 16),
            const CityInput(),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: StateInput(),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ZipCodeInput(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
