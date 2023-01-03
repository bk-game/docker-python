FROM python:3
USER root


RUN apt-get update
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN apt-get install -y vim less

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9

RUN mkdir -p /root/src
ARG SRC_PATH="./src"
COPY ${SRC_PATH} /root/src
WORKDIR /root/src

RUN  if [ ! -e requirements.txt ]; then touch requirements.txt; fi

RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

CMD python3 main.py