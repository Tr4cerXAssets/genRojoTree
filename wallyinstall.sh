set -e

wally install
# wally-patch-package
rojo sourcemap --output sourcemap.json
wally-package-types --sourcemap sourcemap.json Packages/