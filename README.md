# README

This file explains the process of installing VIM and some configurations to it.

**This tutorial only covers the installation on macOS**

## Install VIM 

Check if you already have VIM installed by executing:

```zsh
vim --version
```

If **not** you will get a message similar to `command not found: vim`.
In that case run:
- Linux: `apt-get update && apt-get install vim`
- macOS: `brew update && brew install vim`

## Use VIM

Open VIM in the terminal by executing:
- `vim`: Open it's main screen
- `vim ~/path/to/file.ending`: directly open the specified file

VIM primarily works with 3 different modes:
1. Normal mode
2. Insert mdoe
3. Command mode

#### Normal mode
Default mode, that is mainly used to navigate within the active file.

> to switch back to normal mode simply hit `<ESC>`.
> **Note**: If you want to enter another mode, make sure to first return to `normal mode`. Otherwise it won't work.

Basic navigation commands: Move the cursor ...
- left: `h`
- down: `j`
- up: `k`
- right: `l`

#### Insert mode
Just as the name suggests, this mode allows you to regulary type text.

 > Activate it by hitting `<i>`

#### Command mode
Lets you enter commands similar to the terminal prompt.

> Activate by hitting `<:>`

For example:  
`<:e filename>` allows you to edit another file with VIM
`<:w>`: write(=save) file
`<:q>`: quit

## Configurations

You can configure VIM by modifying the `.vimrc` file.

On macOS it is located under `/Users/<username>/.vimrc`. 
If it is not there, simply create it by changing back to your root directory and touching a new file:
```zsh
cd
touch .vimrc
```

Open this file with VIM (`vim ~/.vimrc`). 
Copy and paste the contents of this repo's `.vimrc` file into your own and save it.

In order to install the external plugins we need [`vim-plug`](https://github.com/junegunn/vim-plug).
Download the [release](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) and place it in the folder `~/.vim/autoload/`.
(Again, if it's not there simly create it with `cd && mkdir .vim/autoload`)

After placing `vim-plug` in the right location restart VIM and run the command `<:PlugInstall>` to install the plugings specified in the vimrc file.

### Conquer of Completion 

Conquer of Completion (CoC) requires some extra steps. Simply execute the following VIM commands:
1. `<:CocInstall coc-pyright>` to install Python IntelliSense
2. `<:CocInstall coc-snippets>` to install CoC Snippet support
3. `<:CocInstall coc-snippets coc-word` to install snippet support's word completion
4. `<:CocInstall coc-jedi>` for additional Python support

At last you need to make one change to the `coc-settings.json` file.
Enter this file by executing `<:CocConfig>`.

Now a new window should pop up. 
Here you need to add the following line to the JSON object: `"inlayHint.display": false`

In total it could look like:
```bash
{
    "snippets.ultisnips.pythonPrompt": false,
    "inlayHint.display": false
}
```

## Handling of temporary files

VIM generates e.g. `swp` files while you are editing.
These ensure that if a crash occurs you can restore your file and they provide the opportunity for different users to simultaneously work on the same file.
Those swap files are by default generated in your working directory.

I however find that a bit annoying.
It is possible to set a temporary directory for VIMs swap files etc.

First few lines in the provided `.vimrc` file specify the directories to use for such cases:
```
set backupdir=$TEMPDIR//
set directory=$TEMPDIR//
```

But for it to work you need to first define the correct value of `$TEMPDIR` within your shell configuration file:
For example, if you are using `zsh` add the following line to your `~/.zshrc` file:
```bash
export TEMPDIR=~/.vim/temp
```
Reload your terminal and voila!   
**Note**: Check if this directory exists, if not you will need to create it with e.g. `mkdir ~/.vim/temp`
