Function.prototype.myBind = function(context) {
    var fn = this;
    return function () {
        fn.apply(context, []);
    };
};

function Cat(name) {
  this.name = name;
}

var lol = function () {
  console.log(this.name + " lol");
};

var a = new Cat("guy");

var x = lol.myBind(a);
x();
a.lol();
