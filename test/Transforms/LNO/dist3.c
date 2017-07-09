int foo(int *restrict A, int *restrict B) {
	for(int i = 0; i < 1000; i++) {
		A[i] = A[i - 1] * 23;
		B[i] = B[i - 1] * 43;
	}
	return 0;
}
