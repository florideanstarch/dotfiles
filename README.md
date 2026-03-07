# dotfiles
A repo for managing my dotfiles using [chezmoi](https://www.chezmoi.io/).

### Basics of `chezmoi`:
- `chezmoi add <rcfile>`
- Make some edit to the `<rcfile>`.
- `chezmoi diff` or `chezmoi -n -v apply` (checks for changes, dryrun).
- `chezmoi apply`
- `chezmoi cd`
- Use git commands to push changes.

As the README.md for this repo is in `.chezmoiignore`, changes to that can be
made use `vim .local/share/chezmoi/README.md` before pushing the changes using git.

### Managing python environments:
`uv` for pacakge management. When to `uv` and when to `uvx`? Find the answer [here](https://pydevtools.com/handbook/explanation/when-to-use-uv-run-vs-uvx/).

### Lue (a Kokoro powered terminal reader) is a bit hard to get going:
Lue is a beautiful, all local, terminal reader. Checkout its [repo](https://github.com/superstarryeyes/lue). 

In order to use use lue to read articles:
- `npm install -g readability-cli` and have it in the path.
- Refer to zepo for installation, use venv.
- `cd` into the cloned repo for lue.
- `source activate .venv`
- `readable <an article link> -p text-content > temp.txt && lue temp.txt --tts kokoro`

### Some useful one-liners:
- Get unmanaged files in my brew bin: 

```
find /opt/homebrew/bin -type f -maxdepth 1 | while read f; do 
brew list --formula | grep -q "$(basename $f)" || echo "unmanaged: $f" 
done
```
