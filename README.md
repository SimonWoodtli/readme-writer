# Wakatime Stats

[![WIP](https://img.shields.io/badge/status-wip-red)](https://img.shields.io/badge/status-wip-red)
[![wakatime](https://wakatime.com/badge/user/173067c8-7ded-4cfb-8605-b3032659c00c/project/b4396c85-9a02-4fd4-8228-1ef7a4d6d378.svg)](https://wakatime.com/badge/user/173067c8-7ded-4cfb-8605-b3032659c00c/project/b4396c85-9a02-4fd4-8228-1ef7a4d6d378)

Fetch the data from your wakatime API and update your your github.com profile page with a github action.

***💥 DEPRECATED: Use [`readme-writer`] instead***

[readme-writer]: <

## Features

* wakatime API

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

## What would I have done differently next time?

Once I wrote the script and it was working locally, I should have forked it to play around with github action and docker. Since prior to this project I never really used either of these technologies. Therefor I have a lot of commits and testing and debugging on the `readme-scraper` repo.

I should have looked into perl earlier text manipulating hero no. 1! I struggled to get a version working that until the end only kind of worked but still had some issues. And was quite complicated, with perl I wouldn't say it was a breeze but that is because prior to this project I've never used it. Once you understand how regex, substitute work with perl it's actually just a simple one liner.

I should have started with debug commands earlier in order to figure out what commands and github actions on my workflow actually did. I don't know for some reason the whole github workflow thing felt like some "magic" that just does things and gives bad feedback if something throws an error. And I was frustrated by it because I am so used to work on my local computer and the shell there so I know how to debug stuff there. But at the end of the day it's just a remote linux VM that executes unix commands, but it feels like a new environment. Especially because you also need to use the github webpage in order to see what is going on. Github actions are just a template for another set of commands or "workflow" so you don't have to write them in your own workflow.

Since I never used github action before it would have probably also been better to start with a project that did not rely on Docker and only uses an ubuntu VM. That complexity was really challenging and frustrating, which is also why I took a couple of breaks on this project. But hey I persevered and it's finally working 🎉

## Github Action

```
## Name of the Workflow
name: CI to update the README.md of your github profile
## Events to trigger Action:
on:
  ## If you make a manual push
  push:
  schedule:
    ## If it is midnight, cronjob runs once per day
    - cron: "0 0 * * *"
## Jobs groups a set of actions to get executed
jobs:
  ## Name of first job/group with its actions
  build:
    runs-on: ubuntu-latest
    ## Docker container to be pulled, the following steps are executed
    ## within running docker container and busybox shell (cause Alpine)
    container:
      image: simonwoodtli/readme-writer:latest
      ## Github Secrets to be passed to the Container as env. variables
      env:
        GITHUB_TOKEN: ${{ secrets.PERSONAL_GITHUB_TOKEN }}
        WAKATIME_API_KEY: ${{ secrets.WAKATIME_API_KEY }}
        MY_SECRET: ${{ secrets.MY_SECRET }}
    ## Actual actions
    steps:
      ## 1. checkout mounts the content of the repo into the github
      ## action, if you use a docker container like here it will mount it
      ## in $GITHUB_WORKSPACE which is /__w/nameOfRepo/nameOfRepo
      - uses: actions/checkout@v3
      - run: |
        ##HOTFIX this is required until I figure out why there are two
        ## owners `ntp` and `root` in $GITHUB_WORKSPACE
        ## It also makes not much sense as github checkout action
        ## already uses this safe.dir command itself, oh well...
        ## debugging was weird until I used `git remote -v` I just got
        ## no git repo errors, even though `ls -lah $GITHUB_WORKSPACE`
        ## clearly showed the .git repo so it wasn't an API download but
        ## the checkout action used a git clone.
          git config --global --add safe.directory /__w/readme-scraper/readme-scraper
      ## 2. run script
      - name: Run Script - Update README.md
        run: |
          #readme-scraper /__w/readme-scraper/readme-scraper/templates/preTemplateReadme.md.tpl /__w/readme-scraper/readme-scraper/templates/README.md.tpl
          readme-scraper templates/preTemplateReadme.md.tpl templates/README.md.tpl
      ## 3. push update
      - name: Git Push updated README.md
        run: |
          git config user.name readme-writer 🤖
          git config user.email actions@github.com
          git add .
          git commit -m "📝 update auto-generated README.md"
          git push origin main
```

## TODO

* add github API to fetch github stats
