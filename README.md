
# Vania Dart backend framework

![Vania](https://vdart.dev/img/logo.png)

[Documentation](https://vdart.dev)

[Github](https://github.com/vania-dart/framework)

[pub.dev](https://pub.dev/packages/vania)

YouTube Video [Quick Start](https://www.youtube.com/watch?v=k8ol0F4bDKs)

[![Quick Start](http://img.youtube.com/vi/k8ol0F4bDKs/0.jpg)](https://www.youtube.com/watch?v=k8ol0F4bDKs "Quick Start")


## Rename .env.example file to .env
```bash
.env
```

For user token storage
```bash
vania make:auth
```

## make new project
```bash
vania create project_name

eg. vania create todo

```

## make migrations
```bash
vania make:migration migration_name

eg. vania make:migration create_user_product
```

## make model
```bash
vania make:model model_name

eg. vania make:model product
```
## run migtations
```bash
vania migrate
```

## run serve
```bash
vania serve
```

## Generate a Private Key

Open a Git bash and run:
```bash

openssl genpkey -algorithm RSA -out private_key.pem -aes256 -pass pass:yourpassword

```
This command generates a private key and saves it to private_key.pem. You will be prompted to set a passphrase to protect the key.

## Extract the Public Key

Extract the public key from the private key:

```bash
openssl rsa -pubout -in private_key.pem -out public_key.pem -passin pass:yourpassword

```

## View or Use Keys

You can view your private key with:

```bash
cat private_key.pem
```
And the public key with:

```bash
cat public_key.pem
```
