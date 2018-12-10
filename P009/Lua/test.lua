#!/usr/bin/lua
element = 0
iteration = 0
iterations = 0
innerloop = 0
sum = 0
array_length = 100000000
array = {}
if #arg > 0 then
    iterations = tonumber(arg[1])
end
print("iterations ", iterations)
for element=0, array_length-1 do
    array[element] = element
end
for iteration=0, iterations-1 do
    for innerloop=0, 1000000000-1 do
        sum = sum + array[((iteration + innerloop) % array_length)]
    end
end
print("sum ", sum)
array = nil
