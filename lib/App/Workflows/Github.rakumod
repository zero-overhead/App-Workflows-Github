unit class App::Workflows::Github:ver<0.0.9>:auth<github:rcmlz>:api<1>;

sub generate-workflow-files(IO(Str) :$base-dir) is export {

	my @files = <runner dispatch linux macos windows>;

	my IO $out = workflow-dir($base-dir);

	$out.mkdir unless $out.e;

	# Parse Templates
	my @output = gather {
	  for @files -> $f {

		my %mapping =
			CRONMINUTES => (0..59).rand.Int,
			CRONHOUR => (0..23).rand.Int,
			CRONDAYOFMONTH => (1..28).rand.Int;

		my $content = %?RESOURCES{"$f.tmpl.yml"}.slurp;

		for %mapping.kv -> $k, $v {
				$content ~~ s:g/\@\@$k\@\@/$v/
		}
		take ($out.add("$f.yml"), $content);
	  }
	}

	# Write Output
	if @output {
		say "#" x 31;
		say "## creating github workflows ##";
		say "#" x 31;
		for @output -> ($fn, $content) {
			my $ok = spurt $fn, $content;
			say "$fn" if $ok;
			note "ERROR $fn" unless $ok;
		}
	}

	# copy test script
	my $script-name = "run-tests.raku";
	my $script-path = $base-dir.add($script-name);
	say "$script-path" if %?RESOURCES{"run-tests.raku"}.copy($script-path);

}

sub workflow-dir(IO(Str) $base) is export {
	$base.add('.github').add('workflows')
}

=begin pod

|push to main|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/linux.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/macos.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/windows.yml/badge.svg?event=push)](https://github.com/zero-overhead/App-Workflows-Github/actions) | 
|---|---|---|---| 
|scheduled run|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/linux.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/macos.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/windows.yml/badge.svg?event=schedule)](https://github.com/zero-overhead/App-Workflows-Github/actions)| 
|pull request|[![Linux Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/linux.yml/badge.svg?event=pull)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![MacOS Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/macos.yml/badge.svg?event=pull)](https://github.com/zero-overhead/App-Workflows-Github/actions)|[![Windows Status](https://github.com/zero-overhead/App-Workflows-Github/actions/workflows/windows.yml/badge.svg?event=pull)](https://github.com/zero-overhead/App-Workflows-Github/actions)| 

=head1 NAME

App::Workflows::Github - a CI/CD workflow collection for Raku Module developers.

=head1 SYNOPSIS

=begin code :lang<bash>
zef install App::Workflows::Github

cd your-module-directory

create-workflows-4-github
=end code

This will create or overwrite the following files:

=begin code :lang<bash>
your-module-directory/.github/workflows/runner.yml
your-module-directory/.github/workflows/dispatch.yml
your-module-directory/.github/workflows/linux.yml
your-module-directory/.github/workflows/macos.yml
your-module-directory/.github/workflows/windows.yml
your-module-directory/run-tests.raku
=end code

Then do the usual three git steps to push the changes to github.

=begin code :lang<bash>
git add .github/workflows/
git commit -m"adding github workflows"
git push
=end code

Open https://github.com/your-name/your-module/actions to check the workflow results.

To dispatch a workflow run using CLI [gh](https://cli.github.com/manual/) do

=begin code :lang<bash>
cd your-module-directory

gh workflow run 'dispatch' --ref branch-to-run-on -f verbosity=debug -f os=windows -f run_prove6=true -f install_module=true -f skip_deps_tests=false
=end code

For 'os' you can choose any of 'ubuntu|macos|ubuntu'. Use https://github.com/your-name/your-module/actions/workflows/dispatch.yml to launch a run from the webbrowser.

![screenshot of dispatch menu](https://github.com/zero-overhead/App-Workflows-Github/blob/main/resources/dispatch-screenshot.png?raw=true)

=head1 DESCRIPTION

App::Workflows::Github is collecting Github workflows for testing your [Module](https://raku.land) on Linux, MacOS and Windows.

Scheduled workflows only run automatically on github if the .yml files are pushed to the default branch - usually 'main'.

[![last version](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/version)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges) [![downloads](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges/downloads)](https://raku.land/zef:zero-overhead/App::Workflows::Github/badges)

=head1 AUTHOR

rcmlz <rcmlz@github.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2023 rcmlz

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod