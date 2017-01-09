# release.sh

This is a pretty simple bash script that helps manage your releases based on the
contents of your `CHANGELOG.md` file.

## What You Need

 * A `CHANGELOG.md` file
 * `git`
 * `bash` 4+
 * A system with `head`, `awk` and `grep`

## HOWTO

This script expects that you manage your versioning a semver-style format.
Pre-release versions are prefixed with `-pre` and if the script detects this as
the first second-level heading in your Markdown file (prefixed with `##`), the
script will fail.

When you are ready to release, remove the `-pre` suffix from the first `h2`
heading.

When the script runs, the following happens:

 * `CHANGELOG.md` is committed if it needs to be still
 * The git repository is tagged at the current commit with the version found in
   the heading.
 * The version's patch version is incremented and the `-pre` suffix is written
   back.
 * The new version is written out as a new second-level heading section in your
   CHANGELOG.md, and committed with a simple version bump comment.
 * All commits and tags are pushed.

## License

```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
```
