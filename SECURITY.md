# Security Policy

## Alcance

Portable File Organizer for Windows es un script local que organiza archivos mediante `cmd.exe` y Windows PowerShell. No utiliza servicios remotos, cuentas de usuario, telemetría ni almacenamiento en la nube.

## Recomendaciones de uso seguro

- Descarga el script únicamente desde este repositorio oficial o desde Releases asociadas al mismo.
- Verifica el contenido o el hash de la descarga antes de ejecutarla si el archivo procede de un tercero o espejo.
- Haz una prueba inicial en una carpeta temporal antes de utilizarlo con información importante.
- Mantén copias de seguridad independientes para datos críticos.
- No elimines la carpeta `_Organizador` mientras quieras conservar la capacidad de deshacer operaciones compatibles.
- No ejecutes versiones modificadas por terceros sin revisar sus cambios.

## Comportamiento de seguridad relevante

El organizador está diseñado para:

- no sobrescribir archivos existentes;
- ignorar descargas temporales o incompletas conocidas;
- no recorrer ni reorganizar subcarpetas existentes durante la operación normal;
- registrar los movimientos necesarios para Undo;
- eliminar durante Undo únicamente carpetas que el propio organizador haya registrado como creadas y que estén vacías.

## Reporte de vulnerabilidades

Si detectas un comportamiento que pueda provocar pérdida de datos, sobrescritura inesperada, ejecución de comandos no prevista o cualquier otra vulnerabilidad, evita publicar inicialmente datos sensibles, rutas privadas o información personal en un issue público.

Puedes abrir un issue con una descripción reproducible y datos anonimizados para iniciar el análisis.

## Distribución oficial

La fuente oficial del proyecto es este repositorio bajo la cuenta `zaper3`. Las copias redistribuidas por terceros pueden haber sido modificadas y no deben considerarse equivalentes a la versión publicada aquí.
