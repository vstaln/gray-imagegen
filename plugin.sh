#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-imagegen.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-imagegen" ;;
    *) rel="x86_64-apple-darwin/gray-imagegen" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-imagegen" ;;
    *) rel="x86_64-unknown-linux-musl/gray-imagegen" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-imagegen.exe" "$here/target/release/gray-imagegen" "$here/target/debug/gray-imagegen.exe" "$here/target/debug/gray-imagegen"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-imagegen binary not found in $here" >&2
exit 1
