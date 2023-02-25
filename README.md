# readme-writer

[![License](https://img.shields.io/badge/license-Apache2-brightgreen.svg)](LICENSE)

`readme-writer` automatically fetches the data from your Wakatime and GitHub
APIs and updates your GitHub.com profile page. This is done using a custom
GitHub workflow with the `readme-writer` script in a Docker container.

## Features

* GitHub action `readmeUpdateAction.yml`, which is triggered once per day and
  updates your GitHub profile
* Docker container [readme-writer], running Alpine Linux and containing the
  script and all its dependencies
* Bash script `readme-writer` that reads from a template and writes data to
  README.md
* Uses Wakatime REST API and GitHub GraphQL API to fetch user data
* You want to see more APIs integrated? let me know

## Installation

### 1. Create and Add Tokens

1. Create a GitHub Personal Access Token (Classic) in your [Developer Settings]
   and give it the following scopes: `public_repo, read:org, read:user,
   repo:status`
1. Go to your GitHub profile repo. Or if you don't have it yet, create a repo
   and name it like your username.
    1. Go to the Repos settings
       `https://github.com/yourUsername/yourUsername/settings` and under
       `Secrets and variables`, `Actions`  create a new secret. The Name should
       be 'PERSONAL_GITHUB_TOKEN' and the Secret/value is your GitHub Token you
       just created.
1. Optionally Create a Wakatime account and follow the setup procedure if you
   want to view Wakatime statistics in your profile.
    1. On the Wakatimes website, you can find your API key in the Settings.
       Copy it and go to create another Secret in your profile repo Settings.
       Name it 'PERSONAL_WAKATIME_KEY' and paste the key into Secret/value.

### 2.1 Create Files: Local Machine

1. Clone your GitHub Repo to your machine and `cd` into it
1. Create a folder: `mkdir .github/workflows`
1. Download the action: `curl -LJ
   https://raw.githubusercontent.com/SimonWoodtli/readme-writer/main/readmeUpdateAction.yml
   -o .github/workflows/readmeUpdateAction.yml`
1. Create another folder: `mkdir templates`
    1. If you already have a README.md, copy it to the new folder: `cp
       README.md templates/README.md.tpl`
    1. If you just created your GitHub profile repo: `touch
       templates/README.md.tpl`
    1. From now don't write anything into the regular README.md.
       This is because it will be overwritten by the action. So instead, add
       new information to be displayed on your profile page to the
       README.md.tpl file.
    1. Finally, select the data you want to display in your profile page and
       write its HTML comment in the README.md.tpl file. Take a look at the
       [Example] to see how.
    1. add, commit and push it

### 2.2 Create Files: Website

If you don't know what these commands are in **2.1**, don't worry. All these
things can be done on the GitHub website. You can easily create folders and
files and copy paste things on the website.

1. Go to your GitHub Profile Repo page
1. Create a folder/file: Click on 'Add files' then name it '.github/workflows/readmeUpdateAction.yml' and copy/paste the contents of [readmeUpdateAction.yml] into it. Then Give it a commit title/message and commit it to the main branch.
1. Create another folder/file in the same way, but name it 'templates/README.md.tpl' and if you already have a profile, copy the contents of README.md to it.
    1. From now don't write  anything into the regular README.md.
       This is because it will be overwritten by the action. So instead, add
       new information to be displayed on your profile page to the
       README.md.tpl file.
    1. Finally, select the data you want to display in your profile page and
       write its HTML comment in the README.md.tpl file. Take a look at the
       [Example] to see how.

### 3. Example

The titles in the example are for illustration and categorization only. You can write your own titles, only the HTML comments are relevant.

<details>
  <summary><b>Automated GitHub Profile: template/README.md.tpl Example</b></summary>

```markdown
## 👋 &nbsp;Hey there! This is an automated example Profile

Checkout [readme-writer](https://github.com/SimonWoodtli/readme-writer)
for setup instructions!

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
```

</details>

<details>
  <summary><b>Automated GitHub Profile: Rendered README.md Example</b></summary>

![Screenshot from 2023-02-23 15-23-18](https://user-images.githubusercontent.com/66033447/221223488-d3608db8-3f47-406e-b202-2d4eff4510b6.png)

</details>

You can also checkout my [profile page] if it helps.

## Challenges

* Small changes to the `readme-writer` script needed to be pushed GitHub, then
  a new docker image had to be created, tagged and pushed to the registry.
  All this had to happen before I could retest my GitHub workflow.
* Debugging a GitHub workflow can be tedious,
  you have to watch the site and wait for the build to download and execute
  each action until it throws an error. This error can only be found with more
  echo statements in the script itself, in the Docker image or the Ubuntu VM.
  If the problem is in the script or container, you need to do again what
  I just described in my first point. There is a local action-run tool called
  [act]. But I found the information it gave me for troubleshooting was not
  sufficient.
* Find out how Docker, GitHub Action, and a bash script work together even
  though I haven't used Docker or GitHub Action before.
* Figure out how to do multi line text substitution without Perl and later with
  Perl.
* Finding out how GitHub's GraphQL API works. And how to use `curl` to retrieve
  user data with it.
* Find out how to get more than 100 entries (max with GitHub GraphQL) with
  multiple queries. And how to process and filter the data later.
* Learn how to format and output information with data that requires multiple
  rows and columns. And just because you have nicely formatted columns in your
  terminal output doesn't mean in every case that the content is rendered
  Markdown as you'd expect (see Markdown lists).
* Finding out how to use flags in a script with `getopts`

## Gotchas

* GitHub Actions allows you to use either `- name: ...\n uses:...` or `- uses:
  ...\n run: ...` but not `- name: ...\n run: ...`
* GitHub Action Checkout has a bug where when mounting files into a Docker
  container, the permissions are not preserved for each following action. So
  you have to explicitly override the permissions in the mounted folder with
  `chown -R $(id -u):$(id -g) $PWD`. If you do not want to use this action you
  can also mount files with `options: -v ${{ github.workspace }}:/root`
* You cannot calculate the spaces for different word lengths and multiple
  columns per line with Markdown lists. You can calculate them, but inserting
  spaces in a Markdown list will be ignored. And even if you replace spaces
  with `&nbsp;` to get around this, your columns will not be formatted
  correctly. This is because it would assume that each character has the same
  width, which is not true. Use Markdown blocks or tables instead!

## What would I have done differently?

* Once I wrote the script and it was working locally, I should have forked it
  to play around with GitHub Action and Docker. Since prior to this project
  I never really used any of those technologies. As a result, I did a lot of
  debugging, commits on the `readme-scraper` repository.
* I should have played with GitHub Action alone first to get the hang of
  it and add a Docker container later.
* I should have looked into Perl earlier, because I already knew it was (and
  still is) a very powerful language for editing text! I struggled to get
  a version working that could substitute multi-line text without Perl.
  Eventually it worked reasonably well, but still had some problems. And it was
  pretty complicated code, with Perl it got much easier. Once you understand
  how regex and substitutions work in Perl, it's really just a simple
  one-liner. But it's not like I learned the whole language, I just wanted to
  solve my specific problem with Perl, writing a whole script in Perl would be
  whole different endeavour.
* I should have started using echo commands earlier to troubleshoot what each
  command actually did and where it came from: Script, container, VM/workflow.
  I don't know, for some reason the whole GitHub Action thing felt like a black
  box that just does things and gives bad feedback when something triggers an
  error. And that frustrated me because I'm used to working on my local
  computer and the shell there, so I know how to debug things there. But in the
  end, it's just a remote Linux VM/container running Unix commands that you
  define in your workflow. But it feels like a new environment, especially
  because you access it through the browser. You can also create GitHub actions
  in a custom repository. Then they simply become a template with a set of
  commands or a "workflow", that you can import in a new workflow without
  having to repeat mundane, repetitive tasks.
* Since I've never worked with Github Action before, it probably would have
  been better to start with a project that wasn't Docker based and only used an
  Ubuntu VM. This complexity made the whole project really challenging and
  frustrating at times.

[profile page]: <https://github.com/SimonWoodtli/SimonWoodtli>
[act]: <https://github.com/nektos/act>
[readme-writer]:<https://hub.docker.com/r/simonwoodtli/readme-writer>
[Example]: <#3. example>
[readmeUpdateAction.yml]:<https://raw.githubusercontent.com/SimonWoodtli/readme-writer/main/readmeUpdateAction.yml>
[Developer Settings]:<https://github.com/settings/tokens>
