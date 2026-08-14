# Portable File Organizer

[![Latest Release](https://img.shields.io/github/v/release/zaper3/Portable-File-Organizer?label=release)](https://github.com/zaper3/Portable-File-Organizer/releases/latest)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-informational)
![Linux](https://img.shields.io/badge/Linux-Bash%204%2B-informational)
![Offline](https://img.shields.io/badge/operation-100%25%20offline-success)
![License](https://img.shields.io/badge/license-source--available-orange)

**Portable, offline file organizer with bilingual English/Spanish interfaces, safe duplicate handling and transactional Undo.**

**Organizador portátil y sin conexión con interfaces en inglés/español, protección frente a duplicados y función transaccional de deshacer.**

> **Official repository / Repositorio oficial:** `https://github.com/zaper3/Portable-File-Organizer`

[**Download latest release / Descargar última versión**](https://github.com/zaper3/Portable-File-Organizer/releases/latest)

---

## Platform status / Estado por plataforma

| Platform / Plataforma | Edition / Edición | Status / Estado | Undo | Language / Idioma |
|---|---|---|---|---|
| Windows 10/11 | `.bat` | Stable / Estable | ✅ | EN / ES |
| GNU/Linux | Bash `.sh` | Stable / Estable | ✅ | EN / ES |
| iOS / iPadOS | Apple Shortcuts | Preview / Preparada para Shortcut | Design target / Objetivo de diseño | EN / ES |

The iOS/iPadOS edition uses Apple Shortcuts because iOS does not execute arbitrary `.bat`/`.sh` files like desktop operating systems. Apple validates shared shortcut files when they are exported for other users, so the final distributable `.shortcut` must be exported/signed from Shortcuts on an Apple device. See [`ios/README.md`](ios/README.md).

La edición para iOS/iPadOS utiliza Apple Shortcuts porque iOS no ejecuta archivos `.bat`/`.sh` arbitrarios como un sistema operativo de escritorio. Apple valida los atajos compartidos al exportarlos para otros usuarios, por lo que el `.shortcut` distribuible final debe exportarse/firmarse desde Atajos en un dispositivo Apple. Consulta [`ios/README.md`](ios/README.md).

---

# English

## What it does

Portable File Organizer sorts the files located directly in the same folder as the script. It does **not** recursively reorganize existing subfolders during a normal run.

Core features:

- English or Spanish selected at startup.
- Category folders created in the selected language.
- Main classification by file extension.
- Optional subcategorization by type/format, date, filename rules, or combinations.
- Existing files are never overwritten; collisions receive a safe alternative name.
- Known temporary/incomplete downloads are ignored.
- Transactional Undo for the latest compatible organization run on Windows and Linux.
- Undo only removes folders that were created by the organizer and are still empty.
- Internal history stored in `_PortableFileOrganizer`.
- No telemetry, accounts, cloud processing or network access.

## Windows

Download the Windows ZIP from Releases, extract the `.bat`, copy it into the folder you want to organize, then double-click it.

Repository source: [`Organizar_Archivos_Portable.bat`](Organizar_Archivos_Portable.bat)

## Linux

Download the Linux package from Releases or use [`linux/portable-file-organizer.sh`](linux/portable-file-organizer.sh).

```bash
chmod +x portable-file-organizer.sh
./portable-file-organizer.sh
```

The Linux edition targets mainstream GNU/Linux distributions with **Bash 4+** and standard command-line tools such as `base64`, `awk`, `date`, `mv`, `mkdir`, `rmdir` and `tr`. Very minimal distributions that do not ship Bash or GNU-style userland by default may require installing the missing tools first.

## Organization modes

| Mode | Result |
|---|---|
| `0` | Main category only |
| `1` | Category + file type/format |
| `2` | Category + date |
| `3` | Category + type/format + date |
| `4` | Category + smart filename rules |
| `5` | Category + type + date + smart rules |

## Safety

Before using any file-moving utility with critical data, test it in a temporary folder and maintain independent backups. Check [`SECURITY.md`](SECURITY.md) for the project security model.

## License

This project is **source-available**, not OSI open source. Personal, educational and internal non-commercial use is permitted under the conditions in [`LICENSE.md`](LICENSE.md). Public distribution of modified versions and commercial exploitation require prior written permission.

---

# Español

## Qué hace

Portable File Organizer clasifica los archivos situados directamente en la misma carpeta que el script. Durante una ejecución normal **no** reorganiza recursivamente las subcarpetas existentes.

Funciones principales:

- Selección de inglés o español al iniciar.
- Carpetas de categorías en el idioma seleccionado.
- Clasificación principal por extensión.
- Subclasificación opcional por tipo/formato, fecha, reglas por nombre o combinaciones.
- Nunca sobrescribe archivos existentes; ante una colisión genera un nombre alternativo seguro.
- Ignora descargas temporales/incompletas conocidas.
- Undo transaccional de la última organización compatible en Windows y Linux.
- Al deshacer solo elimina carpetas creadas por el organizador que continúen vacías.
- Historial interno almacenado en `_PortableFileOrganizer`.
- Sin telemetría, cuentas, procesamiento cloud ni acceso a Internet.

## Windows

Descarga el ZIP de Windows desde Releases, extrae el `.bat`, cópialo en la carpeta que quieras organizar y haz doble clic.

Código fuente en el repositorio: [`Organizar_Archivos_Portable.bat`](Organizar_Archivos_Portable.bat)

## Linux

Descarga el paquete Linux desde Releases o utiliza [`linux/portable-file-organizer.sh`](linux/portable-file-organizer.sh).

```bash
chmod +x portable-file-organizer.sh
./portable-file-organizer.sh
```

La edición Linux está orientada a distribuciones GNU/Linux de uso general con **Bash 4+** y herramientas estándar como `base64`, `awk`, `date`, `mv`, `mkdir`, `rmdir` y `tr`. Las distribuciones extremadamente mínimas que no incluyan Bash o un userland compatible de fábrica pueden requerir instalar previamente las herramientas que falten.

## Modos de organización

| Modo | Resultado |
|---|---|
| `0` | Solo categoría principal |
| `1` | Categoría + tipo/formato |
| `2` | Categoría + fecha |
| `3` | Categoría + tipo/formato + fecha |
| `4` | Categoría + reglas inteligentes por nombre |
| `5` | Categoría + tipo + fecha + reglas inteligentes |

## Seguridad

Antes de utilizar cualquier herramienta que mueva archivos sobre información crítica, pruébala primero en una carpeta temporal y conserva copias de seguridad independientes. Consulta [`SECURITY.md`](SECURITY.md) para conocer el modelo de seguridad del proyecto.

## Licencia

Este proyecto es **source-available / código visible**, no open source bajo una licencia OSI. Se permite el uso personal, educativo e interno no comercial bajo las condiciones de [`LICENSE.md`](LICENSE.md). La distribución pública de versiones modificadas y la explotación comercial requieren autorización previa por escrito.

---

## Versioning / Versionado

The public project starts at **v1.0.0** as a multiplatform release. Semantic Versioning is used for subsequent public versions.

El proyecto público comienza en **v1.0.0** como Release multiplataforma. Las versiones públicas posteriores seguirán Versionado Semántico.

Developed and maintained by / Desarrollado y mantenido por **zaper3**.  
Copyright © 2026 zaper3.
