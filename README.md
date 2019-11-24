# drone-aws-role-auth

## Store

Save the AWS credentials on Drone Secrets using this pattern:

```
${aws_access_key_id}.${aws_secret_access_key}
```

## Drone configuration examples

```yaml
kind: pipeline
name: deploy
steps:
  - get-aws-credentials:
    image: neemiasjnr/drone-aws-role-auth
    role: arn:aws:iam::***:role/***
    file: /env/.aws
    credentials:
      from_env: aws-credentials

  - plan-infra:
    image: jmccann/drone-terraform:6.0-0.12.6
    role_arn_to_assume: "***"
    root_dir: terraform
    volumes:
      - name: credentials
        path: /env
    env-file: /env/.aws
    actions:
      - validate
      - plan
    when:
      event: push
      branch:
        exclude: master

volumes:
  - name: credentials
    temp: {}
```
