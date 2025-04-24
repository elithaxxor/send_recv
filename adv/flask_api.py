from flask import Flask, jsonify
import threading

class FlaskAPI:
    def __init__(self):
        self.app = Flask(__name__)
        self.setup_routes()

    def setup_routes(self):
        @self.app.route('/status', methods=['GET'])
        def status():
            return jsonify({"status": "running"})

    def run(self, host='0.0.0.0', port=5000):
        threading.Thread(target=self.app.run, kwargs={'host': host, 'port': port}, daemon=True).start()
