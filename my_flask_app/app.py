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
