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
```

If you are on Windows, please switch off the [maximum-path-length-limitation](https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=powershell). You might get away with temporaily setting TEMP to a short path.

```PowerShell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force

set TEMP=D:\T

mkdir -Force %TEMP%
set TMP=%TEMP%
set ZEF_CONFIG_TEMPDIR=%TEMP%

zef install App::Workflows::Github
```

Finaly execute the following commands:

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

Open https://github.com/your-name/your-module/actions to check the workflow results.

To [dispatch a workflow run](https://cli.github.com/manual/gh_workflow_run) using [gh](https://cli.github.com/manual/) CLI use e.g.

```bash
cd your-module-directory

echo '{"verbosity":"debug", "os":"windows", "ad_hoc_pre_command":"pwd", "ad_hoc_post_command":"ls -alsh", "os_version":"2019", "raku_version":"2023.02", "run_prove6":"true", "install_module":"true", "run_tests_script":"true", "skip_deps_tests":"false"}' > run_parameters.json
cat run_parameters.json | gh workflow run 'dispatch' --ref branch-to-run-on --json
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

