FROM python:3.12

WORKDIR /backend

COPY ./requirements.txt /backend/requirements.txt
COPY ./main.py /backend/main.py

RUN pip install --no-cache-dir --upgrade -r /backend/requirements.txt

ENV PYTHONPATH=/backend

CMD uvicorn main:app --host 0.0.0.0 --port 80
