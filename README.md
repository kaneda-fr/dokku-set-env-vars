# dokku-set-env-vars

This action set Dokku environment variables (dokku config:set)

## Inputs

### ssh-private-key

The private ssh key used for Dokku deployments. Never use as plain text! Configure it as a secret in your repository by navigating to https://github.com/USERNAME/REPO/settings/secrets

**Required**

### dokku-user

The user to use for ssh. If not specified, "dokku" user will be used.

### dokku-host

The Dokku host to deploy to.

### app-name

The Dokku app name to be deployed.

### var-name

The name of the environment variable to set

### var-value

The value of the environment variable to set

### app-restart

Trigger restart of the app when config is changed. If not set to false, application will be restarted.

## Example

Note: `actions/checkout` must preceed this action in order for the repository data to be exposed for the action.
It is recommended to pass `actions/checkout` the `fetch-depth: 0` parameter to avoid errors such as `shallow update not allowed`

```
steps:
  - uses: actions/checkout@v2
    with:
        fetch-depth: 0
  - id: deploy
    name: Deploy to dokku
    uses: kaneda-fr/dokku-set-env-vars@v1
    with:
        ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}
        dokku-host: 'my-dokku-host.com'
        app-name: 'my-dokku-app'
        var-name: 'backend-url'
        var-value: 'my-backend-host.com'
```
