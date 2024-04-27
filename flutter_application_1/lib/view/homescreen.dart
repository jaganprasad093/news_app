import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/homescreencontroller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.watch<homescreencontroller>().getDataByCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<homescreencontroller>();
    return DefaultTabController(
      length: provider.categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("NewsApp"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      5,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.amber,
                              height: 100,
                              width: 160,
                              child: Center(child: Text("Contents")),
                            ),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              TabBar(
                  onTap: (value) {
                    context
                        .read<homescreencontroller>()
                        .onCategorySelection(value);
                  },
                  isScrollable: true,
                  tabs: List.generate(
                      provider.categories.length,
                      (index) =>
                          Text(provider.categories[index].toUpperCase()))),
              provider.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: provider.resBycategory?.articles?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              provider.resBycategory?.articles?[index].title ??
                                  ""),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
