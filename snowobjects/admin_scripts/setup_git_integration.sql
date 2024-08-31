use role accountadmin;

create or replace secret github_secret
    type = password
    username = '<Github Username>' 
    password = '<Personal Access Token>'; 

create or replace api integration git_api_integration
    api_provider = git_https_api
    api_allowed_prefixes = ('<Base Github URL>') 
    allowed_authentication_secrets = (github_secret)
    enabled = true;

create or replace git repository notebooksl
    api_integration = git_api_integration
    git_credentials = github_secret
    origin = '<REPOSITORY URL>';