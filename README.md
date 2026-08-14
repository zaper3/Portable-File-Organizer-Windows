# Portable File Organizer for Windows

**Portable, offline file organizer for Windows 10/11 with rule-based categorization and safe transactional Undo. No installation required.**

**Organizador portátil y sin conexión para Windows 10/11, con categorización basada en reglas y función segura de deshacer mediante transacciones. No requiere instalación.**

> **Official repository / Repositorio oficial:** https://github.com/zaper3/Portable-File-Organizer-Windows
>
> **Latest release / Última versión:** https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest

---

## English

### Overview

Portable File Organizer for Windows is a single-file `.bat` utility designed to organize the files contained directly in the folder where the script is executed.

It runs locally using Windows `cmd.exe` and Windows PowerShell. It does not require installation, administrator privileges for normal writable folders, a background service, an account or an Internet connection.

### Main features

- Automatic organization by main file categories.
- Optional subcategorization by file type/format.
- Optional organization by file date.
- Simple intelligent rules based on file names.
- Safe duplicate handling: existing files are never overwritten.
- Incomplete or temporary downloads such as `.crdownload`, `.part`, `.partial` and `.tmp` are ignored.
- Existing subfolders are not traversed or reorganized during normal organization.
- Transactional Undo for the latest compatible organization run.
- Undo removes only folders created by the organizer itself and only when they are empty.
- Internal Undo/history data is stored inside the `_Organizador` folder.
- 100% local/offline operation.
- No telemetry and no file-name uploads.

### Download

For normal use, download the latest packaged version from **GitHub Releases**:

**https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest**

The official Release package is the recommended distribution channel. The source script can also be inspected directly in this repository.

When a SHA-256 checksum is provided with a Release, you can use it to verify that the downloaded package has not changed.

### Quick start

1. Download the latest Release.
2. Extract `Organizar_Archivos_Portable.bat` if you downloaded the ZIP package.
3. Copy the `.bat` file into the folder you want to organize, for example `Downloads`.
4. Double-click the script.
5. Select `1 - Organizar archivos`.
6. Type `SI` to confirm.
7. Choose an optional categorization mode or press `ENTER` for the default mode.

### Organization modes

| Mode | Result |
|---|---|
| `0` | Main category only — default |
| `1` | Category + file type/format |
| `2` | Category + date |
| `3` | Category + type/format + date |
| `4` | Category + intelligent file-name rules |
| `5` | Category + type + date + intelligent rules |

### Main categories

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

### Undo

From the main menu select:

```text
2 - Deshacer ultima organizacion
```

The organizer attempts to restore every file to its original location.

It will **not overwrite** a file that already exists at the original path. If a conflict or missing file prevents a complete restoration, the Undo is marked as partial so the unresolved situation can be corrected and retried.

Undo data is stored locally in:

```text
_Organizador/
├── Movimientos.csv
├── Carpetas.csv
└── Ejecuciones.csv
```

Do not delete this folder if you want to preserve the ability to undo compatible previous runs.

### Security and privacy

The script does not intentionally send files, file names, telemetry or other user data to the Internet. Processing takes place locally on Windows.

Before using any tool that moves files on important data, test it first in a temporary folder and maintain appropriate backups of critical information.

### Compatibility

- Windows 10
- Windows 11
- Windows PowerShell included with Windows

Administrator privileges are not required when working in folders where the current user already has write permissions.

### Official distribution and authenticity

The authoritative project source is:

**https://github.com/zaper3/Portable-File-Organizer-Windows**

Official public builds should be obtained from the repository's **Releases** section. Third-party copies may exist, but only releases published from this repository should be considered official releases maintained by zaper3.

Do not trust a modified copy merely because it uses the same project name. When available, verify the SHA-256 checksum published with the official Release.

### License

This project is **source-available**, not open source under an OSI-approved license.

In summary, the license allows free personal, educational and internal non-commercial use, inspection of the source code, private modifications and free redistribution of complete, unmodified official releases with attribution and a link to the official repository.

Commercial exploitation and public redistribution of modified versions require prior written permission.

Read the complete terms in [LICENSE.md](LICENSE.md). The full license text governs in case of any difference between this summary and the license.

### Version

Current public version: **v3.1**

See [CHANGELOG.md](CHANGELOG.md) for version history and [SECURITY.md](SECURITY.md) for security information.

### Author

Developed and maintained by **zaper3**.

Copyright © 2026 zaper3.

---

## Español

### Descripción

Portable File Organizer for Windows es una utilidad contenida en un único archivo `.bat`, diseñada para organizar los archivos que se encuentran directamente dentro de la carpeta donde se ejecuta el script.

Funciona localmente mediante `cmd.exe` y Windows PowerShell. No requiere instalación, privilegios de administrador para carpetas normales con permisos de escritura, servicios en segundo plano, cuentas de usuario ni conexión a Internet.

### Características principales

- Organización automática por categorías principales.
- Subclasificación opcional por tipo/formato de archivo.
- Organización opcional por fecha.
- Reglas inteligentes simples basadas en el nombre del archivo.
- Gestión segura de duplicados: nunca sobrescribe un archivo existente.
- Ignora descargas incompletas o temporales como `.crdownload`, `.part`, `.partial` y `.tmp`.
- No recorre ni reorganiza las subcarpetas existentes durante la organización normal.
- Undo/deshacer transaccional de la última ejecución compatible.
- El proceso de deshacer solo elimina carpetas creadas por el propio organizador y únicamente cuando están vacías.
- Los datos internos de historial y Undo se almacenan dentro de la carpeta `_Organizador`.
- Funcionamiento 100 % local/offline.
- Sin telemetría ni envío de nombres de archivo.

### Descarga

Para un uso normal, descarga la última versión empaquetada desde **GitHub Releases**:

**https://github.com/zaper3/Portable-File-Organizer-Windows/releases/latest**

La Release oficial es el canal de distribución recomendado. El script fuente también puede inspeccionarse directamente en este repositorio.

Cuando una Release incluya un checksum SHA-256, puedes utilizarlo para comprobar que el paquete descargado no ha sido modificado.

### Uso rápido

1. Descarga la última Release.
2. Extrae `Organizar_Archivos_Portable.bat` si has descargado el paquete ZIP.
3. Copia el `.bat` dentro de la carpeta que quieras organizar, por ejemplo `Descargas`.
4. Haz doble clic sobre el script.
5. Selecciona `1 - Organizar archivos`.
6. Escribe `SI` para confirmar.
7. Elige un modo de categorización adicional o pulsa `ENTER` para utilizar el modo por defecto.

### Modos de organización

| Modo | Resultado |
|---|---|
| `0` | Solo categoría principal — modo por defecto |
| `1` | Categoría + tipo/formato |
| `2` | Categoría + fecha |
| `3` | Categoría + tipo/formato + fecha |
| `4` | Categoría + reglas inteligentes por nombre |
| `5` | Categoría + tipo + fecha + reglas inteligentes |

### Categorías principales

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

### Deshacer

Desde el menú principal selecciona:

```text
2 - Deshacer ultima organizacion
```

El organizador intentará devolver cada archivo a su ubicación original.

**No sobrescribirá** un archivo que ya exista en la ruta de origen. Si un conflicto o un archivo no encontrado impide restaurar completamente la ejecución, el Undo queda marcado como parcial para que puedas corregir la situación y volver a intentarlo.

Los datos necesarios se guardan localmente en:

```text
_Organizador/
├── Movimientos.csv
├── Carpetas.csv
└── Ejecuciones.csv
```

No elimines esta carpeta si quieres conservar la posibilidad de deshacer ejecuciones anteriores compatibles.

### Seguridad y privacidad

El script no envía intencionadamente archivos, nombres de archivo, telemetría ni otros datos del usuario a Internet. Todo el procesamiento se realiza localmente en Windows.

Antes de utilizar cualquier herramienta que mueva archivos sobre información importante, pruébala primero en una carpeta temporal y mantén copias de seguridad adecuadas de los datos críticos.

### Compatibilidad

- Windows 10
- Windows 11
- Windows PowerShell incluido con Windows

No requiere privilegios de administrador para trabajar en carpetas donde el usuario actual ya tenga permisos de escritura.

### Distribución oficial y autenticidad

La fuente oficial y autoritativa del proyecto es:

**https://github.com/zaper3/Portable-File-Organizer-Windows**

Las versiones públicas oficiales deben obtenerse desde la sección **Releases** de este repositorio. Pueden existir copias de terceros, pero únicamente las Releases publicadas desde este repositorio deben considerarse versiones oficiales mantenidas por zaper3.

No confíes en una copia modificada únicamente porque utilice el mismo nombre del proyecto. Cuando esté disponible, verifica el checksum SHA-256 publicado junto con la Release oficial.

### Licencia

Este proyecto es **source-available o de código visible**, no software de código abierto bajo una licencia aprobada por la OSI.

Como resumen, la licencia permite el uso personal, educativo e interno no comercial de forma gratuita, estudiar el código fuente, realizar modificaciones privadas y redistribuir gratuitamente versiones oficiales completas y sin modificar, manteniendo la atribución y el enlace al repositorio oficial.

La explotación comercial y la redistribución pública de versiones modificadas requieren autorización previa por escrito.

Consulta las condiciones completas en [LICENSE.md](LICENSE.md). En caso de diferencia entre este resumen y la licencia, prevalece el texto completo de la licencia.

### Versión

Versión pública actual: **v3.1**

Consulta [CHANGELOG.md](CHANGELOG.md) para ver el historial de versiones y [SECURITY.md](SECURITY.md) para información de seguridad.

### Autor

Desarrollado y mantenido por **zaper3**.

Copyright © 2026 zaper3.
