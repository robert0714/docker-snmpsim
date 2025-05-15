FROM python:3.12-slim
 
RUN pip install pipenv
RUN pipenv --python 3.12
RUN pipenv install snmpsim

RUN adduser --system snmpsim

ADD data /usr/local/snmpsim/data

EXPOSE 161/udp
ENV EXTRA_FLAGS=""
#CMD snmpsimd.py --agent-udpv4-endpoint=0.0.0.0:161 --process-user=snmpsim --process-group=nogroup $EXTRA_FLAGS
ENV TZ=Asia/Taipei
CMD ["pipenv","run","snmpsim-command-responder","--data-dir=/usr/local/snmpsim/data","--agent-udpv4-endpoint=0.0.0.0:161","--process-user=snmpsim","--process-group=nogroup","$EXTRA_FLAGS"]
