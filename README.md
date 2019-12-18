# Free for Food (FFF)

Project by Yang Yan, Stella Yang, Jing Lin, and Tony Wang.

An app that lets you find friends near you who are available right now to grab a meal with. Grabbing a meal is really just a proxy for hanging out.

## Secrets

Secrets are available via the link <https://drive.google.com/drive/folders/1U_5gPiPYDzk3eNVXlqUZNAM9XGK7QQTM?usp=sharing>.

In addition to cloning the repository, several secret files need to be imported from the folder `secret-files` via the link. Relative to the root repository directory, these files are:

`secret-files` path|Repository path
-|-
`Secret.swift`|`/fff_ios/Secret.swift`
`django_secret_key.py`|`/django/fff/django_secret_key.py`
`add_mock_data_secrets.py`|`/django/api/management/commands/add_mock_data_secrets.py`

## Front-end

FFF builds for both iOS and Android using Flutter.

## Back-end

FFF runs a Django backend on an AWS EC2 instance managed by Yang. The Django server is tunneled via an HTTP multiplexer to the backend URL <https://mus.icu> with the command:

```bash
ssh -p 2222 -R mus.icu:80:127.0.0.1:8000 gilgamesh.cc
```

Substitute 8000 with whatever port Django runs on. Both the tunnel and the Django server run on the same instance, in separate `tmux` sessions. The instance is accessible via the command:

```bash
ssh mus_icu@gilgamesh.cc
```

The password is the secret `$BACKEND_PASSWORD`.

The Django server should be run with:

```bash
./manage.py runserver --noreload
```

to prevent too much CPU load.

The backend runs at <https://mus.icu> because that is a domain we bought before realizing we want to do `FFF` instead of `mus-icu` as our Hack Lodge project.

## Branches

The backend runs on the `production` branch, which is `master` but one commit ahead, turning off `DEBUG` mode for the Django server and making the reset script not add mock data.

## Database

Django interfaces with a Postgres server on the backend. These are the instructions to setting up the Postgres server:

```bash
cd django
pip install -r requirements.txt
sudo apt-get install postgresql postgresql-contrib python-psycopg2 libpq-dev
sudo su - postgres
createuser -P fff
psql postgres
ALTER USER fff CREATEDB;
\q
exit
./reset_and_add_mock_data.sh
```

The Postgres user `fff` should have password `$POSTGRES_FFF_PASSWORD`, available as a secret. Postgres should run on the default port. When installing Postgres, the local user `postgres` should have password `password` for clarity.

On OSX with Brew, Postgres can be installed via:

```bash
brew install postgresql
```

On Windows, each command should be run with `-U postgres` instead of prepending commands with `sudo su - postgres`.

## Endpoints

### Unauthenticated endpoints

Route|Usage
-|-
`/`|404
`/dumb/`|Returns status `200`, with only the word "dumb". Used for sanity checks.
`/favicon.ico/`|Favicon for the backend. Not used.
`/admin/`|Default Django admin panel. Superuser login required.
`/auth/login/`|Login with user credentials. Note token.
`/auth/facebook/`|Login to FFF with a Facebook token to retrieve the FFF `$TOKEN`.

### Authenticated endpoints

All authenticated routes require an `Authorization` header, with the value `Token $TOKEN`, where `$TOKEN` is obtained via logging in.

Route|Usage
-|-
`/api/dumb/`|Returns status `2xx` if authenticated, otherwise an error status (`4xx`). Used to test if token is valid.
`/api/self/detail/`|Properties of the authenticated user.
`/self/device/<str:registration_id>/`|Subscribe or unsubscribe device from notifications.
`/lobby/expiration/`|Get or set lobby expiration time.
`/lobby/friends/`|Get set of all friends in lobby.
`/ffrequests/create/`|Create a new FF request (request to eat with friend).
`/ffrequests/incoming/<str:status>/`|Get set of incoming FF requests.
`/ffrequests/outgoing/<str:status>/`|Get set of outgoing FF requests.
`/ffrequests/respond/<int:pk>/<str:action>/`|Respond to an incoming FF request.
`/ffrequests/cancel/<int:pk>/`|Cancel an outgoing FF request.
`/ffrequests/search_friend_request/<int:other_pk>/`|Get the FF request associated with a given friend (incoming or outgoing).
`/ffrequests/accepted_and_unread/`|View all outgoing FF requests which have been accepted by the other party, but have not been notified locally yet. Used to pop-up a notification when the friend accepts an outgoing FF request.
`/friends/friends/`|Returns the set of user's friends.
`/friends/nonfriends/`|Returns the list of all users which are not friends and have not been sent a friend request.
`/friends/fbfriends/`|Returns a list of user's Facebook friends also on FFF.
`/friends/requests/<str:action>/`|Get incoming or outgoing friend requests.
`/friends/actions/<str:action>/<int:pk>/`|Create, accept, decline, or cancel incoming or outgoing friend requests.
`/friends/bulkadd/`|Bypass friend requests system and add a set of users as friends.
`/api/mockdata/generate_for_user/`|Generate mock data for logged-in user. Only useful for debugging.
