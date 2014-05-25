#include <stdio.h>

/* print Fahrenheit-Celsius table
   for fahr = 0, 20, ..., 300; flating-point version */
main()
{
	//int fahr, celsius;
	//int lower, upper, step;
	float fahr, celsius;
	float lower, upper, step;

	lower = 0; /* lower limit of temperature scale */
	upper = 300; /* upper limit */
	step = 20; /* step size */

	fahr = lower;
	printf("Fahrenheit Celsius\n");
	while (fahr <= upper) {
		//celsius = 5 * (fahr-32) / 9;
		celsius = (5.0/9.0) * (fahr-32);
		//printf("%d\t%d\n", fahr, celsius);
		//printf("%3d %6d\n", fahr, celsius);
		//printf("%3.0f %6.1f\n", fahr, celsius);
		printf("%10.0f %7.1f\n", fahr, celsius);/* exp 1-3 */
		fahr = fahr + step;
	}

	/* exp 1-4 */
	printf("Input Celsius: ");
	scanf("%f", &celsius);
	printf("The corrsponding fahrenheit is %f.\n", (9.0/5.0) * celsius + 32.0);
}
