import json

from flask import Flask, jsonify, Response

app = Flask(__name__)


class Conta:
    def __init__(self, login, senha):
        self.login = login
        self.senha = senha


conta_01 = Conta("Maria", "1234567")
conta_02 = Conta("Lucas", "7654321")

lista_contas = [conta_01, conta_02]
list_js = []

for x in lista_contas:
    list_js.append({"login": x.login , "senha": x.senha})


@app.route('/')
def inicio():
    return Response(json.dumps(list_js), mimetype='application/json')


app.run(host='0.0.0.0')
