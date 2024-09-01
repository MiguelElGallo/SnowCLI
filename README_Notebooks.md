
# 🚀 Welcome to the Snowflake Notebooks CI/CD Repo!

This repository demonstrates how to set up a CI/CD pipeline using GitHub Actions for Snowflake Notebooks. By integrating Snowflake with Git and automating notebook updates and executions, we can enhance the efficiency and reliability of our Data Engineering workflows.

## Background

📅 On Friday, I saw this great video by Doris Lee, Product Manager at Snowflake. In the video, Doris explains how to set up Git integration with Snowflake for Notebooks. As a strong believer in the power of Notebooks within Snowflake for data engineering tasks, I was inspired to extend this setup.

After watching the video, I thought, what could make this integration even better? Well, you guessed it! 🤓 A CI/CD pipeline using GitHub Actions! Now, every time you commit something to the repository, the pipeline will automatically trigger, updating and executing the notebook.

## How to setup

### Connection from GitHub to Snowflake

First, make sure you follow the README.md instructions from main branch of this REPO.

### Setup Github Integration
Follow this great [video by Doris Lee](https://www.youtube.com/watch?v=4GOa1eUccmQ)

### In Snowflake 

Create a database called REPO_NOTEBOOKS 

## Results

[Action Pipeline](.github/workflows/deploy_notebook_dev.yml) will be triggered whenever your commit to merge. Merge any changes and you will see the pipe running.
