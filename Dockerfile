# -- Build stage
FROM python:3.10-slim-buster
# create db dir
RUN mkdir -p home/db
COPY ./db home/db
# creating app dir
RUN mkdir -p home/app
WORKDIR /home/app
# from host to container
COPY ./app home/app

# -- Run stage
# install requirements
RUN pip install -r home/app/requirements.txt
CMD ["python", "-u", "home/app/main.py"]
