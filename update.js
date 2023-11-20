import { $ } from "https://deno.land/x/deno_dx/mod.ts";

function getTimestamp() {
  const date = new Date();
  date.setTime(date.getTime() + (9 * 60 * 60 * 1000));
  const timestamp = date.toISOString().replace("T", " ").slice(0, 16);
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
    "src/zh/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    for (const file of files) {
      try {
        Deno.statSync(file);
        await $`sd -f m "${from}" '${to}' ${file}`;
      } catch {
        // skip
      }
    }
  }
  Deno.chdir(basedir);
}

async function updateTfjs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.12.0";
  const to = "https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@4.13.0";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e js -e html .)`;
  }
  Deno.chdir(basedir);
}

async function updateBootstrapJs(repoList) {
  const from = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>';
  const to = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>';
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
  const from = '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">';
  const to = '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">';
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
  const from = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.1";
  const to = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2";
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
  const from = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.6/dist/signature_pad.umd.min.js" integrity="sha256-9WGszpHeq3MpHIIm/4OJHXD88GiswTgHC78Oa1xulpg=" crossorigin="anonymous"></script>';
  const to = '<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js" integrity="sha256-/8a/3YLn7UlBx9oXDxpq5L47fLEDb29g7bCWF6ho56Q=" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    await $`sd -s '${from}' '${to}' $(fdfind --type file -e html . src)`;
  }
  Deno.chdir(basedir);
}

async function updateSignaturePadSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/signature_pad@4.1.6";
  const to = "https://cdn.jsdelivr.net/npm/signature_pad@4.1.7";
  const files = [
    "src/sw.js",
    "src/ja/sw.js",
    "src/en/sw.js",
  ];
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    Deno.chdir(`${basedir}/../${repoName}`);
    for (const file of files) {
      try {
        Deno.statSync(file);
        await $`sd -f m "${from}" "${to}" ${file}`;
      } catch {
        // skip
      }
    }
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
    const comment = "bump tfjs from 4.12.0 to 4.13.0";
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
    const comment = "bump bootstrap from 5.3.1 to 5.3.2";
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
    const comment = "bump signature_pad from 4.1.6 to 4.1.7";
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
