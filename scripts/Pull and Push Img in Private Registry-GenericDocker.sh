#!/bin/bash

# Lista de imágenes a descargar
VERSION="2.3.31" #Actual Version for Images

IMAGES=(
  "trendmicrocloudone/admission-controller"
  "trendmicrocloudone/oversight-controller"
  "trendmicrocloudone/usage-controller"
  "trendmicrocloudone/rbac-proxy"
  "trendmicrocloudone/falco"
  "trendmicrocloudone/scout"
  "trendmicrocloudone/scan-manager"
  "trendmicrocloudone/scan-job"
  "trendmicrocloudone/workload-operator"
  "trendmicrocloudone/fargate-tool"
  "trendmicrocloudone/pdig"
)

#Iniciar Sesion con Docker
echo "<contraseña>" | docker login -u "<nombre_de_usuario>" --password-stdin

# Descarga y sube las imágenes
for IMAGE in "${IMAGES[@]}"; do
  # Descarga la imagen
  docker pull $IMAGE:$VERSION
  docker tag $IMAGE:$VERSION $ECR_IMAGE

  # Sube la imagen al registro de ECR
  docker push $ECR_IMAGE
done

# Limpieza: Puedes eliminar las imágenes locales si lo deseas
for IMAGE in "${IMAGES[@]}"; do
  docker rmi $IMAGE:$VERSION
done