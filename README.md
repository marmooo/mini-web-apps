# mini-web-apps

[marmooo.github.io](https://marmooo.github.io/) manager.

## Requirements

- [marmooo/gitn](https://github.com/marmooo/gitn)
- [marmooo/drop-inline-css](https://github.com/marmooo/drop-inline-css)
- minify, rg, sd, fd

## Installation

```
gitn clone .. all.lst
bash install-deps.sh
```

## Usage

```
gitn pull .. all.lst
deno run -A update.js build all.lst
deno run -A update.js grep all.lst keyword src/*
deno run -A update.js sw.js tfjs.lst
deno run -A update.js bootstrap
```

## License

MIT
