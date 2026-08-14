#!/usr/bin/env bash
# Portable File Organizer for Linux v1.0.0
# Copyright (c) 2026 zaper3. All rights reserved.
# Official repository: https://github.com/zaper3/Portable-File-Organizer
# License: see LICENSE.md in the official repository.

set -u

VERSION="1.0.0"
OFFICIAL_REPO="https://github.com/zaper3/Portable-File-Organizer"
BASE_DIR="$(cd -- "$(dirname -- "$0")" && pwd -P)"
SELF="$BASE_DIR/$(basename -- "$0")"
DATA_DIR="$BASE_DIR/_PortableFileOrganizer"
RUNS_LOG="$DATA_DIR/Runs.tsv"
MOVES_LOG="$DATA_DIR/Movements.tsv"
FOLDERS_LOG="$DATA_DIR/Folders.tsv"
UNDO_LOG="$DATA_DIR/Undo.tsv"

for cmd in bash base64 awk date mkdir mv rmdir tr; do
    command -v "$cmd" >/dev/null 2>&1 || {
        printf 'Missing required command / Falta el comando requerido: %s\n' "$cmd" >&2
        exit 1
    }
done

mkdir -p -- "$DATA_DIR" || exit 1

b64enc() { printf '%s' "$1" | base64 | tr -d '\n'; }
b64dec() { printf '%s' "$1" | base64 -d; }

select_language() {
    clear 2>/dev/null || true
    printf '%s\n' '================================================================'
    printf '        PORTABLE FILE ORGANIZER FOR LINUX v%s\n' "$VERSION"
    printf '%s\n\n' '================================================================'
    printf '%s\n\n' 'Select language / Selecciona idioma'
    printf '%s\n' '  1 - English'
    printf '%s\n\n' '  2 - Español'
    read -r -p 'Selection / Selección [1-2]: ' choice
    if [[ "$choice" == "2" ]]; then LANG_UI="es"; else LANG_UI="en"; fi
}

trn() {
    local k="$1"
    if [[ "$LANG_UI" == "es" ]]; then
        case "$k" in
            title) echo 'ORGANIZADOR PORTABLE DE ARCHIVOS PARA LINUX';;
            current) echo 'Carpeta actual';;
            internal) echo 'Datos internos';;
            menu1) echo '1 - Organizar archivos';;
            menu2) echo '2 - Deshacer última organización';;
            menu3) echo '3 - Salir';;
            selection) echo 'Selección';;
            invalid) echo 'Opción no válida.';;
            detected) echo 'Archivos detectados';;
            nofiles) echo 'No hay archivos que organizar en esta carpeta.';;
            press) echo 'Pulsa ENTER para volver al menú';;
            safety) echo 'SEGURIDAD';;
            safe1) echo 'Solo se procesan archivos del nivel actual.';;
            safe2) echo 'Las subcarpetas existentes no se reorganizan.';;
            safe3) echo 'Los archivos existentes nunca se sobrescriben.';;
            safe4) echo 'Las descargas temporales o incompletas se ignoran.';;
            safe5) echo 'Los registros internos de Undo se guardan en _PortableFileOrganizer.';;
            confirm) echo 'Escribe SI para continuar';;
            cancelled) echo 'Operación cancelada.';;
            addcat) echo 'CATEGORIZACIÓN ADICIONAL (opcional)';;
            m0) echo '0 - Solo categoría principal (por defecto)';;
            m1) echo '1 - Categoría + tipo/formato';;
            m2) echo '2 - Categoría + fecha (AAAA/MM_Mes)';;
            m3) echo '3 - Categoría + tipo/formato + fecha';;
            m4) echo '4 - Categoría + reglas inteligentes por nombre';;
            m5) echo '5 - Categoría + tipo + fecha + reglas inteligentes';;
            organizing) echo 'Organizando...';;
            run) echo 'Ejecución';;
            finished) echo 'Finalizado';;
            moved) echo 'Movidos';;
            errors) echo 'Errores';;
            undo_title) echo 'DESHACER ÚLTIMA ORGANIZACIÓN';;
            no_undo) echo 'No hay ninguna organización pendiente de deshacer.';;
            undo_missing) echo 'No existe el registro de movimientos necesario para deshacer.';;
            pending) echo 'Archivos pendientes de restaurar';;
            undo1) echo 'Devolverá cada archivo a su ubicación original.';;
            undo2) echo 'Nunca sobrescribirá un archivo existente.';;
            undo3) echo 'Eliminará solo carpetas creadas por este organizador y únicamente si están vacías.';;
            undo_confirm) echo 'Escribe DESHACER para continuar';;
            restoring) echo 'Restaurando archivos...';;
            conflict) echo 'CONFLICTO';;
            missing) echo 'NO ENCONTRADO';;
            restored) echo 'restaurado';;
            cleaning) echo 'Limpiando carpetas creadas por el organizador...';;
            deleted) echo 'ELIMINADA';;
            kept) echo 'CONSERVADA';;
            partial) echo 'La reversión fue parcial. Resuelve los conflictos y vuelve a ejecutar DESHACER.';;
            documents) echo '01_Documentos';;
            images) echo '02_Imagenes';;
            videos) echo '03_Videos';;
            audio) echo '04_Audio';;
            archives) echo '05_Comprimidos';;
            installers) echo '06_Instaladores';;
            disk) echo '07_Imagenes_Disco';;
            torrents) echo '08_Torrents';;
            fonts) echo '09_Fuentes';;
            code) echo '10_Codigo_y_Datos';;
            cad) echo '11_CAD_BIM';;
            other) echo '99_Otros';;
            invoices) echo 'Facturas';;
            quotes) echo 'Presupuestos_y_Ofertas';;
            reports) echo 'Informes';;
            contracts) echo 'Contratos';;
            cv) echo 'CV_y_Curriculum';;
            certificates) echo 'Certificados';;
            manuals) echo 'Manuales_y_Guias';;
            screenshots) echo 'Capturas';;
            noext) echo 'Sin_Extension';;
        esac
    else
        case "$k" in
            title) echo 'PORTABLE FILE ORGANIZER FOR LINUX';;
            current) echo 'Current folder';;
            internal) echo 'Internal data';;
            menu1) echo '1 - Organize files';;
            menu2) echo '2 - Undo last organization';;
            menu3) echo '3 - Exit';;
            selection) echo 'Selection';;
            invalid) echo 'Invalid option.';;
            detected) echo 'Files detected';;
            nofiles) echo 'There are no files to organize in this folder.';;
            press) echo 'Press ENTER to return to the menu';;
            safety) echo 'SAFETY';;
            safe1) echo 'Only files in the current folder level are processed.';;
            safe2) echo 'Existing subfolders are not reorganized.';;
            safe3) echo 'Existing files are never overwritten.';;
            safe4) echo 'Temporary or incomplete downloads are ignored.';;
            safe5) echo 'Internal Undo records are stored in _PortableFileOrganizer.';;
            confirm) echo 'Type YES to continue';;
            cancelled) echo 'Operation cancelled.';;
            addcat) echo 'ADDITIONAL CATEGORIZATION (optional)';;
            m0) echo '0 - Main category only (default)';;
            m1) echo '1 - Category + file type/format';;
            m2) echo '2 - Category + date (YYYY/MM_Month)';;
            m3) echo '3 - Category + file type/format + date';;
            m4) echo '4 - Category + smart filename rules';;
            m5) echo '5 - Category + type + date + smart rules';;
            organizing) echo 'Organizing...';;
            run) echo 'Run';;
            finished) echo 'Finished';;
            moved) echo 'Moved';;
            errors) echo 'Errors';;
            undo_title) echo 'UNDO LAST ORGANIZATION';;
            no_undo) echo 'There is no organization pending to undo.';;
            undo_missing) echo 'The movement log required for Undo does not exist.';;
            pending) echo 'Files pending restoration';;
            undo1) echo 'Restore each file to its original location.';;
            undo2) echo 'Never overwrite an existing file.';;
            undo3) echo 'Delete only folders created by this organizer and only when empty.';;
            undo_confirm) echo 'Type UNDO to continue';;
            restoring) echo 'Restoring files...';;
            conflict) echo 'CONFLICT';;
            missing) echo 'NOT FOUND';;
            restored) echo 'restored';;
            cleaning) echo 'Cleaning folders created by the organizer...';;
            deleted) echo 'DELETED';;
            kept) echo 'KEPT';;
            partial) echo 'Undo was partial. Resolve conflicts and run UNDO again.';;
            documents) echo '01_Documents';;
            images) echo '02_Images';;
            videos) echo '03_Videos';;
            audio) echo '04_Audio';;
            archives) echo '05_Archives';;
            installers) echo '06_Installers';;
            disk) echo '07_Disk_Images';;
            torrents) echo '08_Torrents';;
            fonts) echo '09_Fonts';;
            code) echo '10_Code_and_Data';;
            cad) echo '11_CAD_BIM';;
            other) echo '99_Other';;
            invoices) echo 'Invoices';;
            quotes) echo 'Budgets_and_Quotes';;
            reports) echo 'Reports';;
            contracts) echo 'Contracts';;
            cv) echo 'CV_and_Resume';;
            certificates) echo 'Certificates';;
            manuals) echo 'Manuals_and_Guides';;
            screenshots) echo 'Screenshots';;
            noext) echo 'No_Extension';;
        esac
    fi
}

get_extension() {
    local n="$1"
    if [[ "$n" == *.* && "$n" != .* ]]; then printf '%s' "${n##*.}" | tr '[:upper:]' '[:lower:]';
    elif [[ "$n" == .*.* ]]; then printf '%s' "${n##*.}" | tr '[:upper:]' '[:lower:]';
    else printf '';
    fi
}

get_category() {
    case "$1" in
        pdf|doc|docx|odt|rtf|txt|md|epub|mobi|azw|azw3|csv|xls|xlsx|xlsm|ods|ppt|pptx|odp|one) trn documents;;
        jpg|jpeg|png|gif|webp|bmp|tif|tiff|svg|ico|heic|heif|avif|raw|cr2|cr3|nef|arw|dng) trn images;;
        mp4|mkv|avi|mov|wmv|flv|webm|m4v|mpeg|mpg|mts|m2ts|3gp) trn videos;;
        mp3|wav|flac|aac|ogg|m4a|wma|opus|aiff|alac|mid|midi) trn audio;;
        zip|rar|7z|tar|gz|tgz|bz2|xz|cab|zst) trn archives;;
        deb|rpm|appimage|run|bin|flatpakref|snap|apk|aab) trn installers;;
        iso|img|vhd|vhdx|dmg) trn disk;;
        torrent) trn torrents;;
        ttf|otf|woff|woff2|eot) trn fonts;;
        py|js|jsx|ts|tsx|html|htm|css|scss|sass|less|json|xml|yaml|yml|sql|java|cs|cpp|c|h|hpp|php|rb|go|rs|sh|zsh|fish|ini|cfg|conf|toml|log) trn code;;
        dwg|dxf|dwt|rvt|rfa|rte|ifc|nwd|nwc|nwf|skp) trn cad;;
        *) trn other;;
    esac
}

get_subtype() {
    local e="$1"
    [[ -z "$e" ]] && { trn noext; return; }
    case "$e" in
        doc|docx|odt) echo 'Word';; xls|xlsx|xlsm|ods) echo 'Excel';; ppt|pptx|odp) echo 'PowerPoint';;
        jpg|jpeg) echo 'JPG';; cr2|cr3|nef|arw|dng|raw) echo 'RAW';;
        deb) echo 'DEB';; rpm) echo 'RPM';; appimage) echo 'AppImage';;
        py) echo 'Python';; js|jsx) echo 'JavaScript';; ts|tsx) echo 'TypeScript';;
        html|htm|css|scss|sass|less) echo 'Web';; sh) echo 'Shell';;
        *) printf '%s' "$e" | tr '[:lower:]' '[:upper:]'; echo;;
    esac
}

get_keyword_folder() {
    local n
    n="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
    [[ "$n" =~ factura|invoice ]] && { trn invoices; return; }
    [[ "$n" =~ presupuesto|budget|quote|oferta ]] && { trn quotes; return; }
    [[ "$n" =~ informe|report ]] && { trn reports; return; }
    [[ "$n" =~ contrato|contract ]] && { trn contracts; return; }
    [[ "$n" =~ curriculum|resume|(^|[_[:space:]-])cv([_[:space:]-]|$) ]] && { trn cv; return; }
    [[ "$n" =~ certificado|certificate ]] && { trn certificates; return; }
    [[ "$n" =~ manual|guide|guia|guía ]] && { trn manuals; return; }
    [[ "$n" =~ captura|screenshot ]] && { trn screenshots; return; }
    return 1
}

free_destination() {
    local dir="$1" name="$2" stem ext candidate i=2
    candidate="$dir/$name"
    [[ ! -e "$candidate" ]] && { printf '%s' "$candidate"; return; }
    if [[ "$name" == *.* && "$name" != .* ]]; then stem="${name%.*}"; ext=".${name##*.}"; else stem="$name"; ext=""; fi
    while :; do
        candidate="$dir/$stem ($i)$ext"
        [[ ! -e "$candidate" ]] && { printf '%s' "$candidate"; return; }
        ((i++))
    done
}

declare -A CREATED_SET=()
CREATED_DIRS=()
ensure_path() {
    local current="$BASE_DIR" part
    for part in "$@"; do
        current="$current/$part"
        if [[ ! -d "$current" ]]; then
            mkdir -- "$current" || return 1
            if [[ -z "${CREATED_SET[$current]+x}" ]]; then
                CREATED_SET["$current"]=1
                CREATED_DIRS+=("$current")
            fi
        fi
    done
    ENSURED_PATH="$current"
}

update_run_status() {
    local run="$1" status="$2" moved="$3" errors="$4" tmp="$RUNS_LOG.tmp.$$"
    [[ -f "$RUNS_LOG" ]] || return 0
    awk -F '\t' -v OFS='\t' -v r="$run" -v s="$status" -v m="$moved" -v e="$errors" \
        '{ if ($1==r) {$5=s; $6=m; $7=e} print }' "$RUNS_LOG" > "$tmp" && mv -- "$tmp" "$RUNS_LOG"
}

is_restored() {
    local run="$1" dst64="$2"
    [[ -f "$UNDO_LOG" ]] || return 1
    awk -F '\t' -v r="$run" -v d="$dst64" '$1==r && $2==d && $3=="RESTORED" {found=1} END{exit !found}' "$UNDO_LOG"
}

collect_files() {
    FILES=()
    local p n
    shopt -s nullglob dotglob
    for p in "$BASE_DIR"/*; do
        [[ -f "$p" ]] || continue
        [[ "$p" == "$SELF" ]] && continue
        n="$(basename -- "$p")"
        case "$n" in
            *.crdownload|*.part|*.partial|*.tmp|desktop.ini|Thumbs.db|.DS_Store|Portable-File-Organizer*.sh|portable-file-organizer*.sh) continue;;
        esac
        [[ -s "$p" ]] || continue
        FILES+=("$p")
    done
    shopt -u dotglob
}

organize() {
    collect_files
    clear 2>/dev/null || true
    printf '%s\n' '================================================================'
    printf '        %s v%s\n' "$(trn title)" "$VERSION"
    printf '%s\n\n' '================================================================'
    printf '%s: %s\n' "$(trn current)" "$BASE_DIR"
    printf '%s: %d\n\n' "$(trn detected)" "${#FILES[@]}"
    if (( ${#FILES[@]} == 0 )); then read -r -p "$(trn nofiles)  $(trn press): "; return; fi

    printf '%s\n' "$(trn safety)"
    for k in safe1 safe2 safe3 safe4 safe5; do printf ' - %s\n' "$(trn "$k")"; done
    printf '\n'
    read -r -p "$(trn confirm): " answer
    if [[ "$LANG_UI" == "es" ]]; then [[ "${answer^^}" == "SI" ]] || { echo "$(trn cancelled)"; sleep 1; return; }
    else [[ "${answer^^}" == "YES" ]] || { echo "$(trn cancelled)"; sleep 1; return; }; fi

    printf '\n%s\n\n' "$(trn addcat)"
    for k in m0 m1 m2 m3 m4 m5; do printf '  %s\n' "$(trn "$k")"; done
    printf '\n'
    read -r -p "$(trn selection) [0-5]: " mode
    [[ -z "$mode" ]] && mode=0
    [[ "$mode" =~ ^[0-5]$ ]] || mode=0

    local use_sub=0 use_date=0 use_kw=0
    [[ "$mode" == 1 || "$mode" == 3 || "$mode" == 5 ]] && use_sub=1
    [[ "$mode" == 2 || "$mode" == 3 || "$mode" == 5 ]] && use_date=1
    [[ "$mode" == 4 || "$mode" == 5 ]] && use_kw=1

    local run_id now moved=0 errors=0 p name ext cat subtype keyword year month monthname destdir dest src64 dst64 name64
    run_id="$(date '+%Y%m%d-%H%M%S')-$$"
    now="$(date '+%Y-%m-%d %H:%M:%S')"
    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$run_id" "$now" "$LANG_UI" "$mode" 'IN_PROGRESS' 0 0 >> "$RUNS_LOG"
    CREATED_SET=(); CREATED_DIRS=()

    printf '\n%s: %s\n%s\n\n' "$(trn run)" "$run_id" "$(trn organizing)"
    for p in "${FILES[@]}"; do
        name="$(basename -- "$p")"
        ext="$(get_extension "$name")"
        cat="$(get_category "$ext")"
        parts=("$cat")
        if (( use_kw )); then keyword="$(get_keyword_folder "$name" 2>/dev/null || true)"; [[ -n "$keyword" ]] && parts+=("$keyword"); fi
        (( use_sub )) && { subtype="$(get_subtype "$ext")"; parts+=("$subtype"); }
        if (( use_date )); then
            year="$(date -r "$p" '+%Y' 2>/dev/null || date '+%Y')"
            month="$(date -r "$p" '+%m' 2>/dev/null || date '+%m')"
            if [[ "$LANG_UI" == "es" ]]; then
                case "$month" in 01) monthname='01_Enero';;02) monthname='02_Febrero';;03) monthname='03_Marzo';;04) monthname='04_Abril';;05) monthname='05_Mayo';;06) monthname='06_Junio';;07) monthname='07_Julio';;08) monthname='08_Agosto';;09) monthname='09_Septiembre';;10) monthname='10_Octubre';;11) monthname='11_Noviembre';;12) monthname='12_Diciembre';; esac
            else
                case "$month" in 01) monthname='01_January';;02) monthname='02_February';;03) monthname='03_March';;04) monthname='04_April';;05) monthname='05_May';;06) monthname='06_June';;07) monthname='07_July';;08) monthname='08_August';;09) monthname='09_September';;10) monthname='10_October';;11) monthname='11_November';;12) monthname='12_December';; esac
            fi
            parts+=("$year" "$monthname")
        fi
        if ensure_path "${parts[@]}"; then
            destdir="$ENSURED_PATH"
            dest="$(free_destination "$destdir" "$name")"
        else
            ((errors++)); printf '[ERROR] %s\n' "$name" >&2; continue
        fi
        if mv -- "$p" "$dest"; then
            src64="$(b64enc "$p")"; dst64="$(b64enc "$dest")"; name64="$(b64enc "$name")"
            printf '%s\t%s\t%s\t%s\n' "$run_id" "$src64" "$dst64" "$name64" >> "$MOVES_LOG"
            ((moved++)); printf '[OK] %s -> %s\n' "$name" "${parts[*]}"
        else
            ((errors++)); printf '[ERROR] %s\n' "$name" >&2
        fi
    done
    local d
    for d in "${CREATED_DIRS[@]}"; do printf '%s\t%s\n' "$run_id" "$(b64enc "$d")" >> "$FOLDERS_LOG"; done
    local status='COMPLETED'; (( errors > 0 )) && status='COMPLETED_WITH_ERRORS'
    update_run_status "$run_id" "$status" "$moved" "$errors"
    printf '\n%s\n%s: %d | %s: %d\n%s\n\n' '================================================================' "$(trn moved)" "$moved" "$(trn errors)" "$errors" '================================================================'
    read -r -p "$(trn press): "
}

undo_last() {
    clear 2>/dev/null || true
    printf '%s\n        %s - v%s\n%s\n\n' '================================================================' "$(trn undo_title)" "$VERSION" '================================================================'
    [[ -f "$RUNS_LOG" ]] || { read -r -p "$(trn no_undo)  $(trn press): "; return; }
    local run_id
    run_id="$(awk -F '\t' '$5=="COMPLETED" || $5=="COMPLETED_WITH_ERRORS" || $5=="PARTIAL_UNDO" {r=$1} END{print r}' "$RUNS_LOG")"
    [[ -n "$run_id" ]] || { read -r -p "$(trn no_undo)  $(trn press): "; return; }
    [[ -f "$MOVES_LOG" ]] || { read -r -p "$(trn undo_missing)  $(trn press): "; return; }

    MOVE_SRCS=(); MOVE_DSTS=(); MOVE_NAMES=(); MOVE_DST64=()
    while IFS=$'\t' read -r r s d n; do
        [[ "$r" == "$run_id" ]] || continue
        is_restored "$r" "$d" && continue
        MOVE_SRCS+=("$(b64dec "$s")"); MOVE_DSTS+=("$(b64dec "$d")"); MOVE_NAMES+=("$(b64dec "$n")"); MOVE_DST64+=("$d")
    done < "$MOVES_LOG"

    (( ${#MOVE_SRCS[@]} > 0 )) || { update_run_status "$run_id" 'UNDONE' 0 0; read -r -p "$(trn no_undo)  $(trn press): "; return; }
    printf '%s: %s\n%s: %d\n\n' "$(trn run)" "$run_id" "$(trn pending)" "${#MOVE_SRCS[@]}"
    printf ' - %s\n - %s\n - %s\n\n' "$(trn undo1)" "$(trn undo2)" "$(trn undo3)"
    read -r -p "$(trn undo_confirm): " answer
    if [[ "$LANG_UI" == "es" ]]; then [[ "${answer^^}" == "DESHACER" ]] || { echo "$(trn cancelled)"; sleep 1; return; }
    else [[ "${answer^^}" == "UNDO" ]] || { echo "$(trn cancelled)"; sleep 1; return; }; fi

    local restored=0 conflicts=0 missing=0 errors=0 i src dst name dst64 parent
    printf '\n%s\n\n' "$(trn restoring)"
    for ((i=${#MOVE_SRCS[@]}-1; i>=0; i--)); do
        src="${MOVE_SRCS[$i]}"; dst="${MOVE_DSTS[$i]}"; name="${MOVE_NAMES[$i]}"; dst64="${MOVE_DST64[$i]}"
        if [[ ! -e "$dst" ]]; then ((missing++)); printf '[%s] %s\n' "$(trn missing)" "$dst"; continue; fi
        if [[ -e "$src" ]]; then ((conflicts++)); printf '[%s] %s\n' "$(trn conflict)" "$src"; continue; fi
        parent="$(dirname -- "$src")"; mkdir -p -- "$parent"
        if mv -- "$dst" "$src"; then
            printf '%s\t%s\tRESTORED\n' "$run_id" "$dst64" >> "$UNDO_LOG"
            ((restored++)); printf '[OK] %s -> %s\n' "$name" "$(trn restored)"
        else ((errors++)); printf '[ERROR] %s\n' "$name" >&2; fi
    done

    local folders_deleted=0 folders_kept=0 folder i
    printf '\n%s\n\n' "$(trn cleaning)"
    FOLDERS=()
    if [[ -f "$FOLDERS_LOG" ]]; then
        while IFS=$'\t' read -r r f; do [[ "$r" == "$run_id" ]] && FOLDERS+=("$(b64dec "$f")"); done < "$FOLDERS_LOG"
    fi
    for ((i=${#FOLDERS[@]}-1; i>=0; i--)); do
        folder="${FOLDERS[$i]}"
        [[ -d "$folder" ]] || continue
        if rmdir -- "$folder" 2>/dev/null; then ((folders_deleted++)); printf '[%s] %s\n' "$(trn deleted)" "$folder"
        else ((folders_kept++)); printf '[%s] %s\n' "$(trn kept)" "$folder"; fi
    done

    local remaining=0
    while IFS=$'\t' read -r r s d n; do [[ "$r" == "$run_id" ]] || continue; is_restored "$r" "$d" || ((remaining++)); done < "$MOVES_LOG"
    if (( remaining == 0 )); then update_run_status "$run_id" 'UNDONE' "$restored" "$errors"; else update_run_status "$run_id" 'PARTIAL_UNDO' "$restored" "$errors"; fi
    printf '\n%s\n%s: %d | %s: %d | %s: %d | %s: %d\n%s\n\n' '================================================================' "$(trn restored)" "$restored" "$(trn conflict)" "$conflicts" "$(trn missing)" "$missing" "$(trn errors)" "$errors" '================================================================'
    (( remaining > 0 )) && printf '%s\n\n' "$(trn partial)"
    read -r -p "$(trn press): "
}

select_language
while :; do
    clear 2>/dev/null || true
    printf '%s\n        %s v%s\n%s\n\n' '================================================================' "$(trn title)" "$VERSION" '================================================================'
    printf '%s: %s\n%s: %s\n\n' "$(trn current)" "$BASE_DIR" "$(trn internal)" "$DATA_DIR"
    printf '  %s\n  %s\n  %s\n\n' "$(trn menu1)" "$(trn menu2)" "$(trn menu3)"
    read -r -p "$(trn selection) [1-3]: " choice
    case "$choice" in 1) organize;; 2) undo_last;; 3) exit 0;; *) echo "$(trn invalid)"; sleep 1;; esac
done
