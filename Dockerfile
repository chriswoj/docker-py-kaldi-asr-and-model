FROM uptospace/docker-py-kaldi-asr:latest

RUN apt-get install xz-utils -y && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y

ARG MODEL_NAME=kaldi-generic-de-tdnn_250-r20190328

WORKDIR /opt
RUN wget -q http://goofy.zamia.org/zamia-speech/asr-models/${MODEL_NAME}.tar.xz && \
    tar xf ${MODEL_NAME}.tar.xz && \
    mv ${MODEL_NAME} kaldi-model && \
    rm ${MODEL_NAME}.tar.xz

COPY asr_live.py /opt/asr_live.py

RUN pip install py-nltools
RUN pip install future

#EXPOSE 80
WORKDIR /opt
CMD ["python", "asr_live.py"]
