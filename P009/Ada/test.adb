with Ada.Text_IO, Ada.Command_Line, Ada.Unchecked_Deallocation;
use Ada.Text_IO, Ada.Command_Line;
procedure test is
    element : Integer := 0;
    iteration : Integer := 0;
    iterations : Integer := 0;
    innerloop : Integer := 0;
    sum : Standard.Long_Float := 0.0;
    array_length : Integer := 100000000;
    type vector is array (0..array_length) of Standard.Long_Float;
    type vector_access is access vector;
    procedure free_vector is new Ada.Unchecked_Deallocation
        (Object => vector, Name => vector_access);
begin
    declare
        test_array : vector_access := new vector;
    begin
        if Argument_Count > 0 then
            iterations := Integer'Value(Argument(1));
        end if;
        Put_Line("iterations " & Integer'Image(iterations));
        while element < array_length loop
            test_array(element) := Standard.Long_Float(element);
            element := element + 1;
        end loop;
        while iteration < iterations loop
            innerloop := 0;
            while innerloop < 1000000000 loop
                sum := sum + test_array((iteration + innerloop) mod array_length);
                innerloop := innerloop + 1;
            end loop;
            iteration := iteration + 1;
        end loop;
        Put_Line("sum " & Standard.Long_Float'Image(sum));
        free_vector(test_array);
    end;
end test;
