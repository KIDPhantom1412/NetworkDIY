#!/usr/bin/env bash
# Read a PDF via the Windows-side uv + PyMuPDF (see AGENTS.md "阅读 handout PDF 的方法").
# Windows processes cannot see the WSL filesystem, so the script and PDF are staged
# under the Windows %TEMP% directory before uv.exe is invoked.
#
# Usage:
#   scripts/read-pdf.sh text   <file.pdf> [start] [end]
#   scripts/read-pdf.sh render <file.pdf> <start> <end> <outdir> [dpi]
set -euo pipefail

UV=/mnt/c/Users/xiang/.local/bin/uv.exe
STAGE=/mnt/c/Users/xiang/AppData/Local/Temp/read-pdf
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mode=$1
pdf=$2
shift 2

mkdir -p "$STAGE/out"
cp "$SCRIPT_DIR/read-pdf.py" "$STAGE/"
cp "$pdf" "$STAGE/input.pdf"

case $mode in
  text)
    "$UV" run "$(wslpath -w "$STAGE/read-pdf.py")" text "$(wslpath -w "$STAGE/input.pdf")" "$@"
    ;;
  render)
    start=$1
    end=$2
    outdir=$3
    dpi=${4:-150}
    rm -f "$STAGE"/out/*.png
    "$UV" run "$(wslpath -w "$STAGE/read-pdf.py")" render "$(wslpath -w "$STAGE/input.pdf")" \
      "$start" "$end" "$(wslpath -w "$STAGE/out")" "$dpi"
    mkdir -p "$outdir"
    cp "$STAGE"/out/*.png "$outdir/"
    ls "$outdir"/*.png
    ;;
  *)
    echo "unknown mode: $mode (expected 'text' or 'render')" >&2
    exit 2
    ;;
esac
