# Free for Food (FFF)

Project by Yang Yan, Stella Yang, Jing Lin, and Tony Wang.

An app that lets you find friends near you who are available right now to grab a meal with. Grabbing a meal is really just a proxy for hanging out.

## Secrets

Secrets are available via the link <https://drive.google.com/drive/folders/1U_5gPiPYDzk3eNVXlqUZNAM9XGK7QQTM?usp=sharing>.

## Front-end

FFF builds for both iOS and Android using Flutter.

## Back-end

FFF runs a Django backend on an AWS EC2 instance managed by Yang. The Django server is tunneled via an HTTP multiplexer to the backend URL <https://mus.icu> with the command:

```bash
ssh -p 2222 -R mus.icu:80:127.0.0.1:8000 gilgamesh.cc
```

Both the tunnel and the Django server run on the same instance, accessible via the command:

```bash
ssh mus_icu@gilgamesh.cc
```

The password is the secret `$BACKEND_PASSWORD`.

### Branches

The backend runs on the `production` branch, which is `master` but one commit ahead, turning off `DEBUG` mode for the Django server.
