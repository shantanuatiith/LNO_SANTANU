int foo(int A[][1000]){
for(int i=0; i<997; i++)
  for(int j=1; j<1000; j++)
    A[i][j] = A[i+3][j-1];

return 0;
}

