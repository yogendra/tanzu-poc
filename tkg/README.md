# TKG PoC

These scripts assume:

1. SE has an AWS account
1. There is a poc hosted zone on route 53
1. TKG 1.1.2+
1. vSphere
1. Get a jumpbox IP from client
1. Internet Restricted Environment.
1. SE Workstation is setup with AWS cli access

## Required Tools

SE Workstation

- bash
- aws cli
- [lego](https://github.com/go-acme/lego/releases)
- curl

Client Jumpbox

- bash
- curl
- sudo and sudoer permission
- jq
- yq
- tkg

All tools, except tkg, are installed by jumpbox initialization script

## Setup `.env-private`

Automated setup

- Run init env script

  ```
  ./00-init-env.sh
  ```

Alternatively, you can setup `.env-private` manually

- Create a `.env-private` file

  ```
  touch .env-private
  ```

- Edit `.env-private` and add following settings

  - Set client name

    ```
    CLIENT=super-tech
    ```

  - Set Jumpbox IP (one provided by client)

    ```
    JUMPBOX_IP=10.1.2.3
    ```

  - Set POC Domain. This is generally one domain that you would use for multiple POC. Every client will have a subdomain under this.

    ```
    POC_DOMAIN=poc.yogendra.me
    ```

  - Set AWS Hosted Zone ID. Get it from [AWS Console](https://console.aws.amazon.com/route53/v2/hostedzones)

    ```
    AWS_HOSTED_ZONE_ID=XYZABCD
    ```

  - Set Email for Let's Encrypt certificate

    ```
    CERT_EMAIL=myemail@mydomain.com
    ```

## Prepare on SE workstation (Mac/Windows WSL)

- Create certificates

  ```
  ./01-generate-cert.sh
  ```

- Update dns record for local-registry

  ```
  ./02-update-route54.sh
  ```

- Send certificates to client. There will be a `ROOT_DOMAIN-certificates.tar.gz` in the poc dir

## On client site

- Init Jumpbox

  ```
  ./03-init-jumpbox.sh
  ```

- Run registry on jumpbox

  ```
  ./04-run-registry.sh
  ```

- Migrate images

  ```
  ./05-migrate-images.sh
  ```

- Update `~/.tkg` config

  ```
  ./06-update-config.sh
  ```

- Install TKG Management Cluster

  ```
  tkg init --infrastructure vsphere --ui
  ```

  Or any other advance init command that suites your env.
