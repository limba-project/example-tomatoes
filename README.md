# Limba "I have no Tomatoes" Example

This is a more complex example on how to create a Limba[1] package.
It demonstrates how to:
 * Build a Limba package with the build-helper
 * Handle multiple dependencies
 * Create a Limba repository
 * Create bundles containing multiple software components which depend on each other

More information and explanations of the single steps will follow.

Please keep in mind that this repository contains software from multiple organizations,
using different licenses. Please refer to the individual projects for more information about
licensing.
The software source code originates from the respective Debian packages[3], refer to the packages
for more information on the upstream components.

The Limba package definitions are public domain or subjected to the MIT license. Descriptions
might be copyrighted by the respective project which wrote them (refer to the individual files).

### Building
To initiate the build process, add the [Neverball Limba Repo](https://github.com/limba-project/example-neverball) because it contains
some SDK packages which we use for this build process.
Then just run `./make_all.sh`.

[1]: http://people.freedesktop.org/~mak/limba/
[2]: https://github.com/ximion/limba
[3]: http://packages.debian.org/
