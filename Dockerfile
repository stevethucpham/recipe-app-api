FROM python:3.7-alpine
MAINTAINER Thuc Pham

# It doesn't allow python to buffer the output in docker container.
# Avoid some complications with docker image
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# No cache will reduce the size of your image
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
     gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create a dir app for the docker image
RUN mkdir /app
# Start with this dir
WORKDIR /app
# Copy into our docker image
COPY ./app /app

RUN adduser -D user
USER user


