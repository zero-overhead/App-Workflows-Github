|last push|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Linux.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/MacOS.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Windows.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![NixOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/NixOS.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|
|---|---|---|---|---|
|scheduled check|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Linux.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/MacOS.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/Windows.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![NixOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/NixOS.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/NixOS.yml)|


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

DESCRIPTION
===========

[![last version](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/version)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges) [![downloads](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/downloads)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges)

App::Workflows::Github is collecting Github workflows for testing your [Module](https://raku.land) on Linux, MacOS and Windows.

Installation
------------

Linux/MacOS/Windows install module command:

```bash
zef install App::Workflows::Github
```

Finally execute the following commands:

```bash
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
git add run-tests.raku

git commit -m"adding github workflows"

git push
```

Workflow Dispatch
-----------------

To [dispatch a workflow run](https://cli.github.com/manual/gh_workflow_run) using [gh](https://cli.github.com/manual/) CLI use e.g.

```bash
cd your-module-directory

echo '{"verbosity":"debug", "os":"windows", "ad_hoc_pre_command":"pwd", "ad_hoc_post_command":"ls -alsh", "os_version":"2019", "raku_version":"2023.02", "run_prove6":"true", "install_module":"true", "run_tests_script":"true", "skip_deps_tests":"false"}' > run_parameters.json
cat run_parameters.json | gh workflow run 'dispatch' --ref branch-to-run-on --json
```

For 'os' you can choose any of 'ubuntu|macos|windows'. For 'os_version' check [supported-runners-and-hardware-resources](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources). For available 'raku_version' check [here](https://www.rakudo.org/downloads/rakudo).

![screenshot of dispatch menu](https://github.com/zero-overhead/App-Workflows-Github/blob/main/resources/dispatch-screenshot.png?raw=true)

Open https://github.com/your-name/your-module/actions to check the workflow results or dispatch a run via browser.

Scheduled workflows only run automatically on github if the .yml files are pushed to the default branch - usually 'main'.

AUTHOR
======

rcmlz <rcmlz@github.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2023 rcmlz

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

