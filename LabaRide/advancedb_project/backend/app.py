from flask import Flask, request, jsonify
from flask_cors import CORS
from controllers.userController import UserController

app = Flask(__name__)
CORS(app)

user_controller = UserController()

@app.route('/signup', methods=['POST'])
def signup():
    try:
        result = user_controller.signup(request.json)
        return jsonify(result), result['status']
    except Exception as e:
        return jsonify({'status': 500, 'message': str(e)}), 500

@app.route('/update_user_details/<int:user_id>', methods=['PUT'])
def update_user_details(user_id):
    try:
        result = user_controller.update_profile(user_id, request.json)
        return jsonify(result), result['status']
    except Exception as e:
        return jsonify({'status': 500, 'message': str(e)}), 500

@app.route('/login', methods=['POST'])
def login():
    try:
        result = user_controller.login(request.json)
        return jsonify(result), result['status']
    except Exception as e:
        return jsonify({'status': 500, 'message': str(e)}), 500

@app.route('/delete_account/<int:user_id>', methods=['DELETE'])
def delete_account(user_id):
    try:
        result = user_controller.delete_account(user_id)
        return jsonify(result), result['status']
    except Exception as e:
        return jsonify({'status': 500, 'message': str(e)}), 500

@app.route('/user/<int:user_id>', methods=['GET'])
def get_user(user_id):
    try:
        result = user_controller.get_user_details(user_id)
        return jsonify(result), result['status']
    except Exception as e:
        return jsonify({'status': 500, 'message': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True, port=5000)