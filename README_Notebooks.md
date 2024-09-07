
# 🚀 Welcome to the Snowflake Notebooks CI/CD Repo!

This repository demonstrates how to set up a CI/CD pipeline using GitHub Actions for Snowflake Notebooks. By integrating Snowflake with Git and automating notebook updates and executions, we can enhance the efficiency and reliability of our Data Engineering workflows.

![Snowflake Notebooks CI/CD](/media/GihutActionsSnow.png)
## Background

📅 On Friday, I saw this great video by Doris Lee, Product Manager at Snowflake. In the video, Doris explains how to set up Git integration with Snowflake for Notebooks. As a strong believer in the power of Notebooks within Snowflake for data engineering tasks, I was inspired to extend this setup.

After watching the video, I thought, what could make this integration even better? Well, you guessed it! 🤓 A CI/CD pipeline using GitHub Actions! Now, every time you commit something to the repository, the pipeline will automatically trigger, updating and executing the notebook.

## How to setup

### Connection from GitHub to Snowflake

First, make sure you follow the README.md instructions from main branch of this REPO.

### Setup Github Integration
Follow this great [video by Doris Lee](https://www.youtube.com/watch?v=4GOa1eUccmQ)

### In Snowflake 

Create a database called REPO_NOTEBOOKS, with schemas DEV an PROD

## Results

[Action Pipeline](.github/workflows/deploy_notebook_dev.yml) will be triggered whenever your commit to merge. Merge any changes and you will see the pipe running.

## Reasoning

The [pipeline](.github/workflows/deploy_notebook_dev.yml) calls the [template](.github/workflows/temp_deploy_notebook_to_env.yml) and passes the name of the environment, in this case dev.

**.github/workflows/temp_deploy_notebook_to_env.yml** Creates the Notebook in a schema based on the enviroment:

```bash
snow notebook create  ${{ env.SNOWFLAKE_NOTEBOOK_NAME }} .......  --schema  ${{ env.SNOWFLAKE_ENV }}
```

Then the [notebook](Notebooks/DemoCount/Notebook1.ipynb)  is aware of the enviroment via this code that leverages the session.

```python
from snowflake.snowpark.context import get_active_session
session = get_active_session()
schema = session.get_current_schema()
print(schema)
MODE = schema 
# Now we know which schema , that defines if is DEV or PROD
if (MODE != "DEV") & (MODE != "PROD"):
    # default to dev
    MODE = "DEV"
   

    
if MODE == "DEV":
    # For development, use XSMALL warehouse on TPCH data with scale factor of 1
    warehouse_name = "GIT_EXAMPLE_DEV_WH"
    schema_name = "TPCH_SF1"
    size = 'XSMALL'
elif MODE == "PROD": 
    # For production, use LARGE warehouse on TPCH data with scale factor of 100
    warehouse_name = "GIT_EXAMPLE_PROD_WH"
    schema_name = "TPCH_SF100"
    size = 'LARGE'
```