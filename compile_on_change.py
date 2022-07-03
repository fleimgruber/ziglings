import re
import subprocess as sp

from watchgod import watch

PATTERN = re.compile("(\d{3})")


if __name__ == "__main__":
    for changes in watch('./exercises'):
        print(f"changes: {changes}")
        for c in changes:
            # Check if the change is of "modified" kind
            if c[0] == 2:
                path = c[1]
                m = re.findall(PATTERN, path)
                if m:
                    n_exercise = int(m[0])
                    sp.call(["zig", "build", f"{n_exercise}"])
