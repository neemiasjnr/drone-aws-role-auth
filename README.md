# drone-aws-role-auth

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
```

## Passing the credentials from Drone Secrets (new syntax)

Save the AWS credentials on Drone Secrets using this pattern:

```
${aws_access_key_id}.${aws_secret_access_key}
```

```yaml
kind: pipeline
name: main
steps:
  - name: get-aws-credentials
    image: nodefortytwo/drone-aws-role-auth
    settings:
      role: "***"
      file: .env
      credentials:
        from_env: aws_credentials
```
