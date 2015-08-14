#!/usr/bin/env bash

set -e

########
# INIT #
########
SCRIPT_DIR=$(dirname $(readlink -f $0))
source ${SCRIPT_DIR}/common-conf

function usage() {
  echo "Modo de uso: $0 [-r] [-t] <ACCION>"
  echo ""
  echo "El parámetro -r realiza modificaciones a los archivos. Con lo cual,"
  echo "debe utilizarlo cuando esté seguro de lo que está haciendo"
  echo ""
  echo "El parámetro -t lo puede usar para probar que acciones se van a ejecutar."
  echo "En este caso, no se ejecuta ninguna acción y no se modifica ningun archivo."
  echo ""
  echo "En <ACCION> debe ir la referencia del nombre de la acción a ejecutar"
  echo ""
  echo ""
  echo "Ejemplo de uso:"
  echo "  $0 -t [instalar|preparar]"
  echo ""
  echo "" 1>&2
  exit 1
}

CMD=""
while getopts ":rt" parameter; do
  case "${parameter}" in
    r)
      echo "Ejecutar"
      CMD="run"
      ;;
    t)
      echo "Preparar"
      CMD="test"
      ;;
    *)
      usage
      ;;
  esac
done

if [ -z "${CMD}" ]; then
  usage
fi

shift $((OPTIND-1))
run-parts --report --exit-on-error ${SCRIPT_DIR}/${1}.d
