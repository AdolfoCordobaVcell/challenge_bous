from flask import Flask, render_template, request, redirect, url_for, flash
import psycopg2
import psycopg2.extras

import json

app = Flask(__name__)
app.secret_key = "secretkey"

# Conección de Postgres
DB_HOST = 'localhost'
DB_NAME = 'challenge_bous'
DB_USER = 'postgres'
DB_PASS = 'password'

conn =  psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST)

@app.route('/')
def Index():
    return render_template('index.html')

@app.route('/', methods=['POST'])
def show():
    # Obtener el valor del input
    folio = request.form['folio']

    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    # Consulta a la tabla de adeudo y porcentaje por ciudad
    consulta_ciudad = "SELECT ciudad, adeudo, porcentaje FROM adeudo_y_porcentaje_por_ciudad WHERE folio_procesados = %s"
    cur.execute(consulta_ciudad, folio)
    data_ciudad = cur.fetchall()
    ans_ciudad = []
    for row in data_ciudad:
        ans_ciudad.append(dict(row))
    response_ciudad = ans_ciudad
    
    # Consulta a la tabla de adeudo y porcentaje por empresa
    consulta_empresa = "SELECT empresa, adeudo, porcentaje FROM adeudo_y_porcentaje_por_empresa WHERE folio_procesados = %s"
    cur.execute(consulta_empresa, folio)
    data_empresa = cur.fetchall()
    ans_empresa = []
    for row in data_empresa:
        ans_empresa.append(dict(row))
    response_empresa = ans_empresa
    
    # Consulta a la tabla de folio
    consulta_folio = "SELECT folio, numero_de_registros, adeudo_total FROM procesados WHERE folio = %s"
    cur.execute(consulta_folio, folio)
    data_folio = cur.fetchall()
    ans_folio = []
    for row in data_folio:
        ans_folio.append(dict(row))
    response_folio = ans_folio

    # Union de los arrays que trae como respuesta
    response_folio.extend(response_ciudad)
    response_folio.extend(response_empresa)

    # Convertir el array en un objeto en Python
    response = json.dumps(response_folio)

    # Impresion de la respuesta JSON ya que en el navegador no se observan por error de las cookies
    print(response)

    # Inserción del JSON en el HTML
    flash(response)
    return redirect(url_for('Index'))

if __name__ == '__main__':
    app.run(port = 3000)