# Security Policy / Política de Seguridad

> Official source / Fuente oficial: `https://github.com/zaper3/Portable-File-Organizer-Windows`

---

## English

### Scope

Portable File Organizer is a local file-management utility with platform-specific editions.

- **Windows:** `.bat` + Windows PowerShell.
- **GNU/Linux:** Bash + standard local command-line utilities.
- **iOS/iPadOS:** Apple Shortcuts design; final shared Shortcut requires Apple validation/export.

### Security model

The stable Windows and Linux editions are designed to:

- operate locally without telemetry, accounts or remote APIs;
- process only files located directly in the script's current folder during normal organization;
- avoid recursive reorganization of existing subfolders;
- avoid overwriting existing destination files;
- ignore known temporary/incomplete download extensions;
- record moves required for Undo;
- delete during Undo only folders recorded as created by the organizer and only when those folders are empty.

### Recommended use

- Download official builds only from this repository's Releases.
- Verify published SHA-256 checksums where available.
- Test a new version in a temporary folder before using it with important data.
- Maintain independent backups for critical data.
- Do not remove `_PortableFileOrganizer` while you need compatible Undo history.
- Review third-party modifications before executing them.

### Platform-specific notes

On Linux, the script checks for its required commands before running. Extremely minimal distributions may need Bash or standard utilities installed first.

On iOS/iPadOS, file access is constrained by the permissions and locations available to Apple Shortcuts. Shared Shortcut files should be exported/validated using Apple's supported sharing flow; unsigned or manually fabricated Shortcut files are not treated as official builds.

### Reporting a vulnerability

If you discover behavior that may cause data loss, unexpected overwrites, unsafe command execution, path handling problems or another security issue, avoid placing sensitive paths or personal information in a public report. Open a GitHub issue with a reproducible, anonymized description so the problem can be triaged.

---

## Español

### Alcance

Portable File Organizer es una utilidad local de gestión de archivos con ediciones específicas por plataforma.

- **Windows:** `.bat` + Windows PowerShell.
- **GNU/Linux:** Bash + herramientas locales estándar de línea de comandos.
- **iOS/iPadOS:** diseño Apple Atajos; el Shortcut compartido final requiere validación/exportación de Apple.

### Modelo de seguridad

Las ediciones estables de Windows y Linux están diseñadas para:

- funcionar localmente, sin telemetría, cuentas ni APIs remotas;
- procesar durante la organización normal únicamente archivos situados directamente en la carpeta actual del script;
- no reorganizar recursivamente subcarpetas existentes;
- no sobrescribir archivos existentes en destino;
- ignorar extensiones conocidas de descargas temporales/incompletas;
- registrar los movimientos necesarios para Undo;
- eliminar durante Undo únicamente carpetas registradas como creadas por el organizador y solo cuando estén vacías.

### Uso recomendado

- Descarga builds oficiales únicamente desde Releases de este repositorio.
- Verifica los checksums SHA-256 publicados cuando estén disponibles.
- Prueba cada nueva versión en una carpeta temporal antes de utilizarla con información importante.
- Mantén copias de seguridad independientes de los datos críticos.
- No elimines `_PortableFileOrganizer` mientras necesites conservar un historial Undo compatible.
- Revisa las modificaciones de terceros antes de ejecutarlas.

### Notas específicas por plataforma

En Linux, el script comprueba sus comandos necesarios antes de ejecutarse. Las distribuciones extremadamente mínimas pueden requerir instalar previamente Bash o utilidades estándar.

En iOS/iPadOS, el acceso a archivos está limitado por los permisos y ubicaciones disponibles para Apple Atajos. Los archivos Shortcut compartidos deben exportarse/validarse mediante el flujo soportado por Apple; los archivos Shortcut sin firmar o fabricados manualmente no se consideran builds oficiales.

### Reporte de vulnerabilidades

Si detectas un comportamiento que pueda provocar pérdida de datos, sobrescrituras inesperadas, ejecución insegura de comandos, problemas de tratamiento de rutas u otra vulnerabilidad, evita incluir rutas sensibles o información personal en un reporte público. Abre un issue de GitHub con una descripción reproducible y anonimizada para iniciar el análisis.
