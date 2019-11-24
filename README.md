# drone-aws-role-auth

## Store

Save the AWS credentials on Drone Secrets using this pattern:

```
${aws_access_key_id}.${aws_secret_access_key}
```

## Drone configuration examples

```yaml
kind: pipeline
name: main
steps:
  - name: get-aws-credentials
    image: neemiasjnr/drone-aws-role-auth
    settings:
      role: "***"
      file: .env
      credentials:
        from_env: aws_credentials

  - name: plan-infra
    image: jmccann/drone-terraform:6.0-0.12.6
    role_arn_to_assume: "***"
    root_dir: terraform
    env-file: .env
    actions:
      - validate
      - plan
    when:
      event: push
      branch:
        exclude: master
```
