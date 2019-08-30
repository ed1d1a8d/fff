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
`/users/friends`|List of friends of current user and all data in JSON format.
`/users/friends/requests/unread`|JSON of unread friend requests or 400.
`/users/friends/requests/unrejected`|JSON of unrejected friend requests or 400.
`/users/friends/actions/info/x`|JSON information about friend with pk x, or 400 if not friends.
`/users/friends/actions/request/x`|200 or 400 to request a friendship with user with pk x.
`/users/friends/actions/accept/x`|200 or 400 to accept a friendship request from user with pk x.
`/users/friends/actions/decline/x`|200 or 400 to decline a friendship request from user with pk x.
`/users/friends/actions/remove/x`|200 or 400 to remove a friend with pk x.

Add `.json` suffix to an endpoint to get the JSON version instead of HTML version i.e. `/auth/user.json`.

### AWS

`/deploy/fff-1.pem` contains the gitignored AWS private key. Check Drive for a copy.
