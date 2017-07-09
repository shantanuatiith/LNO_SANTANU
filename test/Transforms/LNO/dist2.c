int foo(int *restrict A, int *restrict B) {
	for(int i = 0; i < 1000; i++) {
		A[i] = A[i - 8] * 23;
		B[i] = A[i] * 43;
	}
	return 0;
}
