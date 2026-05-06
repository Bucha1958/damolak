from flask import Flask
import requests

app = Flask(__name__)

@app.route("/")
def home():
    c = requests.get("http://app-c").text
    return f"App B here -> {c}"
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)