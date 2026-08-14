# Changelog

Todos los cambios relevantes del proyecto se documentarán en este archivo.

## [3.1] - 2026-08-13

### Añadido

- Carpeta interna `_Organizador` para almacenar los registros de Undo sin ensuciar la raíz de la carpeta organizada.
- Migración automática de los registros generados por v3.0.
- Conservación del historial necesario para deshacer operaciones anteriores compatibles.

### Mejorado

- Organización de metadatos internos.
- Experiencia de uso y limpieza visual de la carpeta principal.

## [3.0] - 2026-08-13

### Añadido

- Undo transaccional de la última organización.
- Identificador único por ejecución.
- Registro independiente de movimientos, carpetas creadas y ejecuciones.
- Restauración conservadora: nunca sobrescribe archivos existentes.
- Eliminación exclusiva de carpetas creadas por el organizador y únicamente cuando están vacías.
- Soporte para reintentar un Undo parcial después de resolver conflictos.

## [2.2] - 2026-08-13

### Corregido

- Codificación UTF-8 sin BOM para compatibilidad correcta con `cmd.exe`.
- Finales de línea CRLF para Windows.
- Lanzador PowerShell simplificado sin continuaciones problemáticas mediante `^`.

## [2.0] - 2026-08-13

### Añadido

- Categorización adicional opcional.
- Organización por formato.
- Organización por fecha.
- Reglas inteligentes simples basadas en nombres de archivo.

## [1.0] - 2026-08-13

### Añadido

- Clasificación portable de archivos mediante un único `.bat`.
- Categorías principales por extensión.
- Protección contra sobrescritura.
- Exclusión de archivos temporales e incompletos.
- Registro básico de movimientos.
