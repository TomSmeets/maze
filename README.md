# maze
Simple Haskell maze generator using the state monad

## Compile
Building using
[stack](https://github.com/commercialhaskell/stack/blob/master/doc/install_and_upgrade.md): `stack build`

## Running
To Run the project use: `stack exec maze`  

If you run `stack install` stack places the executable inside your `~/.local/bin` directory

The executable can also be found inside the `.stack-work/dist` directory  

For me it was at `.stack-work/dist/x86_64-linux/Cabal-1.22.4.0/build/maze/maze`
but this can be different for you

`maze Width Height [FilledSTRING] [EmptySTRING]`

## Examples
Example output of `maze 10 10` equivalent of `maze 10 10 "██" "  "` (those are two spaces but markdown somehow doesn't show them):
```
██████████████████████████████████████████
██              ██                      ██
██████  ██████  ██  ██████████████████  ██
██      ██          ██              ██  ██
██  ██████████████████  ██████████  ██  ██
██                      ██          ██  ██
██  ██████████████████████  ██████████  ██
██      ██                  ██      ██  ██
██████████  ██████████████████  ██████  ██
██          ██      ██          ██      ██
██  ██████████  ██  ██████  ██  ██  ██████
██  ██          ██  ██  ██  ██  ██      ██
██  ██  ██████████  ██  ██  ██████████  ██
██  ██          ██      ██  ██      ██  ██
██  ██████████  ██████████  ██  ██  ██  ██
██          ██  ██              ██  ██  ██
██████████  ██  ██████████████████  ██  ██
██          ██                  ██  ██  ██
██  ██████████████████████████  ██  ██  ██
██                              ██      ██
██████████████████████████████████████████
```

Example output of `maze 10 10 "#" " "`:
```
#####################
#     #     # #     #
# # # # ### # # # ###
# # #   #   #   #   #
### ##### ##### ### #
#   #         # #   #
# ### ####### ### # #
#   # #   #   #   # #
### # # # ### # #####
#   # # #   # # #   #
# ##### ### # # # # #
#     #   # # #   # #
##### ### ### ##### #
# #     #   #   #   #
# # ####### ### # # #
# #       # # #   # #
# ####### # # ##### #
# #     #   # #     #
# # ### ##### # #####
#     #             #
#####################
```
