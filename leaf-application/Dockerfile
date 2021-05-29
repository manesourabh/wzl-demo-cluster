FROM python:3.7.7
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code
RUN pip install -r requirements.txt
COPY . /code
CMD ["python", "manage.py", "runserver_plus", "0.0.0.0:8000", "--cert-file", "cert.crt"]
