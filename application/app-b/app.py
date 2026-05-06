from flask import Flask
import requests

app = Flask(__name__)

@app.route("/")
def home():
    c = requests.get("http://app-c:5000").text
    return f"App B here -> {c}"

app.run(host="0.0.0.0", port=5000)