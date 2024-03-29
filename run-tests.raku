#!/usr/bin/env raku

unit sub MAIN(:$author);

say run(<raku --version>, :out).out.slurp.chomp;
say "Running on $*DISTRO.gist().\n";

say "Testing {
    "dist.ini".IO.lines.head.substr(7) if "dist.ini".IO.f;
}{
    " including author tests" if $author
}";

my @failed;
my $done   = 0;

sub test-dir($dir) {
    return note "=== directory $dir not found" unless $dir.IO.e;

    for $dir.IO.dir(:test(*.ends-with: '.t' | '.rakutest')).map(*.Str).sort {
        say "=== $_";
        my $proc := run "raku", "--ll-exception", "-I.", $_, :out,:err,:merge;
        if $proc {
            $proc.out.slurp;
        }
        else {
            @failed.push($_);
            if $proc.out.slurp -> $stdout {
                my @lines = $stdout.lines;
                with @lines.first(
                  *.starts-with(" from gen/moar/stage2"),:k)
                -> $index {
                    say @lines[^$index].join("\n");
                }
                else {
                    say $stdout;
                }
            }
            elsif $proc.err -> $stderr {
                say .slurp with $stderr;
            }
            else {
                say "No output received, exit-code $proc.exitcode() ($proc.signal())";
            }
        }
        $done++;
    }
}

test-dir("t");
test-dir("xt") if $author;

if @failed {
    say "FAILED: {+@failed} of $done:";
    say "  $_" for @failed;
    exit +@failed;
}

say "\nALL {"$done " if $done > 1}OK";

# vim: expandtab shiftwidth=4
