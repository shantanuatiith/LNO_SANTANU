int foo(int *restrict A, int *restrict B) {
	for(int i = 5; i < 1000; i++) {
		A[i] = A[i - 8];
		B[i] = B[i-2];
	}
	return 0;
}
