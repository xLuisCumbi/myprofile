#!/bin/bash

# Script de despliegue para AWS S3 y CloudFront
# Requiere tener configurado AWS CLI y las credenciales adecuadas

# Variables (reemplazar con tus propios valores)
S3_BUCKET="xluiscumbi.com"
CLOUDFRONT_DISTRIBUTION_ID="YOUR_CLOUDFRONT_ID"

# Colores para mensajes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Función para mostrar mensajes
function log() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

function warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

function error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

# Verificar si AWS CLI está instalado
if ! command -v aws &> /dev/null; then
  error "AWS CLI no está instalado. Por favor, instálalo primero: https://aws.amazon.com/cli/"
fi

# Construir el proyecto
log "Construyendo el proyecto..."
npm run build || error "Error al construir el proyecto"

# Desplegar a S3
log "Desplegando a S3..."
aws s3 sync dist/ s3://$S3_BUCKET/ --delete || error "Error al sincronizar con S3"

# Invalidar caché de CloudFront si se proporciona un ID de distribución
if [ "$CLOUDFRONT_DISTRIBUTION_ID" != "YOUR_CLOUDFRONT_ID" ]; then
  log "Invalidando caché de CloudFront..."
  aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "/*" || warn "Error al invalidar la caché de CloudFront"
else
  warn "ID de distribución de CloudFront no configurado. Saltando invalidación de caché."
fi

log "Despliegue completado con éxito!"
log "Sitio disponible en: https://$S3_BUCKET" 