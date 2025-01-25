#! /usr/bin/env nix-shell
#! nix-shell -i bash -p xmlstarlet

set -eux

package="$1"
extid="$(sed -n 's/^ *extid = "\([^"]*\)";$/\1/p' "$package")"
chrmajor="$(nix-instantiate --eval --xml -E "with import <nixpkgs>{}; lib.versions.major ungoogled-chromium.version" | xml sel -t -v /expr/string/@value)"
gupdate="$(curl "https://clients2.google.com/service/update2/crx?acceptformat=crx2,crx3&prodversion=$chrmajor.0&x=id%3D$extid%26installsource%3Dondemand%26uc")"
url="$(xml sel -N res=http://www.google.com/update2/response -t -m //res:updatecheck -v @codebase <<<"$gupdate")"
version="$(xml sel -N res=http://www.google.com/update2/response -t -m //res:updatecheck -v @version <<<"$gupdate")"
sha256="$(nix-prefetch-url --type sha256 "$url")"
sri="$(nix-hash --to-sri --type sha256 "$sha256")"

sed -i '
	s#^\( *url = "\)[^"]*";$#\1'"$url"'";#;
	s#^\( *hash = "\)[^"]*";$#\1'"$sri"'";#;
	s#^\( *external_version = "\)[^"]*";$#\1'"$version"'";#
	' "$package"
