import 'package:kuis_mobile_124240085/models/data.dart';
import 'package:kuis_mobile_124240085/screens/detail.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    //var visibleMenus = shoeCatalog;
    var visibleMenus = shoeCatalog.where((menu) {
      final categoryMatches = selectedCategory == 'Semua' ||
          menu.category == selectedCategory;
        return categoryMatches;
    }).toList();

    return Column(
      children: [
        DropdownButton<String>(
          value: selectedCategory,
          items: ['Semua', 'Running', 'Sneakers', 'Basketball', 'Lifestyle', 'Outdoor']
              .map(
                (category) =>
                    DropdownMenuItem(value: category, child: Text(category)),
              )
              .toList(),
          onChanged: (category) {
            if (category != null) {
              setState(() => selectedCategory = category);
            }
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: visibleMenus.length,
            itemBuilder: (context, index) {
              final menu = visibleMenus[index];
              return ListTile(
                onTap: () async {
                  // Buka detail, lalu perbarui daftar setelah kembali.
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(menu: menu),
                    ),
                  );
                  if (mounted) {
                    // Perbarui daftar setelah kembali dari halaman detail.
                    setState(() {});
                  }
                },
                title: Row(
                  children: [
                    Expanded(child: Text(menu.shoeName)),
                  ],
                ),
                subtitle: Text("${menu.shoeName} • ${menu.price} • ${menu.category} • Sisa ${menu.stock} • Likes: ${menu.likes}"), 
                leading: Image.network(menu.image),
                trailing: const Icon(Icons.arrow_forward), 
              );
            },
          ),
        ),
      ],
    );
  }
}
