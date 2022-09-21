
option = {
  series: [{
    type: 'surface',//曲面图
    parametric: false,//是否是参数曲面,
    wireframe: {//曲面图的网格线
      show: true
    },
    equation: {},//曲面的函数表达式
    parametricEquation:{},//参数方程
    itemStyle: {},//曲面的颜色，不透明度等样式
    data: [
      [-1,-1,0],[-0.5,-1,0],[0,-1,0],[0.5,-1,0],[1,-1,0],
      [-1,-0.5,0],[-0.5,-0.5,1],[0,-0.5,0],[0.5,-0.5,-1],[1,-0.5,0],
      [-1,0,0],[-0.5,0,0],[0,0,0],[0.5,0,0],[1,0,0],
      [-1,0.5,0],[-0.5,0.5,-1],[0,0.5,0],[0.5,0.5,1],[1,0.5,0],
      [-1,1,0],[-0.5,1,0],[0,1,0],[0.5,1,0],[1,1,0]
    ],
    shading: 'realistic',//着色渲染

  }]
}