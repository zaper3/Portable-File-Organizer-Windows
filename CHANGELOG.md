# Changelog

All notable public changes to **Portable File Organizer** are documented here.  
Todos los cambios públicos relevantes de **Portable File Organizer** se documentan aquí.

The public version history starts at **v1.0.0** as a multiplatform project. Earlier numbers used during private/internal development are not public releases.

El historial público comienza en **v1.0.0** como proyecto multiplataforma. Las numeraciones utilizadas durante el desarrollo privado/interno no constituyen Releases públicas.

---

## [1.0.0] - 2026-08-14

### English

#### Added
- First public multiplatform release.
- Windows 10/11 portable `.bat` edition.
- GNU/Linux portable Bash edition.
- English/Spanish language selector.
- Localized category folders.
- Six organization modes: category, type, date, smart filename rules and combinations.
- Collision-safe moves without overwriting existing files.
- Exclusion of known temporary/incomplete downloads.
- Transactional Undo for Windows and Linux.
- Internal operation history in `_PortableFileOrganizer`.
- iOS/iPadOS Apple Shortcuts distribution design and signing documentation.
- Source-available bilingual license and security documentation.

#### Security
- Offline/local-only operation for Windows and Linux editions.
- Undo removes only folders recorded as created by the organizer and only when empty.
- SHA-256 checksums prepared for Release assets.

### Español

#### Añadido
- Primera Release pública multiplataforma.
- Edición portable `.bat` para Windows 10/11.
- Edición portable Bash para GNU/Linux.
- Selector de idioma inglés/español.
- Carpetas de categorías localizadas.
- Seis modos de organización: categoría, tipo, fecha, reglas inteligentes por nombre y combinaciones.
- Movimientos seguros ante colisiones, sin sobrescribir archivos existentes.
- Exclusión de descargas temporales/incompletas conocidas.
- Undo transaccional para Windows y Linux.
- Historial interno en `_PortableFileOrganizer`.
- Diseño de distribución y documentación de firma para la edición Apple Shortcuts de iOS/iPadOS.
- Licencia source-available bilingüe y documentación de seguridad.

#### Seguridad
- Funcionamiento local/offline para las ediciones Windows y Linux.
- Undo elimina únicamente carpetas registradas como creadas por el organizador y solo si están vacías.
- Checksums SHA-256 preparados para los assets de la Release.
