# Security Policy / Política de seguridad

> **Official repository / Repositorio oficial:** https://github.com/zaper3/Portable-File-Organizer-Windows

---

## English

### Scope

Portable File Organizer for Windows is a local script that organizes files using `cmd.exe` and Windows PowerShell. It does not intentionally use remote services, user accounts, telemetry or cloud storage.

### Safe-use recommendations

- Download the script only from this official repository or its associated GitHub Releases.
- When available, verify the SHA-256 checksum published with the official Release.
- Test the tool first in a temporary folder before using it with important information.
- Keep independent backups of critical data.
- Do not delete the `_Organizador` folder while you want to preserve compatible Undo history.
- Do not execute third-party modified copies without reviewing their changes.

### Security-relevant behavior

The organizer is designed to:

- avoid overwriting existing files;
- ignore known temporary or incomplete downloads;
- avoid traversing or reorganizing existing subfolders during normal organization;
- record the movements required for Undo; and
- remove during Undo only folders recorded as created by the organizer and only when those folders are empty.

### Reporting a vulnerability

If you identify behavior that could cause data loss, unexpected overwriting, unintended command execution or another security issue, avoid posting sensitive data, private paths or personal information in a public issue.

You may open a GitHub issue with a reproducible description and anonymized information to begin the analysis.

### Official distribution

The authoritative source of the project is this repository under the `zaper3` account. Third-party redistributed copies may have been modified and should not automatically be treated as equivalent to the official version published here.

---

## Español

### Alcance

Portable File Organizer for Windows es un script local que organiza archivos mediante `cmd.exe` y Windows PowerShell. No utiliza intencionadamente servicios remotos, cuentas de usuario, telemetría ni almacenamiento en la nube.

### Recomendaciones de uso seguro

- Descarga el script únicamente desde este repositorio oficial o desde sus GitHub Releases asociadas.
- Cuando esté disponible, verifica el checksum SHA-256 publicado junto con la Release oficial.
- Haz una prueba inicial en una carpeta temporal antes de utilizarlo con información importante.
- Mantén copias de seguridad independientes para datos críticos.
- No elimines la carpeta `_Organizador` mientras quieras conservar el historial compatible de Undo.
- No ejecutes copias modificadas por terceros sin revisar previamente sus cambios.

### Comportamiento de seguridad relevante

El organizador está diseñado para:

- no sobrescribir archivos existentes;
- ignorar descargas temporales o incompletas conocidas;
- no recorrer ni reorganizar subcarpetas existentes durante la operación normal;
- registrar los movimientos necesarios para Undo; y
- eliminar durante Undo únicamente carpetas registradas como creadas por el propio organizador y solo cuando estén vacías.

### Reporte de vulnerabilidades

Si detectas un comportamiento que pueda provocar pérdida de datos, sobrescritura inesperada, ejecución de comandos no prevista u otro problema de seguridad, evita publicar datos sensibles, rutas privadas o información personal en un issue público.

Puedes abrir un issue en GitHub con una descripción reproducible y datos anonimizados para iniciar el análisis.

### Distribución oficial

La fuente autoritativa del proyecto es este repositorio bajo la cuenta `zaper3`. Las copias redistribuidas por terceros pueden haber sido modificadas y no deben considerarse automáticamente equivalentes a la versión oficial publicada aquí.
