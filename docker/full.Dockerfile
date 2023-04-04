FROM tiangolo/uwsgi-nginx-flask:python3.10 as base
ENV UWSGI_CHEAPER=
ENV UWSGI_PROCESSES=1
WORKDIR /app
COPY HiCT_Library/dist/*.whl .
COPY HiCT_Server/ .
COPY HiCT_WebUI/dist /app/static/
RUN find -type f -name "*.whl" | xargs -n 1 pip install --upgrade --no-cache-dir
RUN find -type f -name "*.whl" | xargs -n 1 rm -f 
RUN ls -alRh
RUN unset UWSGI_CHEAPER 
RUN unset UWSGI_PROCESSES
RUN export UWSGI_PROCESSES=1
RUN python -m compileall -o 2 -r 3 -f -e . 
RUN pip install --upgrade --no-cache-dir .
EXPOSE 5000 8080
ENV STATIC_INDEX=1
RUN rm -f /etc/nginx/conf.d/nginx.conf
COPY ./docker/nginx.conf /app/nginx.server.conf
RUN echo "cp -f /app/nginx.server.conf /etc/nginx/conf.d/nginx.conf" >> /app/prestart.sh
