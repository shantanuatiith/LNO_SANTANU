int foo(int *restrict A, int *restrict B, int *restrict C) {
	for(int i = 4; i < 1000; i++) {
		A[i] = A[i - 1];
		B[i] = B[i - 4];
	}
	return 0;
}
