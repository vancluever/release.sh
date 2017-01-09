#!/usr/bin/env bash

#shellcheck disable=SC1090
source "$(dirname "$0")/message.function"

# The release from CHANGELOG.md.
release=$(head -n 1 CHANGELOG.md | awk '{print $2}')

if [[ "${release}" == *"-pre" ]]; then
  message error "This is a pre-release - release aborted." >&2
  message error "Please update the first line in CHANGELOG.md to a version without the -pre tag."
  exit 1
fi

semver=(${release//./ })

for n in 0 1 2; do 
  if ! [ "${semver[$n]}" -eq "${semver[$n]}" ]; then
    message error "${release} is not a proper semantic-versioned release." >&2
    message error "Please update the first line in CHANGELOG.md to a numeric MAJOR.MINOR.PATCH version."
    exit 1
  fi
done

changelog_status=$(git status -s | grep CHANGELOG.md)

if [ "${changelog_status}" == " M CHANGELOG.md" ]; then
  git add CHANGELOG.md
  changelog_status=$(git status -s | grep CHANGELOG.md)
fi

if [ "${changelog_status}" == "M  CHANGELOG.md" ]; then
  git commit -m "$(echo -e "Release v${release}\n\nSee CHANGELOG.md for more details.")"
fi

git tag "v${release}" -m "$(echo -e "Release v${release}\n\nSee CHANGELOG.md for more details.")"

new_prerelease="${semver[0]}.${semver[1]}.$((semver[2]+1))-pre"

echo -e "## ${new_prerelease}\n\nBumped version for dev.\n\n$(cat CHANGELOG.md)" > CHANGELOG.md

git add CHANGELOG.md
git commit -m "Bump CHANGELOG.md to v${new_prerelease}"

git push origin master
git push origin --tags
