# flaskEx1의 예제에서 html파일로 출력 메세지를 분리

from flask import Flask, render_template
app = Flask(__name__)

# 라우터의 역할
@app.route("/")
@app.route("/<name>")
def hello(name = None):
    # html코드에 name값을 전달하면서 hello.html을 불러와서
    # html에서 서술하는 대로 화면에 그려주는 함수가 trender_template이다
    return render_template('hello.html', name = name)

@app.route("/melong/")
def melong():
    return "<h1>Melong!!!</h1>"

if __name__ == "__main__":
    app.run()