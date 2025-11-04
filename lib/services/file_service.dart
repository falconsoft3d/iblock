import 'dart:io';

class FileService {
  /// Guarda el contenido en un archivo
  Future<void> saveFile(String filePath, String content) async {
    try {
      final file = File(filePath);
      await file.writeAsString(content);
    } catch (e) {
      throw Exception('Error al guardar el archivo: $e');
    }
  }

  /// Lee el contenido de un archivo
  Future<String> readFile(String filePath) async {
    try {
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      throw Exception('Error al leer el archivo: $e');
    }
  }

  /// Verifica si un archivo existe
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
}