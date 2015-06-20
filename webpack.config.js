module.exports = {
    entry: "./src/client/script.coffee",
    output: {
        path: __dirname,
        filename: "static/js/bundle.js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css" },
            { test: /\.(sass)$/, loader: "style!css!sass?indentedSyntax=sass" },
            { test: /\.coffee$/, loader: "coffee-loader" },
            { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
        ]
    },
    resolve: {
      extensions: ["", ".webpack.js", ".web.js", ".js", ".coffee", "sass"]
    }
};
