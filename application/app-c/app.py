from flask import Flask
import requests

app = Flask(__name__)

@app.route("/")
def home():
    d = requests.get("http://app-d").text
    return f"App C here -> {d}"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)