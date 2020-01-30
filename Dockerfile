FROM python:3.8.1-alpine
COPY ./dora_dhcp_client /source
COPY ./requirements.txt /source/
WORKDIR /source
RUN pip install -r requirements.txt
ENTRYPOINT [ "python3.8", "./dora.py" ]
