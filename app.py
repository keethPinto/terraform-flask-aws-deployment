from flask import Flask
import logging

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

@app.route("/")
def hello():
    app.logger.info("Homepage was accessed")
    return "<h1 style='color:green; '>Hello Terraform from Flask on AWS EC2!</h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)