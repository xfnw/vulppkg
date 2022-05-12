# This file has been generated by node2nix 1.6.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {};
in
{
  ep_bookmark = nodeEnv.buildNodePackage {
    name = "ep_bookmark";
    packageName = "ep_bookmark";
    version = "1.0.2";
    src = fetchurl {
      url = "https://registry.npmjs.org/ep_bookmark/-/ep_bookmark-1.0.2.tgz";
      sha1 = "14ef41ab3eccc3c387f40a0093683fc6497cb560";
    };
    buildInputs = globalBuildInputs;
    meta = {
      description = "Etherpad plugin for users to save a list of bookmarks of their visited pads locally in the browser's local storage";
      homepage = "https://github.com/Gared/ep_bookmark#readme";
    };
    production = true;
    bypassCache = false;
  };
}