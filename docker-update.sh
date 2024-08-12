#!/bin/bash
aws ecr get-login-password --region {AWS_REGION} | sudo docker login --username AWS --password-stdin {ECR_REPO}

# Detenemos el contenedor
sudo {PROJECT_PATH}/docker-compose down 2>&1

# Limpiamos las imágenes que sean /${IMAGE_NAME}
sudo docker rmi $(sudo docker images | grep {IMAGE_NAME} | awk '{print $3}') -f 2>&1

# Limpiamos los contenedores que sean /${IMAGE_NAME}
# sudo docker rm $(sudo docker ps -a | grep ${IMAGE_NAME} | awk '{print $1}') -f 2>&1

# Volvemos a ejecutar el docker-compose
sudo {PROJECT_PATH}/docker-compose up --build -d 2>&1

# Listo
echo "Actualización completada"
