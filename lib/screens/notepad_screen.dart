import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../widgets/menu_bar_widget.dart';
import '../services/file_service.dart';

class NotepadScreen extends StatefulWidget {
  const NotepadScreen({super.key});

  @override
  State<NotepadScreen> createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  final TextEditingController _textController = TextEditingController();
  final FileService _fileService = FileService();
  String _currentFileName = 'Sin título';
  String _currentFilePath = '';
  bool _isModified = false;
  bool _wordWrap = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_isModified) {
      setState(() {
        _isModified = true;
      });
    }
  }

  void _newFile() {
    if (_isModified) {
      _showSaveDialog(() {
        _resetEditor();
      });
    } else {
      _resetEditor();
    }
  }

  void _resetEditor() {
    setState(() {
      _textController.clear();
      _currentFileName = 'Sin título';
      _currentFilePath = '';
      _isModified = false;
    });
  }

  void _openFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'md', 'dart', 'json'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        String content = await file.readAsString();
        
        setState(() {
          _textController.text = content;
          _currentFileName = result.files.single.name;
          _currentFilePath = result.files.single.path!;
          _isModified = false;
        });
      }
    } catch (e) {
      _showErrorDialog('Error al abrir el archivo: $e');
    }
  }

  void _saveFile() async {
    if (_currentFilePath.isEmpty) {
      _saveAsFile();
    } else {
      try {
        await _fileService.saveFile(_currentFilePath, _textController.text);
        setState(() {
          _isModified = false;
        });
        _showSuccessMessage('Archivo guardado correctamente');
      } catch (e) {
        _showErrorDialog('Error al guardar el archivo: $e');
      }
    }
  }

  void _saveAsFile() async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Guardar archivo como...',
        fileName: _currentFileName.endsWith('.txt') ? _currentFileName : '$_currentFileName.txt',
        allowedExtensions: ['txt'],
      );

      if (outputFile != null) {
        await _fileService.saveFile(outputFile, _textController.text);
        setState(() {
          _currentFileName = outputFile.split('/').last;
          _currentFilePath = outputFile;
          _isModified = false;
        });
        _showSuccessMessage('Archivo guardado correctamente');
      }
    } catch (e) {
      _showErrorDialog('Error al guardar el archivo: $e');
    }
  }

  void _showSaveDialog(VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bloc de notas'),
          content: Text('¿Desea guardar los cambios en $_currentFileName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: const Text('No guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveFile();
                onConfirm();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acerca de IBlock'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'IBlock',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('Versión 1.0.0'),
              SizedBox(height: 15),
              Text('Un bloc de notas estilo Windows creado con Flutter.'),
              SizedBox(height: 10),
              Text('Compatible con Mac y Windows.'),
              SizedBox(height: 20),
              Text(
                'Autor: Marlon Falcon',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('Email: mfalconsoft@gmail.com'),
              SizedBox(height: 5),
              Text('Web: www.marlonfalcon.com'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _selectAll() {
    _textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textController.text.length,
    );
  }

  void _copy() {
    final text = _textController.text.substring(
      _textController.selection.start,
      _textController.selection.end,
    );
    Clipboard.setData(ClipboardData(text: text));
  }

  void _cut() {
    final text = _textController.text.substring(
      _textController.selection.start,
      _textController.selection.end,
    );
    Clipboard.setData(ClipboardData(text: text));
    
    final newText = _textController.text.replaceRange(
      _textController.selection.start,
      _textController.selection.end,
      '',
    );
    _textController.text = newText;
    _textController.selection = TextSelection.collapsed(
      offset: _textController.selection.start,
    );
  }

  void _paste() async {
    final data = await Clipboard.getData('text/plain');
    if (data != null) {
      final newText = _textController.text.replaceRange(
        _textController.selection.start,
        _textController.selection.end,
        data.text!,
      );
      final newOffset = _textController.selection.start + data.text!.length;
      _textController.text = newText;
      _textController.selection = TextSelection.collapsed(offset: newOffset);
    }
  }

  void _toggleWordWrap() {
    setState(() {
      _wordWrap = !_wordWrap;
    });
  }

  String get _windowTitle {
    String title = _currentFileName;
    if (_isModified) {
      title = '*$title';
    }
    return '$title - Bloc de notas';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _windowTitle,
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 30,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          MenuBarWidget(
            onNewFile: _newFile,
            onOpenFile: _openFile,
            onSaveFile: _saveFile,
            onSaveAsFile: _saveAsFile,
            onSelectAll: _selectAll,
            onCopy: _copy,
            onCut: _cut,
            onPaste: _paste,
            onToggleWordWrap: _toggleWordWrap,
            onAbout: _showAboutDialog,
            wordWrap: _wordWrap,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  fontFamily: 'Consolas',
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ),
        ],
      ),
    );
  }
}