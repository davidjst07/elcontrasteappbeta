import 'package:flutter/material.dart';
import 'package:elcontrasteappbeta/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60), // Ajusta la altura del AppBar si es necesario
        child: CustomAppbar(),
      ),
      body: Center(
        child: Text(
          'Contenido de la pantalla',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
