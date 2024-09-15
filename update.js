import { $ } from "npm:zx@8.1.3";

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
    $.cwd = `${basedir}/../${repoName}`;
    console.log(`%c${repoName}`, "font-weight: bold");
    try {
      await $`bash build.sh`.quiet();
    } catch (err) {
      console.log(err);
    }
  }
  $.cwd = basedir;
}

async function grep(repoList, keyword, args) {
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    console.log(`%c${repoName}`, "font-weight: bold");
    try {
      const result = await $`rg --count ${keyword} ${args.join(" ")}`.quiet();
      console.log(result.stdout);
    } catch (_err) {
      /* skip error */
    }
  }
  $.cwd = basedir;
}

async function updateServiceWorker(repoList) {
  const timestamp = getTimestamp();
  const from = "^const CACHE_NAME.*$";
  const to = `const CACHE_NAME = "${timestamp}";`;
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind --glob -p **/src/**/sw.js -x sd -f m ${from} ${to} {}`
      .quiet();
  }
  $.cwd = basedir;
}

async function updateBootstrapJs(repoList) {
  const from =
    '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>';
  const to =
    '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind -tf -p -e html src -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind page.eta -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind -tf -p -e eta eta -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind -tf -p layouts -x sd -s ${from} ${to} {}`.quiet();
  }
  $.cwd = basedir;
}

async function updateBootstrapCss(repoList) {
  const from =
    '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">';
  const to =
    '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">';
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind -tf -p -e html src -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind page.eta -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind -tf -p -e eta eta -x sd -s ${from} ${to} {}`.quiet();
    await $`fdfind -tf -p layouts -x sd -s ${from} ${to} {}`.quiet();
  }
  $.cwd = basedir;
}

async function updateBootstrapSwJs(repoList) {
  const from = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.2";
  const to = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind --glob -p **/src/**/sw.js -x sd -f m ${from} ${to} {}`
      .quiet();
  }
  $.cwd = basedir;
}

async function updateSignaturePadJs(repoList) {
  const from = "signature_pad@5.0.2";
  const to = "signature_pad@5.0.3";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind -tf -p -e js src -x sd -s ${from} ${to}`.quiet();
  }
  $.cwd = basedir;
}

async function updateTfjs(repoList) {
  const from = "@tensorflow/tfjs@4.20.0";
  const to = "@tensorflow/tfjs@4.21.0";
  const basedir = Deno.cwd();
  for (const repoName of getRepos(repoList)) {
    $.cwd = `${basedir}/../${repoName}`;
    await $`fdfind -tf -p -e js src -x sd -s ${from} ${to}`.quiet();
  }
  $.cwd = basedir;
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
    const comment = "bump tfjs from 4.20.0 to 4.21.0";
    await $`gitn add .. tfjs.lst -A`.quiet();
    await $`gitn commit .. tfjs.lst -m ${comment}`.quiet();
    await $`gitn push .. tfjs.lst`.quiet();
    break;
  }
  case "bootstrap": {
    await updateBootstrapJs("all.lst");
    await updateBootstrapCss("all.lst");
    await updateBootstrapSwJs("all.lst");
    await updateServiceWorker("all.lst");
    await build("all.lst");
    const comment = "bump bootstrap from 5.3.2 to 5.3.3";
    await $`gitn add .. all.lst -A`.quiet();
    await $`gitn commit .. all.lst -m ${comment}`;
    await $`gitn push .. all.lst`.quiet();
    break;
  }
  case "signature_pad": {
    await updateSignaturePadJs("signature_pad.lst");
    await updateServiceWorker("signature_pad.lst");
    await build("signature_pad.lst");
    const comment = "bump signature_pad from 5.0.2 to 5.0.3";
    await $`gitn add .. signature_pad.lst -A`.quiet();
    await $`gitn commit .. signature_pad.lst -m ${comment}`.quiet();
    await $`gitn push .. signature_pad.lst`.quiet();
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
