from flask import Flask
import requests

app = Flask(__name__)

@app.route("/")
def home():
    b = requests.get("http://app-b").text
    return f"App A here -> {b}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)