#!/usr/bin/env bash
#
# Usage:
#   ./link-module.sh Vendor Module ProjectName [local|community]
#   ./link-module.sh --unlink Vendor Module ProjectName [local|community]
#
# Example:
#   ./link-module.sh MyVendor MyModule NmcCatalog local
#   ./link-module.sh --unlink MyVendor MyModule NmcCatalog local
#

set -euo pipefail

# --- CONFIG ---
OPENMAGE_PATH="${HOME}/PhpstormProjects/NmcTest" # path to OpenMage install
MODULES_PATH="${HOME}/PhpstormProjects"          # where module repos live

# --- INPUT ---
UNLINK_MODE=false
if [[ "${1:-}" == "--unlink" ]]; then
  UNLINK_MODE=true
  shift
fi

VENDOR="$1"
MODULE="$2"
PROJECTNAME="$3"
CODEPOOL="${4:-community}" # default if not specified

PROJECTPATH="${MODULES_PATH}/${PROJECTNAME}"

# --- HELPERS ---
link_path() {
  local source="$1"
  local target="$2"
  local label="$3"

  if $UNLINK_MODE; then
    if [[ -L "$target" ]]; then
      echo "🗑️  Removing symlink for $label: $target"
      rm "$target"
    else
      echo "ℹ️  Skipped $label (no symlink at $target)"
    fi
  else
    if [[ -e "$source" ]]; then
      if [[ -L "$target" ]]; then
        # Already a symlink, check if it points to the right place
        local current
        current=$(readlink "$target")
        if [[ "$current" == "$source" ]]; then
          echo "✔️  $label already linked: $target -> $current"
          return
        else
          echo "🔄 Updating symlink for $label: $target (was $current)"
          rm "$target"
        fi
      elif [[ -e "$target" ]]; then
        echo "⚠️  Removing existing $label (not a symlink): $target"
        rm -rf "$target"
      fi

      mkdir -p "$(dirname "$target")"
      ln -s "$source" "$target"
      echo "✅ Linked $label: $target -> $source"
    else
      echo "ℹ️  Skipped $label (not found at $source)"
    fi
  fi
}

# --- PATHS ---
SOURCE="${PROJECTPATH}/app/code/${CODEPOOL}/${VENDOR}/${MODULE}"
TARGET="${OPENMAGE_PATH}/app/code/${CODEPOOL}/${VENDOR}/${MODULE}"

SOURCE_CONFIGFILE="${PROJECTPATH}/app/etc/modules/${VENDOR}_${MODULE}.xml"
TARGET_CONFIGFILE="${OPENMAGE_PATH}/app/etc/modules/${VENDOR}_${MODULE}.xml"

declare -A PATHS=(
  ["$SOURCE"]="$TARGET|module"
  ["$SOURCE_CONFIGFILE"]="$TARGET_CONFIGFILE|config"
  ["${PROJECTPATH}/app/design/frontend/base/default/template/${VENDOR,,}/${MODULE,,}"]="${OPENMAGE_PATH}/app/design/frontend/base/default/template/${VENDOR,,}/${MODULE,,}|frontend template"
  ["${PROJECTPATH}/app/design/frontend/base/default/layout/${VENDOR,,}/${MODULE,,}.xml"]="${OPENMAGE_PATH}/app/design/frontend/base/default/layout/${VENDOR,,}/${MODULE,,}.xml|frontend layout"
  ["${PROJECTPATH}/skin/frontend/base/default/${VENDOR,,}/${MODULE,,}"]="${OPENMAGE_PATH}/skin/frontend/base/default/${VENDOR,,}/${MODULE,,}|frontend skin"
  ["${PROJECTPATH}/app/design/adminhtml/default/default/template/${VENDOR,,}/${MODULE,,}"]="${OPENMAGE_PATH}/app/design/adminhtml/default/default/template/${VENDOR,,}/${MODULE,,}|adminhtml template"
  ["${PROJECTPATH}/app/design/adminhtml/default/default/layout/${VENDOR,,}/${MODULE,,}.xml"]="${OPENMAGE_PATH}/app/design/adminhtml/default/default/layout/${VENDOR,,}/${MODULE,,}.xml|adminhtml layout"
  ["${PROJECTPATH}/skin/adminhtml/default/default/${VENDOR,,}/${MODULE,,}"]="${OPENMAGE_PATH}/skin/adminhtml/default/default/${VENDOR,,}/${MODULE,,}|adminhtml skin"
  ["${PROJECTPATH}/js/${VENDOR,,}/${MODULE,,}"]="${OPENMAGE_PATH}/js/${VENDOR,,}/${MODULE,,}|javascript"
)

# --- EXECUTE ---
for src in "${!PATHS[@]}"; do
  IFS="|" read -r tgt label <<<"${PATHS[$src]}"
  link_path "$src" "$tgt" "$label"
done
