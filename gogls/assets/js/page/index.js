const elm = require("../../src/Main.elm");

window.initElm = function (params) {
  console.log(elm);
  const app = elm.Elm.Main.init(params);
};
