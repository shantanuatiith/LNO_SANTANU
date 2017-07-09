int foo(int  *A) {
	for(int i = 0; i < 999; i++) {
		for(int j = 0; j < 999; j++) {
		A[i+j] = A[i +j - 1];
	}
	}
	return 0;
}
