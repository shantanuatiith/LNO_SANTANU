int foo(int  A[][1000]) {
	int B[1000][1000];
	for(int i = 0; i < 999; i++) {
		for(int j = 0; j < 999; j++) {
		A[i][j] = A[i - 1][j + 1];
		B[i][j]  = A[i][j];
		A[i][j] = A[i + 1][j + 1];
		
	}
	}
	return 0;
}
