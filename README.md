# Snowflake Connection via CLI with GitHub Actions

[![deploy using snowflake-cli](https://github.com/MiguelElGallo/SnowCLI/actions/workflows/snowflake_workflow.yml/badge.svg)](https://github.com/MiguelElGallo/SnowCLI/actions/workflows/snowflake_workflow.yml)

## Purpose

This repository demonstrates how to connect to Snowflake using the [new CLI](https://docs.snowflake.com/en/developer-guide/snowflake-cli-v2/index) with key pair authentication from GitHub Actions.

## Steps to Run

### 1. Set Up Key Pair Authentication

Follow the steps in the [Snowflake documentation](https://docs.snowflake.com/en/user-guide/key-pair-auth) to set up key pair authentication. This involves generating a private and public key pair and configuring them for use with Snowflake.

### 2. Create Secrets in GitHub Repo

In your GitHub repository, create the following secrets:

- `SNOWSQL_PRIVATE_KEY_PASSPHRASE`: The passphrase for your Snowflake private key.
- `SNOW_SQL_PRIVATE_KEY`: The private key for Snowflake.
- `SNOW_SQL_PUBLIC_KEY`: The public key for Snowflake.
- `SNOW_SQL_ACCOUNT`: Your Snowflake account identifier.
- `SNOW_SQL_USER`: Your Snowflake username.

### 3. Create a database

In your snowflake account create a database called ***STREAMLIT_DB*** or whatever you decide to put in the file: snowobjects/streamlit/app1/demo_st_app/snowflake.yml

***Note:*** There is a file calle config.toml that has a dummy user name and password, the existence of the file seems to be mandatory, but the values inside the file are not used
To create these secrets, navigate to your repository on GitHub, go to **Settings** > **Secrets and variables** > **Actions**, and add each secret.

### 4. Run the GitHub Action

Run the GitHub Action defined in `.github/workflows/snowflake_workflow.yml` that is part of this repository. This workflow will use the secrets you created to authenticate and connect to Snowflake.

To manually trigger the workflow, you can use the GitHub Actions tab in your repository, select the `snowflake_workflow.yml` workflow, and click on "Run workflow".

The sreamlit application will be deployed.

## The GitHub Action

In this part

```json
        # Write SNOWSQL_PRIVATE_KEY to a file

        - name: Write private key
          run: echo "$SNOWSQL_PRIVATE_KEY" > private_key.pem
```

The key is written to a file in the runner, because I did not find any other way to pass the key to Snow CLI.

This last lines does the streamlit deployment>

```json
snow streamlit deploy --replace --connection cicd --private-key-path $GITHUB_WORKSPACE/private_key.pem --account $SNOW_SQL_ACCOUNT --user $SNOW_SQL_USER --authenticator SNOWFLAKE_JWT --database STREAMLIT_DB --schema PUBLIC
```
