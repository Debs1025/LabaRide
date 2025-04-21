from models.userModel import User
from database.connection import create_connection
import bcrypt
import mysql.connector

class UserController:
    def __init__(self):
        self.connection = None

    def signup(self, data):
        conn = create_connection()
        if not conn:
            return {'status': 500, 'message': 'Database connection failed'}
        
        try:
            cursor = conn.cursor(dictionary=True)
            
            # Check if email already exists
            cursor.execute("SELECT * FROM users WHERE email = %s", (data['email'],))
            if cursor.fetchone():
                return {'status': 400, 'message': 'Email already exists'}

            # Hash password
            hashed_password = bcrypt.hashpw(data['password'].encode('utf-8'), bcrypt.gensalt())
            
            # Insert initial user data
            query = """
                INSERT INTO users (name, email, password) 
                VALUES (%s, %s, %s)
            """
            values = (data['name'], data['email'], hashed_password)
            
            cursor.execute(query, values)
            conn.commit()
            user_id = cursor.lastrowid
            
            # Generate token
            token = f"user_{user_id}_token"
            
            return {
                'status': 201,
                'message': 'User created successfully',
                'user_id': user_id,
                'token': token
            }
                
        except mysql.connector.Error as err:
            return {'status': 500, 'message': f'Database error: {str(err)}'}
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()

    def update_profile(self, user_id, data):
        conn = create_connection()
        if not conn:
            return {'status': 500, 'message': 'Database connection failed'}
        
        try:
            cursor = conn.cursor(dictionary=True)
            
            query = """
                UPDATE users 
                SET phone = %s,  
                    birthdate = %s,
                    gender = %s,
                    zone = %s,
                    street = %s,
                    barangay = %s,
                    building = %s
                WHERE id = %s
            """
            values = (
                data.get('phone'),
                data.get('birthdate'),
                data.get('gender'),
                data.get('zone'),
                data.get('street'), 
                data.get('barangay'),
                data.get('building'),
                user_id
            )
            
            cursor.execute(query, values)
            conn.commit()
            
            if cursor.rowcount == 0:
                return {'status': 404, 'message': 'User not found'}
                
            return {'status': 200, 'message': 'Profile updated successfully'}
            
        except mysql.connector.Error as err:
            return {'status': 500, 'message': f'Database error: {str(err)}'}
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()

    def login(self, credentials):
        conn = create_connection()
        if not conn:
            return {'status': 500, 'message': 'Database connection failed'}
            
        try:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users WHERE email = %s", (credentials['email'],))
            user = cursor.fetchone()
            
            if not user:
                return {'status': 401, 'message': 'Invalid email or password'}
                
            if bcrypt.checkpw(credentials['password'].encode('utf-8'), user['password'].encode('utf-8')):
                del user['password']
                return {
                    'status': 200,
                    'message': 'Login successful',
                    'user': user,
                    'token': f"user_{user['id']}_token"
                }
            
            return {'status': 401, 'message': 'Invalid email or password'}
            
        except mysql.connector.Error as err:
            return {'status': 500, 'message': f'Database error: {str(err)}'}
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()

    def delete_account(self, user_id):
        conn = create_connection()
        if not conn:
            return {'status': 500, 'message': 'Database connection failed'}
            
        try:
            cursor = conn.cursor()
            
            cursor.execute("DELETE FROM users WHERE id = %s", (user_id,))
            conn.commit()
            
            if cursor.rowcount == 0:
                return {'status': 404, 'message': 'User not found'}
                
            return {'status': 200, 'message': 'Account deleted successfully'}
            
        except mysql.connector.Error as err:
            return {'status': 500, 'message': f'Database error: {str(err)}'}
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()

    def get_user_details(self, user_id):
        conn = create_connection()
        if not conn:
            return {'status': 500, 'message': 'Database connection failed'}
            
        try:
            cursor = conn.cursor(dictionary=True)
            
            query = """
                SELECT id, name, email, phone, birthdate, gender,
                    zone, street, barangay, building
                FROM users 
                WHERE id = %s
            """
            
            cursor.execute(query, (user_id,))
            user = cursor.fetchone()
            
            if not user:
                return {'status': 404, 'message': 'User not found'}
                
            return {
                'status': 200,
                'message': 'User details retrieved successfully',
                'user': user
            }
                
        except mysql.connector.Error as err:
            return {'status': 500, 'message': f'Database error: {str(err)}'}
        finally:
            if conn.is_connected():
                cursor.close()
                conn.close()