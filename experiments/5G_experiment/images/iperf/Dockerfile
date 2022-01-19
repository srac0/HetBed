# iperf3 in a container
#
# docker build --tag iperf .
#
# Run as Server:
# docker run  -it --rm --name=iperf3-srv -p 5201:5201 iperf -s
#
# Run as Client (first get server IP address):
# docker inspect --format "{{ .NetworkSettings.IPAddress }}" iperf3-srv
# docker run  -it --rm iperf -c <SERVER_IP>
#
FROM debian:latest

# install binary and remove cache
RUN apt-get update \
    && apt-get install -y iperf3 \
    && rm -rf /var/lib/apt/lists/*

# Expose the default iperf3 server port
EXPOSE 5201

ENTRYPOINT ["iperf3"]