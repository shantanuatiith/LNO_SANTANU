int foo(int *restrict A, int *restrict B) {
	for(int i = 0; i < 1000; i++) {
		A[i] = A[i + 1] * 23;
		//B[i] = A[i] * 43;
	}
	return 0;
}
