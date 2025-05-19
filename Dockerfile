FROM python:3.12-slim

# RUN apt-get update && apt-get install -y \
#     iproute2 iputils-ping net-tools dnsutils \
#     tcpdump traceroute curl vim less procps snmp \
#  && rm -rf /var/lib/apt/lists/*

# Install required dependencies
RUN pip install snmpsim

# Create a directory for SNMP simulation data
ADD data /opt/snmpsim/data

# Set the working directory
WORKDIR /opt/snmpsim

# Command to run the SNMP simulator
RUN addgroup --system snmpsim && adduser --system --ingroup snmpsim snmpsim

# Expose the SNMP port
EXPOSE 1161/udp

ENV EXTRA_FLAGS="--agent-udpv4-endpoint=0.0.0.0:1161"
 
ENV TZ=Asia/Taipei

USER snmpsim

ENTRYPOINT [ "sh", "-c","snmpsim-command-responder --data-dir=/opt/snmpsim/data  $EXTRA_FLAGS"]
