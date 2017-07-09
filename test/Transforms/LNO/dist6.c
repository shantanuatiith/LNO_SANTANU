int foo(int  A[][1000], B[][1000]) {
	for(int i = 0; i < 999; i++) {
		for(int j = 2; j < 999; j++) {
		//A[i][j] = A[i + 1][j + 1];
		A[i][j] = A[i - 3][j - 2];
		//B[i][j] = B[i+3][j+3];
	}
}
	return 0;
}
