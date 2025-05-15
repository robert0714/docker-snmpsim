FROM python:3.12-slim

# Install required dependencies
RUN pip install snmpsim

# Create a directory for SNMP simulation data
ADD data /opt/snmpsim/data

# Set the working directory
WORKDIR /opt/snmpsim

# Command to run the SNMP simulator
RUN addgroup --system snmpsim && adduser --system --ingroup snmpsim snmpsim

# Expose the SNMP port
EXPOSE 161/udp

ENV EXTRA_FLAGS=""
 
ENV TZ=Asia/Taipei

USER snmpsim

ENTRYPOINT [ "sh", "-c","snmpsim-command-responder --data-dir=/opt/snmpsim/data --agent-udpv4-endpoint=0.0.0.0:161 $EXTRA_FLAGS"]
