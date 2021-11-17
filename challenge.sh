#!/bin/bash

# Condicional que verifica que el el archivo excel alla sido enviado en la peticion
if [ -f "$1" ]; then
    echo "El archivo $1 si existe en esta carpeta."
else
    echo "El archivo $1 no esta en esta carpeta, por favor coloquelo en la carpeta."
    exit
fi

# Condicional para que si el directorio a crear ya existe no lo vuelva a crear y a su vez verifica que el archivo excel este dentro de el
# de lo contrario lo copia en el directorio
if [ -d "./work" ]; then
    echo "El directorio /work ya existe en esta carpeta."
    if [ -f "./work/$1" ]; then
        echo "El archivo: $1 ya existe en el repositorio de trabajo."
    else
        cp -v "$1" ./work/"$1"
        echo "Se copio con exito el archivo: $1 en el directorio de trabajo."
    fi
else
    mkdir "work"
    echo "El directorio work se creo con exito"
    cp -v "$1" ./work/"$1"
    echo "Se copio con exito el archivo: $1 en el directorio de trabajo."
fi

# Validar los headers del archivo excel con un script en python
python3 validar_header.py $1

# Condicional que verifica que el archivo .cvs se encuentre dentro de la carpeta de trabajo, de lo contrario convierte el archivo de
# excel con extención .xlsx a un archivo .csv y le quita los headers de las columnas
if [ -f "./work/nuevo_archivo.csv" ]; then
    echo "El archivo nuevo_archivo.cvs ya existe dentro del directorio ./work Asi que no se creo nuevamente."
else
    ssconvert excel_ejemplo_desarrolador_backend.xlsx ./work/nuevo_archivo.csv
    echo "El archivo nuevo_archivo.cvs a sido creado con exito en el directorio ./work"
    echo ./work/nuevo_archivo.csv

    sed -i "1,4d" ./work/nuevo_archivo.csv 
    echo "Se modifico el archivo nuevo_archivo.csv y se quitaron los headers para la inserción en postgres."
fi

# Copiar el archivo .svg a la base de datos "challenge_bous" en la tabla "tabla_de_trabajo"
psql -h localhost -U postgres -d challenge_bous -c "\copy tabla_de_trabajo(cliente, contrato, fecha_de_compra, ciudad, empresa, valor_adeudado) from 'work/nuevo_archivo.csv' delimiter ',' csv"

# Ejecución del script  SQL carga_y_calculos.sql
psql -h localhost -U postgres -d challenge_bous -f carga_y_calculos.sql

# Ejecucion del script python servicio.py
python3 servicio.py

exit