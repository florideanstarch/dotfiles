# dotfiles
A repo for managing my dotfiles using [chezmoi](https://www.chezmoi.io/).

### More on managing my python environments.
`uv` for pacakge management.

### Lue (Kokoro powered terminal reader) is a bit hard to get going.
Lue is a beautiful, all local, terminal reader. Checkout its [repo](https://github.com/superstarryeyes/lue). 

In order to use use lue to read articles:
- `npm install -g readability-cli` and have it in the path.
- `cd` into the cloned repo for lue.
- `source activate .venv`
- `readable <an article link> -p text-content > temp.txt && lue temp.txt --tts kokoro`

### Some useful one-liners
- Get unmanaged files in brew bin: 
```find /opt/homebrew/bin -type f -maxdepth 1 | while read f; do brew list --formula | grep -q "$(basename $f)" || echo "unmanaged: $f" done```
