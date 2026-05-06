from flask import Flask
import requests

app = Flask(__name__)

@app.route("/")
def home():
    b = requests.get("http://app-b:5000").text
    return f"App A here -> {b}"

app.run(host="0.0.0.0", port=5000)