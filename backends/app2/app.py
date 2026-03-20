from os import getenv

from flask import Flask, jsonify

app = Flask(__name__)


def payload():
    return {
        "app": getenv("APP_NAME", "app2"),
        "environment": getenv("APP_ENV", "main"),
        "status": "ok",
        "version": getenv("APP_VERSION", "1.0.0"),
    }


@app.get("/")
def index():
    return jsonify(payload())


@app.get("/health")
def health():
    body = payload()
    body["health"] = "healthy"
    return jsonify(body)
