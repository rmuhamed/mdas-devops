FROM python:3.8-buster

RUN pip install retry requests

RUN export VOTINGAPP_HOST

COPY test.py .

ENTRYPOINT [ "python", "test.py" ]