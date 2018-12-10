package main
import "os"
import "fmt"
import "strconv"
func main() {
    var (
        element int = 0
        iteration int = 0
        iterations int = 0
        innerloop int = 0
        sum float64 = 0.0
        array_length int = 100000000
        array []float64 = make([]float64, array_length)
    )
    if len(os.Args) > 1 {
        iterations,_ = strconv.Atoi(os.Args[1])
    }
    fmt.Printf("iterations %d\n", iterations)
    for element = 0; element < array_length; element++ {
        array[element] = float64(element)
    }
    for iteration = 0; iteration < iterations; iteration++ {
        for innerloop = 0; innerloop < 1000000000; innerloop++ {
            sum += array[(iteration + innerloop) % array_length]
        }
    }
    fmt.Printf("sum %E\n", sum)
    array = nil
}
