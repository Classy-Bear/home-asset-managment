part of 'widgets.dart';

/// A widget that displays the assets of a home.
///
/// This widget shows the assets of a home, including their name, description, and category.
/// The user can also remove an asset from the home.
class AssetsSection extends StatelessWidget {
  /// The home to display.
  final Home home;

  const AssetsSection({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assets',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        home.assets.isEmpty
            ? const Center(
                child: Text(
                  'No assets yet. Add your first asset!',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: home.assets.length,
                itemBuilder: (context, index) {
                  return AssetItem(
                    asset: home.assets[index],
                    homeId: home.id,
                  );
                },
              ),
      ],
    );
  }
}
