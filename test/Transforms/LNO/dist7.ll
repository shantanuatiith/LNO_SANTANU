; ModuleID = 'dist7.c'
source_filename = "dist7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo([1000 x i32]* %A) #0 {
entry:
  %A.addr = alloca [1000 x i32]*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store [1000 x i32]* %A, [1000 x i32]** %A.addr, align 8
  store i32 3, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc15, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 999
  br i1 %cmp, label %for.body, label %for.end17

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp slt i32 %1, 999
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %j, align 4
  %sub = sub nsw i32 %2, 1
  %idxprom = sext i32 %sub to i64
  %3 = load i32, i32* %i, align 4
  %idxprom4 = sext i32 %3 to i64
  %4 = load [1000 x i32]*, [1000 x i32]** %A.addr, align 8
  %arrayidx = getelementptr inbounds [1000 x i32], [1000 x i32]* %4, i64 %idxprom4
  %arrayidx5 = getelementptr inbounds [1000 x i32], [1000 x i32]* %arrayidx, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx5, align 4
  %6 = load i32, i32* %j, align 4
  %idxprom6 = sext i32 %6 to i64
  %7 = load i32, i32* %i, align 4
  %sub7 = sub nsw i32 %7, 3
  %idxprom8 = sext i32 %sub7 to i64
  %8 = load [1000 x i32]*, [1000 x i32]** %A.addr, align 8
  %arrayidx9 = getelementptr inbounds [1000 x i32], [1000 x i32]* %8, i64 %idxprom8
  %arrayidx10 = getelementptr inbounds [1000 x i32], [1000 x i32]* %arrayidx9, i64 0, i64 %idxprom6
  %9 = load i32, i32* %arrayidx10, align 4
  %add = add nsw i32 %5, %9
  %10 = load i32, i32* %j, align 4
  %idxprom11 = sext i32 %10 to i64
  %11 = load i32, i32* %i, align 4
  %idxprom12 = sext i32 %11 to i64
  %12 = load [1000 x i32]*, [1000 x i32]** %A.addr, align 8
  %arrayidx13 = getelementptr inbounds [1000 x i32], [1000 x i32]* %12, i64 %idxprom12
  %arrayidx14 = getelementptr inbounds [1000 x i32], [1000 x i32]* %arrayidx13, i64 0, i64 %idxprom11
  store i32 %add, i32* %arrayidx14, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %13 = load i32, i32* %j, align 4
  %inc = add nsw i32 %13, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc15

for.inc15:                                        ; preds = %for.end
  %14 = load i32, i32* %i, align 4
  %inc16 = add nsw i32 %14, 1
  store i32 %inc16, i32* %i, align 4
  br label %for.cond

for.end17:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1 (tags/RELEASE_391/final)"}
