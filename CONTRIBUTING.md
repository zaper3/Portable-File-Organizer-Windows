# Contributing to Portable File Organizer / Contribuir a Portable File Organizer

Thank you for your interest in improving Portable File Organizer. This project welcomes useful feedback, bug reports, compatibility reports, translations, documentation improvements and proposed code changes.

Gracias por tu interés en mejorar Portable File Organizer. El proyecto agradece feedback útil, informes de errores, pruebas de compatibilidad, traducciones, mejoras de documentación y propuestas de cambios de código.

> **Important / Importante:** Portable File Organizer is **source-available, not OSI open source**. Contributions and use of the project remain subject to [`LICENSE.md`](LICENSE.md). Public redistribution of modified versions or forks and commercial exploitation are not automatically authorized by contributing to this repository.
>
> Portable File Organizer es **source-available / código visible, no open source bajo una licencia OSI**. Las contribuciones y el uso del proyecto continúan sujetos a [`LICENSE.md`](LICENSE.md). Contribuir al repositorio no autoriza automáticamente la redistribución pública de versiones modificadas o forks ni la explotación comercial.

---

## English

### Ways to contribute

You can help by:

- reporting reproducible bugs;
- reporting Windows or GNU/Linux compatibility results;
- proposing new file extensions or classification rules;
- suggesting usability or safety improvements;
- improving English/Spanish text or proposing additional translations;
- improving documentation;
- proposing focused code changes through a Pull Request.

### Before opening a bug report

Please check that you are using the latest official Release and, when possible, reproduce the issue in a temporary test folder rather than with critical data.

A useful report should include:

- operating system and version;
- Portable File Organizer version;
- Windows or Linux edition;
- selected language and organization mode;
- expected behavior;
- actual behavior and exact error message;
- minimal reproduction steps;
- relevant filenames/extensions, anonymized when necessary.

**Do not include passwords, tokens, private documents, personal data or other secrets in Issues, logs, screenshots or Pull Requests.**

### Proposing a change

For small fixes, a focused Pull Request is welcome. For substantial behavior changes, new platforms or architectural changes, please open an Issue first so the proposal can be discussed before significant work is done.

Keep changes small and reviewable. Avoid unrelated refactoring. Preserve the existing safety principles: no silent overwrite, conservative file movement, reversible operations where supported, local/offline operation, and clear user confirmation for destructive or potentially disruptive actions.

When changing user-visible behavior, keep English and Spanish interfaces/documentation synchronized.

### Pull Request checklist

Before submitting a Pull Request:

- test the change in a disposable folder;
- verify that filenames with spaces and common special characters are handled safely;
- test collision behavior;
- test Undo when the change affects file movement;
- update documentation when behavior changes;
- avoid adding network access, telemetry or dependencies unless they are clearly justified and discussed first;
- do not add secrets, generated credentials, private data or unrelated binaries.

### Security issues

Please do not publicly disclose a vulnerability before giving the maintainer a reasonable opportunity to assess it. Follow the reporting guidance in [`SECURITY.md`](SECURITY.md).

### Licensing and contributions

By submitting a contribution, you confirm that you have the right to submit it and that you understand the repository is distributed under the terms in [`LICENSE.md`](LICENSE.md). Submission of a contribution does not change the project's license or grant third parties additional redistribution or commercial rights beyond those license terms.

---

## Español

### Formas de contribuir

Puedes ayudar mediante:

- informes de errores reproducibles;
- resultados de compatibilidad en Windows o GNU/Linux;
- propuestas de nuevas extensiones o reglas de clasificación;
- mejoras de usabilidad o seguridad;
- mejoras de textos en inglés/español o propuestas de nuevas traducciones;
- mejoras de documentación;
- cambios de código concretos mediante Pull Request.

### Antes de abrir un informe de error

Comprueba que utilizas la última Release oficial y, cuando sea posible, reproduce el problema en una carpeta temporal de pruebas en lugar de utilizar información crítica.

Un informe útil debería indicar:

- sistema operativo y versión;
- versión de Portable File Organizer;
- edición Windows o Linux;
- idioma y modo de organización seleccionados;
- comportamiento esperado;
- comportamiento obtenido y mensaje de error exacto;
- pasos mínimos para reproducirlo;
- nombres/extensiones relevantes, anonimizados cuando sea necesario.

**No incluyas contraseñas, tokens, documentos privados, datos personales ni otros secretos en Issues, logs, capturas o Pull Requests.**

### Proponer un cambio

Para correcciones pequeñas, se agradecen Pull Requests concretos. Para cambios importantes de comportamiento, nuevas plataformas o cambios de arquitectura, abre primero un Issue para discutir la propuesta antes de invertir trabajo significativo.

Mantén los cambios pequeños y revisables. Evita refactorizaciones no relacionadas. Conserva los principios de seguridad existentes: no sobrescribir silenciosamente, movimientos conservadores de archivos, operaciones reversibles cuando estén soportadas, funcionamiento local/offline y confirmación clara ante acciones destructivas o potencialmente disruptivas.

Cuando cambies comportamiento visible para el usuario, mantén sincronizadas las interfaces y documentación en inglés y español.

### Checklist para Pull Requests

Antes de enviar un Pull Request:

- prueba el cambio en una carpeta desechable;
- comprueba nombres con espacios y caracteres especiales habituales;
- prueba las colisiones de nombres;
- prueba Undo si el cambio afecta al movimiento de archivos;
- actualiza la documentación cuando cambie el comportamiento;
- evita introducir acceso a red, telemetría o dependencias salvo que estén claramente justificadas y se hayan discutido previamente;
- no añadas secretos, credenciales generadas, datos privados ni binarios ajenos al cambio.

### Problemas de seguridad

No publiques una vulnerabilidad antes de dar al mantenedor una oportunidad razonable de evaluarla. Sigue las indicaciones de [`SECURITY.md`](SECURITY.md).

### Licencia y contribuciones

Al enviar una contribución confirmas que tienes derecho a hacerlo y que comprendes que el repositorio se distribuye bajo las condiciones de [`LICENSE.md`](LICENSE.md). Enviar una contribución no cambia la licencia del proyecto ni concede a terceros derechos adicionales de redistribución o explotación comercial fuera de dichas condiciones.
