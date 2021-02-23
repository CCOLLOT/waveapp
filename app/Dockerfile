FROM python:3

LABEL MAINTAINER=Christophe_Collot

# Create the directory and cd into it
WORKDIR /app

# Expose the port uWSGI will listen on
EXPOSE 5000
# Copy file with Python dependencies
COPY requirements.txt .
# Install Python dependencies to enable layer caching
RUN pip install -r requirements.txt

# Copy the application code inside the /app folder
COPY . .

#Give uwsgi user access to the app
RUN chmod 755 -R /app 
RUN chown -R www-data /app
# Finally, we run uWSGI with the ini file we
# created earlier
CMD [ "uwsgi", "--ini", "app.ini" ]