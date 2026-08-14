# Portable File Organizer for Windows

Organizador portable de archivos para Windows 10/11. Se ejecuta directamente desde un único archivo `.bat`, sin instalación, sin servicios en segundo plano y sin conexión a Internet.

## Características

- Organización automática por categorías principales.
- Subclasificación opcional por formato/tipo.
- Organización opcional por fecha.
- Reglas inteligentes simples basadas en el nombre del archivo.
- Protección frente a sobrescrituras: si ya existe un archivo con el mismo nombre, genera un nombre alternativo.
- Ignora descargas temporales o incompletas (`.crdownload`, `.part`, `.partial`, `.tmp`).
- No modifica las subcarpetas existentes durante la organización normal.
- Undo transaccional de la última organización.
- El Undo solo elimina carpetas creadas por el propio organizador y únicamente cuando están vacías.
- Historial interno almacenado en la carpeta `_Organizador`.
- Funcionamiento 100 % local/offline.

## Uso

1. Descarga `Organizar_Archivos_Portable.bat`.
2. Copia el archivo dentro de la carpeta que quieras organizar, por ejemplo `Descargas`.
3. Haz doble clic sobre el `.bat`.
4. Selecciona `1 - Organizar archivos`.
5. Escribe `SI` para confirmar.
6. Elige el nivel de categorización adicional o pulsa `ENTER` para usar el modo por defecto.

### Modos de organización

| Modo | Resultado |
|---|---|
| 0 | Categoría principal |
| 1 | Categoría + tipo/formato |
| 2 | Categoría + fecha |
| 3 | Categoría + tipo/formato + fecha |
| 4 | Categoría + reglas inteligentes por nombre |
| 5 | Categoría + tipo + fecha + reglas inteligentes |

## Deshacer

Desde el menú principal selecciona `2 - Deshacer ultima organizacion`.

El programa intentará restaurar los archivos exactamente a sus ubicaciones originales. No sobrescribirá archivos que hayan aparecido posteriormente en la ruta de origen.

Los registros necesarios se guardan en:

```text
_Organizador/
├── Movimientos.csv
├── Carpetas.csv
└── Ejecuciones.csv
```

No borres esa carpeta si quieres conservar la posibilidad de deshacer operaciones anteriores compatibles.

## Categorías principales

```text
01_Documentos
02_Imagenes
03_Videos
04_Audio
05_Comprimidos
06_Instaladores
07_Imagenes_Disco
08_Torrents
09_Fuentes
10_Codigo_y_Datos
11_CAD_BIM
99_Otros
```

## Seguridad y privacidad

El script no envía archivos, nombres de archivo, telemetría ni ningún otro dato a Internet. Todo el procesamiento ocurre localmente en Windows mediante `cmd.exe` y Windows PowerShell.

Antes de usarlo sobre información importante, se recomienda probar primero el comportamiento en una carpeta temporal. Aunque el organizador incorpora validaciones y Undo, cualquier herramienta que mueva archivos debe utilizarse con copias de seguridad adecuadas cuando los datos sean críticos.

## Compatibilidad

- Windows 10
- Windows 11
- Windows PowerShell incluido con Windows

No requiere privilegios de administrador para trabajar sobre carpetas donde el usuario ya tenga permisos de escritura.

## Versión actual

**v3.1**

Consulta [CHANGELOG.md](CHANGELOG.md) para ver la evolución del proyecto.

## Autoría

Proyecto desarrollado y mantenido por **zaper3**.

Copyright © 2026 zaper3. Todos los derechos reservados salvo que posteriormente se publique una licencia específica.

## Licencia

Actualmente este repositorio no incluye una licencia de software abierta. La publicación pública del código no implica por sí misma permiso general para copiar, modificar, redistribuir o relicenciar el proyecto fuera de los derechos concedidos por los términos aplicables de GitHub.
