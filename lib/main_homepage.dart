import 'package:wtfc_provider_app/export.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apps Location'),
        centerTitle: true,
        actions: [
          PopupMenuButton<AuthMenuItemModel>(
            //when you select, the value from builitem -> value will go into this onselected section
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...AuthMenuItems.itemsFirst.map(buildItem).toList(),
              const PopupMenuDivider(),
              ...AuthMenuItems.itemsSecond.map(buildItem).toList(),
            ],
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/voting');
                  },
                  child: const Text('Voting Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/recipe');
                  },
                  child: const Text('Recipe Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/habittracker');
                  },
                  child: const Text('Habit Tracker Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/filestorage');
                  },
                  child: const Text('File Storage Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookingevent');
                  },
                  child: const Text('Booking event Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/expensetracker');
                  },
                  child: const Text('Expense Tracker Screen')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '');
                  },
                  child: const Text('blank')),
              const SizedBox(height: 10),
            ],
          ),
        ),
      )),
    );
  }

  PopupMenuItem<AuthMenuItemModel> buildItem(AuthMenuItemModel item) =>
      PopupMenuItem<AuthMenuItemModel>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.black, size: 20),
            const SizedBox(
              width: 12,
            ),
            Text(item.text),
          ],
        ),
      );

  void onSelected(BuildContext context, AuthMenuItemModel item) {
    switch (item) {
      case AuthMenuItems.itemSettings:
        Navigator.pushNamed(context, '/signout');
        break;
      case AuthMenuItems.itemShare:
        Navigator.pushNamed(context, '/signout');
        break;
      case AuthMenuItems.itemSignOut:
        Navigator.pushNamed(context, '/signout');
        break;
    }
  }
}
