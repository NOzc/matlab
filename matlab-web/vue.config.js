module.exports = {
  devServer: {
    port: 8081,   // 端口号
  },
  publicPath: process.env.NODE_ENV === 'production' ? '' : '',
  outputDir: "dist",
  assetsDir: "static",
}
