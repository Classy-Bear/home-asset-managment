part of 'widgets.dart';

/// A widget that displays a single home in the list.
///
/// This widget shows a single home and allows the user to edit or delete it.
class HomeListItem extends StatelessWidget {
  /// The home to display.
  final Home home;

  /// The callback function to be called when the home is tapped.
  final VoidCallback onTap;

  /// The callback function to be called when the home is deleted.
  final VoidCallback onDelete;

  /// The callback function to be called when the home is edited.
  final VoidCallback onEdit;

  const HomeListItem({
    super.key,
    required this.home,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          home.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(home.address.formattedAddress),
        trailing: Text(
          '${home.assets.length} assets',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: onTap,
      ),
    );
  }
}
