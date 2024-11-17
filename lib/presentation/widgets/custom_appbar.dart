import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
      child: Container(
        color: Colors.white, // Fondo del custom Appbar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo_c negro.png',
                width: 35,
                height: 35,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  'El Contraste Noticias',
                  style: titleStyle,
                  textAlign: TextAlign.center,// Centra el texto dentro del Expanded
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
        ),
      ),
    );
  }
}
