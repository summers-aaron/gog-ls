const esbuild = require('esbuild')
const ElmPlugin = require('esbuild-plugin-elm');
const sassPlugin = require('esbuild-plugin-sass');


const bundle = true
const logLevel = process.env.ESBUILD_LOG_LEVEL || 'silent'
const watch = !!process.env.ESBUILD_WATCH

const plugins = [
    ElmPlugin({ debug: true }),
    sassPlugin()
]

const promise = esbuild.build({
    entryPoints: [
        'js/app.js',
        'js/page/index.js'
    ],
    bundle,
    target: 'es2016',
    plugins,
    outdir: '../priv/static/assets',
    logLevel,
    watch
})

if (watch) {
    promise.then(_result => {
        process.stdin.on('close', () => {
            process.exit(0)
        })

        process.stdin.resume()
    })
}