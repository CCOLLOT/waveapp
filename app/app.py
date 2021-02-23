import os
from flask import Flask, render_template, request, redirect, send_file, url_for
from src.s3_upload import upload_file
app = Flask(__name__, static_folder="./static", static_url_path="/")


@app.route("/", methods=['GET','POST'])
def upload():
    if request.method == "GET":
        return render_template('index.html', vars={"upload":""})
    if request.method == "POST":
        f = request.files['user_file']
        f.save(os.path.join("uploads/", f.filename))
        try:
            upload_file(file_name=f"uploads/{f.filename}")
        except:
            return render_template('index.html', vars={"upload":False})
        return render_template('index.html', vars={"upload":True})

if __name__ == "__main__":
    app.run(debug=True, port=5000)
