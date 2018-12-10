#!/usr/bin/ruby

require 'matrix'
element = 0.0
iteration = 0
iterations = 0
innerloop = 0
sum = 0.0
array_length = 100000000
array = Array.new(array_length) {0.0}
vector = [array]
if ARGV[0]
    iterations = ARGV[0].to_i
end
puts "iterations #{iterations}"
for element in 0..array_length-1
    vector[element] = element
end
for iteration in 0..iterations-1
    for innerloop in 0..1000000000-1
        sum = sum + vector[(iteration + innerloop) % array_length];
    end
end
printf("sum %E\n", sum);
array = nil
