program testpascal;
uses sysutils;
type
    vector = array of double;
var
    element : longint;
    iteration : longint;
    iterations : longint;
    innerloop : longint;
    sum : double;
    array_length : longint;
    my_array : vector;
begin
    element := 0;
    iteration := 0;
    iterations := 0;
    innerloop := 0;
    sum := 0.0;
    array_length := 100000000;
    setlength(my_array, array_length);
    if paramcount > 0 then
        iterations := strtoint(paramstr(1));
    writeln('iterations ', iterations);
    for element := 0 to array_length-1 do
        my_array[element] := element;
    for iteration := 0 to iterations-1 do
        for innerloop := 0 to 1000000000-1 do
            sum := sum + my_array[(iteration + innerloop) mod array_length];
    writeln('sum ', sum);
    my_array := nil;
end.
