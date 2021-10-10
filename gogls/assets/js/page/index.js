const elm = require('../../src/Page/Index.elm');
console.log(elm)

window.initElm = function (params) {
    const app = elm.Elm.Page.Index.init(params);
}
    