#!/bin/bash

# 7 x 7

#        0 1 2 3 4 5 6
# Sun 0  . @ . . . @ .
# Mon 1  @ @ @ . @ @ @
# Tue 2  @ @ @ @ @ @ @
# Wed 3  @ @ @ @ @ @ @
# Thu 4  . @ @ @ @ @ .
# Fri 5  . . @ @ @ . .
# Sat 6  . . . @ . . .

# start date : Jan 26th, 2025
# end date   : Mar 15th, 2025

# (0, 1), (0, 5)
# (1, 0), (1, 1), (1, 2), (1, 4), (1, 5), (1, 6)
# (2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6)
# (3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6)
# (4, 1), (4, 2), (4, 3), (4, 4), (4, 5)
# (5, 2), (5, 3), (5, 4)
# (6, 3)

#!/bin/bash

START_DATE="2025-01-26"

heart=(
".@...@."
"@@@.@@@"
"@@@@@@@"
"@@@@@@@"
".@@@@@."
"..@@@.."
"...@..."
)

for y in {0..6}; do
  line="${heart[$y]}"
  for x in {0..6}; do
    char="${line:$x:1}"
    if [ "$char" = "@" ]; then
      offset_days=$((x * 7 + y))
      commit_date=$(date -j -v+"$offset_days"d -f "%Y-%m-%d" "$START_DATE" +"%Y-%m-%d")

      GIT_AUTHOR_DATE="$commit_date 12:00:00" \
      GIT_COMMITTER_DATE="$commit_date 12:00:00" \
      git commit --allow-empty -m "💚 commit for $commit_date"
    fi
  done
done

git push origin main