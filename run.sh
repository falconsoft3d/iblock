#!/bin/bash

# Script para ejecutar IBlock en diferentes plataformas

echo "🚀 IBlock - Bloc de Notas"
echo "=========================="
echo ""
echo "Selecciona la plataforma:"
echo "1) macOS"
echo "2) Windows"
echo "3) Construir para macOS (Release)"
echo "4) Construir para Windows (Release)"
echo "5) Limpiar proyecto"
echo ""
read -p "Opción (1-5): " opcion

case $opcion in
    1)
        echo "🍎 Ejecutando en macOS..."
        flutter run -d macos
        ;;
    2)
        echo "🪟 Ejecutando en Windows..."
        flutter run -d windows
        ;;
    3)
        echo "🏗️ Construyendo para macOS (Release)..."
        flutter build macos --release
        echo "✅ Construcción completa. El ejecutable está en: build/macos/Build/Products/Release/"
        ;;
    4)
        echo "🏗️ Construyendo para Windows (Release)..."
        flutter build windows --release
        echo "✅ Construcción completa. El ejecutable está en: build/windows/runner/Release/"
        ;;
    5)
        echo "🧹 Limpiando proyecto..."
        flutter clean
        flutter pub get
        echo "✅ Proyecto limpio y dependencias reinstaladas"
        ;;
    *)
        echo "❌ Opción no válida"
        ;;
esac