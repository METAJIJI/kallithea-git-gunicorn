# BUILD AND RUN CONTAINER
1. Build:

    ```bash
    docker build -t kallithea-gevent .
    ```
2. Create:

    ```bash
    docker create --name=kallithea-gevent --publish="127.0.0.1:5000:5000/tcp" kallithea-gevent
    ```
3. Start:

    ```bash
    docker start kallithea-gevent
    ```
4. Execute live bash shell for interact if needed:

    ```bash
    docker exec -it kallithea-gevent /bin/bash
    ```

# REPRODUCE
## Client side
git version 1.9.1

Goto web `http://localhost:5000/` and create repo `kallithea-git-gevent`.

```bash
$ mkdir /tmp/kallithea-git-gevent
$ cd /tmp/kallithea-git-gevent
$ mkdir rnd
$ for i in $(seq 1 20); do dd if=/dev/urandom of=rnd/$i.rnd bs=1M count=10; done
$ git init
Initialized empty Git repository in /tmp/kallithea-git-gevent/.git/
$ git add .
$ git remote add origin http://admin@localhost:5000/kallithea-git-gevent
$ git commit -m 'Initial commit'
[master (root-commit) 6b81bc4] Initial commit
 20 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 rnd/1.rnd
 create mode 100644 rnd/10.rnd
 create mode 100644 rnd/11.rnd
 create mode 100644 rnd/12.rnd
 create mode 100644 rnd/13.rnd
 create mode 100644 rnd/14.rnd
 create mode 100644 rnd/15.rnd
 create mode 100644 rnd/16.rnd
 create mode 100644 rnd/17.rnd
 create mode 100644 rnd/18.rnd
 create mode 100644 rnd/19.rnd
 create mode 100644 rnd/2.rnd
 create mode 100644 rnd/20.rnd
 create mode 100644 rnd/3.rnd
 create mode 100644 rnd/4.rnd
 create mode 100644 rnd/5.rnd
 create mode 100644 rnd/6.rnd
 create mode 100644 rnd/7.rnd
 create mode 100644 rnd/8.rnd
 create mode 100644 rnd/9.rnd
$ git push -u origin master
Password for 'http://admin@localhost:5000': 
Counting objects: 23, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (22/22), done.
error: RPC failed; result=55, HTTP code = 0
fatal: The remote end hung up unexpectedly
Writing objects: 100% (23/23), 200.06 MiB | 14.23 MiB/s, done.
Total 23 (delta 0), reused 0 (delta 0)
fatal: The remote end hung up unexpectedly
Everything up-to-date
```

## Server side
git version 2.4.3

```bash
2015-10-01 19:15:35.955 INFO  [kallithea.lib.auth_modules] Authenticating user using kallithea.lib.auth_modules.auth_internal plugin
2015-10-01 19:15:36.065 INFO  [kallithea.lib.auth_modules.auth_internal] user admin authenticated correctly
2015-10-01 19:15:36.071 INFO  [kallithea.lib.base] Access for IP:172.17.42.1 allowed
2015-10-01 19:15:36.109 INFO  [kallithea.lib.middleware.simplegit] push action on Git repo "test-git-gevent" by "admin" from 172.17.42.1
2015-10-01 19:15:36.133 INFO  [kallithea.RequestWrapper] IP: 172.17.42.1 Request to /test-git-gevent/git-receive-pack time: 0.254s
2015-10-01 19:15:36.269 INFO  [kallithea.RequestWrapper] IP: 172.17.42.1 Request to /test-git-gevent/git-receive-pack time: 0.004s
[2015-10-01 19:15:36 +0000] [15] [ERROR] Error handling request
Traceback (most recent call last):
  File "/srv/kallithea/venv/lib/python2.7/site-packages/gunicorn/workers/sync.py", line 130, in handle
    self.handle_request(listener, req, client, addr)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/gunicorn/workers/sync.py", line 171, in handle_request
    respiter = self.wsgi(environ, resp.start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/paste/gzipper.py", line 34, in __call__
    response.gzip_start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/paste/cascade.py", line 130, in __call__
    return self.apps[-1](environ, start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/paste/registry.py", line 379, in __call__
    app_iter = self.application(environ, start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/lib/middleware/wrapper.py", line 43, in __call__
    return self.application(environ, start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/lib/base.py", line 312, in __call__
    return self._handle_request(environ, start_response)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/lib/middleware/simplegit.py", line 69, in _handle_request
    if not self._check_ssl(environ):
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/lib/base.py", line 257, in _check_ssl
    if str2bool(Ui.get_by_key('push_ssl').ui_value):
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/model/db.py", line 354, in get_by_key
    return cls.query().filter(cls.ui_key == key).scalar()
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/orm/query.py", line 2215, in scalar
    ret = self.one()
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/orm/query.py", line 2184, in one
    ret = list(self)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/kallithea/lib/caching_query.py", line 83, in __iter__
    return Query.__iter__(self)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/orm/query.py", line 2227, in __iter__
    return self._execute_and_instances(context)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/orm/query.py", line 2242, in _execute_and_instances
    result = conn.execute(querycontext.statement, self._params)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/engine/base.py", line 1449, in execute
    params)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/engine/base.py", line 1584, in _execute_clauseelement
    compiled_sql, distilled_params
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/engine/base.py", line 1698, in _execute_context
    context)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/engine/base.py", line 1691, in _execute_context
    context)
  File "/srv/kallithea/venv/lib/python2.7/site-packages/sqlalchemy/engine/default.py", line 331, in do_execute
    cursor.execute(statement, parameters)
OperationalError: (OperationalError) disk I/O error u'SELECT ui.ui_id AS ui_ui_id, ui.ui_section AS ui_ui_section, ui.ui_key AS ui_ui_key, ui.ui_value AS ui_ui_value, ui.ui_active AS ui_ui_active \nFROM ui \nWHERE ui.ui_key = ?' ('push_ssl',)
```

## pip packages
```bash
(venv)# pip freeze
amqplib==1.0.2
anyjson==0.3.3
Babel==1.3
Beaker==1.6.4
celery==2.2.10
decorator==4.0.4
docutils==0.11
dulwich==0.9.9
FormEncode==1.2.6
funcsigs==0.4
gevent==1.0.2
greenlet==0.4.9
gunicorn==19.3.0
Kallithea==0.2.9
kombu==1.5.1
Mako==1.0.0
Markdown==2.2.1
MarkupSafe==0.23
mercurial==3.5.2
mock==1.3.0
nose==1.3.7
Paste==2.0.2
PasteDeploy==1.5.2
PasteScript==2.0.2
pbr==1.8.0
py-bcrypt==0.4
Pygments==2.0.2
Pylons==1.0.2
pyparsing==1.5.7
python-dateutil==1.5
pytz==2015.6
repoze.lru==0.6
Routes==1.13
simplejson==3.8.0
six==1.9.0
SQLAlchemy==0.7.10
Tempita==0.5.2
URLObject==2.3.4
waitress==0.8.8
WebError==0.11
WebHelpers==1.3
WebOb==1.1.1
WebTest==1.4.3
Whoosh==2.5.7
```
