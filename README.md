# readme-writer

[![License](https://img.shields.io/badge/license-Apache2-brightgreen.svg)](LICENSE)

`readme-writer` automatically fetches the data from your Wakatime and GitHub APIs and updates your GitHub.com profile page. It does so using a GitHub workflow with `readme-writer` in a Docker container.

## Features

* GitHub action `readmeUpdateAction.yml` that triggers once a day and updates your GitHub profile
* docker container [readme-writer] that runs Alpine Linux and contains script and all it's dependencies
* `readme-writer` bash script fetches Wakatime, GitHub user data
* Uses REST API and GraphQL API
* you want to see more APIs integrated? let me know

## Setup

### 1. Create and Add Tokens

1. Create a GitHub Personal Access Token in your [Developer Settings] and give it the following scopes: `public_repo, read:org, read:user, repo:status`
2. Go to your GitHub Profile Repo. Or if you don't have it yet create a Repo and name it like your username.
  1. Go to the Repos settings `https://github.com/yourUsername/yourUsername/settings` and under `Secretes and variables`, `Actions`  create a new secret. The Name should be 'PERSONAL_GITHUB_TOKEN' and the Secret/value is your GitHub Token that you just created.
1. Optionally Create a Wakatime account and follow their setup procedure if you want to display Wakatime stats on your profile.
  1. On the Wakatimes website in the Settings you can find your API key. Copy it and go to create another Secret on your profile Repo Settings. Name it 'PERSONAL_WAKATIME_KEY' and paste the key into Secret/value.

### 2.1 Create Files: Local Machine

1. Clone your GitHub Repo to your machine and `cd` into it
1. Create a folder: `mkdir .github/workflows`
1. Download the action: `curl -LJ https://raw.githubusercontent.com/SimonWoodtli/readme-writer/main/readmeUpdateAction.yml -o .github/workflows/readmeUpdateAction.yml`
1. Create another folder: `mkdir templates`
  1. If you already have a README.md copy&paste it into it `cp README.md templates/README.md.tpl`
  1. If you just created your GitHub Profile Repo: `touch templates/README.md.tpl`
  1. From here on out you won't be adding anything into the regular README.md. Because it will get overwritten by the action. So instead add the information in the README.md.tpl.
  1. Finally write all the html-comments, about auto fetched data you would like to display into README.md.tpl. Checkout the Example to see how.
  1. add, commit and push it

### 2.2 Create Files: Website

If you don't know what these commands are in '2.1' fear not. All these things can be done on the GitHub website. You can easily create folders and files and copy paste stuff on the website.

1. Go to your GitHub Profile Repo page
2. Create a folder/file 'Add files' then name it '.github/workflows/readmeUpdateAction.yml' and copy/paste [readmeUpdateAction.yml] content into it. Then Give it a commit title/message and commit it to the main branch.
3. Create another folder/file the same way but name it 'templates/README.md.tpl' and if you already have a profile copy/paste the content from README.md in there.
  1. From here on out you won't be adding anything into the regular README.md. Because it will get overwritten by the action. So instead add the information in the README.md.tpl.
  1. Finally write all the html-comments, about auto fetched data you would like to display into README.md.tpl. Checkout the Example to see how.


[html-comments]:<???>
[readmeUpdateAction.yml]:<https://raw.githubusercontent.com/SimonWoodtli/readme-writer/main/readmeUpdateAction.yml>
[Developer Settings]:<https://github.com/settings/tokens>

<details>
  <summary><b>Automated GitHub Profile Markdown Example</b></summary>
## 👋 &nbsp;Hey there! This is an automated example Profile

Checkout [readme-writer](https://github.com/SimonWoodtli/readme-writer)
for setup instructions!

These titles are just to showcase and categorize. You can write your own titles only the html-comments are relevant.

## GitHub Graphql

### My personal Projects

<!--github-projectsOwn-start-->
<!--github-projectsOwn-end-->

### All Projects I'm recently working on

<!--github-projectsAll-start-->
<!--github-projectsAll-end-->

### Total Repositories I own

<!--github-projectsCount-start-->
<!--github-projectsCount-end-->

### Up for Hire

<!--github-hire-start-->
<!--github-hire-end-->

### My recent Pull Requests

<!--github-pullRequests-start-->
<!--github-pullRequests-end-->

### My recent zet notes

<!--github-zet-start-->
<!--github-zet-end-->

### My recent forks

<!--github-forks-start-->
<!--github-forks-end-->

### My recent stars

<!--github-stars-start-->
<!--github-stars-end-->

### My recent gists

<!--github-gists-start-->
<!--github-gists-end-->

### My recent followers

<!--github-followers-start-->
<!--github-followers-end-->

### My recent sponsors

<!--github-sponsors-start-->
<!--github-sponsors-end-->

### My most used languages

<!--github-languages-start-->
<!--github-languages-end-->

### My most productive day last year

<!--github-productiveDay-start-->
<!--github-productiveDay-end-->

### My most productive time last year

<!--github-productiveTime-start-->
<!--github-productiveTime-end-->


## Wakatime API

### Lately I have been working with the following languages

<!--wakatime-languages-start-->
<!--wakatime-languages-end-->

### Lately I have been working in the following projects

<!--wakatime-projects-start-->
<!--wakatime-projects-end-->

### Lately I have been working with the following editors

<!--wakatime-editors-start-->
<!--wakatime-editors-end-->

### Lately I have worked with the following operating systems

<!--wakatime-operating_systems-start-->
<!--wakatime-operating_systems-end-->

### My current timezone

<!--wakatime-timezone-start-->
<!--wakatime-timezone-end-->
</details>

<details>
  <summary><b>Automated GitHub Profile Rendered Markdown Example</b></summary>

</details>



## Challenges

```
## if changes get made to the script this will always fetch the
## newest version. If you fetch script from within Dockerfile you need to
## update the container and push it to registry each time you do make
## changes to the script.

#- name: Checkout Project - Mount Repo into Docker Container
##KNOWLEDGE: either have `- name:\nuses:` but you cant have `run:`
## If you need uses and run together ommit `- name:`, and go with `- uses:\n- run:`

## If you don't want to use actions/checkout@v3 this is an
## alternative to mount content of the repo into docker.
## here it will mount it to /root
#options: -v ${{ github.workspace }}:/root
```

This project automatically fetches API data with a github action. `readme-writer` does so by reading a template readme file. In the template it looks for keywords (html-comments) and replaces the keywords with the found API data. At the end it updates your github profile README.md page.


## What would I have done differently next time?

Once I wrote the script and it was working locally, I should have forked it to play around with github action and docker. Since prior to this project I never really used either of these technologies. Therefor I have a lot of commits and testing and debugging on the `readme-scraper` repo.

I should have looked into perl earlier text manipulating hero no. 1! I struggled to get a version working that until the end only kind of worked but still had some issues. And was quite complicated, with perl I wouldn't say it was a breeze but that is because prior to this project I've never used it. Once you understand how regex, substitute work with perl it's actually just a simple one liner.

I should have started with debug commands earlier in order to figure out what commands and github actions on my workflow actually did. I don't know for some reason the whole github workflow thing felt like some "magic" that just does things and gives bad feedback if something throws an error. And I was frustrated by it because I am so used to work on my local computer and the shell there so I know how to debug stuff there. But at the end of the day it's just a remote linux VM that executes unix commands, but it feels like a new environment. Especially because you also need to use the github webpage in order to see what is going on. Github actions are just a template for another set of commands or "workflow" so you don't have to write them in your own workflow.

Since I never used github action before it would have probably also been better to start with a project that did not rely on Docker and only uses an ubuntu VM. That complexity was really challenging and frustrating, which is also why I took a couple of breaks on this project. But hey I persevered and it's finally working 🎉

[readme-writer]:<https://hub.docker.com/r/simonwoodtli/readme-writer>
