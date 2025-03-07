part of 'widgets.dart';

/// A widget that displays a form for creating or editing a home.
///
/// This widget shows a form for creating or editing a home, with fields for the home's name, address, and ZIP code.
/// The user can also add or update a home.
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
