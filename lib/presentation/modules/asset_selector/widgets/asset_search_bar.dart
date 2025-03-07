part of 'widgets.dart';

/// A widget that displays a search bar for the asset selector screen.
///
/// This widget shows a search bar for the asset selector screen, which allows the user to search for an asset by name, category, description, or manufacturer.
/// The user can also clear the search query.
class AssetSearchBar extends StatelessWidget {
  /// The controller for the search bar.
  final TextEditingController searchController;
  /// The search query.
  final String? searchQuery;
  /// The callback function to be called when the search query changes.
  final ValueChanged<String?> onSearchChanged;

  const AssetSearchBar({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search assets...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: searchQuery != null && searchQuery!.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged(null);
                  },
                )
              : null,
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
