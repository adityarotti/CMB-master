function ADD_II(A,B)
INTEGER*8 A,B,ADD_II
ADD_II = A+B
return
END

subroutine ADD_array(A,B,C,sz)
INTEGER*8, intent(in) :: sz
INTEGER*8, intent(in) :: B(sz),A(sz)
INTEGER*8, intent(out) :: C(sz)

C= A+B

return
END

subroutine rADD_array(A,B,C,sz)
integer*8, intent(in) :: sz
real*8, intent(in) :: B(sz),A(sz)
real*8, intent(out) :: C(sz)

C= A+B

return
END

