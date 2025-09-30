#!/usr/bin/env bash
#
# Usage: ./link-module.sh Vendor Module ProjectName [local|community]
#
# Example:
#   ./link-module.sh MyVendor MyModule NmcCatalog local
#

set -euo pipefail

# --- CONFIG ---
OPENMAGE_PATH="${HOME}/PhpstormProjects/NmcTest/" # adjust this path to your setup
MODULES_PATH="${HOME}/PhpstormProjects"           # where your module repos live

# --- INPUT ---
VENDOR="$1"
MODULE="$2"
PROJECTNAME="$3"
CODEPOOL="${4:-commmunity}" # default to local if not specified

PROJECTPATH="${MODULEPATH}/${PROJECTNAME}/"

SOURCE_CONFIGFILE="${PROJECTPATH}app/etc/${VENDOR}_${MODULE}.xml"
TARGET_CONFIGFILE="${OPENMAFE_PATH}/app/etc/modules/${VENDOR}_${MODULE}.xml"
# --- PATHS ---
SOURCE="${PROJECTPATH}app/code/${CODEPOOL}/${VENDOR}/${MODULE}"
TARGET="${OPENMAGE_PATH}/app/code/${CODEPOOL}/${VENDOR}/${MODULE}"

SOURCE_FRONTEND_TEMPLATE="${PROJECTPATH}app/design/frontend/base/default/template/${VENDOR}/${MODULE}"
TARGET_FRONTEND_TEMPLATE="${OPENMAGE_PATH}app/design/frontend/base/default/template/${VENDOR}/${MODULE}"

SOURCE_FRONTEND_LAYOUT="${PROJECTPATH}app/design/frontend/base/default/layout/${VENDOR}/${MODULE}"
TARGET_FRONTEND_LAYOUT="${OPENMAGE_PATH}app/design/frontend/base/default/layout/${VENDOR}/${MODULE}"

SOURCE_FRONTEND_SKIN="${PROJECTPATH}skin/frontend/base/default/${VENDOR}/${MODULE}"
TARGET_FRONTEND_SKIN="${OPENMAGE_PATH}skin/frontend/base/default/${VENDOR}/${MODULE}"

SOURCE_ADMINHTML_SKIN="${PROJECTPATH}skin/adminhtml/default/default/template/${VENDOR}/${MODULE}"
TARGET_ADMINHTML_SKIN="${OPENMAGE_PATH}skin/adminhtml/default/default/template/${VENDOR}/${MODULE}"

SOURCE_ADMINHTML_TEMPLATE="${PROJECTPATH}app/design/adminhtml/default/default/template/${VENDOR}/${MODULE}"
TARGET_ADMINHTML_TEMPLATE="${OPENMAGE_PATH}app/design/adminhtml/default/default/template/${VENDOR}/${MODULE}"

SOURCE_ADMINHTML_LAYOUT="${PROJECTPATH}app/design/adminhtml/default/default/layout/${VENDOR}/${MODULE}"
TARGET_ADMINHTML_LAYOUT="${OPENMAGE_PATH}app/design/adminhtml/default/default/layout/${VENDOR}/${MODULE}"

SOURCE_JS_PATH="${PROJECTPATH}js/${VENDOR}/${MODULE}"
TARGET_JS_PATH="${OPENMAGE_PATH}js/${VENDOR}/${MODULE}"

# --- CHECKS ---
# --- CHECKS ---
if [[ ! -d "$SOURCE" ]]; then
  echo "❌ Module source not found: $SOURCE"
  exit 1
fi

if [[ ! -d "$SOURCE_CONFIGFILE" ]]; then
  echo "❌ Module source config file not found: $SOURCE"
  exit 1
fi
mkdir -p "$(dirname "$TARGET")"

# Remove existing dir if it’s not already the correct symlink
if [[ -e "$TARGET" && ! -L "$TARGET" ]]; then
  echo "⚠️  Removing existing directory: $TARGET"
  rm -rf "$TARGET"
fi

# Remove existing dir if it’s not already the correct symlink
if [[ -e "$TARGET_CONFIGFILE" && ! -L "$TARGET_CONFIGFILE" ]]; then
  echo "⚠️  Removing existing file: $TARGET_CONFIGFILE"
  rm -rf "$TARGET_CONFIGFILE"
fi
# --- CREATE SYMLINK ---
ln -sfn "$SOURCE" "$TARGET"

ln -sfn "$SOURCE_CONFIGFILE" "$TARGET_CONFIGFILE"

echo "✅ Symlink created:"
echo "   $TARGET -> $SOURCE"

echo "   $SOURCE_CONFIGFILE $TARGET_CONFIGFILE"

if [[ -e "$SOURCE_FRONTEND_TEMPLATE" ]]; then
  echo "    Found frontend templates, linking..."
  if [[ -e "$TARGET_FRONTEND_TEMPLATE" && ! -L "$TARGET_FRONTEND_TEMPLATE" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_FRONTEND_TEMPLATE"
    rm -rf "$TARGET_FRONTEND_TEMPLATE"
  fi
  echo "   $SOURCE_FRONTEND_TEMPLATE -> $TARGET_FRONTEND_TEMPLATE"
  ln -sfn "$SOURCE_FRONTEND_TEMPLATE" "$TARGET_FRONTEND_TEMPLATE"
fi

if [[ -e "$SOURCE_ADMINHTML_TEMPLATE" ]]; then
  echo "    Found frontend templates, linking..."
  if [[ -e "$TARGET_ADMINHTML_TEMPLATE" && ! -L "$TARGET_ADMINHTML_TEMPLATE" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_ADMINHTML_TEMPLATE"
    rm -rf "$TARGET_ADMINHTML_TEMPLATE"
  fi
  echo "   $SOURCE_ADMINHTML_TEMPLATE -> $TARGET_ADMINHTML_TEMPLATE"
  ln -sfn "$SOURCE_ADMINHTML_TEMPLATE" "$TARGET_ADMINHTML_TEMPLATE"
fi

if [[ -e "$SOURCE_FRONTEND_LAYOUT" ]]; then
  echo "    Found frontend templates, linking..."
  if [[ -e "$SOURCE_FRONTEND_LAYOUT" && ! -L "$SOURCE_FRONTEND_LAYOUT" ]]; then
    echo "⚠️  Removing existing directory: $SOURCE_FRONTEND_LAYOUT"
    rm -rf "$TARGET_FRONTEND_LAYOUT"
  fi
  echo "   $SOURCE_FRONTEND_LAYOUT -> $TARGET_FRONTEND_LAYOUT"
  ln -sfn "$SOURCE_FRONTEND_LAYOUT" "$TARGET_FRONTEND_LAYOUT"
fi

if [[ -e "$SOURCE_ADMINHTML_LAYOUT" ]]; then
  echo "    Found frontend templates, linking..."
  if [[ -e "$TARGET_ADMINHTML_LAYOUT" && ! -L "$TARGET_ADMINHTML_LAYOUT" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_ADMINHTML_LAYOUT"
    rm -rf "$TARGET_ADMINHTML_LAYOUT"
  fi
  echo "   $SOURCE_ADMINHTML_LAYOUT -> $TARGET_ADMINHTML_LAYOUT"
  ln -sfn "$SOURCE_ADMINHTML_LAYOUT" "$TARGET_ADMINHTML_LAYOUT"
fi

if [[ -e "$SOURCE_FRONTEND_SKIN" ]]; then
  echo "    Found frontend skin, linking..."
  if [[ -e "$SOURCE_FRONTEND_SKIN" && ! -L "$SOURCE_FRONTEND_SKIN" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_FRONTEND_SKIN"
    rm -rf "$TARGET_FRONTEND_SKIN"
  fi
  echo "   $SOURCE_FRONTEND_SKIN -> $TARGET_FRONTEND_SKIN"
  ln -sfn "$SOURCE_FRONTEND_SKIN" "$TARGET_FRONTEND_SKIN"
fi

if [[ -e "$SOURCE_ADMINHTML_SKIN" ]]; then
  echo "    Found adminhtml skin, linking..."
  if [[ -e "$TARGET_ADMINHTML_SKIN" && ! -L "$TARGET_ADMINHTML_SKIN" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_ADMINHTML_SKIN"
    rm -rf "$TARGET_ADMINHTML_SKIN"
  fi
  echo "   $SOURCE_ADMINHTML_SKIN -> $TARGET_ADMINHTML_SKIN"
  ln -sfn "$SOURCE_ADMINHTML_SKIN" "$TARGET_ADMINHTML_SKIN"
fi

if [[ -e "$SOURCE_JS_PATH" ]]; then
  echo "    Found js in js folder, linking..."
  if [[ -e "$TARGET_JS_PATH" && ! -L "$TARGET_JS_PATH" ]]; then
    echo "⚠️  Removing existing directory: $TARGET_JS_PATH"
    rm -rf "$TARGET_JS_PATH"
  fi
  echo "   $SOURCE_JS_PATH -> $TARGET_JS_PATH"
  ln -sfn "$SOURCE_JS_PATH" "$TARGET_JS_PATH"
fi
