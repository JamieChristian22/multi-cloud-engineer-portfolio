from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return """
    <h1>Cloud Insurance App</h1>
    <h2>Status: Running</h2>
    <h3>Environment: Kubernetes</h3>
    <h3>Version: 1.0</h3>
    """

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)