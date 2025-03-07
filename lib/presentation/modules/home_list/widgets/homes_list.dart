part of 'widgets.dart';

/// A widget that displays a list of homes.
///
/// This widget shows a list of homes and allows the user to add a new home.
/// The homes are fetched from the [HomeCubit] and displayed in a list.
/// The user can also edit or delete a home.
class HomesList extends StatelessWidget {
  final List<Home> homes;

  const HomesList({super.key, required this.homes});

  @override
  Widget build(BuildContext context) {
    if (homes.isEmpty) {
      return Center(
        child: Text(
          'No homes yet. Add your first home!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
    return ListView.builder(
      itemCount: homes.length,
      itemBuilder: (context, index) {
        final home = homes[index];
        return HomeListItem(
          home: home,
          onTap: () => context.pushNamed('home-detail',
              pathParameters: {'homeId': home.id.toString()}),
          onDelete: () => _deleteHome(context, home.id),
          onEdit: () => context.pushNamed('edit-home',
              pathParameters: {'homeId': home.id.toString()}),
        );
      },
    );
  }

  void _deleteHome(BuildContext context, int homeId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmDelete(
          context: dialogContext,
          onPressed: () => context.read<HomeCubit>().deleteHome(homeId),
        );
      },
    );
  }
}
