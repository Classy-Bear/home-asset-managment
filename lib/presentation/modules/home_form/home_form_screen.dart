import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home_form/home_form.dart';
import 'widgets/widgets.dart';

/// A screen that displays a form for creating or editing a home.
///
/// This screen allows the user to input the details of a home, such as its name, address, and ZIP code.
/// The user can also add or update a home.
class HomeFormScreen extends StatelessWidget {
  /// The ID of the home to edit, if any.
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

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
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
                HomeNameInput(),
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
