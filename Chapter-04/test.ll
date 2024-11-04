; RUN: opt -O0 -S test.ll > 0.ll
;      opt -O1 -S test.ll > 1.ll
;      opt -O2 -S test.ll > 2.ll
;      opt -O3 -S test.ll > 3.ll
; And see the difference in the optimized code for the O0, O1 and O2 levels.

define internal i32 @test(i32* %X, i32* %Y)
{
  %A = load i32, i32* %X
  %B = load i32, i32* %Y
  %C = add i32 %A, %B
  ret i32 %C
}

define internal i32 @caller(i32* %B)
{
  %A = alloca i32
  store i32 1, i32* %A
  %C = call i32 @test(i32* %A, i32* %B)
  ret i32 %C
}

define i32 @callercaller()
{
  %B = alloca i32
  store i32 2, i32* %B
  %X = call i32 @caller(i32* %B)
  ret i32 %X
}
