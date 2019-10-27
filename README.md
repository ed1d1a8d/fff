# FFF

Free for Food?\
Yang Yan, Stella Yang, Jing Lin, Tony Wang

An app to help connect friends or strangers looking to get food at the same time!

## Branches

`production` is deployed live with 30s CI-CD. It is one commit ahead.

## django

### Endpoints

Endpoint|Purpose
-|-
`/auth/login`|Login and get a session token (which never expires).
`/auth/registration`|Create a new user.
`/auth/user`|Get information about currently logged in user.
`/auth/facebook`|Login with a Facebook token. Pass the FB token in the header field `access_token`.
`/api/friends`|List of friends of current user and all data in JSON format.
`/api/friends/requests/unread`|JSON of unread friend requests or 400.
`/api/friends/requests/unrejected`|JSON of unrejected friend requests or 400.
`/api/friends/actions/info/x`|JSON information about friend with pk x, or 400 if not friends.
`/api/friends/actions/request/x`|200 or 400 to request a friendship with user with pk x.
`/api/friends/actions/accept/x`|200 or 400 to accept a friendship request from user with pk x.
`/api/friends/actions/decline/x`|200 or 400 to decline a friendship request from user with pk x.
`/api/friends/actions/remove/x`|200 or 400 to remove a friend with pk x.

Add `.json` suffix to an endpoint to get the JSON version instead of HTML version i.e. `/auth/user.json`.

This endpoints list may not always be up to date. Please refer to the *self-documenting* code for more info.

### Commands

* `pg_ctl -D /usr/local/var/postgres start`
* `pg_ctl -D /usr/local/var/postgres stop`
* `brew services restart postgresql`

### AWS

`/deploy/fff-1.pem` contains the gitignored AWS private key. Check Drive for a copy.
