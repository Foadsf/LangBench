#!/usr/bin/perl

$element = 0.0;
$iteration = 0;
$iterations = 0;
$innerloop = 0;
$sum = 0.0;
$array_length = 100000000;
@array = [];
$argc = @ARGV;
if ($argc > 0) {
    $iterations = $ARGV[0];
}
print("iterations $iterations\n");
for ($element = 0.0; $element < 100000000.0; $element++) {
    $array[$element] = $element;
}
for ($iteration = 0; $iteration < $iterations; $iteration++) {
    for ($innerloop = 0; $innerloop < 1000000000; $innerloop++) {
        $sum += $array[($iteration + $innerloop) % $array_length];
    }
}
print("sum $sum\n");
@array = [];
