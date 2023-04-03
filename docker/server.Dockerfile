FROM tiangolo/uwsgi-nginx-flask:python3.10 as base
ENV UWSGI_CHEAPER=
ENV UWSGI_PROCESSES=1
WORKDIR /app
COPY *.whl .
COPY HiCT_Server/ .
RUN find -type f -name "*.whl" | xargs -n 1 pip install --upgrade --no-cache-dir
RUN unset UWSGI_CHEAPER 
RUN unset UWSGI_PROCESSES
RUN export UWSGI_PROCESSES=1
RUN python -m compileall -o 2 -r 3 -f -e . 
RUN pip install --upgrade --no-cache-dir .
EXPOSE 5000
