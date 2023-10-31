|last push to main|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Linux.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/MacOS.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Windows.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions) |
|---|---|---|---| 
|scheduled health check|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Linux.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/MacOS.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Windows.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)| 

NAME
====

App::Workflows::Github - a CI/CD workflow collection for Raku Module developers.

SYNOPSIS
========

```bash
zef install App::Workflows::Github

cd your-module-directory

create-workflows-4-github
```

This will create or overwrite the following files:

```bash
your-module-directory/.github/workflows/runner.yml
your-module-directory/.github/workflows/dispatch.yml
your-module-directory/.github/workflows/Linux.yml
your-module-directory/.github/workflows/MacOS.yml
your-module-directory/.github/workflows/Windows.yml
your-module-directory/run-tests.raku
```

Then do the usual three git steps to push the changes to github.

```bash
git add .github/workflows/
git commit -m"adding github workflows"
git push
```

Open https://github.com/your-name/your-module/actions to check the workflow results.

To dispatch a workflow run using CLI [gh](https://cli.github.com/manual/) do

```bash
cd your-module-directory

gh workflow run 'dispatch' --ref branch-to-run-on -f verbosity=debug -f os=windows -f run_prove6=true -f install_module=true -f skip_deps_tests=false
```

For 'os' you can choose any of 'ubuntu|macos|ubuntu'. Use https://github.com/your-name/your-module/actions/workflows/dispatch.yml to launch a run from the webbrowser.

![screenshot of dispatch menu](https://github.com/zero-overhead/App-Workflows-Github/blob/main/resources/dispatch-screenshot.png?raw=true)

DESCRIPTION
===========

App::Workflows::Github is collecting Github workflows for testing your [Module](https://raku.land) on Linux, MacOS and Windows.

Scheduled workflows only run automatically on github if the .yml files are pushed to the default branch - usually 'main'.

[![last version](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/version)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges) [![downloads](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/downloads)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges)

AUTHOR
======

rcmlz <rcmlz@github.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2023 rcmlz

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

