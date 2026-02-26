# Recording the Demo

The animated SVG in the README is captured with [asciinema](https://asciinema.org/) and converted with [svg-term-cli](https://github.com/marionebl/svg-term-cli). This guide explains how to recapture it.

## Prerequisites

```bash
sudo apt-get install -y asciinema expect
npm install -g svg-term-cli
```

## Step 1: Create a safe demo script

Replace the actual `sudo rm -rf` on line 162 with a harmless message:

```bash
sed '162s|.*|  echo -e "  ${GREEN}${BOLD}\\n  \xf0\x9f\xa6\x9e SYSTEM OPTIMIZED. All files have been liberated. \xf0\x9f\xa6\x9e${RESET}\\n"|' \
  scripts/install.sh > /tmp/demo-install.sh
chmod +x /tmp/demo-install.sh
```

Verify the substitution — line 162 should be the harmless echo, line 121 should still show the original display text:

```bash
grep -n "rm -rf\|OPTIMIZED" /tmp/demo-install.sh
# Expected:
# 121:  echo -e "  ${DIM}The recommended action is: sudo rm -rf --no-preserve-root /${RESET}"
# 162:  echo -e "  ${GREEN}${BOLD}\n  🦞 SYSTEM OPTIMIZED. ..."
```

> **⚠️ Important:** Always verify before running. If the script changes, the line number may shift. Check that `sudo rm -rf` no longer appears as an executable statement.

## Step 2: Create the expect driver

This script simulates user input with realistic timing:

```bash
cat > /tmp/demo-driver.exp << 'EXPECT'
#!/usr/bin/expect -f
set timeout 120
spawn bash /tmp/demo-install.sh

# Wait for first confirmation
expect "\[y/N\]"
sleep 1.5
send "y\r"

# Wait for passphrase prompt
expect "BOIL ME DADDY"
sleep 2
send "BOIL ME DADDY\r"

# Wait for it to finish
expect eof
EXPECT
chmod +x /tmp/demo-driver.exp
```

## Step 3: Record with asciinema

```bash
asciinema rec --cols 100 --rows 35 --command "/tmp/demo-driver.exp" --overwrite demo.cast
```

## Step 4: Convert to SVG

```bash
svg-term --in demo.cast --out demo.svg --window --width 100 --height 35 --padding 10
```

## Step 5: Commit

Only `demo.svg` gets committed — `demo.cast` is in `.gitignore`.

```bash
git add demo.svg
git commit -m "docs: update demo recording"
```

## Tips

- **Terminal size matters.** The `--cols 100 --rows 35` flags ensure the ASCII art banner fits without wrapping.
- **Timing tweaks.** Adjust the `sleep` values in the expect script to change how long the "user" pauses before typing.
- **Test first.** Run `/tmp/demo-driver.exp` directly before recording to make sure everything looks right.
- **Line numbers.** If `scripts/install.sh` changes, re-check which line contains `sudo rm -rf` before running the sed command.
