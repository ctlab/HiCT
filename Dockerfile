FROM docker pull tiangolo/uwsgi-nginx-flask:python3.11 as intermediate
LABEL stage=intermediate

COPY ./artifacts /app/artifacts

RUN find ./artifacts/ -type f -name "*.whl" -print0 | xargs -0 pip install --no-cache-dir --upgrade && rm -rf /app/artifacts
ENV MODULE_NAME="hict_server.api_controller.dev_demo_server"
