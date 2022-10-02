import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/models/university_response.dart';
import 'package:prueba_tecnica/widgets/my_custom_form.dart';

import '../providers/university_provider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)?.settings.arguments as int ?? 0;
    final universityProvider =
        Provider.of<UniversityProvider>(context, listen: true);

    final UniversityResponse university =
        universityProvider.getOneUniniversity(id);

    if (university == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const FadeInImage(
              placeholder: NetworkImage('https://i.stack.imgur.com/GNhxO.png'),
              image: NetworkImage('https://via.placeholder.com/200x200'),
              fit: BoxFit.cover,
              height: 300,
              width: 200,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            university.name as String,
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          Text(
            university.country as String,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            university.domains!.join(','),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          Text(
            university.webPages!.join(','),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          const MyCustomForm()
        ]),
      ),
    );
  }
}
