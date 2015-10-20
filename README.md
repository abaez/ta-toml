# ta-rust
## A [TOML](https://github.com/toml-lang/toml) module and lexer for [Textadept](http://foicica.com/textadept/).

### DESCRIPTION
A quick lexer for the Tom's Obvious, Minimal Language. Using [TOML v0.4.0](https://github.com/toml-lang/toml/tree/v0.4.0)
spec sheet.

### INSTALL
Clone the repository to your `~/.textadept/modules` directory:

```
cd ~/.textadept/modules
hg clone https://bitbucket.org/a_baez/ta-toml toml
```

Then copy the `toml.lua` lexer file into your `~/.textadept/lexers` directory:

```
cp ~/.textadept/modules/toml/toml.lua ~/.textadept/lexers/toml.lua
```

Finally, append to your `~/.textadept/init.lua` file the module through the
file extension. Need to do this, since the file type extension declares the
lexer:

```
textadept.file_types.extensions.toml = 'toml'
```
