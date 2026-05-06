from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "App D here -> I am the final service"

app.run(host="0.0.0.0", port=5000)