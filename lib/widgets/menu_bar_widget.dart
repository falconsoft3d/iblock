import 'package:flutter/material.dart';

class MenuBarWidget extends StatelessWidget {
  final VoidCallback onNewFile;
  final VoidCallback onOpenFile;
  final VoidCallback onSaveFile;
  final VoidCallback onSaveAsFile;
  final VoidCallback onSelectAll;
  final VoidCallback onCopy;
  final VoidCallback onCut;
  final VoidCallback onPaste;
  final VoidCallback onToggleWordWrap;
  final VoidCallback onAbout;
  final bool wordWrap;

  const MenuBarWidget({
    super.key,
    required this.onNewFile,
    required this.onOpenFile,
    required this.onSaveFile,
    required this.onSaveAsFile,
    required this.onSelectAll,
    required this.onCopy,
    required this.onCut,
    required this.onPaste,
    required this.onToggleWordWrap,
    required this.onAbout,
    required this.wordWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      color: const Color(0xFFF0F0F0),
      child: Row(
        children: [
          _buildMenuButton('Archivo', [
            _buildMenuItem('Nuevo', onNewFile, 'Ctrl+N'),
            _buildMenuItem('Abrir...', onOpenFile, 'Ctrl+O'),
            const PopupMenuDivider(),
            _buildMenuItem('Guardar', onSaveFile, 'Ctrl+S'),
            _buildMenuItem('Guardar como...', onSaveAsFile, 'Ctrl+Shift+S'),
          ]),
          _buildMenuButton('Edición', [
            _buildMenuItem('Seleccionar todo', onSelectAll, 'Ctrl+A'),
            const PopupMenuDivider(),
            _buildMenuItem('Cortar', onCut, 'Ctrl+X'),
            _buildMenuItem('Copiar', onCopy, 'Ctrl+C'),
            _buildMenuItem('Pegar', onPaste, 'Ctrl+V'),
          ]),
          _buildMenuButton('Formato', [
            _buildCheckboxMenuItem(
              'Ajustar línea',
              wordWrap,
              onToggleWordWrap,
            ),
          ]),
          _buildMenuButton('Ayuda', [
            _buildMenuItem('Acerca de Bloc de notas', onAbout, ''),
          ]),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title, List<PopupMenuEntry> items) {
    return PopupMenuButton<void>(
      offset: const Offset(0, 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 11),
        ),
      ),
      itemBuilder: (context) => items,
    );
  }

  PopupMenuItem _buildMenuItem(String title, VoidCallback onPressed, String shortcut) {
    return PopupMenuItem(
      onTap: onPressed,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          if (shortcut.isNotEmpty)
            Text(
              shortcut,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  PopupMenuItem _buildCheckboxMenuItem(
    String title,
    bool isChecked,
    VoidCallback onPressed,
  ) {
    return PopupMenuItem(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check : null,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}