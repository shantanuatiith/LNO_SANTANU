void reorder(int *A, int *B, int *C, int *D, int N) {
  for(int i = 0; i < N; i++) {
	  A[i] = B[i] + 5;
		C[i] = A[i] + 10;
		A[i] = D[i] *12; //A[i - 1];
	}
	return;
}
