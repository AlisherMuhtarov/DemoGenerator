#!/bin/bash

# Step 1: Update packages
sudo yum update

# Step 2: Install Python and virtual environment
sudo yum install python3
pip3 install virtualenv

# Step 3: Create a directory for your app
mkdir my_flask_app
cd my_flask_app

# Step 4: Create a virtual environment
python3 -m venv venv

# Step 5: Activate the virtual environment
source venv/bin/activate

# Step 6: Install Flask
pip install Flask

# Step 7: Create the Flask app
cat <<EOF > app.py
import os
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        user_input = request.form['user_input']

        # Append the user input to a file on your machine
        if user_input:
            file_path = '/home/ec2-user/user_input.txt'  # Replace with the actual path to your file
            with open(file_path, 'a') as file:
                file.write(user_input + '\n')

        return f'You entered: {user_input} (Saved to your machine)'
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Step 8: Create an HTML template
mkdir templates
cat <<EOF > templates/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Simple Flask App</title>
</head>
<body>
    <h1>Simple Flask Text Input App</h1>
    <form method="post">
        <input type="text" name="user_input" placeholder="Enter text">
        <input type="submit" value="Submit">
    </form>
</body>
</html>
EOF

# Step 9: Run the Flask app
export FLASK_APP=app.py
export FLASK_ENV=development
flask run --host=0.0.0.0 --port=5000

