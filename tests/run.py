"""Run the public bundle, example, and UI checks with a local Luau interpreter."""
import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
GENERATED = ROOT / "tests/.generated"


def run_suite(luau: str, name: str, source: str) -> int:
    path = GENERATED / (name + ".luau")
    path.write_text(source)
    result = subprocess.run([luau, str(path)], text=True, capture_output=True)
    print(result.stdout, end="")
    print(result.stderr, end="", file=sys.stderr)
    result.check_returncode()
    return result.stdout.count("PASS ")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--luau", default=shutil.which("luau"), help="Path to the Luau CLI")
    args = parser.parse_args()
    if not args.luau:
        parser.error("Luau was not found. Install the CLI or pass --luau /path/to/luau.")
    GENERATED.mkdir(parents=True, exist_ok=True)
    subprocess.run([sys.executable, str(ROOT / "tools/build.py")], check=True)
    bundle = (ROOT / "BloomwareUI.lua").read_text()
    mock = (ROOT / "tests/mock.lua").read_text()
    # A Roblox Text property rejects EnumItems; this catches keybind regressions.
    mock = mock.replace(
        "self._properties[key] = value",
        'if key=="Text" then assert(type(value)=="string","Text must be a string")end\n    self._properties[key] = value',
    )
    load_library = "\nlocal function loadLibrary()\n" + bundle + "\nend\n"
    counts = {}
    counts["regression"] = run_suite(args.luau, "regression", mock + load_library + (ROOT / "tests/scenarios.lua").read_text())

    compatibility = mock + '''
local folders={}
local isfolder=function(path)return folders[path]==true end
local makefolder=function(path)folders[path]=true end
local listfiles=function(path)
    local result={}
    for name in pairs(Mock.Files)do if name:sub(1,#path+1)==path.."/"then table.insert(result,name)end end
    return result
end
readfile=function(path)assert(Mock.Files[path],"missing file: "..path);return Mock.Files[path]end
isfile=function(path)return Mock.Files[path]~=nil end
local delfile=function(path)Mock.Files[path]=nil end
local typeof=function(value)
    if type(value)=="table"and value.EnumType then return "EnumItem"end
    if type(value)=="table"and value.R and value.G and value.B then return "Color3"end
    return type(value)
end
''' + load_library
    families = []
    for family in ("original", "renewed", "upstream"):
        for kind in ("Interface", "Save"):
            path = ROOT / "tests/fixtures" / family / (kind + "Manager.luau")
            compatibility += "\nlocal function load" + family + kind + "()\n" + path.read_text() + "\nend\n"
        families.append('{Name="' + family + '",Interface=load' + family + 'Interface,Save=load' + family + 'Save}')
    compatibility += "\nlocal AddonFamilies={" + ",".join(families) + "}\n"
    icons = (ROOT / "src/RenewedIcons.lua").read_text()
    names = re.findall(r"^([^;\n]+);\d+;\d+;\d+;\d+;\d+$", icons, re.M)
    assert len(names) == 10616
    compatibility += "\nlocal UpstreamIconNames={" + ",".join(map(json.dumps, names)) + "}\n"
    compatibility += (ROOT / "tests/compatibility.lua").read_text()
    counts["compatibility"] = run_suite(args.luau, "compatibility", compatibility)

    public = mock + load_library
    public += "\nlocal function runExample(script, require, readfile, isfile, loadstring)\n" + (ROOT / "Example.lua").read_text() + "\nend\n"
    public += (ROOT / "tests/public.lua").read_text()
    counts["public"] = run_suite(args.luau, "public", public)
    report = {"status":"passed", "tests":counts, "total":sum(counts.values()),
              "roblox_apis":"mocked", "bundle_sha256":hashlib.sha256((ROOT / "BloomwareUI.lua").read_bytes()).hexdigest()}
    (GENERATED / "results.json").write_text(json.dumps(report, indent=2) + "\n")
    print(f"Passed {report['total']} checks.")


if __name__ == "__main__":
    main()
