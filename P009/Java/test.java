public class test {
    public static void main(String[] args) {
        int element = 0;
        int iteration = 0;
        int iterations = 0;
        int innerloop = 0;
        double sum = 0.0;
        int array_length = 100000000;
        double[] array = new double[array_length];
        if (args.length > 0)
            iterations = Integer.parseInt(args[0]);
        System.out.println("iterations " + iterations);
        for (element = 0; element < array_length; element++)
            array[element] = element;
        for (iteration = 0; iteration < iterations; iteration++)
            for (innerloop = 0; innerloop < 1000000000; innerloop++)
                sum += array[(iteration + innerloop) % array_length];
        System.out.println("sum " + sum);
        array = null;
    }
}
