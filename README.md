# Portable File Organizer for Windows

[![Latest Release](https://img.shields.io/github/v/release/zaper3/Portable-File-Organizer-Windows?label=Latest%20Release)](https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-blue)
![Offline](https://img.shields.io/badge/Mode-100%25%20Offline-brightgreen)
![Source Available](https://img.shields.io/badge/License-Source--Available-orange)

[![Download Latest Release](https://img.shields.io/badge/Download-Latest%20Release-success?style=for-the-badge)](https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest)

**Portable, offline file organizer for Windows 10/11 with safe transactional Undo. No installation required.**

**Organizador portátil y sin conexión para Windows 10/11 con función segura de deshacer mediante transacciones. No requiere instalación.**

> **Official repository / Repositorio oficial:** https://github.com/zaper3/Portable-File-Organizer-Windows  
> **Latest release / Última versión:** https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest

---

## English

### Overview

Portable File Organizer for Windows is a single-file `.bat` utility. Copy it into any folder, run it, choose **English** or **Español**, and organize the files contained directly in that folder.

### Features

- English and Spanish user interface.
- Categories are also created in the selected language.
- Main-category organization by file extension.
- Optional subcategorization by format, date, smart filename rules, or combinations of them.
- Existing files are never overwritten.
- Temporary/incomplete downloads (`.crdownload`, `.part`, `.partial`, `.tmp`) are ignored.
- Existing subfolders are not traversed during normal organization.
- Transactional Undo for the latest compatible organization run.
- Undo deletes only folders created by the organizer and only when empty.
- Internal history is stored in `_PortableFileOrganizer`.
- 100% local/offline; no telemetry or file-name uploads.

### Quick start

1. Download the latest Release.
2. Extract `Organizar_Archivos_Portable.bat`.
3. Copy it into the folder you want to organize.
4. Double-click the script.
5. Choose `1 - English` or `2 - Español`.
6. Select `1 - Organize files`.
7. Type `YES` to confirm.
8. Choose a mode from `0` to `5`, or press `ENTER` for mode `0`.

### Organization modes

| Mode | Result |
|---|---|
| `0` | Main category only |
| `1` | Category + file type/format |
| `2` | Category + date |
| `3` | Category + type/format + date |
| `4` | Category + smart filename rules |
| `5` | Category + type + date + smart rules |

### Undo

Select `2 - Undo last organization` from the main menu and type `UNDO` to confirm. The script restores files to their original locations without overwriting existing files.

### Official distribution

Use only Releases published from this repository as official builds. Verify the SHA-256 checksum when provided.

### License

This project is **source-available**, not OSI open source. Free personal, educational and internal non-commercial use is permitted. Public redistribution of modified versions and commercial exploitation require prior written permission. See [LICENSE.md](LICENSE.md).

### Version

Current public version: **v1.0.0**.

Public Semantic Versioning starts at `1.0.0`. Earlier numbers used during private/internal development are not public releases.

---

## Español

### Descripción

Portable File Organizer for Windows es una utilidad contenida en un único archivo `.bat`. Cópialo dentro de cualquier carpeta, ejecútalo, elige **English** o **Español** y organiza los archivos situados directamente en esa carpeta.

### Características

- Interfaz en inglés y español.
- Las carpetas de categorías también se crean en el idioma seleccionado.
- Organización por categorías principales según extensión.
- Subclasificación opcional por formato, fecha, reglas inteligentes por nombre o combinaciones de ellas.
- Nunca sobrescribe archivos existentes.
- Ignora descargas temporales/incompletas (`.crdownload`, `.part`, `.partial`, `.tmp`).
- No recorre subcarpetas existentes durante la organización normal.
- Deshacer transaccional de la última organización compatible.
- Al deshacer, solo elimina carpetas creadas por el organizador y únicamente si están vacías.
- El historial interno se guarda en `_PortableFileOrganizer`.
- Funcionamiento 100 % local/offline; sin telemetría ni envío de nombres de archivo.

### Uso rápido

1. Descarga la última Release.
2. Extrae `Organizar_Archivos_Portable.bat`.
3. Cópialo dentro de la carpeta que quieras organizar.
4. Haz doble clic.
5. Elige `1 - English` o `2 - Español`.
6. Selecciona `1 - Organizar archivos`.
7. Escribe `SI` para confirmar.
8. Elige un modo de `0` a `5` o pulsa `ENTER` para usar el modo `0`.

### Modos de organización

| Modo | Resultado |
|---|---|
| `0` | Solo categoría principal |
| `1` | Categoría + tipo/formato |
| `2` | Categoría + fecha |
| `3` | Categoría + tipo/formato + fecha |
| `4` | Categoría + reglas inteligentes por nombre |
| `5` | Categoría + tipo + fecha + reglas inteligentes |

### Deshacer

Selecciona `2 - Deshacer última organización` en el menú principal y escribe `DESHACER` para confirmar. El script restaura los archivos a sus ubicaciones originales sin sobrescribir archivos existentes.

### Distribución oficial

Considera oficiales únicamente las Releases publicadas desde este repositorio. Verifica el checksum SHA-256 cuando esté disponible.

### Licencia

Este proyecto es **source-available / código visible**, no open source bajo una licencia OSI. Se permite uso personal, educativo e interno no comercial gratuito. La redistribución pública de versiones modificadas y la explotación comercial requieren autorización previa por escrito. Consulta [LICENSE.md](LICENSE.md).

### Versión

Versión pública actual: **v1.0.0**.

El versionado semántico público comienza en `1.0.0`. Las numeraciones utilizadas durante el desarrollo privado/interno no constituyen Releases públicas.

---

Developed and maintained by / Desarrollado y mantenido por **zaper3**.  
Copyright © 2026 zaper3.

See / Consulta [CHANGELOG.md](CHANGELOG.md), [SECURITY.md](SECURITY.md) and / y [LICENSE.md](LICENSE.md).
