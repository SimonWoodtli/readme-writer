# readme-writer

[![WIP](https://img.shields.io/badge/status-wip-red)](https://img.shields.io/badge/status-wip-red)

Once per day `readme-writer` automatically fetches the data from your wakatime and github API and updates your github.com profile page. It does so using a github workflow with `readme-writer` in a Docker container.

## Features

* wakatime API

## TODO

* github API

## Setup

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
