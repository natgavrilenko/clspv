
; RUN: clspv-opt --passes=replace-opencl-builtin,replace-llvm-intrinsics %s -o %t.ll
; RUN: FileCheck %s < %t.ll

; AUTO-GENERATED TEST FILE
; This test was generated by add_sat_test_gen.cpp.
; Please modify the that file and regenerate the tests to make changes.

target datalayout = "e-p:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "spir-unknown-unknown"

define <3 x i32> @add_sat_int3(<3 x i32> %a, <3 x i32> %b) {
entry:
 %call = call <3 x i32> @_Z7add_satDv3_iS_(<3 x i32> %a, <3 x i32> %b)
 ret <3 x i32> %call
}

declare <3 x i32> @_Z7add_satDv3_iS_(<3 x i32>, <3 x i32>)

; CHECK: [[add:%[a-zA-Z0-9_.]+]] = add <3 x i32> %a, %b
; CHECK: [[b_lt_0:%[a-zA-Z0-9_.]+]] = icmp slt <3 x i32> %b, zeroinitializer
; CHECK: [[add_gt_a:%[a-zA-Z0-9_.]+]] = icmp sgt <3 x i32> [[add]], %a
; CHECK: [[add_lt_a:%[a-zA-Z0-9_.]+]] = icmp slt <3 x i32> [[add]], %a
; CHECK: [[min_clamp:%[a-zA-Z0-9_.]+]] = select <3 x i1> [[add_gt_a]], <3 x i32> <i32 -2147483648, i32 -2147483648, i32 -2147483648>, <3 x i32> [[add]]
; CHECK: [[max_clamp:%[a-zA-Z0-9_.]+]] = select <3 x i1> [[add_lt_a]], <3 x i32> <i32 2147483647, i32 2147483647, i32 2147483647>, <3 x i32> [[add]]
; CHECK: [[sel:%[a-zA-Z0-9_.]+]] = select <3 x i1> [[b_lt_0]], <3 x i32> [[min_clamp]], <3 x i32> [[max_clamp]]
; CHECK: ret <3 x i32> [[sel]]
