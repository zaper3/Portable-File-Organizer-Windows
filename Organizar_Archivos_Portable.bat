@echo off
setlocal
title Portable File Organizer for Windows v1.0.0
cd /d "%~dp0"
chcp 65001 >nul
set "ORGANIZER_BAT=%~f0"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$bat=$env:ORGANIZER_BAT; $lines=Get-Content -LiteralPath $bat -Encoding UTF8; $marker=[Array]::IndexOf($lines,'#===POWERSHELL==='); if($marker -lt 0){throw 'Embedded PowerShell block not found.'}; $code=($lines[($marker+1)..($lines.Length-1)] -join [Environment]::NewLine); try { & ([ScriptBlock]::Create($code)) } catch { Write-Host ''; Write-Host 'UNEXPECTED ERROR / ERROR INESPERADO:' -ForegroundColor Red; Write-Host $_.Exception.Message -ForegroundColor Red; Write-Host ''; Read-Host 'Press ENTER / Pulsa ENTER'; exit 1 }"
if errorlevel 1 (
  echo.
  echo Portable File Organizer ended with an error.
  echo El organizador termino con un error.
  echo.
  pause
)
endlocal
exit /b

#===POWERSHELL===

$ErrorActionPreference = 'Stop'
$PublicVersion = '1.0.0'
$OfficialRepository = 'https://github.com/zaper3/Portable-File-Organizer-Windows'

$base = (Get-Location).Path
$self = [System.IO.Path]::GetFileName($env:ORGANIZER_BAT)
$dataDir = Join-Path $base '_PortableFileOrganizer'
$oldDataDir = Join-Path $base '_Organizador'
if ((Test-Path -LiteralPath $oldDataDir) -and -not (Test-Path -LiteralPath $dataDir)) {
    Move-Item -LiteralPath $oldDataDir -Destination $dataDir
}
if (-not (Test-Path -LiteralPath $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir | Out-Null
}

$moveLog   = Join-Path $dataDir 'Movements.csv'
$folderLog = Join-Path $dataDir 'Folders.csv'
$runLog    = Join-Path $dataDir 'Runs.csv'

$legacyCandidates = @{
    (Join-Path $dataDir 'Movimientos.csv') = $moveLog
    (Join-Path $dataDir 'Carpetas.csv')    = $folderLog
    (Join-Path $dataDir 'Ejecuciones.csv') = $runLog
    (Join-Path $base '_Organizador_Movimientos.csv') = $moveLog
    (Join-Path $base '_Organizador_Carpetas.csv')    = $folderLog
    (Join-Path $base '_Organizador_Ejecuciones.csv') = $runLog
}
foreach ($legacy in $legacyCandidates.Keys) {
    $target = $legacyCandidates[$legacy]
    if (Test-Path -LiteralPath $legacy) {
        if (-not (Test-Path -LiteralPath $target)) {
            Move-Item -LiteralPath $legacy -Destination $target
        } elseif ((Resolve-Path -LiteralPath $legacy).Path -ne (Resolve-Path -LiteralPath $target).Path) {
            $backupName = [System.IO.Path]::GetFileNameWithoutExtension($legacy) + '_legacy_' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.csv'
            Move-Item -LiteralPath $legacy -Destination (Join-Path $dataDir $backupName)
        }
    }
}

function Select-Language {
    Clear-Host
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ('        PORTABLE FILE ORGANIZER FOR WINDOWS v' + $PublicVersion) -ForegroundColor Cyan
    Write-Host '================================================================' -ForegroundColor Cyan
    Write-Host ''
    Write-Host 'Select language / Selecciona idioma'
    Write-Host ''
    Write-Host '  1 - English'
    Write-Host '  2 - Español'
    Write-Host ''
    $choice = Read-Host 'Selection / Selección [1-2]'
    if ($choice -eq '2') { return 'es' }
    return 'en'
}

$lang = Select-Language

$text = @{
    en = @{
        AppTitle='PORTABLE FILE ORGANIZER FOR WINDOWS'; CurrentFolder='Current folder'; InternalData='Internal data'
        Main1='1 - Organize files'; Main2='2 - Undo last organization'; Main3='3 - Exit'; Select='Selection'; Invalid='Invalid option.'
        Folder='Folder'; FilesDetected='Files detected'; NoFiles='There are no files to organize in this folder.'; PressMenu='Press ENTER to return to the menu'
        Security='SAFETY'; Safe1='Only files in the current folder level are processed.'; Safe2='Existing subfolders are not reorganized.'; Safe3='Existing files are never overwritten.'
        Safe4='Temporary or incomplete downloads are ignored.'; Safe5='Internal Undo records are stored in _PortableFileOrganizer.'; Safe6='This operation can be undone from the main menu.'
        ConfirmOrganize='Type YES to continue'; Cancelled='Operation cancelled.'; Additional='ADDITIONAL CATEGORIZATION (optional)'
        Mode0='0 - Main category only (default)'; Mode1='1 - Category + file type/format'; Mode2='2 - Category + date (YYYY\MM_Month)'; Mode3='3 - Category + file type/format + date'
        Mode4='4 - Category + smart filename rules'; Mode5='5 - Category + type + date + smart rules'; ModeSelect='Selection [0-5]'; ModeInvalid='Invalid option. Mode 0 will be used.'
        Organizing='Organizing...'; Execution='Run'; Finished='Finished'; Moved='Moved'; Errors='Errors'; RunRecorded='Run recorded'
        UndoTitle='UNDO LAST ORGANIZATION'; NoUndo='There is no organization pending to undo.'; MissingMoveLog='The movement log required for Undo does not exist.'; NothingPending='The latest run has no pending movements.'
        OriginalDate='Original date'; Mode='Mode'; PendingRestore='Files pending restoration'; UndoWill='The process will:'; Undo1='Restore each file to its original location.'; Undo2='Never overwrite an existing file.'
        Undo3='Delete only folders created by this organizer and only when empty.'; ConfirmUndo='Type UNDO to continue'; Restoring='Restoring files...'; NotFound='NOT FOUND'; Conflict='CONFLICT'
        ExistsOrigin='Already exists at original location'; Restored='restored'; CleaningFolders='Cleaning folders created by the organizer...'; Deleted='DELETED'; Kept='KEPT'; NotEmpty='Not empty'; NotDeleted='NOT DELETED'
        Pending='Pending'; Conflicts='Conflicts'; Missing='Not found'; FoldersDeleted='Folders deleted'; FoldersKept='Folders kept because they contain files'; PartialUndo='The Undo was partial.'; RetryUndo='Resolve the conflicts and run Undo again.'
        CatDocuments='01_Documents'; CatImages='02_Images'; CatVideos='03_Videos'; CatAudio='04_Audio'; CatArchives='05_Archives'; CatInstallers='06_Installers'; CatDisk='07_Disk_Images'; CatTorrents='08_Torrents'
        CatFonts='09_Fonts'; CatCode='10_Code_and_Data'; CatCad='11_CAD_BIM'; CatOther='99_Other'; KWInvoices='Invoices'; KWBudgets='Budgets_and_Quotes'; KWReports='Reports'; KWContracts='Contracts'
        KWCv='CV_and_Resume'; KWCertificates='Certificates'; KWManuals='Manuals_and_Guides'; KWScreens='Screenshots'; NoExtension='No_Extension'
    }
    es = @{
        AppTitle='ORGANIZADOR PORTABLE DE ARCHIVOS PARA WINDOWS'; CurrentFolder='Carpeta actual'; InternalData='Datos internos'
        Main1='1 - Organizar archivos'; Main2='2 - Deshacer última organización'; Main3='3 - Salir'; Select='Selección'; Invalid='Opción no válida.'
        Folder='Carpeta'; FilesDetected='Archivos detectados'; NoFiles='No hay archivos que organizar en esta carpeta.'; PressMenu='Pulsa ENTER para volver al menú'
        Security='SEGURIDAD'; Safe1='Solo se procesan los archivos del nivel actual.'; Safe2='Las subcarpetas existentes no se reorganizan.'; Safe3='Los archivos existentes nunca se sobrescriben.'
        Safe4='Las descargas temporales o incompletas se ignoran.'; Safe5='Los registros internos de Undo se guardan en _PortableFileOrganizer.'; Safe6='Esta operación puede revertirse desde el menú principal.'
        ConfirmOrganize='Escribe SI para continuar'; Cancelled='Operación cancelada.'; Additional='CATEGORIZACIÓN ADICIONAL (opcional)'
        Mode0='0 - Solo categoría principal (por defecto)'; Mode1='1 - Categoría + tipo/formato'; Mode2='2 - Categoría + fecha (AAAA\MM_Mes)'; Mode3='3 - Categoría + tipo/formato + fecha'
        Mode4='4 - Categoría + reglas inteligentes por nombre'; Mode5='5 - Categoría + tipo + fecha + reglas inteligentes'; ModeSelect='Selección [0-5]'; ModeInvalid='Opción no válida. Se utilizará el modo 0.'
        Organizing='Organizando...'; Execution='Ejecución'; Finished='Finalizado'; Moved='Movidos'; Errors='Errores'; RunRecorded='Ejecución registrada'
        UndoTitle='DESHACER ÚLTIMA ORGANIZACIÓN'; NoUndo='No hay ninguna organización pendiente de deshacer.'; MissingMoveLog='No existe el registro de movimientos necesario para deshacer.'; NothingPending='La última ejecución no tiene movimientos pendientes.'
        OriginalDate='Fecha original'; Mode='Modo'; PendingRestore='Archivos pendientes de restaurar'; UndoWill='El proceso:'; Undo1='Devolverá cada archivo a su ubicación original.'; Undo2='Nunca sobrescribirá un archivo existente.'
        Undo3='Eliminará solo carpetas creadas por este organizador y únicamente si están vacías.'; ConfirmUndo='Escribe DESHACER para continuar'; Restoring='Restaurando archivos...'; NotFound='NO ENCONTRADO'; Conflict='CONFLICTO'
        ExistsOrigin='Ya existe en la ubicación original'; Restored='restaurado'; CleaningFolders='Limpiando carpetas creadas por el organizador...'; Deleted='ELIMINADA'; Kept='CONSERVADA'; NotEmpty='No está vacía'; NotDeleted='NO ELIMINADA'
        Pending='Pendientes'; Conflicts='Conflictos'; Missing='No encontrados'; FoldersDeleted='Carpetas eliminadas'; FoldersKept='Carpetas conservadas por contener archivos'; PartialUndo='La reversión fue parcial.'; RetryUndo='Resuelve los conflictos y ejecuta DESHACER nuevamente.'
        CatDocuments='01_Documentos'; CatImages='02_Imagenes'; CatVideos='03_Videos'; CatAudio='04_Audio'; CatArchives='05_Comprimidos'; CatInstallers='06_Instaladores'; CatDisk='07_Imagenes_Disco'; CatTorrents='08_Torrents'
        CatFonts='09_Fuentes'; CatCode='10_Codigo_y_Datos'; CatCad='11_CAD_BIM'; CatOther='99_Otros'; KWInvoices='Facturas'; KWBudgets='Presupuestos_y_Ofertas'; KWReports='Informes'; KWContracts='Contratos'
        KWCv='CV_y_Curriculum'; KWCertificates='Certificados'; KWManuals='Manuales_y_Guias'; KWScreens='Capturas'; NoExtension='Sin_Extension'
    }
}
function T([string]$key) { return $text[$lang][$key] }

$rules = [ordered]@{
    (T 'CatDocuments')  = @('.pdf','.doc','.docx','.odt','.rtf','.txt','.md','.epub','.mobi','.azw','.azw3','.csv','.xls','.xlsx','.xlsm','.ods','.ppt','.pptx','.odp','.one')
    (T 'CatImages')     = @('.jpg','.jpeg','.png','.gif','.webp','.bmp','.tif','.tiff','.svg','.ico','.heic','.heif','.avif','.raw','.cr2','.cr3','.nef','.arw','.dng')
    (T 'CatVideos')     = @('.mp4','.mkv','.avi','.mov','.wmv','.flv','.webm','.m4v','.mpeg','.mpg','.mts','.m2ts','.3gp')
    (T 'CatAudio')      = @('.mp3','.wav','.flac','.aac','.ogg','.m4a','.wma','.opus','.aiff','.alac','.mid','.midi')
    (T 'CatArchives')   = @('.zip','.rar','.7z','.tar','.gz','.tgz','.bz2','.xz','.cab','.zst')
    (T 'CatInstallers') = @('.exe','.msi','.msix','.msixbundle','.appx','.appxbundle','.apk','.aab')
    (T 'CatDisk')       = @('.iso','.img','.vhd','.vhdx','.dmg')
    (T 'CatTorrents')   = @('.torrent')
    (T 'CatFonts')      = @('.ttf','.otf','.woff','.woff2','.eot')
    (T 'CatCode')       = @('.py','.js','.jsx','.ts','.tsx','.html','.htm','.css','.scss','.sass','.less','.json','.xml','.yaml','.yml','.sql','.java','.cs','.cpp','.c','.h','.hpp','.php','.rb','.go','.rs','.sh','.ps1','.bat','.cmd','.ini','.cfg','.conf','.toml','.log')
    (T 'CatCad')        = @('.dwg','.dxf','.dwt','.rvt','.rfa','.rte','.ifc','.nwd','.nwc','.nwf','.skp')
}

$subtypes = @{
    '.pdf'='PDF'; '.doc'='Word'; '.docx'='Word'; '.odt'='Word'; '.rtf'='Rich_Text'; '.txt'='Text'; '.md'='Markdown'
    '.xls'='Excel'; '.xlsx'='Excel'; '.xlsm'='Excel'; '.ods'='Excel'; '.csv'='CSV'; '.ppt'='PowerPoint'; '.pptx'='PowerPoint'; '.odp'='PowerPoint'
    '.jpg'='JPG'; '.jpeg'='JPG'; '.png'='PNG'; '.gif'='GIF'; '.webp'='WEBP'; '.svg'='SVG'; '.heic'='HEIC'; '.heif'='HEIC'; '.avif'='AVIF'
    '.raw'='RAW'; '.cr2'='RAW'; '.cr3'='RAW'; '.nef'='RAW'; '.arw'='RAW'; '.dng'='RAW'; '.mp4'='MP4'; '.mkv'='MKV'; '.avi'='AVI'; '.mov'='MOV'; '.webm'='WEBM'
    '.mp3'='MP3'; '.flac'='FLAC'; '.wav'='WAV'; '.m4a'='M4A'; '.aac'='AAC'; '.ogg'='OGG'; '.opus'='OPUS'; '.zip'='ZIP'; '.rar'='RAR'; '.7z'='7Z'; '.tar'='TAR'; '.gz'='GZ'
    '.exe'='Windows_EXE'; '.msi'='Windows_MSI'; '.msix'='Windows_MSIX'; '.msixbundle'='Windows_MSIX'; '.apk'='Android_APK'; '.aab'='Android_AAB'
    '.dwg'='AutoCAD'; '.dxf'='AutoCAD'; '.dwt'='AutoCAD'; '.rvt'='Revit'; '.rfa'='Revit'; '.rte'='Revit'; '.ifc'='IFC'; '.nwd'='Navisworks'; '.nwc'='Navisworks'; '.nwf'='Navisworks'; '.skp'='SketchUp'
    '.py'='Python'; '.js'='JavaScript'; '.jsx'='JavaScript'; '.ts'='TypeScript'; '.tsx'='TypeScript'; '.html'='Web'; '.htm'='Web'; '.css'='Web'; '.scss'='Web'; '.sql'='SQL'; '.json'='JSON'; '.xml'='XML'; '.yaml'='YAML'; '.yml'='YAML'
    '.ps1'='PowerShell'; '.bat'='Batch'; '.cmd'='Batch'
}

function Write-CsvRows([object[]]$Rows,[string]$Path) {
    if (-not $Rows -or $Rows.Count -eq 0) { return }
    if (Test-Path -LiteralPath $Path) { $Rows | Export-Csv -LiteralPath $Path -NoTypeInformation -Encoding UTF8 -Append }
    else { $Rows | Export-Csv -LiteralPath $Path -NoTypeInformation -Encoding UTF8 }
}
function Get-RunLog { if (Test-Path -LiteralPath $runLog) { return @(Import-Csv -LiteralPath $runLog) }; return @() }
function Save-RunLog([object[]]$Rows) {
    if (-not $Rows -or $Rows.Count -eq 0) { if (Test-Path -LiteralPath $runLog) { Remove-Item -LiteralPath $runLog -Force }; return }
    $Rows | Export-Csv -LiteralPath $runLog -NoTypeInformation -Encoding UTF8
}
function Update-RunStatus([string]$RunId,[string]$Status,[string]$UndoDate='',[string]$Notes='') {
    $runs=Get-RunLog
    foreach ($r in $runs) { if ($r.RunId -eq $RunId) { $r.Status=$Status; if ($UndoDate) { $r.UndoDate=$UndoDate }; if ($Notes) { $r.Notes=$Notes } } }
    Save-RunLog $runs
}
function Get-Category([string]$Extension) {
    $e=$Extension.ToLowerInvariant(); foreach ($pair in $rules.GetEnumerator()) { if ($pair.Value -contains $e) { return $pair.Key } }; return (T 'CatOther')
}
function Get-Subtype([string]$Extension) {
    $e=$Extension.ToLowerInvariant(); if ($subtypes.ContainsKey($e)) { return $subtypes[$e] }; if ([string]::IsNullOrWhiteSpace($e)) { return (T 'NoExtension') }; return $e.TrimStart('.').ToUpperInvariant()
}
function Get-KeywordFolder([string]$Name) {
    $n=$Name.ToLowerInvariant()
    if ($n -match 'factura|invoice') { return (T 'KWInvoices') }
    if ($n -match 'presupuesto|budget|quote|oferta') { return (T 'KWBudgets') }
    if ($n -match 'informe|report') { return (T 'KWReports') }
    if ($n -match 'contrato|contract') { return (T 'KWContracts') }
    if ($n -match '(^|[_\-\s])cv([_\-\s]|$)|curriculum|resume') { return (T 'KWCv') }
    if ($n -match 'certificado|certificate') { return (T 'KWCertificates') }
    if ($n -match 'manual|guide|guia|guía') { return (T 'KWManuals') }
    if ($n -match 'captura|screenshot') { return (T 'KWScreens') }
    return $null
}
function Get-FreeName([string]$DestinationDirectory,[string]$Name) {
    $candidate=Join-Path $DestinationDirectory $Name; if (-not (Test-Path -LiteralPath $candidate)) { return $candidate }
    $stem=[System.IO.Path]::GetFileNameWithoutExtension($Name); $ext=[System.IO.Path]::GetExtension($Name); $i=2
    do { $candidate=Join-Path $DestinationDirectory ($stem + ' (' + $i + ')' + $ext); $i++ } while (Test-Path -LiteralPath $candidate)
    return $candidate
}
function Ensure-DestinationPath([string]$Root,[System.Collections.Generic.List[string]]$Parts,[string]$RunId,[System.Collections.Generic.List[object]]$CreatedFolders,[System.Collections.Generic.HashSet[string]]$CreatedFolderSet) {
    $current=$Root
    foreach ($part in $Parts) {
        $current=Join-Path $current $part
        if (-not (Test-Path -LiteralPath $current)) {
            New-Item -ItemType Directory -Path $current | Out-Null
            if ($CreatedFolderSet.Add($current)) { $CreatedFolders.Add([pscustomobject]@{RunId=$RunId; Date=Get-Date -Format 'yyyy-MM-dd HH:mm:ss'; Folder=$current}) }
        }
    }
    return $current
}

function Invoke-Organize {
    $excludeNames=@($self,'desktop.ini','Thumbs.db','.DS_Store')
    $files=@(Get-ChildItem -LiteralPath $base -File -Force | Where-Object {
        $excludeNames -notcontains $_.Name -and $_.Name -notlike 'Organizar_Archivos_Portable*.bat' -and $_.Name -notlike 'Portable_File_Organizer*.bat' -and $_.Name -notlike '_Organizador_*.csv' -and
        $_.Name -notlike '*.crdownload' -and $_.Name -notlike '*.part' -and $_.Name -notlike '*.partial' -and $_.Name -notlike '*.tmp' -and $_.Length -gt 0
    })
    Clear-Host
    Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ('        ' + (T 'AppTitle') + ' v' + $PublicVersion) -ForegroundColor Cyan; Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ''
    Write-Host ((T 'Folder') + ': ' + $base); Write-Host ((T 'FilesDetected') + ': ' + $files.Count); Write-Host ''
    if ($files.Count -eq 0) { Write-Host (T 'NoFiles') -ForegroundColor Yellow; Write-Host ''; Read-Host (T 'PressMenu'); return }
    Write-Host (T 'Security') -ForegroundColor Green
    @('Safe1','Safe2','Safe3','Safe4','Safe5','Safe6') | ForEach-Object { Write-Host (' - ' + (T $_)) }
    Write-Host ''
    $answer=Read-Host (T 'ConfirmOrganize')
    $ok=if ($lang -eq 'es') { $answer.Trim().ToUpperInvariant() -eq 'SI' } else { $answer.Trim().ToUpperInvariant() -eq 'YES' }
    if (-not $ok) { Write-Host ''; Write-Host (T 'Cancelled') -ForegroundColor Yellow; Start-Sleep -Seconds 1; return }
    Write-Host ''; Write-Host (T 'Additional') -ForegroundColor Cyan; Write-Host ''
    @('Mode0','Mode1','Mode2','Mode3','Mode4','Mode5') | ForEach-Object { Write-Host ('  ' + (T $_)) }
    Write-Host ''
    $mode=Read-Host (T 'ModeSelect'); if ([string]::IsNullOrWhiteSpace($mode)) { $mode='0' }
    if ($mode -notin @('0','1','2','3','4','5')) { Write-Host ''; Write-Host (T 'ModeInvalid') -ForegroundColor Yellow; $mode='0' }
    $useSubtype=$mode -in @('1','3','5'); $useDate=$mode -in @('2','3','5'); $useKeywords=$mode -in @('4','5')
    $monthsEn=@('01_January','02_February','03_March','04_April','05_May','06_June','07_July','08_August','09_September','10_October','11_November','12_December')
    $monthsEs=@('01_Enero','02_Febrero','03_Marzo','04_Abril','05_Mayo','06_Junio','07_Julio','08_Agosto','09_Septiembre','10_Octubre','11_Noviembre','12_Diciembre')
    $monthNames=if ($lang -eq 'es') { $monthsEs } else { $monthsEn }
    $runId=(Get-Date -Format 'yyyyMMdd-HHmmss-fff') + '-' + ([guid]::NewGuid().ToString('N').Substring(0,6))
    Write-CsvRows @([pscustomobject]@{RunId=$runId; Date=Get-Date -Format 'yyyy-MM-dd HH:mm:ss'; Language=$lang; Mode=$mode; Status='IN_PROGRESS'; Files=$files.Count; UndoDate=''; Notes=''}) $runLog
    $moveRows=New-Object 'System.Collections.Generic.List[object]'; $createdFolders=New-Object 'System.Collections.Generic.List[object]'; $createdFolderSet=New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    $moved=0; $errors=0
    Write-Host ''; Write-Host ((T 'Execution') + ': ' + $runId) -ForegroundColor DarkGray; Write-Host (T 'Organizing') -ForegroundColor Cyan; Write-Host ''
    foreach ($f in $files) {
        try {
            $category=Get-Category $f.Extension; $parts=New-Object 'System.Collections.Generic.List[string]'; [void]$parts.Add($category)
            if ($useKeywords) { $keyword=Get-KeywordFolder $f.BaseName; if ($keyword) { [void]$parts.Add($keyword) } }
            if ($useSubtype) { [void]$parts.Add((Get-Subtype $f.Extension)) }
            if ($useDate) { $d=$f.LastWriteTime; [void]$parts.Add($d.Year.ToString()); [void]$parts.Add($monthNames[$d.Month-1]) }
            $destDir=Ensure-DestinationPath $base $parts $runId $createdFolders $createdFolderSet; $dest=Get-FreeName $destDir $f.Name; $original=$f.FullName
            Move-Item -LiteralPath $original -Destination $dest
            $moveRows.Add([pscustomobject]@{RunId=$runId; Date=Get-Date -Format 'yyyy-MM-dd HH:mm:ss'; File=$f.Name; Source=$original; Destination=$dest; Category=$category; Language=$lang; Mode=$mode; UndoStatus=''; UndoDate=''})
            $moved++; Write-Host ('[OK] ' + $f.Name + '  ->  ' + ($parts -join '\'))
        } catch { $errors++; Write-Host ('[ERROR] ' + $f.Name + ' : ' + $_.Exception.Message) -ForegroundColor Red }
    }
    Write-CsvRows $moveRows.ToArray() $moveLog; Write-CsvRows $createdFolders.ToArray() $folderLog
    $status=if ($errors -eq 0) { 'COMPLETED' } else { 'COMPLETED_WITH_ERRORS' }; Update-RunStatus $runId $status '' ('Moved=' + $moved + '; Errors=' + $errors)
    Write-Host ''; Write-Host '================================================================' -ForegroundColor Green
    Write-Host ((T 'Finished') + '. ' + (T 'Moved') + ': ' + $moved + ' | ' + (T 'Errors') + ': ' + $errors) -ForegroundColor Green
    Write-Host ((T 'RunRecorded') + ': ' + $runId); Write-Host ((T 'InternalData') + ': ' + $dataDir); Write-Host '================================================================' -ForegroundColor Green; Write-Host ''
    Read-Host (T 'PressMenu')
}

function Invoke-Undo {
    Clear-Host
    Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ('        ' + (T 'UndoTitle') + ' - v' + $PublicVersion) -ForegroundColor Cyan; Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ''
    $runs=Get-RunLog; $candidate=$runs | Where-Object { $_.Status -in @('COMPLETED','COMPLETED_WITH_ERRORS','PARTIAL_UNDO') } | Select-Object -Last 1
    if (-not $candidate) { Write-Host (T 'NoUndo') -ForegroundColor Yellow; Write-Host ''; Read-Host (T 'PressMenu'); return }
    if (-not (Test-Path -LiteralPath $moveLog)) { Write-Host (T 'MissingMoveLog') -ForegroundColor Red; Write-Host ''; Read-Host (T 'PressMenu'); return }
    $allMoves=@(Import-Csv -LiteralPath $moveLog); $moves=@($allMoves | Where-Object { $_.RunId -eq $candidate.RunId -and $_.UndoStatus -ne 'RESTORED' })
    if ($moves.Count -eq 0) { Update-RunStatus $candidate.RunId 'UNDONE' (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') 'No pending movements'; Write-Host (T 'NothingPending') -ForegroundColor Yellow; Write-Host ''; Read-Host (T 'PressMenu'); return }
    Write-Host ((T 'Execution') + ': ' + $candidate.RunId); Write-Host ((T 'OriginalDate') + ': ' + $candidate.Date); Write-Host ((T 'Mode') + ': ' + $candidate.Mode); Write-Host ((T 'PendingRestore') + ': ' + $moves.Count); Write-Host ''
    Write-Host (T 'UndoWill') -ForegroundColor Green; @('Undo1','Undo2','Undo3') | ForEach-Object { Write-Host (' - ' + (T $_)) }; Write-Host ''
    $confirm=Read-Host (T 'ConfirmUndo'); $ok=if ($lang -eq 'es') { $confirm.Trim().ToUpperInvariant() -eq 'DESHACER' } else { $confirm.Trim().ToUpperInvariant() -eq 'UNDO' }
    if (-not $ok) { Write-Host ''; Write-Host (T 'Cancelled') -ForegroundColor Yellow; Start-Sleep -Seconds 1; return }
    $restored=0; $conflicts=0; $missing=0; $errors=0; $undoDate=Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Write-Host ''; Write-Host (T 'Restoring') -ForegroundColor Cyan; Write-Host ''; [array]::Reverse($moves)
    foreach ($m in $moves) {
        try {
            if (-not (Test-Path -LiteralPath $m.Destination)) { $missing++; Write-Host ('[' + (T 'NotFound') + '] ' + $m.Destination) -ForegroundColor Yellow; continue }
            if (Test-Path -LiteralPath $m.Source) { $conflicts++; Write-Host ('[' + (T 'Conflict') + '] ' + (T 'ExistsOrigin') + ': ' + $m.Source) -ForegroundColor Yellow; continue }
            $originParent=Split-Path -Parent $m.Source; if (-not (Test-Path -LiteralPath $originParent)) { New-Item -ItemType Directory -Path $originParent -Force | Out-Null }
            Move-Item -LiteralPath $m.Destination -Destination $m.Source
            foreach ($row in $allMoves) { if ($row.RunId -eq $m.RunId -and $row.Destination -eq $m.Destination) { $row.UndoStatus='RESTORED'; $row.UndoDate=$undoDate } }
            $restored++; Write-Host ('[OK] ' + $m.File + ' -> ' + (T 'Restored'))
        } catch { $errors++; Write-Host ('[ERROR] ' + $m.File + ' : ' + $_.Exception.Message) -ForegroundColor Red }
    }
    $allMoves | Export-Csv -LiteralPath $moveLog -NoTypeInformation -Encoding UTF8
    $foldersRemoved=0; $foldersKept=0
    if (Test-Path -LiteralPath $folderLog) {
        $folderRows=@(Import-Csv -LiteralPath $folderLog | Where-Object { $_.RunId -eq $candidate.RunId }); $folderPaths=@($folderRows | Select-Object -ExpandProperty Folder -Unique | Sort-Object { $_.Length } -Descending)
        Write-Host ''; Write-Host (T 'CleaningFolders') -ForegroundColor Cyan; Write-Host ''
        foreach ($folder in $folderPaths) {
            try {
                if (-not (Test-Path -LiteralPath $folder)) { continue }; $children=@(Get-ChildItem -LiteralPath $folder -Force)
                if ($children.Count -eq 0) { Remove-Item -LiteralPath $folder -Force; $foldersRemoved++; Write-Host ('[' + (T 'Deleted') + '] ' + $folder) }
                else { $foldersKept++; Write-Host ('[' + (T 'Kept') + '] ' + (T 'NotEmpty') + ': ' + $folder) -ForegroundColor DarkYellow }
            } catch { $foldersKept++; Write-Host ('[' + (T 'NotDeleted') + '] ' + $folder + ' : ' + $_.Exception.Message) -ForegroundColor DarkYellow }
        }
    }
    $remaining=@($allMoves | Where-Object { $_.RunId -eq $candidate.RunId -and $_.UndoStatus -ne 'RESTORED' }).Count
    if ($remaining -eq 0) { Update-RunStatus $candidate.RunId 'UNDONE' $undoDate ('Restored=' + $restored + '; FoldersDeleted=' + $foldersRemoved) }
    else { Update-RunStatus $candidate.RunId 'PARTIAL_UNDO' $undoDate ('Restored=' + $restored + '; Pending=' + $remaining + '; Conflicts=' + $conflicts + '; Missing=' + $missing + '; Errors=' + $errors) }
    Write-Host ''; Write-Host '================================================================' -ForegroundColor Green
    Write-Host ((T 'Restored') + ': ' + $restored) -ForegroundColor Green; Write-Host ((T 'Pending') + ': ' + $remaining); Write-Host ((T 'Conflicts') + ': ' + $conflicts); Write-Host ((T 'Missing') + ': ' + $missing); Write-Host ((T 'Errors') + ': ' + $errors)
    Write-Host ((T 'FoldersDeleted') + ': ' + $foldersRemoved); Write-Host ((T 'FoldersKept') + ': ' + $foldersKept); Write-Host '================================================================' -ForegroundColor Green; Write-Host ''
    if ($remaining -gt 0) { Write-Host (T 'PartialUndo') -ForegroundColor Yellow; Write-Host (T 'RetryUndo'); Write-Host '' }
    Read-Host (T 'PressMenu')
}

while ($true) {
    Clear-Host
    Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ('        ' + (T 'AppTitle') + ' v' + $PublicVersion) -ForegroundColor Cyan; Write-Host '================================================================' -ForegroundColor Cyan; Write-Host ''
    Write-Host ((T 'CurrentFolder') + ': ' + $base); Write-Host ((T 'InternalData') + ': ' + $dataDir); Write-Host ''
    Write-Host ('  ' + (T 'Main1')); Write-Host ('  ' + (T 'Main2')); Write-Host ('  ' + (T 'Main3')); Write-Host ''
    $choice=Read-Host ((T 'Select') + ' [1-3]')
    switch ($choice) { '1' { Invoke-Organize }; '2' { Invoke-Undo }; '3' { return }; default { Write-Host ''; Write-Host (T 'Invalid') -ForegroundColor Yellow; Start-Sleep -Seconds 1 } }
}
