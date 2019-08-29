# fff

FFF

## Branches

`production` is deployed live with 30s CI-CD. It is one commit ahead.

## django

Endpoint|Purpose
-|-
`/auth/login`|Login and get a session token (which never expires).
`/auth/registration`|Create a new user.
`/auth/user`|Get information about currently logged in user.

Add `.json` suffix to an endpoint to get the JSON version instead of HTML version i.e. `/auth/user.json`.

### AWS

`/production/fff-1.pem` contains the gitignored AWS private key. Check Drive for a copy.
