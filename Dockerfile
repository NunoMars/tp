FROM python:3.11


WORKDIR /app

COPY /app /app/
RUN pip install --no-cache-dir -r requirements.txt && python3 manage.py migrate && python .\manage.py loaddata > database_dumps/db.json


EXPOSE 5000

# Commande pour démarrer l'application
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "siteVoyanceconfig.wsgi:application"]