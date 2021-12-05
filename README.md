# DOTS
###### Da One Thicc Solution (for my dot files management)

### Project Structure
```sh
# dot files
common                  # holds all main dots
machines                # holds all machine specific dots

# dot managers
home_dots               # symlinks home dots
system_dots             # copies system dots
.
.
```

### Usage
there's nothing to it, you put your dots in the right places and the management scripts do the rest.
* home dots are symlinked with stow, this allows for smart restowing to update and mirror the sources
* system dots are simply copied, mainly because they aren't user dependant and should

### TODO
- replace `init_dirs` with a smarter implicit solution
- relocate common to within machines
