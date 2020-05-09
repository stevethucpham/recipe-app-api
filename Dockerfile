FROM python:3.7-alpine
MAINTAINER Thuc Pham

# It doesn't allow python to buffer the output in docker container.
# Avoid some complications with docker image
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Create a dir app for the docker image
RUN mkdir /app
# Start with this dir
WORKDIR /app
# Copy into our docker image
COPY ./app /app

RUN adduser -D user
USER user


