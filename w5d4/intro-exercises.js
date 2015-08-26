// uniq
Array.prototype.uniq = function() {
  var result = [];
  for (var i = 0; i < this.length ; i++) {
    if (result.indexOf(this[i]) < 0) {
      result.push(this[i]);
    }
  }
  return result;
};

// two_sum
Array.prototype.twoSum = function() {
  var result = [];
  for (var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if ((this[i] + this[j]) === 0) {
        result.push([i, j]);
      }
    }
  }
  return result;
};

Array.prototype.transpose = function () {
    var result = [];
    for (var i = 0; i < this.length; i++) {
      var row = [];
      for (var j = 0; j < this[i].length; j++) {
        row.push(this[j][i]);
      }
      result.push(row);
    }
    return result;
};


//ENUMERABLES

Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++) {
    callback(this[i]);
  }
  return this;
};

Array.prototype.myMap = function (callback) {
  var result = [];
  this.myEach(function (el) {
    result.push(callback(el));
  });
  return result;
};

Array.prototype.myInject = function (callback) {
  var accumulator = this[0];
  this.slice(1).myEach(function (el) {
    accumulator = callback(accumulator, el);
  });
  return accumulator;
};

Array.prototype.bubbleSort = function () {
  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this.length - (1 + i); j++) {
      if (this[j] > this[j+1]) {
        var temp = this[j];
        this[j] = this[j+1];
        this[j+1] = temp;
      }
    }
  }
  return this;
};

String.prototype.substrings = function () {
  var results = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      results.push(this.slice(i,j));
    }
  }
  return results.uniq();
};

function range(start, end) {
  if(end <= start) {
    return [];
  }
  return [start].concat(range(start + 1, end));
};

Array.prototype.mySum = function() {
  if (this.length === 1) {
    return this[0];
  }
  return this.slice(1).mySum() + this[0];
};

function exp1(b, p) {
  if (p === 0) {
    return 1;
  }
  return b * exp1(b, p - 1);
};

function exp2(b, p) {
  if (p === 0) {
    return 1;
  } else if (p === 1) {
    return b;
  } else if (p % 2 === 0) {
    return exp2(b, p/2) * exp2(b, p/2);
  } else {
    return b * (exp2(b, (p-1) / 2) * exp2(b, (p-1) / 2));
  }
};

function fibonacci(n) {
  if(n <= 2) {
    return [0,1].slice(0, n);
  }
  var previous = fibonacci(n-1);
  previous.push(previous[previous.length - 1] + previous[previous.length - 2]);
  return previous;
}

Array.prototype.binarySearch = function (target) {
  if(this.length === 1) {
    return this[0] === target ? 0 : null;
  }
  var mid = Math.floor(this.length / 2);
  if(target < this[mid]) {
    return this.slice(0, mid).binarySearch(target);
  } else {
    var test = this.slice(mid, this.length).binarySearch(target);
    return (test === null) ? test : test + mid;
  }
};

function makeChange(value, coins) {
  if (value === 0) {
    return [];
  }
  var fewestCoins = new Array(value + 1);

  coins.myEach(function(coin) {
    var theseCoins = [];
    if (coin <= value) {
      if (value % coin === 0) {
        for (var i = 0; i < value / coin; i++) {
          theseCoins.push(coin);
        }
      } else {
        theseCoins.push(coin);
        var newCoins = (value - coin < coin) ? coins.slice(1) : coins;
        theseCoins = theseCoins.concat(makeChange(value - coin, newCoins));
      }
      if (theseCoins.length < fewestCoins.length) {
        fewestCoins = theseCoins;
      }
    }
  });

  return fewestCoins;
}

Array.prototype.mergeSort = function () {
  if(this.length < 2) {
    return this;
  }
  var mid = Math.floor(this.length / 2);
  var left = this.slice(0, mid).mergeSort();
  var right = this.slice(mid, this.length).mergeSort();
  return left.merge(right);
};

Array.prototype.merge = function(other) {
  var merged = [];
  var dup = this.slice(0);
  while (dup.length > 0 && other.length > 0) {
    if(dup[0] < other[0]) {
      merged.push(dup[0]);
      dup = dup.slice(1);
    } else {
      merged.push(other[0]);
      other = other.slice(1);
    }
  }
  merged = (dup.length === 0) ? merged.concat(other) : merged.concat(dup);
  return merged;
};

Array.prototype.subsets = function() {
  if (this.length === 0) {
    return [this];
  }
  var previous = this.slice(1).subsets();
  var thisElement = this[0];
  var thisSet = previous.myMap(function(el) {
    return el.concat([thisElement]);
  });
  return previous.concat(thisSet);
};

function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return this.name + " loves " + this.owner;
};

Cat.prototype.meow = function () {
  return "meow meow";
};

function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
}

function Course(name, dept, credits) {
  this.name = name;
  this.dept = dept;
  this.credits = credits;
  this.students = [];
}

Student.prototype.name = function() {
  return this.fname + " " + this.lname;
};

Student.prototype.enroll = function(course) {
  if (this.courses.indexOf(course) < 0) {
    this.courses.push(course);
    course._addStudent(this);
  }
};

Course.prototype._addStudent = function(student) {
  this.students.push(student);
};
