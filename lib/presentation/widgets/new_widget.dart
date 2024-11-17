import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Noticia {
  final int id;
  final String titulo;
  final String contenido;
  final String urlImagen;

  Noticia({required this.id, required this.titulo, required this.contenido, required this.urlImagen});

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      id: json['id'],
      titulo: json['title']['rendered'],
      contenido: json['content']['rendered'],
      urlImagen: json['jetpack_featured_media_url'], // Cambia si no usas Jetpack
    );
  }
}

Future<List<Noticia>> obtenerNoticias() async {
  final url = Uri.parse('https://www.elcontraste.co/wp-json/wp/v2/posts');
  final respuesta = await http.get(url);

  if (respuesta.statusCode == 200) {
    List jsonData = json.decode(respuesta.body);
    return jsonData.map((json) => Noticia.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar noticias');
  }
}

class NoticiasWidget extends StatefulWidget {
  @override
  _NoticiasWidgetState createState() => _NoticiasWidgetState();
}

class _NoticiasWidgetState extends State<NoticiasWidget> {
  late Future<List<Noticia>> _noticias;

  @override
  void initState() {
    super.initState();
    _noticias = obtenerNoticias();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Noticia>>(
      future: _noticias,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar noticias'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay noticias disponibles'));
        } else {
          final noticias = snapshot.data!;
          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final noticia = noticias[index];
              return ListTile(
                title: Text(noticia.titulo),
                subtitle: Text(noticia.contenido),
                leading: Image.network(noticia.urlImagen, fit: BoxFit.cover),
                onTap: () {
                  _abrirEnlaceNoticia(noticia.id);
                },
              );
            },
          );
        }
      },
    );
  }

  void _abrirEnlaceNoticia(int id) {
    final url = 'https://www.elcontraste.co/?p=$id';
    // Aquí puedes agregar el código para abrir el enlace en el navegador usando `url_launcher`
  }
}
