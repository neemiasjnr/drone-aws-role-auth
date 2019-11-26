# drone-aws-role-auth

## Usage

### Parameters

#### role

The IAM role you created with admin access

#### file

The name of the file that will contain the session credentials

#### file_format

Default: sh

- sh: save with **export** before the variables to be used with **source** command
- dotenv: save as dotenv format to be loaded by [godotenv](https://github.com/joho/godotenv) or [dotenv](https://www.npmjs.com/package/dotenv)

### Environment Variables

#### plugin_credentials (optional)

Save a env variable on Drone Secrets containing the credentials to generate the session tokens. The secret should be saved using this pattern:

```
AWS_ACCESS_KEY_ID.AWS_SECRET_ACCESS_KEY
```

This is useful for open souce projects that uses Cloud Drone, and you can't save the /.aws/credentials file on the hosted machine.

## Drone configuration examples

```yaml
pipeline:
  deploy:
    image: nodefortytwo/drone-aws-role-auth
    role: arn:aws:iam::***:role/***
```

```yaml
pipeline:
  deploy:
    image: nodefortytwo/drone-aws-role-auth
    role: arn:aws:iam::***:role/***
    file: .creds
    file_format: sh
```

### Passing the credentials from Drone Secrets

```yaml
pipeline:
  deploy:
    image: nodefortytwo/drone-aws-role-auth
    role: arn:aws:iam::***:role/***
    file: .creds
    file_format: dotenv
    secrets:
      - source: [YOUR_CREDENTIAL_SECRET]
        target: plugin_credentials
```

or using the new syntax

```yaml
kind: pipeline
name: main
steps:
  - name: deploy
    image: nodefortytwo/drone-aws-role-auth
    settings:
      role: arn:aws:iam::***:role/***
      file: .creds
      file_format: dotenv
    environment:
      PLUGIN_CREDENTIALS:
        from_secret: YOUR_CREDENTIAL_SECRET
```
