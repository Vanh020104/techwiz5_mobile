import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/category.dart';
import 'package:shop/screens/search/views/components/search_form.dart';
import 'package:shop/services/CategoryService.dart';


class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  late Future<List<Category>> futureCategories;
  final CategoryService categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    futureCategories = categoryService.fetchCategories(page: 1, limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: SearchForm(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: futureCategories,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        return ListTile(
                          title: Text(category.categoryName),
                          subtitle: category.description != null
                              ? Text(category.description!)
                              : null,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}