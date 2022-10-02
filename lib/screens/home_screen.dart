import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/providers/university_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final universityProvider =
        Provider.of<UniversityProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de universidades'),
          actions: [
            IconButton(
                onPressed: () {
                  universityProvider.setChangeGrid();
                },
                icon: !universityProvider.changeGrid
                    ? const Icon(Icons.grid_3x3)
                    : const Icon(Icons.list_alt_rounded))
          ],
        ),
        body: ListContainer(
          onNextPage: () => universityProvider.getOnDisplayUniversity(),
        ));
  }
}

class ListContainer extends StatefulWidget {
  final Function onNextPage;
  const ListContainer({super.key, required this.onNextPage});

  @override
  State<ListContainer> createState() => _ListContainerState();
}

class _ListContainerState extends State<ListContainer> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final universityProvider =
        Provider.of<UniversityProvider>(context, listen: true);
    // print(universityProvider.universities.length);
    if (universityProvider.universities.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return universityProvider.changeGrid
        ? GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: universityProvider.universities.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (() =>
                    Navigator.pushNamed(context, 'detail', arguments: index)),
                child: GridTile(
                    child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const FadeInImage(
                        placeholder:
                            NetworkImage('https://i.stack.imgur.com/GNhxO.png'),
                        image:
                            NetworkImage('https://via.placeholder.com/200x200'),
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      ),
                    ),
                    Text(
                      universityProvider.universities[index].name as String,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ],
                )),
              );
            },
          )
        : ListView.separated(
            controller: scrollController,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: universityProvider.universities.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () =>
                    Navigator.pushNamed(context, 'detail', arguments: index),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const FadeInImage(
                    placeholder:
                        NetworkImage('https://i.stack.imgur.com/GNhxO.png'),
                    image: NetworkImage('https://via.placeholder.com/200x200'),
                    fit: BoxFit.cover,
                    height: 70,
                    width: 70,
                  ),
                ),
                title:
                    Text(universityProvider.universities[index].name as String),
                trailing: const Icon(
                  Icons.arrow_right,
                  size: 40,
                ),
              );
            },
          );
  }
}
