# flask.Flask
from flask import Flask
app = Flask(__name__)

@app.route("/")
def flaskEx1():
    # html코드를 문자열로 입력
    # html은 "header" + "body"로 이루어져 있다
    return "<h1>Hello World!</h1>"

@app.route("/melong/")
def melong():
    return "<h1>Melong!!!</h1>"

if __name__ == "__main__":
    app.run()