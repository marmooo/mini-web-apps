import { $ } from "https://deno.land/x/deno_dx/mod.ts";

function getTimestamp() {
  const date = new Date();
  date.setTime(date.getTime() + (9 * 60 * 60 * 1000));
  const timestamp = date.toISOString().replace("T", " ").substr(0, 16);
  return timestamp;
}

function getRepos(repoList) {
  const text = Deno.readTextFileSync(repoList);
  return text.split("\n")
    .filter((line) => line != "" && !line.startsWith(";"))
    .map((line) => {
      let [url, repoName] = line.split(" ");
      if (!repoName) {
        if (url.endsWith("/")) url = url.slice(0, -1);
        if (url.endsWith(".git")) url = url.slice(0, -4);
        repoName = url.split("/").at(-1);
      }
      return repoName;
    });
}

async function build(repoList) {
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`bash build.sh`;
  }
  Deno.chdir(basedir);
}

async function grep(repoList, keyword, args) {
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    console.log(`%c${repoName}`, "font-weight: bold");
    try {
      const result = await $`rg --count ${keyword} ${args.join(" ")}`;
      console.log(result);
    } catch (_err) {
      /* skip error */
    }
  }
  Deno.chdir(basedir);
}

async function updateServiceWorker(repoList) {
  const timestamp = getTimestamp();
  const from = "^var CACHE_NAME.*$";
  const to = `var CACHE_NAME = "${timestamp}";`;
  const files = [
    "src/sw.js",
    "src/ja/sw.js",
    "src/en/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -f m "${from}" '${to}' ${files.join(" ")}`;
  }
  Deno.chdir(basedir);
}

async function updateTfjs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@3.16.0";
  const to = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@3.17.0";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e js -e html .)`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapJs(repoList) {
  const from =
    '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>';
  const to =
    '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapCss(repoList) {
  const from =
    '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">';
  const to =
    '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/bootstrap@5.1.2";
  const to = "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3";
  const files = [
    "src/sw.js",
    "src/ja/sw.js",
    "src/en/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -f m "${from}" ${to} ${files.join(" ")}`;
  }
  Deno.chdir(basedir);
}

async function updateSignaturePadJs(repoList) {
  const from = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.6/dist/signature_pad.umd.min.js" integrity="sha256-+m3D7+nEQzP6tyb4trUMOfRLh3/NK370mPVpFR8kyYE=" crossorigin="anonymous"></script>';
  const to = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.7/dist/signature_pad.umd.min.js" integrity="sha256-CMptYYXRcNVLvNSGRK6ZLrOBRO729Cg5aAC8l34V+nI=" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
  }
  Deno.chdir(basedir);
}

async function updateSignaturePadSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/signature_pad@4.0.6";
  const to = "https://cdn.jsdelivr.net/npm/signature_pad@4.0.7";
  const files = [
    "src/sw.js",
    "src/ja/sw.js",
    "src/en/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -f m "${from}" ${to} ${files.join(" ")}`;
  }
  Deno.chdir(basedir);
}

switch (Deno.args[0]) {
  case "build":
    await build(Deno.args[1]);
    break;
  case "grep":
    await grep(Deno.args[1], Deno.args[2], Deno.args.slice(3));
    break;
  case "sw.js":
    await updateServiceWorker(Deno.args[1]);
    break;
  case "tfjs": {
    await updateTfjs("tfjs.lst");
    await updateServiceWorker("tfjs.lst");
    await build("all.lst");
    const comment = "bump tfjs from 3.16.0 to 3.17.0";
    await $`gitn add .. tfjs.lst "*"`;
    await $`gitn commit .. tfjs.lst -m "${comment}"`;
    await $`gitn push .. tfjs.lst`;
    break;
  }
  case "bootstrap": {
    await updateBootstrapJs("all.lst");
    await updateBootstrapCss("all.lst");
    await updateBootstrapSwJs("all.lst");
    await updateServiceWorker("all.lst");
    await build("all.lst");
    const comment = "bump bootstrap from 5.1.2 to 5.1.3";
    await $`gitn add .. all.lst "*"`;
    await $`gitn commit .. all.lst -m "${comment}"`;
    await $`gitn push .. all.lst`;
    break;
  }
  case "signature_pad": {
    await updateSignaturePadJs("signature_pad.lst");
    await updateSignaturePadSwJs("signature_pad.lst");
    await updateServiceWorker("signature_pad.lst");
    await build("signature_pad.lst");
    const comment = "bump signature_pad from 4.0.6 to 4.0.7";
    await $`gitn add .. signature_pad.lst "*"`;
    const result = await $`gitn commit .. signature_pad.lst -m "${comment}"`;
    await $`gitn push .. signature_pad.lst`;
    break;
  }
  case "help":
  case "--help":
  default:
    console.log("Usage: update.js [command] [repoList]");
}
