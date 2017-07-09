; ModuleID = 'dist4.ll'
source_filename = "dist4.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define i32 @foo(i32* noalias %A, i32* noalias %B) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 8, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 1000
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %sub = sub nsw i32 %i.0, 8
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4    ;                  -----\      
  %idxprom1 = sext i32 %i.0 to i64                                   |
  %arrayidx2 = getelementptr inbounds i32, i32* %B, i64 %idxprom1    |
  %1 = load i32, i32* %arrayidx2, align 4                            |
  %mul = mul nsw i32 %0, %1                                          |
  %idxprom3 = sext i32 %i.0 to i64                                   |
  %arrayidx4 = getelementptr inbounds i32, i32* %A, i64 %idxprom3    /
  store i32 %mul, i32* %arrayidx4, align 4 ;                   ------
  %sub5 = sub nsw i32 %i.0, 2
  %idxprom6 = sext i32 %sub5 to i64
  %arrayidx7 = getelementptr inbounds i32, i32* %B, i64 %idxprom6
  %2 = load i32, i32* %arrayidx7, align 4                      -----
  %idxprom8 = sext i32 %i.0 to i64                                  |
  %arrayidx9 = getelementptr inbounds i32, i32* %B, i64 %idxprom8   |
  store i32 %2, i32* %arrayidx9, align 4                       -----
  br label %for.inc
11
for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.1 (tags/RELEASE_391/final)"}
