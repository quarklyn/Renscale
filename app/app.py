from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<h1><a href='https://github.com/quarklyn/Tailscale'>Tailscale</a>is running!</h1>"

if __name__ == "__main__":
    app.run(host='0.0.0.0')