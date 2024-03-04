FROM python:3.11


WORKDIR /app

COPY /app /app/
RUN pip install --no-cache-dir -r requirements.txt

RUN python3 manage.py makemigrations ball8
RUN python3 manage.py makemigrations accounts
RUN python3 manage.py makemigrations clairvoyance
RUN python3 manage.py makemigrations responses

RUN python3 manage.py migrate ball8
RUN python3 manage.py migrate accounts
RUN python3 manage.py migrate clairvoyance
RUN python3 manage.py migrate responses

RUN python3 create_superuser.py

EXPOSE 5000

# Commande pour démarrer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "siteVoyanceconfig.wsgi:application"]