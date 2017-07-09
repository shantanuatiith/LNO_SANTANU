int foo(int  A[][1000]) {

	for(int i = 3; i < 999; i++) {
		for(int j = 1; j < 999; j++) {
		  A[i][j] = A[i][j-1] + A[i -3][j];

	}
}
	return 0;
}
