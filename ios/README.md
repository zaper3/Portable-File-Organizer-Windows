# Portable File Organizer — iOS / iPadOS

> Status: **Preview / preparación de distribución**

The iOS/iPadOS edition is designed for **Apple Shortcuts** so it can remain native, lightweight and free of third-party runtime dependencies.

La edición iOS/iPadOS está diseñada para **Apple Atajos (Shortcuts)** para mantenerse nativa, ligera y sin dependencias de ejecución de terceros.

> **Important:** the `Portable-File-Organizer-iOS-v1.0.0-preview.zip` asset is documentation/build guidance only. It is **not** an executable `.shortcut` file and cannot simply be “validated” by an end user to turn it into one.
>
> **Importante:** el asset `Portable-File-Organizer-iOS-v1.0.0-preview.zip` contiene únicamente documentación/guía de construcción. **No** es un archivo `.shortcut` ejecutable y un usuario no puede simplemente “validarlo” para convertirlo en uno.

## English

### Why there is no `.bat` or `.sh`

iOS/iPadOS does not offer the same arbitrary shell-script execution model as Windows or GNU/Linux. The appropriate native equivalent for this project is a Shortcut that operates on files/folders selected or authorized by the user.

Apple supports sharing Shortcuts through iCloud links or exported shortcut files. When a shortcut file is exported for **Anyone**, Apple receives a copy for validation to help prevent unauthorized tampering. Because that validation/signing step is performed by Apple, the final public `.shortcut` asset must first exist as a real Shortcut and then be exported from the Shortcuts app on an iPhone/iPad or signed with the `shortcuts` command on macOS.

A Windows PC cannot perform Apple's Shortcut signing/validation flow. An iPhone/iPad user could manually recreate the Shortcut from a build guide and then export it through Apple Shortcuts, but that would be a user-created build until it has been reviewed and adopted as an official project asset.

Official Apple documentation:
- https://support.apple.com/guide/shortcuts/share-shortcuts-apdf01f8c054/ios
- https://support.apple.com/guide/shortcuts-mac/run-shortcuts-from-the-command-line-apd455c82f02/mac

### v1.0.0 design target

The Shortcut edition should preserve the same project principles where the platform permits them:

- English / Español selection.
- User-selected folder in the Files app.
- Organization of files in that selected folder, without unrestricted access to the whole device.
- Main categories equivalent to the Windows/Linux editions.
- Conservative handling of name collisions.
- No telemetry or remote processing.
- Clear preview before moving files.
- Transaction/Undo design using a local `_PortableFileOrganizer` record where Shortcuts capabilities permit safe implementation.

### Distribution requirement

A repository-generated or hand-crafted unsigned `.shortcut` is **not** published here as if it were an official working build. The public Shortcut must first be created/tested in Apple Shortcuts and exported with Apple's validation/signing flow.

Once exported, the intended Release asset name is:

```text
Portable-File-Organizer-iOS-v1.0.0.shortcut
```

and it should be uploaded to the same GitHub Release as the Windows and Linux assets.

---

## Español

### Por qué no existe un `.bat` o `.sh`

iOS/iPadOS no ofrece el mismo modelo de ejecución arbitraria de scripts de shell que Windows o GNU/Linux. El equivalente nativo apropiado para este proyecto es un Atajo que trabaje sobre archivos/carpetas seleccionados o autorizados por el usuario.

Apple permite compartir Atajos mediante enlaces de iCloud o archivos exportados. Cuando un archivo de Atajo se exporta para **Cualquiera**, Apple recibe una copia para validarlo y ayudar a impedir manipulaciones no autorizadas. Como esa validación/firma la realiza Apple, el `.shortcut` público final debe existir primero como un Atajo real y después exportarse desde la app Atajos en un iPhone/iPad o firmarse mediante el comando `shortcuts` en macOS.

Un PC con Windows no puede realizar el flujo de firma/validación de Apple Shortcuts. Un usuario con iPhone/iPad sí podría reconstruir manualmente el Atajo siguiendo una guía y después exportarlo mediante Apple Atajos, pero esa sería una build creada por ese usuario hasta que fuese revisada y adoptada como asset oficial del proyecto.

Documentación oficial de Apple:
- https://support.apple.com/es-es/guide/shortcuts/apdf01f8c054/ios
- https://support.apple.com/es-es/guide/shortcuts-mac/apd455c82f02/mac

### Objetivo de diseño v1.0.0

La edición Shortcut debe conservar los mismos principios del proyecto donde la plataforma lo permita:

- Selección English / Español.
- Carpeta seleccionada por el usuario en la app Archivos.
- Organización de los archivos de esa carpeta, sin acceso irrestricto a todo el dispositivo.
- Categorías principales equivalentes a las ediciones Windows/Linux.
- Gestión conservadora de colisiones de nombres.
- Sin telemetría ni procesamiento remoto.
- Vista/confirmación previa antes de mover archivos.
- Diseño transaccional/Undo mediante un registro local `_PortableFileOrganizer` cuando las capacidades de Atajos permitan implementarlo de forma segura.

### Requisito de distribución

No se publicará un `.shortcut` fabricado manualmente o sin firmar como si fuera una build oficial funcional. El Atajo público debe crearse/probarse primero en Apple Atajos y exportarse mediante el flujo de validación/firma de Apple.

Una vez exportado, el nombre previsto del asset será:

```text
Portable-File-Organizer-iOS-v1.0.0.shortcut
```

y deberá subirse a la misma GitHub Release que los assets de Windows y Linux.
