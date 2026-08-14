@echo off
setlocal
title Organizador portable de archivos v3.1
cd /d "%~dp0"
set "ORGANIZER_BAT=%~f0"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$bat=$env:ORGANIZER_BAT; $lines=Get-Content -LiteralPath $bat; $marker=[Array]::IndexOf($lines,'#===POWERSHELL==='); if($marker -lt 0){throw 'No se encontro el bloque PowerShell interno.'}; $code=($lines[($marker+1)..($lines.Length-1)] -join [Environment]::NewLine); try { & ([ScriptBlock]::Create($code)) } catch { Write-Host ''; Write-Host 'ERROR INESPERADO:' -ForegroundColor Red; Write-Host $_.Exception.Message -ForegroundColor Red; Write-Host ''; Read-Host 'Pulsa ENTER para cerrar'; exit 1 }"
if errorlevel 1 (
  echo.
  echo El organizador termino con un error.
  echo.
  pause
)
endlocal
exit /b

#===POWERSHELL===

$ErrorActionPreference = 'Stop'

$base = (Get-Location).Path
$self = [System.IO.Path]::GetFileName($env:ORGANIZER_BAT)

$dataDir = Join-Path $base '_Organizador'

if (-not (Test-Path -LiteralPath $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

$moveLog   = Join-Path $dataDir 'Movimientos.csv'
$folderLog = Join-Path $dataDir 'Carpetas.csv'
$runLog    = Join-Path $dataDir 'Ejecuciones.csv'

# Migracion automatica desde v3.0 si existen registros antiguos en la raiz.
$legacyFiles = @{
    (Join-Path $base '_Organizador_Movimientos.csv') = $moveLog
    (Join-Path $base '_Organizador_Carpetas.csv')    = $folderLog
    (Join-Path $base '_Organizador_Ejecuciones.csv') = $runLog
}

foreach ($legacy in $legacyFiles.Keys) {
    $target = $legacyFiles[$legacy]

    if (Test-Path -LiteralPath $legacy) {
        if (-not (Test-Path -LiteralPath $target)) {
            Move-Item -LiteralPath $legacy -Destination $target
        }
        else {
            # Si ya existe un registro nuevo, conserva el antiguo como copia.
            $backupName = [System.IO.Path]::GetFileNameWithoutExtension($legacy) + '_legacy_' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.csv'
            Move-Item -LiteralPath $legacy -Destination (Join-Path $dataDir $backupName)
        }
    }
}

$rules = [ordered]@{
    '01_Documentos'     = @('.pdf','.doc','.docx','.odt','.rtf','.txt','.md','.epub','.mobi','.azw','.azw3','.csv','.xls','.xlsx','.xlsm','.ods','.ppt','.pptx','.odp','.one')
    '02_Imagenes'       = @('.jpg','.jpeg','.png','.gif','.webp','.bmp','.tif','.tiff','.svg','.ico','.heic','.heif','.avif','.raw','.cr2','.cr3','.nef','.arw','.dng')
    '03_Videos'         = @('.mp4','.mkv','.avi','.mov','.wmv','.flv','.webm','.m4v','.mpeg','.mpg','.mts','.m2ts','.3gp')
    '04_Audio'          = @('.mp3','.wav','.flac','.aac','.ogg','.m4a','.wma','.opus','.aiff','.alac','.mid','.midi')
    '05_Comprimidos'    = @('.zip','.rar','.7z','.tar','.gz','.tgz','.bz2','.xz','.cab','.zst')
    '06_Instaladores'   = @('.exe','.msi','.msix','.msixbundle','.appx','.appxbundle','.apk','.aab')
    '07_Imagenes_Disco' = @('.iso','.img','.vhd','.vhdx','.dmg')
    '08_Torrents'       = @('.torrent')
    '09_Fuentes'        = @('.ttf','.otf','.woff','.woff2','.eot')
    '10_Codigo_y_Datos' = @('.py','.js','.jsx','.ts','.tsx','.html','.htm','.css','.scss','.sass','.less','.json','.xml','.yaml','.yml','.sql','.java','.cs','.cpp','.c','.h','.hpp','.php','.rb','.go','.rs','.sh','.ps1','.bat','.cmd','.ini','.cfg','.conf','.toml','.log')
    '11_CAD_BIM'        = @('.dwg','.dxf','.dwt','.rvt','.rfa','.rte','.ifc','.nwd','.nwc','.nwf','.skp')
}

$subtypes = @{
    '.pdf'='PDF'
    '.doc'='Word'; '.docx'='Word'; '.odt'='Word'
    '.rtf'='Texto_Rico'; '.txt'='Texto'; '.md'='Markdown'
    '.xls'='Excel'; '.xlsx'='Excel'; '.xlsm'='Excel'; '.ods'='Excel'
    '.csv'='CSV'
    '.ppt'='PowerPoint'; '.pptx'='PowerPoint'; '.odp'='PowerPoint'

    '.jpg'='JPG'; '.jpeg'='JPG'; '.png'='PNG'; '.gif'='GIF'
    '.webp'='WEBP'; '.svg'='SVG'; '.heic'='HEIC'; '.heif'='HEIC'; '.avif'='AVIF'
    '.raw'='RAW'; '.cr2'='RAW'; '.cr3'='RAW'; '.nef'='RAW'; '.arw'='RAW'; '.dng'='RAW'

    '.mp4'='MP4'; '.mkv'='MKV'; '.avi'='AVI'; '.mov'='MOV'; '.webm'='WEBM'
    '.mp3'='MP3'; '.flac'='FLAC'; '.wav'='WAV'; '.m4a'='M4A'; '.aac'='AAC'; '.ogg'='OGG'; '.opus'='OPUS'

    '.zip'='ZIP'; '.rar'='RAR'; '.7z'='7Z'; '.tar'='TAR'; '.gz'='GZ'

    '.exe'='Windows_EXE'; '.msi'='Windows_MSI'; '.msix'='Windows_MSIX'; '.msixbundle'='Windows_MSIX'
    '.apk'='Android_APK'; '.aab'='Android_AAB'

    '.dwg'='AutoCAD'; '.dxf'='AutoCAD'; '.dwt'='AutoCAD'
    '.rvt'='Revit'; '.rfa'='Revit'; '.rte'='Revit'
    '.ifc'='IFC'
    '.nwd'='Navisworks'; '.nwc'='Navisworks'; '.nwf'='Navisworks'
    '.skp'='SketchUp'

    '.py'='Python'
    '.js'='JavaScript'; '.jsx'='JavaScript'
    '.ts'='TypeScript'; '.tsx'='TypeScript'
    '.html'='Web'; '.htm'='Web'; '.css'='Web'; '.scss'='Web'
    '.sql'='SQL'; '.json'='JSON'; '.xml'='XML'; '.yaml'='YAML'; '.yml'='YAML'
    '.ps1'='PowerShell'; '.bat'='Batch'; '.cmd'='Batch'
}

function Write-CsvRows {
    param(
        [Parameter(Mandatory)] [object[]]$Rows,
        [Parameter(Mandatory)] [string]$Path
    )

    if (-not $Rows -or $Rows.Count -eq 0) { return }

    if (Test-Path -LiteralPath $Path) {
        $Rows | Export-Csv -LiteralPath $Path -NoTypeInformation -Encoding UTF8 -Append
    }
    else {
        $Rows | Export-Csv -LiteralPath $Path -NoTypeInformation -Encoding UTF8
    }
}

function Save-RunLog {
    param([object[]]$Rows)

    if (-not $Rows -or $Rows.Count -eq 0) {
        if (Test-Path -LiteralPath $runLog) {
            Remove-Item -LiteralPath $runLog -Force
        }
        return
    }

    $Rows | Export-Csv -LiteralPath $runLog -NoTypeInformation -Encoding UTF8
}

function Get-RunLog {
    if (Test-Path -LiteralPath $runLog) {
        return @(Import-Csv -LiteralPath $runLog)
    }
    return @()
}

function Update-RunStatus {
    param(
        [string]$RunId,
        [string]$Status,
        [string]$UndoDate = '',
        [string]$Notes = ''
    )

    $runs = Get-RunLog

    foreach ($r in $runs) {
        if ($r.RunId -eq $RunId) {
            $r.Status = $Status
            if ($UndoDate) { $r.UndoDate = $UndoDate }
            if ($Notes)    { $r.Notes = $Notes }
        }
    }

    Save-RunLog -Rows $runs
}

function Get-Category {
    param([string]$Extension)

    $e = $Extension.ToLowerInvariant()

    foreach ($pair in $rules.GetEnumerator()) {
        if ($pair.Value -contains $e) {
            return $pair.Key
        }
    }

    return '99_Otros'
}

function Get-Subtype {
    param([string]$Extension)

    $e = $Extension.ToLowerInvariant()

    if ($subtypes.ContainsKey($e)) { return $subtypes[$e] }
    if ([string]::IsNullOrWhiteSpace($e)) { return 'Sin_Extension' }

    return $e.TrimStart('.').ToUpperInvariant()
}

function Get-KeywordFolder {
    param([string]$Name)

    $n = $Name.ToLowerInvariant()

    if ($n -match 'factura|invoice') { return 'Facturas' }
    if ($n -match 'presupuesto|budget|oferta') { return 'Presupuestos_y_Ofertas' }
    if ($n -match 'informe|report') { return 'Informes' }
    if ($n -match 'contrato|contract') { return 'Contratos' }
    if ($n -match '(^|[_\-\s])cv([_\-\s]|$)|curriculum|resume') { return 'CV_y_Curriculum' }
    if ($n -match 'certificado|certificate') { return 'Certificados' }
    if ($n -match 'manual|guide|guia') { return 'Manuales_y_Guias' }
    if ($n -match 'captura|screenshot') { return 'Capturas' }

    return $null
}

function Get-FreeName {
    param(
        [string]$DestinationDirectory,
        [string]$Name
    )

    $candidate = Join-Path $DestinationDirectory $Name

    if (-not (Test-Path -LiteralPath $candidate)) { return $candidate }

    $stem = [System.IO.Path]::GetFileNameWithoutExtension($Name)
    $ext  = [System.IO.Path]::GetExtension($Name)
    $i = 2

    do {
        $candidate = Join-Path $DestinationDirectory ($stem + ' (' + $i + ')' + $ext)
        $i++
    }
    while (Test-Path -LiteralPath $candidate)

    return $candidate
}

function Ensure-DestinationPath {
    param(
        [string]$Root,
        [System.Collections.Generic.List[string]]$Parts,
        [string]$RunId,
        [System.Collections.Generic.List[object]]$CreatedFolders,
        [System.Collections.Generic.HashSet[string]]$CreatedFolderSet
    )

    $current = $Root

    foreach ($part in $Parts) {
        $current = Join-Path $current $part

        if (-not (Test-Path -LiteralPath $current)) {
            New-Item -ItemType Directory -Path $current | Out-Null

            if ($CreatedFolderSet.Add($current)) {
                $CreatedFolders.Add([pscustomobject]@{
                    RunId   = $RunId
                    Fecha   = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
                    Carpeta = $current
                })
            }
        }
    }

    return $current
}

function Invoke-Organize {
    $excludeNames = @(
        $self,
        'desktop.ini',
        'Thumbs.db',
        '.DS_Store'
    )

    $files = @(Get-ChildItem -LiteralPath $base -File -Force | Where-Object {
        $excludeNames -notcontains $_.Name -and
        $_.Name -notlike 'Organizar_Archivos_Portable*.bat' -and
        $_.Name -notlike '_Organizador_*.csv' -and
        $_.Name -notlike '*.crdownload' -and
        $_.Name -notlike '*.part' -and
        $_.Name -notlike '*.partial' -and
        $_.Name -notlike '*.tmp' -and
        $_.Length -gt 0
    })

    Clear-Host

    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host '        ORGANIZADOR PORTABLE DE ARCHIVOS v3.1' -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ''
    Write-Host ('Carpeta: ' + $base)
    Write-Host ('Archivos detectados: ' + $files.Count)
    Write-Host ''

    if ($files.Count -eq 0) {
        Write-Host 'No hay archivos que organizar en esta carpeta.' -ForegroundColor Yellow
        Write-Host ''
        Read-Host 'Pulsa ENTER para volver al menu'
        return
    }

    Write-Host 'SEGURIDAD' -ForegroundColor Green
    Write-Host ' - Solo se procesan archivos del nivel actual.'
    Write-Host ' - Las subcarpetas existentes no se modifican.'
    Write-Host ' - Los archivos duplicados nunca se sobrescriben.'
    Write-Host ' - Las descargas temporales o incompletas se ignoran.'
    Write-Host ' - Los registros internos se guardan en _Organizador.'
    Write-Host ' - Esta ejecucion podra revertirse desde el menu principal.'
    Write-Host ''

    $answer = Read-Host 'Escribe SI para continuar'

    if ($answer.Trim().ToUpperInvariant() -ne 'SI') {
        Write-Host ''
        Write-Host 'Operacion cancelada.' -ForegroundColor Yellow
        Start-Sleep -Seconds 1
        return
    }

    Write-Host ''
    Write-Host 'CATEGORIZACION ADICIONAL (opcional)' -ForegroundColor Cyan
    Write-Host ''
    Write-Host '  0 - Solo categoria principal (por defecto)'
    Write-Host '  1 - Categoria + tipo/formato'
    Write-Host '  2 - Categoria + fecha (AAAA\MM_Mes)'
    Write-Host '  3 - Categoria + tipo/formato + fecha'
    Write-Host '  4 - Categoria + reglas inteligentes por nombre'
    Write-Host '  5 - Categoria + tipo + fecha + reglas inteligentes'
    Write-Host ''

    $mode = Read-Host 'Seleccion [0-5]'

    if ([string]::IsNullOrWhiteSpace($mode)) { $mode = '0' }

    if ($mode -notin @('0','1','2','3','4','5')) {
        Write-Host ''
        Write-Host 'Opcion no valida. Se usara el modo 0.' -ForegroundColor Yellow
        $mode = '0'
    }

    $useSubtype  = $mode -in @('1','3','5')
    $useDate     = $mode -in @('2','3','5')
    $useKeywords = $mode -in @('4','5')

    $monthNames = @(
        '01_Enero','02_Febrero','03_Marzo','04_Abril','05_Mayo','06_Junio',
        '07_Julio','08_Agosto','09_Septiembre','10_Octubre','11_Noviembre','12_Diciembre'
    )

    $runId = (Get-Date -Format 'yyyyMMdd-HHmmss-fff') + '-' + ([guid]::NewGuid().ToString('N').Substring(0,6))

    $runRow = [pscustomobject]@{
        RunId       = $runId
        Fecha       = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        Modo        = $mode
        Status      = 'IN_PROGRESS'
        Archivos    = $files.Count
        UndoDate    = ''
        Notes       = ''
    }

    Write-CsvRows -Rows @($runRow) -Path $runLog

    $moveRows = New-Object 'System.Collections.Generic.List[object]'
    $createdFolders = New-Object 'System.Collections.Generic.List[object]'
    $createdFolderSet = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)

    $moved = 0
    $errors = 0

    Write-Host ''
    Write-Host ('Ejecucion: ' + $runId) -ForegroundColor DarkGray
    Write-Host 'Organizando...' -ForegroundColor Cyan
    Write-Host ''

    foreach ($f in $files) {
        try {
            $category = Get-Category -Extension $f.Extension
            $parts = New-Object 'System.Collections.Generic.List[string]'
            [void]$parts.Add($category)

            if ($useKeywords) {
                $keywordFolder = Get-KeywordFolder -Name $f.BaseName
                if ($keywordFolder) { [void]$parts.Add($keywordFolder) }
            }

            if ($useSubtype) {
                [void]$parts.Add((Get-Subtype -Extension $f.Extension))
            }

            if ($useDate) {
                $date = $f.LastWriteTime
                [void]$parts.Add($date.Year.ToString())
                [void]$parts.Add($monthNames[$date.Month - 1])
            }

            $destinationDirectory = Ensure-DestinationPath `
                -Root $base `
                -Parts $parts `
                -RunId $runId `
                -CreatedFolders $createdFolders `
                -CreatedFolderSet $createdFolderSet

            $destination = Get-FreeName -DestinationDirectory $destinationDirectory -Name $f.Name
            $original = $f.FullName

            Move-Item -LiteralPath $original -Destination $destination

            $moveRows.Add([pscustomobject]@{
                RunId      = $runId
                Fecha      = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
                Archivo    = $f.Name
                Origen     = $original
                Destino    = $destination
                Categoria  = $category
                Modo       = $mode
                UndoEstado = ''
                UndoFecha  = ''
            })

            $moved++
            Write-Host ('[OK] ' + $f.Name + '  ->  ' + ($parts -join '\'))
        }
        catch {
            $errors++
            Write-Host ('[ERROR] ' + $f.Name + ' : ' + $_.Exception.Message) -ForegroundColor Red
        }
    }

    Write-CsvRows -Rows $moveRows.ToArray() -Path $moveLog
    Write-CsvRows -Rows $createdFolders.ToArray() -Path $folderLog

    if ($errors -eq 0) {
        Update-RunStatus -RunId $runId -Status 'COMPLETED' -Notes ('Movidos=' + $moved)
    }
    else {
        Update-RunStatus -RunId $runId -Status 'COMPLETED_WITH_ERRORS' -Notes ('Movidos=' + $moved + '; Errores=' + $errors)
    }

    Write-Host ''
    Write-Host '================================================================' -ForegroundColor Green
    Write-Host ('Finalizado. Movidos: ' + $moved + ' | Errores: ' + $errors) -ForegroundColor Green
    Write-Host ('Ejecucion registrada: ' + $runId)
    Write-Host ('Datos internos: ' + $dataDir)
    Write-Host '================================================================' -ForegroundColor Green
    Write-Host ''

    Read-Host 'Pulsa ENTER para volver al menu'
}

function Invoke-Undo {
    Clear-Host

    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host '        DESHACER ULTIMA ORGANIZACION - v3.1' -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ''

    $runs = Get-RunLog

    $candidate = $runs |
        Where-Object { $_.Status -in @('COMPLETED','COMPLETED_WITH_ERRORS','PARTIAL_UNDO') } |
        Select-Object -Last 1

    if (-not $candidate) {
        Write-Host 'No hay ninguna organizacion pendiente de deshacer.' -ForegroundColor Yellow
        Write-Host ''
        Read-Host 'Pulsa ENTER para volver al menu'
        return
    }

    if (-not (Test-Path -LiteralPath $moveLog)) {
        Write-Host 'No existe el registro de movimientos necesario para deshacer.' -ForegroundColor Red
        Write-Host ''
        Read-Host 'Pulsa ENTER para volver al menu'
        return
    }

    $allMoves = @(Import-Csv -LiteralPath $moveLog)
    $moves = @($allMoves | Where-Object {
        $_.RunId -eq $candidate.RunId -and $_.UndoEstado -ne 'RESTAURADO'
    })

    if ($moves.Count -eq 0) {
        Update-RunStatus -RunId $candidate.RunId -Status 'UNDONE' -UndoDate (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') -Notes 'Sin movimientos pendientes'
        Write-Host 'La ultima ejecucion ya no tiene movimientos pendientes.' -ForegroundColor Yellow
        Write-Host ''
        Read-Host 'Pulsa ENTER para volver al menu'
        return
    }

    Write-Host ('Ejecucion: ' + $candidate.RunId)
    Write-Host ('Fecha original: ' + $candidate.Fecha)
    Write-Host ('Modo: ' + $candidate.Modo)
    Write-Host ('Archivos pendientes de restaurar: ' + $moves.Count)
    Write-Host ''
    Write-Host 'El proceso:' -ForegroundColor Green
    Write-Host ' - Devolvera cada archivo a su ubicacion original.'
    Write-Host ' - No sobrescribira ningun archivo existente.'
    Write-Host ' - Eliminara solo carpetas creadas por este organizador y solo si estan vacias.'
    Write-Host ''

    $confirm = Read-Host 'Escribe DESHACER para continuar'

    if ($confirm.Trim().ToUpperInvariant() -ne 'DESHACER') {
        Write-Host ''
        Write-Host 'Operacion cancelada.' -ForegroundColor Yellow
        Start-Sleep -Seconds 1
        return
    }

    $restored = 0
    $conflicts = 0
    $missing = 0
    $errors = 0
    $undoDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

    Write-Host ''
    Write-Host 'Restaurando archivos...' -ForegroundColor Cyan
    Write-Host ''

    [array]::Reverse($moves)

    foreach ($m in $moves) {
        try {
            if (-not (Test-Path -LiteralPath $m.Destino)) {
                $missing++
                Write-Host ('[NO ENCONTRADO] ' + $m.Destino) -ForegroundColor Yellow
                continue
            }

            if (Test-Path -LiteralPath $m.Origen) {
                $conflicts++
                Write-Host ('[CONFLICTO] Ya existe en origen: ' + $m.Origen) -ForegroundColor Yellow
                continue
            }

            $originParent = Split-Path -Parent $m.Origen

            if (-not (Test-Path -LiteralPath $originParent)) {
                New-Item -ItemType Directory -Path $originParent -Force | Out-Null
            }

            Move-Item -LiteralPath $m.Destino -Destination $m.Origen

            foreach ($row in $allMoves) {
                if ($row.RunId -eq $m.RunId -and $row.Destino -eq $m.Destino) {
                    $row.UndoEstado = 'RESTAURADO'
                    $row.UndoFecha = $undoDate
                }
            }

            $restored++
            Write-Host ('[OK] ' + $m.Archivo + '  ->  restaurado')
        }
        catch {
            $errors++
            Write-Host ('[ERROR] ' + $m.Archivo + ' : ' + $_.Exception.Message) -ForegroundColor Red
        }
    }

    $allMoves | Export-Csv -LiteralPath $moveLog -NoTypeInformation -Encoding UTF8

    $foldersRemoved = 0
    $foldersKept = 0

    if (Test-Path -LiteralPath $folderLog) {
        $folderRows = @(Import-Csv -LiteralPath $folderLog | Where-Object { $_.RunId -eq $candidate.RunId })

        $folderPaths = @(
            $folderRows |
            Select-Object -ExpandProperty Carpeta -Unique |
            Sort-Object { $_.Length } -Descending
        )

        Write-Host ''
        Write-Host 'Limpiando carpetas creadas por el organizador...' -ForegroundColor Cyan
        Write-Host ''

        foreach ($folder in $folderPaths) {
            try {
                if (-not (Test-Path -LiteralPath $folder)) { continue }

                $children = @(Get-ChildItem -LiteralPath $folder -Force)

                if ($children.Count -eq 0) {
                    Remove-Item -LiteralPath $folder -Force
                    $foldersRemoved++
                    Write-Host ('[ELIMINADA] ' + $folder)
                }
                else {
                    $foldersKept++
                    Write-Host ('[CONSERVADA] No esta vacia: ' + $folder) -ForegroundColor DarkYellow
                }
            }
            catch {
                $foldersKept++
                Write-Host ('[NO ELIMINADA] ' + $folder + ' : ' + $_.Exception.Message) -ForegroundColor DarkYellow
            }
        }
    }

    $remaining = @($allMoves | Where-Object {
        $_.RunId -eq $candidate.RunId -and $_.UndoEstado -ne 'RESTAURADO'
    }).Count

    if ($remaining -eq 0) {
        Update-RunStatus `
            -RunId $candidate.RunId `
            -Status 'UNDONE' `
            -UndoDate $undoDate `
            -Notes ('Restaurados=' + $restored + '; CarpetasEliminadas=' + $foldersRemoved + '; CarpetasConservadas=' + $foldersKept)
    }
    else {
        Update-RunStatus `
            -RunId $candidate.RunId `
            -Status 'PARTIAL_UNDO' `
            -UndoDate $undoDate `
            -Notes ('Restaurados=' + $restored + '; Pendientes=' + $remaining + '; Conflictos=' + $conflicts + '; NoEncontrados=' + $missing + '; Errores=' + $errors)
    }

    Write-Host ''
    Write-Host '================================================================' -ForegroundColor Green
    Write-Host ('Restaurados: ' + $restored) -ForegroundColor Green
    Write-Host ('Pendientes: ' + $remaining)
    Write-Host ('Conflictos: ' + $conflicts)
    Write-Host ('No encontrados: ' + $missing)
    Write-Host ('Errores: ' + $errors)
    Write-Host ('Carpetas eliminadas: ' + $foldersRemoved)
    Write-Host ('Carpetas conservadas por contener archivos: ' + $foldersKept)
    Write-Host '================================================================' -ForegroundColor Green
    Write-Host ''

    if ($remaining -gt 0) {
        Write-Host 'La reversion fue parcial.' -ForegroundColor Yellow
        Write-Host 'Puedes resolver los conflictos y ejecutar DESHACER nuevamente.'
        Write-Host ''
    }

    Read-Host 'Pulsa ENTER para volver al menu'
}

while ($true) {
    Clear-Host

    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host '        ORGANIZADOR PORTABLE DE ARCHIVOS v3.1' -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ''
    Write-Host ('Carpeta actual: ' + $base)
    Write-Host ('Datos internos: ' + $dataDir)
    Write-Host ''
    Write-Host '  1 - Organizar archivos'
    Write-Host '  2 - Deshacer ultima organizacion'
    Write-Host '  3 - Salir'
    Write-Host ''

    $choice = Read-Host 'Seleccion [1-3]'

    switch ($choice) {
        '1' { Invoke-Organize }
        '2' { Invoke-Undo }
        '3' { return }
        default {
            Write-Host ''
            Write-Host 'Opcion no valida.' -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }
    }
}
