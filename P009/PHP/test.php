#!/usr/bin/php
<?php
ini_set('memory_limit', '-1');
$element = 0;
$iteration = 0;
$iterations = 0;
$innerloop = 0;
$sum = 0.0;
$array_length = 100000000;
$array[] = 0;
if ( $argc > 1 ) {
    $iterations = $argv[1];
}
fwrite(STDOUT, "iterations ". $iterations . "\n");
for ($element = 1; $element < $array_length; $element++) {
    $array[] = $element;
}
for ($iteration = 0; $iteration < $iterations; $iteration++) {
    for ($innerloop = 0; $innerloop < 1000000000; $innerloop++) {
        $sum = $sum + $array[($iteration + $innerloop) % $array_length];
    }
}
fwrite(STDOUT, "sum ". $sum . "\n");
$array = 0;
?>
