#!/usr/bin/node --max-old-space-size=4096

var element = 0;
var iteration = 0;
var iterations = 0;
var innerloop = 0;
var sum = 0.0;
var array_length = 100000000;
var array = new Array(array_length);
var argc = process.argv.length
if (argc > 2)
    iterations = process.argv[2];
console.log("iterations " + iterations);
for (element = 0; element < array_length; element++)
    array[element] = element;
for (iteration = 0; iteration < iterations; iteration++)
    for (innerloop = 0; innerloop < 1000000000; innerloop++)
        sum += array[(iteration + innerloop) % array_length];
console.log("sum " + sum);
array = 0
