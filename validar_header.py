import sys
import pandas as pd

# Creación de un array con el contenido correcto de los headers a validar
headers_validos = [
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        'Cliente',
        '(alfabético)'
    ),
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        '# Contrato',
        '(alfanumérico)'
    ),
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        'Fecha de Compra',
        '(fecha)'
    ),
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        'Ciudad',
        '(alfabético)'
    ),
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        'Empresa',
        '(alfanumérico)'
    ),
    (
        'Examen Técnico Desarrollador Backend',
        'Listado de adeudos',
        'Valor adeudado',
        '(numérico)'
    )
]

# Estructura del documento excel con pandas (dar un formato correcto)
df = pd.read_excel(sys.argv[1], header=[0,1,2,3], index_col=0)

# Acceso a los headers en pandas
headers = (list(df.columns.values))

# Validación de los headers recogidos en pandas y los validos
if headers == headers_validos:
    print("El archivo excel es valido.")
else:
    print("El archivo excel ingresado no es valido, porfavor ingrese el archivo valido.")
    exit()
