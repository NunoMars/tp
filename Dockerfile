FROM python:3.11


WORKDIR /app

COPY /app /app/
RUN pip install --no-cache-dir -r requirements.txt

# Comande pour appliquer les migrations
RUN python3 manage.py migrate

EXPOSE 5000

# Commande pour démarrer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "siteVoyance.wsgi:application"]