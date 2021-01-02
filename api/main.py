from flask import Flask
from random import randint

app = Flask(__name__)


@app.route("/")
def health_check():
    return "Server is up"


@app.route("/get/random")
def get_random():
    return '''
        <h1>Hello there dude</h1>
        <p>You've accessed a random content generator</p>
        <p>{0}</p>
    '''.format(randint(0, 1000))


app.run(debug=True, host="0.0.0.0", port=5000)
