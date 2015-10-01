#
# For build this Dockerfile:
# docker build -t kallithea-gevent .
#

FROM fedora:22

RUN dnf -y update
RUN dnf install -y procps-ng openssl
RUN dnf install -y git python-virtualenv supervisor gcc
RUN dnf clean all

RUN easy_install supervisor-stdout

RUN mkdir /srv/kallithea
RUN mkdir /srv/kallithea/repo_data
RUN virtualenv /srv/kallithea/venv

RUN /srv/kallithea/venv/bin/pip install kallithea
RUN /srv/kallithea/venv/bin/pip install gunicorn gevent

# Create the kallithea user and group
RUN groupadd -r kallithea -g 1001 && useradd -u 1001 -r -g kallithea -d /srv/kallithea -s /sbin/nologin -c "kallithea user" kallithea

# Create initial kallithea config
RUN (cd /srv/kallithea; /srv/kallithea/venv/bin/paster make-config Kallithea my.ini)
RUN sed -i 's/\(^use .*egg:waitress#main\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/\(^threads .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/\(^max_request_body_size .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(use .*egg:gunicorn#main\)/\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(workers .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(proc_name .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(worker_class .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(max_requests .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^#\(timeout .*\)/#\1/' /srv/kallithea/my.ini
RUN sed -i 's/^host = 127\.0\.0\.1/host = 0.0.0.0/' /srv/kallithea/my.ini
RUN sed -i 's/^instance_id .*/instance_id = */' /srv/kallithea/my.ini


# Create empty database
RUN (cd /srv/kallithea; yes 'y' | /srv/kallithea/venv/bin/paster setup-db my.ini --user=admin --password=admin --email=admin@example.ltd --repos=/srv/kallithea/repo_data)

RUN chown -R kallithea:kallithea /srv/kallithea

ADD ./deploy/supervisord.conf /etc/supervisord.conf

EXPOSE 5000

CMD supervisord -c /etc/supervisord.conf -n
