# This file has been generated by node2nix 1.6.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {};
in
{
  ep_headings2 = nodeEnv.buildNodePackage {
    name = "ep_headings2";
    packageName = "ep_headings2";
    version = "0.0.9";
    src = fetchurl {
      url = "https://registry.npmjs.org/ep_headings2/-/ep_headings2-0.0.9.tgz";
      sha1 = "115f4162a2e49808a0cee50e04aff26c591db0d4";
    };
    buildInputs = globalBuildInputs;
    meta = {
      description = "Adds heading support to Etherpad Lite.  Includes improved suppot for export, i18n etc.";
      homepage = https://github.com/johnmclear/ep_headings2;
    };
    production = true;
    bypassCache = false;
  };
}