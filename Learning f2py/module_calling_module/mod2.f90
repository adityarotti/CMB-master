module mod2
use mod1

contains
subroutine add_num(a,b,c)
real*8, intent(in):: a,b
real*8, intent(out):: c
c=add(a,b)
end subroutine add_num

end module mod2
