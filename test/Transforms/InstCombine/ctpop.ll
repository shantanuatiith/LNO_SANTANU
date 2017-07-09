; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -instcombine | FileCheck %s

declare i32 @llvm.ctpop.i32(i32)
declare i8 @llvm.ctpop.i8(i8)
declare void @llvm.assume(i1)

define i1 @test1(i32 %arg) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    ret i1 false
;
  %and = and i32 %arg, 15
  %cnt = call i32 @llvm.ctpop.i32(i32 %and)
  %res = icmp eq i32 %cnt, 9
  ret i1 %res
}

define i1 @test2(i32 %arg) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret i1 false
;
  %and = and i32 %arg, 1
  %cnt = call i32 @llvm.ctpop.i32(i32 %and)
  %res = icmp eq i32 %cnt, 2
  ret i1 %res
}

define i1 @test3(i32 %arg) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    [[ASSUME:%.*]] = icmp eq i32 [[ARG:%.*]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[ASSUME]])
; CHECK-NEXT:    ret i1 false
;
  ;; Use an assume to make all the bits known without triggering constant
  ;; folding.  This is trying to hit a corner case where we have to avoid
  ;; taking the log of 0.
  %assume = icmp eq i32 %arg, 0
  call void @llvm.assume(i1 %assume)
  %cnt = call i32 @llvm.ctpop.i32(i32 %arg)
  %res = icmp eq i32 %cnt, 2
  ret i1 %res
}

; Negative test for when we know nothing
define i1 @test4(i8 %arg) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[CNT:%.*]] = call i8 @llvm.ctpop.i8(i8 [[ARG:%.*]])
; CHECK-NEXT:    [[RES:%.*]] = icmp eq i8 [[CNT]], 2
; CHECK-NEXT:    ret i1 [[RES]]
;
  %cnt = call i8 @llvm.ctpop.i8(i8 %arg)
  %res = icmp eq i8 %cnt, 2
  ret i1 %res
}