# IBlock - Bloc de Notas

Un bloc de notas estilo Windows creado con Flutter que funciona tanto en macOS como en Windows.

## Características

- ✅ Interfaz similar al Bloc de Notas de Windows
- ✅ **Icono personalizado** configurado para macOS y Windows
- ✅ Menú de archivos (Nuevo, Abrir, Guardar, Guardar como)
- ✅ Menú de edición (Seleccionar todo, Cortar, Copiar, Pegar)
- ✅ Ajuste de línea
- ✅ Contador de líneas y columnas
- ✅ Indicador de cambios no guardados
- ✅ Diálogos de confirmación
- ✅ Soporte para múltiples formatos de archivo (.txt, .md, .dart, .json)
- ✅ Atajos de teclado
- ✅ Compatible con macOS y Windows

## Requisitos

- Flutter SDK (3.0.0 o superior)
- Dart SDK
- Para Windows: Visual Studio con herramientas de C++
- Para macOS: Xcode

## Instalación

1. Clona o descarga este proyecto
2. Navega al directorio del proyecto:
   ```bash
   cd iblock
   ```
3. Instala las dependencias:
   ```bash
   flutter pub get
   ```

## Ejecución

### En macOS:
```bash
flutter run -d macos
```

### En Windows:
```bash
flutter run -d windows
```

### Desarrollo (modo debug):
```bash
flutter run
```

## Construcción para distribución

### Para macOS:
```bash
flutter build macos --release
```
El archivo ejecutable se encontrará en `build/macos/Build/Products/Release/`

### Para Windows:
```bash
flutter build windows --release
```
El archivo ejecutable se encontrará en `build/windows/runner/Release/`

## Estructura del proyecto

```
iblock/
├── lib/
│   ├── main.dart                 # Punto de entrada de la aplicación
│   ├── screens/
│   │   └── notepad_screen.dart   # Pantalla principal del bloc de notas
│   ├── widgets/
│   │   └── menu_bar_widget.dart  # Widget de la barra de menú
│   └── services/
│       └── file_service.dart     # Servicio para manejo de archivos
├── assets/
│   └── fonts/                    # Fuentes personalizadas
├── windows/                      # Configuración específica de Windows
├── macos/                        # Configuración específica de macOS
└── pubspec.yaml                  # Dependencias del proyecto
```

## Funcionalidades

### Menú Archivo
- **Nuevo** (Ctrl+N): Crea un nuevo documento
- **Abrir** (Ctrl+O): Abre un archivo existente
- **Guardar** (Ctrl+S): Guarda el documento actual
- **Guardar como** (Ctrl+Shift+S): Guarda el documento con un nuevo nombre

### Menú Edición
- **Seleccionar todo** (Ctrl+A): Selecciona todo el texto
- **Cortar** (Ctrl+X): Corta el texto seleccionado
- **Copiar** (Ctrl+C): Copia el texto seleccionado
- **Pegar** (Ctrl+V): Pega el texto del portapapeles

### Menú Formato
- **Ajustar línea**: Activa/desactiva el ajuste automático de líneas

### Menú Ayuda
- **Acerca de**: Muestra información sobre la aplicación

## Formatos de archivo soportados

- `.txt` - Archivos de texto plano
- `.md` - Archivos Markdown
- `.dart` - Archivos de código Dart
- `.json` - Archivos JSON

## Personalización

### Cambiar el icono de la aplicación
El proyecto usa `icon.png` como icono personalizado. Para cambiarlo:

1. Reemplaza `icon.png` en la raíz del proyecto (recomendado: 512x512 o mayor)
2. Ejecuta el script de regeneración de iconos (si está disponible) o:
3. Regenera manualmente los iconos:
   ```bash
   # Para macOS (múltiples tamaños)
   sips -z 16 16 icon.png --out macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png
   sips -z 32 32 icon.png --out macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png
   # ... etc para otros tamaños
   
   # Para Windows (formato ICO)
   sips -s format ico icon.png --out windows/runner/resources/app_icon.ico
   ```

### Cambiar la fuente
Edita el archivo `pubspec.yaml` y modifica la sección de fuentes:

```yaml
fonts:
  - family: TuFuente
    fonts:
      - asset: assets/fonts/tu-fuente.ttf
```

### Agregar nuevos formatos de archivo
Modifica el array `allowedExtensions` en `notepad_screen.dart`:

```dart
allowedExtensions: ['txt', 'md', 'dart', 'json', 'nuevo-formato'],
```

## Contribuir

1. Fork el proyecto
2. Crea una nueva rama para tu feature
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Troubleshooting

### Error de dependencias
Si encuentras errores de dependencias, ejecuta:
```bash
flutter clean
flutter pub get
```

### Error en Windows
Asegúrate de tener instalado Visual Studio con las herramientas de C++.

### Error en macOS
Asegúrate de tener Xcode instalado y actualizado.

## Versión

**Versión actual:** 1.0.0

## Autor

**Marlon Falcon**
- 📧 Email: mfalconsoft@gmail.com
- 🌐 Web: www.marlonfalcon.com

Desarrollado con ❤️ usando Flutter