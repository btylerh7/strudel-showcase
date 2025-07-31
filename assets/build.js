import esbuild from 'esbuild';
import { copy } from 'esbuild-plugin-copy';

const args = process.argv.slice(2);
const watch = args.includes('--watch');
const deploy = args.includes('--deploy');

const loader = {
  // Add loaders for images/fonts/etc, e.g. { '.svg': 'file' }
}
const plugins = [
  // Add the copy plugin here
  copy({
    from: './css', // Source directory relative to assets/
    to: '../priv/static/css', // Destination directory relative to assets/build (which is usually where esbuild outputs)
    // You might need to adjust 'to' based on your esbuild output path
    // If your esbuild output is directly in priv/static, then 'to' might just be './css'
  }),
];

// Define esbuild options
let opts = {
  entryPoints: ["js/app.js"],
  bundle: true,
  logLevel: "info",
  target: "es2017",
  outdir: "../priv/static/assets",
  external: ["*.css", "fonts/*", "images/*"],
  nodePaths: ["../deps"],
  loader: loader,
  plugins: plugins,
};

if (deploy) {
  opts = {
    ...opts,
    minify: true,
  };
}

if (watch) {
  opts = {
    ...opts,
    sourcemap: "inline",
  };
  esbuild
    .context(opts)
    .then((ctx) => {
      ctx.watch();
    })
    .catch((_error) => {
      process.exit(1);
    });
} else {
  esbuild.build(opts);
}

