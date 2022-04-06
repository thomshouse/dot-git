# thomshouse/dot-git

(Opinionated) dotfiles package for git by [thomshouse][thomshouse].

This package contains various aliases and completion settings, and also wraps the main `git` command in a function that provides some added utility.

Additionally, the git and system aliases in this package are configured to display the long-form version of the aliased commands on execution.  If you wish to suppress these messages, you can create an empty file named `.dotfiles_hide_git_verbalizing` in your home folder.

## Install
Clone and symlink or install with [ellipsis][ellipsis]:

```
$ ellipsis install thomshouse/dot-git
```

[ellipsis]: http://ellipsis.sh
[thomshouse]: https://github.com/thomshouse
