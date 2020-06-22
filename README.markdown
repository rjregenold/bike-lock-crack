# Bike Lock Crack

![Image of bike lock](assets/bike-lock.jpg)

My son found his old bike lock but could not remember the combination. He did, however, remember that the word it formed was an actual word. This is a simple program that generates all possible four-character combinations, filters them against english dictionary words, and dumps them into a simply formatted text file.

The combination ended up being `BASK` and we were lucky enough to crack it within ~20 attempts.

If you use one of these locks, the best thing you can probably do is make sure you choose a combination that is not a word found in the dictionary.

## Running

To run the program, execute the following:

```
$ nix-shell
$ spago run
```

The generated combinations will be output to a file in `output/possible-combos.txt`.