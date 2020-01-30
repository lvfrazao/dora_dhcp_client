FROM python:3.8.1-alpine
COPY . /source
WORKDIR /source
RUN pip install -r requirements.txt
ENTRYPOINT [ "python3.7", "./dora_dhcp_client/dora.py" ]
