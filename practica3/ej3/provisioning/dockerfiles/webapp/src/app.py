from flask import Flask
from flask import render_template
from markupsafe import Markup
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine,text

app = Flask(__name__)

# Modify db_host for configuring MySQL connection
db_host = 'acr2324-db'
# URI format: mysql://username:password@server:port/db_name
db_uri = 'mysql://flask:12345@%s:3306/mydb' % (db_host)

app.config['SQLALCHEMY_DATABASE_URI'] = db_uri
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route("/")
def test():
    error = None
    mysql_result = False
    
    try:
        engine = create_engine(db_uri)
        query = text('SELECT 1')
        with engine.connect() as connection:
            result = connection.execute(query)

        if [row[0] for row in result][0] == 1:
            mysql_result = True
    except Exception as exc:
        error = str(exc).replace("\n", "")
        mysql_result = False
        pass

    if mysql_result:
        height = '390px'
        result = Markup('<span style="color: green;">OK</span>')
    else:
        height = '440px'
        result = Markup('<span style="color: red;">FAILED</span><p><span style="color: red;">{}</span>').format(error)

    # Return the page with the result
    return render_template('index.html', result=result, db_uri=db_uri, height=height)
