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
    console.log(`%c${repoName}`, "font-weight: bold");
    try {
      await $`bash build.sh`;
    } catch (err) {
      console.log(err);
    }
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
  const from = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.5.0";
  const to = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.6.0";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e js -e html .)`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapJs(repoList) {
  const from = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>';
  const to = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
    await $`sd -s '${from}' '${to}' page.eta`;
    await $`sd -s '${from}' '${to}' layouts/**/*`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapCss(repoList) {
  const from = '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">';
  const to = '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
    await $`sd -s '${from}' '${to}' page.eta`;
    await $`sd -s '${from}' '${to}' layouts/**/*`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/bootstrap@5.2.3";
  const to = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0";
  const files = [
    "src/sw.js",
    "src/ja/sw.js",
    "src/en/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -f m '${from}' '${to}' ${files.join(" ")}`;
  }
  Deno.chdir(basedir);
}

async function updateSignaturePadJs(repoList) {
  const from = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.4/dist/signature_pad.umd.min.js" integrity="sha256-9WcA0fSt3eVJuMgyitGmuRK/c86bZezvLcAcVMWW42s=" crossorigin="anonymous"></script>';
  const to = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.5/dist/signature_pad.umd.min.js" integrity="sha256-uGyFpu2wVfZ4h/KOsoT+7NdggPAEU2vXx0oNPEYq3J0=" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
  }
  Deno.chdir(basedir);
}

async function updateSignaturePadSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/signature_pad@4.1.4";
  const to = "https://cdn.jsdelivr.net/npm/signature_pad@4.1.5";
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
    await build("tfjs.lst");
    const comment = "bump tfjs from 4.5.0 to 4.6.0";
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
    const comment = "bump bootstrap from 5.2.3 to 5.3.0";
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
    const comment = "bump signature_pad from 4.1.4 to 4.1.5";
    await $`gitn add .. signature_pad.lst "*"`;
    await $`gitn commit .. signature_pad.lst -m "${comment}"`;
    await $`gitn push .. signature_pad.lst`;
    break;
  }
  case "help":
  case "--help":
  default:
    console.log("Usage: update.js [command] [repoList]");
    console.log("Examples:");
    console.log("  updates.js bootstrap");
    console.log("  updates.js build tfjs.lst");
    console.log("  updates.js grep all.lst title src/index.html");
}
