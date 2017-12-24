#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for mazad"

  set -- mazad "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "mazad" ]; then
  mkdir -p "$BITCOIN_DATA"
  chmod 700 "$BITCOIN_DATA"
  chown -R maza "$BITCOIN_DATA"

  echo "$0: setting data directory to $BITCOIN_DATA"

  set -- "$@" -datadir="$BITCOIN_DATA"
fi

if [ "$1" = "mazad" ] || [ "$1" = "maza-cli" ] || [ "$1" = "maza-tx" ]; then
  echo
  exec su-exec maza "$@"
fi

echo
exec "$@"
