# Dotfiles

1. Clone repository
2. Run `sh setup.sh`
3. Enjoy

## FAQ

#### How do I make sure `Brewfile` and local setup are kept in sync?

Run `brew bundle cleanup` to see which packages are installed locally, but not
part of your `Brewfile`. Add `--force` to remove said packages, or add them to
your Brewfile if you want to keep them.
