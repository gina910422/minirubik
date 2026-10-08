input_state:
    .asciz "25314672313211"

move_R:   .asciz "R"
move_R2:  .asciz "R2"
move_Rp:  .asciz "R'"
move_B:   .asciz "B"
move_B2:  .asciz "B2"
move_Bp:  .asciz "B'"
move_D:   .asciz "D"
move_D2:  .asciz "D2"
move_Dp:  .asciz "D'"

.align 2
move_names:
    .word move_R, move_R2, move_Rp
    .word move_B, move_B2, move_Bp
    .word move_D, move_D2, move_Dp

move_face:
    .byte 0,0,0,1,1,1,2,2,2

move_source:
    .byte 1,4,2,0,3,5,6
    .byte 4,3,2,1,0,5,6
    .byte 3,0,2,4,1,5,6
    .byte 0,1,2,4,5,6,3
    .byte 0,1,2,5,6,3,4
    .byte 0,1,2,6,3,4,5
    .byte 0,2,5,3,1,4,6
    .byte 0,5,4,3,2,1,6
    .byte 0,4,1,3,5,2,6

move_twist:
    .byte 1,2,0,2,1,0,0
    .byte 0,0,0,0,0,0,0
    .byte 1,2,0,2,1,0,0
    .byte 0,0,0,1,2,1,2
    .byte 0,0,0,0,0,0,0
    .byte 0,0,0,1,2,1,2
    .byte 0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0
    .byte 0,0,0,0,0,0,0

orientation_table:
    .byte 0, 5, 5, 4, 4, 5, 4, 6, 3, 6, 3, 4, 4, 3, 5, 5
    .byte 1, 5, 5, 4, 4, 5, 5, 3, 3, 5, 4, 4, 3, 6, 4, 5
    .byte 4, 5, 4, 4, 4, 4, 2, 3, 5, 4, 5, 5, 4, 5, 5, 4 
    .byte 5, 4, 3, 5, 3, 5, 4, 5, 4, 5, 5, 5, 4, 4, 5, 5 
    .byte 4, 5, 4, 5, 4, 5, 4, 5, 4, 4, 4, 5, 5, 5, 3, 4
    .byte 4, 5, 3, 5, 4, 5, 4, 5, 4, 5, 4, 4, 4, 4, 5, 5 
    .byte 4, 4, 5, 4, 5, 5, 5, 4, 5, 4, 4, 5, 4, 5, 3, 5 
    .byte 6, 5, 5, 4, 6, 4, 5, 5, 4, 5, 5, 6, 5, 4, 6, 5 
    .byte 4, 5, 6, 4, 4, 5, 5, 6, 3, 4, 4, 5, 6, 4, 3, 5 
    .byte 2, 5, 4, 5, 5, 5, 3, 5, 5, 5, 4, 5, 4, 5, 6, 5 
    .byte 5, 5, 5, 5, 3, 6, 4, 3, 4, 3, 5, 4, 5, 5, 2, 5 
    .byte 4, 5, 4, 5, 4, 5, 4, 4, 4, 4, 3, 5, 4, 5, 5, 4 
    .byte 4, 5, 3, 5, 6, 4, 5, 5, 4, 5, 4, 5, 5, 5, 4, 4 
    .byte 5, 5, 4, 4, 5, 5, 5, 5, 4, 4, 5, 4, 6, 5, 5, 5 
    .byte 6, 6, 5, 4, 3, 4, 4, 5, 5, 6, 4, 6, 5, 5, 5, 5 
    .byte 5, 4, 5, 5, 3, 5, 4, 4, 5, 4, 5, 5, 5, 4, 3, 3 
    .byte 5, 4, 4, 5, 5, 6, 4, 3, 4, 4, 4, 4, 2, 5, 4, 4 
    .byte 4, 4, 5, 4, 4, 4, 4, 4, 5, 5, 4, 3, 5, 5, 5, 5 
    .byte 4, 5, 2, 4, 5, 3, 4, 5, 3, 4, 5, 5, 4, 5, 5, 3 
    .byte 4, 4, 4, 5, 6, 4, 5, 4, 5, 3, 5, 4, 5, 5, 5, 4 
    .byte 5, 4, 5, 4, 3, 3, 5, 3, 4, 4, 5, 5, 4, 4, 4, 5 
    .byte 5, 4, 5, 4, 4, 3, 3, 5, 4, 4, 5, 3, 5, 2, 4, 4 
    .byte 5, 4, 4, 4, 5, 5, 5, 5, 5, 4, 5, 4, 5, 4, 5, 4 
    .byte 5, 5, 4, 5, 5, 5, 5, 4, 5, 5, 4, 5, 3, 4, 4, 5 
    .byte 4, 4, 5, 4, 5, 5, 5, 3, 4, 3, 3, 4, 2, 3, 3, 5 
    .byte 4, 4, 5, 5, 4, 5, 5, 2, 5, 4, 4, 5, 4, 4, 4, 4 
    .byte 5, 5, 5, 2, 5, 5, 5, 4, 5, 4, 1, 5, 6, 5, 2, 5 
    .byte 5, 4, 3, 4, 5, 4, 5, 5, 4, 5, 6, 3, 4, 4, 4, 4 
    .byte 4, 5, 4, 4, 5, 3, 4, 5, 4, 4, 3, 5, 5, 5, 4, 5 
    .byte 4, 5, 5, 6, 5, 4, 6, 5, 5, 5, 5, 4, 5, 5, 5, 5 
    .byte 3, 5, 4, 5, 4, 4, 5, 5, 3, 4, 5, 5, 4, 4, 4, 5 
    .byte 4, 5, 4, 5, 4, 5, 4, 4, 5, 4, 4, 5, 5, 4, 4, 5 
    .byte 5, 4, 5, 5, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5 
    .byte 5, 3, 4, 5, 6, 4, 5, 5, 5, 4, 4, 5, 4, 5, 4, 4 
    .byte 5, 5, 4, 4, 5, 5, 4, 5, 5, 4, 6, 4, 4, 5, 4, 5 
    .byte 6, 5, 6, 6, 5, 5, 4, 5, 2, 5, 5, 5, 5, 5, 3, 4 
    .byte 3, 4, 5, 5, 4, 4, 3, 6, 6, 5, 5, 5, 5, 5, 6, 4 
    .byte 4, 5, 5, 4, 4, 5, 6, 5, 5, 4, 5, 6, 5, 3, 4, 4 
    .byte 5, 5, 5, 6, 5, 6, 4, 5, 5, 5, 6, 4, 4, 5, 4, 4 
    .byte 4, 4, 5, 4, 4, 5, 4, 5, 4, 3, 4, 5, 5, 5, 5, 5 
    .byte 5, 5, 4, 4, 5, 4, 4, 5, 3, 5, 3, 4, 3, 5, 4, 4 
    .byte 5, 4, 5, 5, 5, 2, 4, 4, 3, 4, 3, 4, 4, 5, 3, 4 
    .byte 5, 5, 4, 5, 4, 5, 4, 5, 4, 5, 5, 5, 4, 5, 5, 5 
    .byte 5, 5, 6, 5, 4, 5, 6, 5, 4, 5, 3, 5, 5, 4, 3, 4 
    .byte 4, 4, 5, 4, 4, 5, 4, 5, 6, 5, 4, 5, 5, 4, 4, 5 
    .byte 5, 5, 4, 5, 4, 5, 3, 5, 5



permutation_table:
    .byte 0, 7, 7, 6, 6, 6, 7, 5, 6, 1, 6, 6, 6, 6, 6, 6
    .byte 1, 6, 1, 6, 6, 7, 6, 5, 7, 3, 3, 6, 6, 6, 5, 5
    .byte 6, 6, 4, 4, 4, 5, 5, 4, 6, 5, 6, 4, 5, 5, 3, 5
    .byte 5, 5, 4, 6, 5, 4, 6, 4, 6, 4, 4, 5, 6, 5, 3, 4
    .byte 5, 5, 5, 5, 6, 5, 5, 4, 6, 4, 5, 5, 6, 3, 6, 4
    .byte 7, 6, 4, 4, 3, 6, 4, 4, 6, 5, 5, 5, 6, 6, 4, 3
    .byte 6, 4, 4, 5, 5, 5, 4, 5, 6, 6, 4, 4, 4, 5, 4, 5
    .byte 6, 5, 5, 4, 5, 5, 3, 5, 7, 4, 5, 5, 5, 5, 4, 5
    .byte 5, 6, 4, 5, 5, 4, 5, 5, 6, 5, 6, 5, 5, 5, 5, 6
    .byte 5, 5, 5, 6, 3, 5, 6, 5, 3, 4, 4, 6, 6, 2, 4, 5
    .byte 5, 6, 5, 5, 6, 3, 6, 5, 3, 4, 4, 5, 6, 6, 6, 6
    .byte 6, 3, 5, 4, 5, 5, 5, 5, 3, 5, 2, 5, 6, 5, 5, 6
    .byte 6, 5, 5, 2, 5, 5, 1, 6, 6, 5, 5, 6, 6, 5, 6, 5
    .byte 5, 2, 6, 6, 2, 5, 5, 6, 6, 5, 5, 7, 3, 4, 6, 5
    .byte 3, 5, 4, 5, 5, 2, 5, 5, 5, 6, 5, 5, 6, 3, 6, 4
    .byte 5, 5, 5, 3, 6, 5, 3, 4, 6, 6, 5, 5, 4, 6, 5, 5
    .byte 5, 3, 5, 6, 2, 7, 5, 4, 6, 5, 4, 5, 5, 6, 6, 5
    .byte 4, 6, 4, 4, 4, 5, 6, 4, 5, 5, 6, 3, 5, 5, 4, 5
    .byte 6, 4, 5, 5, 4, 6, 4, 6, 5, 5, 4, 4, 4, 5, 5, 5
    .byte 5, 4, 5, 5, 5, 5, 3, 6, 5, 4, 5, 6, 4, 5, 6, 6
    .byte 4, 4, 5, 5, 5, 4, 5, 6, 5, 6, 4, 6, 6, 3, 5, 5
    .byte 5, 6, 6, 3, 5, 6, 3, 5, 5, 6, 5, 5, 5, 6, 6, 5
    .byte 5, 3, 6, 5, 2, 5, 6, 5, 6, 5, 6, 5, 2, 5, 6, 6
    .byte 1, 6, 6, 5, 5, 2, 6, 5, 6, 5, 5, 5, 5, 2, 6, 5
    .byte 6, 5, 4, 6, 5, 3, 7, 4, 6, 6, 3, 5, 4, 6, 4, 3
    .byte 5, 6, 6, 4, 6, 6, 5, 3, 4, 6, 6, 3, 6, 5, 3, 5
    .byte 6, 5, 6, 5, 5, 6, 5, 6, 5, 3, 5, 5, 2, 6, 6, 4
    .byte 4, 5, 5, 5, 4, 6, 5, 5, 3, 5, 5, 4, 5, 4, 6, 4
    .byte 4, 5, 5, 5, 4, 4, 5, 5, 5, 5, 4, 6, 6, 5, 6, 5
    .byte 6, 5, 3, 5, 4, 5, 5, 4, 5, 6, 5, 4, 6, 6, 5, 6
    .byte 3, 4, 4, 6, 5, 6, 6, 5, 6, 3, 5, 4, 5, 6, 6, 5
    .byte 2, 6, 3, 5, 5, 5, 5, 6, 4, 4, 6, 5, 5, 4, 6, 3
    .byte 6, 5, 6, 4, 4, 6, 4, 5, 5, 5, 5, 5, 5, 6, 5, 4
    .byte 5, 4, 4, 5, 5, 5, 6, 6, 6, 5, 4, 4, 3, 6, 6, 3
    .byte 6, 6, 5, 3, 5, 6, 4, 5, 5, 5, 5, 6, 6, 2, 5, 2
    .byte 6, 4, 5, 6, 6, 5, 1, 6, 5, 5, 4, 6, 6, 5, 5, 2
    .byte 5, 3, 5, 5, 5, 6, 5, 6, 6, 5, 4, 4, 4, 5, 5, 5
    .byte 5, 4, 5, 5, 5, 5, 4, 6, 4, 6, 5, 3, 6, 5, 3, 4
    .byte 5, 5, 6, 5, 5, 5, 5, 5, 5, 3, 5, 6, 2, 6, 6, 4
    .byte 6, 4, 4, 5, 5, 5, 6, 5, 5, 7, 4, 3, 3, 6, 5, 3
    .byte 6, 6, 6, 3, 5, 6, 4, 6, 5, 4, 4, 6, 5, 5, 5, 5
    .byte 5, 5, 4, 5, 5, 5, 4, 5, 5, 5, 4, 5, 6, 4, 4, 5
    .byte 5, 5, 6, 5, 3, 5, 6, 6, 3, 5, 6, 4, 4, 4, 6, 6
    .byte 5, 6, 4, 6, 5, 4, 5, 6, 4, 6, 6, 3, 5, 5, 3, 4
    .byte 6, 5, 5, 5, 5, 6, 5, 6, 4, 3, 5, 6, 2, 6, 6, 5
    .byte 7, 5, 4, 5, 5, 5, 5, 6, 5, 6, 5, 5, 5, 5, 5, 5
    .byte 6, 4, 6, 5, 5, 4, 4, 5, 3, 7, 5, 5, 5, 5, 5, 5
    .byte 5, 4, 4, 6, 6, 6, 5, 4, 4, 5, 4, 4, 6, 6, 6, 4
    .byte 5, 5, 6, 4, 6, 4, 4, 4, 6, 5, 5, 5, 4, 5, 4, 6
    .byte 4, 4, 5, 6, 3, 6, 5, 3, 5, 4, 5, 6, 4, 6, 6, 5
    .byte 4, 5, 6, 4, 4, 3, 5, 5, 5, 6, 4, 5, 5, 4, 5, 6
    .byte 4, 6, 4, 6, 5, 4, 5, 5, 5, 5, 4, 6, 6, 6, 5, 4
    .byte 4, 6, 4, 3, 6, 6, 6, 5, 6, 5, 4, 4, 4, 5, 4, 5
    .byte 5, 7, 4, 4, 4, 5, 6, 3, 6, 5, 6, 4, 5, 5, 4, 5
    .byte 5, 6, 5, 4, 6, 3, 4, 4, 5, 4, 5, 6, 6, 6, 4, 5
    .byte 5, 4, 5, 4, 3, 5, 5, 4, 6, 3, 5, 5, 4, 6, 4, 5
    .byte 4, 5, 4, 4, 4, 3, 6, 5, 6, 4, 6, 5, 5, 4, 4, 6
    .byte 5, 5, 2, 7, 5, 5, 6, 6, 5, 5, 3, 5, 5, 5, 5, 3
    .byte 4, 6, 4, 3, 6, 4, 6, 5, 4, 5, 5, 5, 6, 3, 4, 4
    .byte 5, 3, 6, 6, 6, 5, 4, 6, 4, 4, 4, 5, 4, 6, 5, 4
    .byte 4, 4, 6, 5, 5, 5, 4, 6, 5, 4, 6, 5, 5, 6, 5, 7
    .byte 4, 5, 3, 6, 5, 5, 4, 5, 6, 5, 6, 5, 2, 5, 6, 5
    .byte 3, 5, 6, 4, 5, 3, 4, 6, 5, 6, 6, 5, 6, 3, 4, 5
    .byte 5, 5, 2, 5, 6, 6, 5, 6, 6, 4, 3, 5, 6, 6, 5, 3
    .byte 5, 5, 4, 3, 4, 5, 6, 6, 5, 3, 5, 3, 5, 5, 2, 6
    .byte 5, 5, 4, 4, 4, 5, 5, 5, 5, 3, 4, 5, 3, 4, 4, 6
    .byte 6, 4, 5, 6, 6, 5, 6, 5, 6, 6, 4, 4, 4, 5, 5, 4
    .byte 6, 6, 5, 5, 6, 5, 5, 4, 6, 4, 3, 5, 6, 6, 4, 5
    .byte 6, 6, 4, 4, 5, 5, 6, 4, 5, 5, 6, 4, 4, 5, 4, 6
    .byte 1, 6, 6, 5, 6, 6, 6, 5, 6, 2, 5, 5, 5, 5, 6, 5
    .byte 2, 5, 2, 6, 5, 6, 5, 5, 6, 4, 5, 5, 5, 4, 6, 5
    .byte 5, 7, 4, 4, 3, 5, 5, 4, 6, 6, 6, 4, 6, 6, 4, 4
    .byte 5, 5, 6, 7, 3, 4, 6, 4, 4, 4, 5, 4, 5, 4, 3, 5
    .byte 5, 6, 5, 6, 6, 4, 4, 4, 3, 5, 6, 5, 4, 4, 5, 3
    .byte 5, 4, 6, 5, 4, 5, 4, 5, 4, 5, 4, 6, 4, 5, 5, 4
    .byte 6, 5, 5, 5, 4, 4, 5, 4, 3, 6, 5, 6, 6, 4, 5, 5
    .byte 6, 5, 5, 6, 4, 4, 6, 4, 6, 5, 5, 2, 5, 5, 3, 6
    .byte 5, 7, 5, 5, 4, 5, 5, 4, 6, 3, 6, 4, 3, 6, 5, 5
    .byte 2, 5, 6, 5, 4, 4, 6, 3, 5, 3, 6, 5, 4, 5, 4, 5
    .byte 3, 6, 3, 5, 5, 5, 5, 4, 5, 5, 6, 4, 4, 5, 4, 5
    .byte 3, 5, 6, 6, 5, 4, 6, 6, 5, 3, 4, 5, 4, 4, 6, 5
    .byte 5, 6, 3, 4, 5, 6, 5, 6, 5, 5, 4, 5, 6, 5, 5, 4
    .byte 5, 5, 4, 4, 4, 4, 6, 5, 5, 4, 6, 5, 6, 5, 4, 5
    .byte 5, 5, 6, 5, 5, 5, 4, 6, 4, 5, 4, 5, 5, 5, 4, 5
    .byte 5, 6, 6, 5, 2, 5, 5, 4, 3, 5, 6, 5, 6, 3, 5, 5
    .byte 4, 6, 5, 5, 6, 3, 5, 4, 6, 6, 3, 4, 6, 6, 4, 5
    .byte 6, 5, 4, 5, 5, 6, 6, 4, 5, 4, 5, 4, 4, 5, 6, 5
    .byte 4, 3, 5, 4, 6, 4, 3, 5, 6, 4, 5, 4, 4, 5, 5, 6
    .byte 4, 4, 3, 6, 4, 5, 4, 5, 5, 4, 4, 5, 6, 5, 6, 5
    .byte 5, 6, 4, 4, 4, 6, 5, 3, 5, 6, 6, 4, 5, 6, 5, 4
    .byte 6, 5, 4, 4, 4, 5, 4, 5, 4, 6, 5, 4, 5, 4, 6, 5
    .byte 6, 4, 7, 4, 3, 5, 5, 5, 4, 4, 6, 5, 5, 5, 6, 4
    .byte 6, 5, 5, 4, 3, 6, 5, 6, 4, 6, 5, 6, 5, 5, 4, 5
    .byte 4, 6, 5, 3, 6, 6, 4, 5, 5, 4, 4, 5, 5, 6, 6, 5
    .byte 5, 4, 5, 4, 4, 5, 6, 5, 5, 6, 5, 5, 4, 4, 6, 4
    .byte 3, 5, 5, 6, 6, 4, 5, 4, 4, 5, 5, 4, 6, 4, 6, 4
    .byte 4, 5, 7, 5, 5, 5, 6, 4, 6, 5, 6, 5, 4, 5, 5, 6
    .byte 4, 5, 5, 6, 5, 5, 4, 5, 6, 5, 5, 5, 5, 4, 5, 4
    .byte 6, 5, 5, 5, 6, 5, 3, 6, 6, 5, 5, 5, 6, 5, 5, 4
    .byte 5, 6, 5, 3, 4, 6, 4, 6, 5, 4, 6, 5, 5, 5, 6, 6
    .byte 5, 4, 4, 5, 4, 5, 6, 6, 5, 6, 5, 5, 3, 4, 5, 5
    .byte 4, 5, 5, 5, 6, 4, 5, 4, 5, 5, 6, 5, 4, 4, 6, 5
    .byte 2, 5, 7, 5, 6, 5, 5, 4, 5, 3, 6, 5, 5, 5, 5, 6
    .byte 3, 4, 3, 6, 4, 5, 6, 5, 5, 5, 5, 3, 4, 6, 4, 5
    .byte 5, 5, 5, 5, 5, 5, 6, 5, 4, 4, 5, 4, 4, 5, 6, 6
    .byte 5, 5, 4, 6, 6, 5, 5, 6, 5, 5, 4, 5, 5, 5, 6, 5
    .byte 5, 5, 4, 5, 6, 5, 4, 6, 3, 6, 5, 4, 6, 5, 5, 6
    .byte 6, 4, 4, 6, 6, 5, 5, 4, 4, 5, 4, 4, 5, 6, 5, 5
    .byte 4, 3, 6, 4, 5, 5, 5, 4, 6, 5, 6, 3, 2, 6, 5, 5
    .byte 5, 5, 5, 5, 4, 6, 3, 5, 5, 5, 6, 5, 3, 4, 5, 4
    .byte 4, 4, 5, 5, 6, 4, 3, 6, 5, 5, 5, 6, 5, 4, 5, 4
    .byte 6, 4, 4, 6, 5, 4, 5, 5, 5, 6, 5, 5, 5, 4, 5, 5
    .byte 6, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 4, 5, 5, 4, 6
    .byte 5, 4, 5, 6, 6, 5, 5, 6, 5, 5, 5, 6, 4, 4, 6, 6
    .byte 6, 4, 6, 4, 5, 4, 4, 4, 6, 5, 6, 4, 5, 6, 3, 6
    .byte 6, 5, 5, 5, 5, 6, 4, 4, 5, 4, 3, 6, 5, 4, 5, 5
    .byte 5, 5, 4, 5, 5, 4, 5, 4, 5, 5, 4, 4, 6, 5, 5, 5
    .byte 4, 3, 5, 4, 5, 5, 3, 6, 6, 4, 6, 4, 4, 6, 5, 6
    .byte 4, 4, 3, 6, 4, 5, 4, 6, 5, 6, 4, 4, 6, 5, 5, 4
    .byte 5, 4, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 4, 5, 6, 5
    .byte 5, 4, 6, 6, 5, 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 6
    .byte 6, 5, 5, 6, 6, 5, 5, 5, 5, 4, 5, 5, 4, 6, 4, 6
    .byte 4, 5, 5, 5, 5, 3, 6, 5, 5, 5, 6, 6, 5, 4, 4, 7
    .byte 6, 6, 4, 4, 5, 4, 5, 5, 4, 5, 5, 5, 6, 5, 5, 5
    .byte 6, 5, 6, 4, 4, 5, 6, 5, 3, 6, 5, 4, 4, 6, 5, 5
    .byte 5, 4, 5, 6, 5, 5, 5, 4, 4, 5, 4, 5, 5, 5, 6, 5
    .byte 4, 4, 5, 5, 4, 5, 6, 4, 5, 5, 5, 4, 3, 5, 5, 4
    .byte 5, 6, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 5, 6, 4, 6
    .byte 5, 6, 5, 6, 6, 4, 6, 6, 5, 5, 5, 6, 5, 5, 5, 7
    .byte 4, 6, 4, 5, 5, 4, 5, 5, 5, 5, 4, 6, 5, 4, 5, 5
    .byte 5, 5, 4, 5, 6, 5, 6, 5, 4, 4, 5, 5, 5, 5, 6, 4
    .byte 6, 5, 6, 4, 3, 6, 5, 5, 5, 6, 5, 6, 5, 6, 4, 5
    .byte 6, 6, 6, 4, 4, 5, 5, 5, 4, 5, 5, 5, 5, 5, 4, 5
    .byte 6, 4, 6, 6, 4, 5, 6, 5, 5, 4, 4, 7, 5, 3, 6, 4
    .byte 4, 5, 4, 5, 5, 4, 4, 4, 5, 6, 4, 5, 6, 5, 5, 4
    .byte 5, 6, 5, 6, 4, 3, 6, 3, 5, 4, 5, 5, 5, 4, 2, 5
    .byte 5, 6, 5, 6, 7, 5, 5, 3, 6, 5, 6, 2, 5, 5, 1, 6
    .byte 6, 5, 5, 6, 6, 6, 5, 6, 5, 2, 5, 6, 2, 5, 5, 5
    .byte 5, 5, 5, 6, 3, 4, 6, 4, 2, 6, 5, 6, 5, 3, 5, 4
    .byte 5, 5, 5, 5, 5, 3, 6, 4, 2, 6, 5, 5, 5, 6, 5, 5
    .byte 6, 3, 4, 6, 6, 6, 6, 5, 3, 4, 3, 4, 4, 6, 5, 6
    .byte 5, 6, 3, 6, 5, 5, 5, 4, 5, 4, 4, 6, 7, 5, 4, 4
    .byte 4, 5, 4, 4, 5, 4, 6, 5, 5, 6, 5, 4, 3, 6, 5, 6
    .byte 2, 5, 5, 5, 5, 3, 7, 5, 6, 4, 5, 4, 5, 3, 5, 6
    .byte 7, 4, 4, 6, 6, 4, 6, 5, 6, 6, 3, 4, 3, 5, 5, 3
    .byte 6, 5, 6, 4, 5, 6, 4, 4, 5, 6, 5, 4, 5, 5, 4, 4
    .byte 6, 6, 5, 5, 6, 6, 5, 5, 5, 4, 6, 4, 3, 5, 6, 4
    .byte 5, 5, 5, 5, 4, 5, 5, 4, 3, 5, 5, 4, 5, 4, 5, 4
    .byte 4, 5, 5, 4, 4, 4, 5, 5, 4, 5, 5, 5, 5, 6, 6, 5
    .byte 5, 5, 4, 5, 4, 5, 5, 4, 4, 6, 4, 5, 5, 6, 5, 6
    .byte 3, 6, 5, 6, 4, 5, 6, 4, 5, 4, 4, 6, 6, 5, 5, 4
    .byte 4, 5, 4, 4, 5, 5, 6, 4, 4, 5, 5, 5, 5, 6, 6, 5
    .byte 5, 4, 6, 4, 4, 4, 5, 6, 4, 6, 3, 5, 6, 5, 4, 5
    .byte 5, 5, 4, 6, 4, 4, 5, 4, 4, 4, 3, 6, 6, 3, 3, 4
    .byte 5, 5, 4, 4, 6, 4, 5, 4, 6, 3, 5, 6, 5, 4, 6, 4
    .byte 6, 5, 4, 3, 2, 6, 5, 4, 6, 6, 6, 5, 5, 6, 3, 5
    .byte 4, 6, 6, 6, 3, 4, 5, 3, 4, 5, 6, 5, 6, 4, 4, 5
    .byte 4, 6, 5, 5, 6, 4, 5, 4, 4, 3, 5, 6, 5, 4, 5, 4
    .byte 6, 4, 6, 4, 4, 5, 3, 6, 4, 5, 3, 6, 6, 6, 4, 4
    .byte 5, 5, 6, 4, 3, 6, 3, 6, 4, 4, 5, 5, 5, 4, 6, 6
    .byte 4, 4, 5, 5, 4, 4, 4, 7, 5, 5, 5, 5, 4, 5, 6, 4
    .byte 3, 5, 5, 4, 4, 4, 5, 5, 4, 6, 5, 4, 5, 4, 5, 5
    .byte 6, 5, 5, 4, 6, 5, 5, 4, 6, 6, 5, 6, 6, 5, 5, 4
    .byte 6, 5, 6, 4, 4, 5, 5, 4, 5, 4, 6, 6, 6, 4, 5, 5
    .byte 5, 5, 6, 4, 4, 6, 5, 6, 5, 5, 4, 5, 6, 5, 3, 5
    .byte 6, 5, 6, 4, 3, 5, 3, 5, 4, 5, 5, 5, 5, 4, 5, 6
    .byte 5, 4, 5, 6, 4, 4, 4, 5, 4, 4, 5, 6, 5, 3, 5, 3
    .byte 5, 4, 4, 5, 5, 4, 2, 5, 4, 5, 3, 5, 6, 5, 5, 3
    .byte 5, 4, 5, 5, 4, 6, 5, 6, 4, 5, 5, 5, 5, 3, 6, 6
    .byte 5, 5, 4, 6, 6, 4, 4, 6, 5, 6, 6, 4, 4, 6, 3, 5
    .byte 5, 4, 6, 6, 5, 5, 6, 5, 4, 4, 4, 6, 4, 5, 5, 6
    .byte 6, 6, 4, 5, 5, 4, 6, 5, 5, 5, 5, 7, 6, 4, 4, 5
    .byte 6, 5, 6, 5, 5, 4, 6, 5, 4, 5, 5, 6, 4, 4, 6, 4
    .byte 4, 5, 4, 5, 4, 4, 4, 4, 5, 7, 5, 5, 6, 5, 5, 3
    .byte 6, 4, 6, 6, 4, 4, 5, 5, 4, 5, 5, 5, 4, 3, 5, 6
    .byte 6, 5, 5, 6, 6, 4, 4, 5, 5, 5, 5, 3, 6, 5, 2, 5
    .byte 5, 4, 6, 6, 6, 6, 4, 6, 5, 3, 4, 6, 3, 6, 5, 5
    .byte 4, 6, 4, 5, 5, 5, 6, 5, 4, 5, 4, 5, 6, 5, 5, 4
    .byte 4, 6, 5, 3, 5, 5, 6, 4, 5, 4, 6, 5, 4, 7, 6, 6
    .byte 3, 5, 6, 4, 3, 4, 6, 5, 6, 6, 5, 5, 5, 4, 4, 6
    .byte 4, 4, 6, 5, 6, 4, 4, 5, 6, 4, 6, 4, 4, 6, 5, 6
    .byte 4, 4, 3, 5, 5, 5, 3, 5, 6, 5, 5, 6, 3, 5, 6, 5
    .byte 3, 5, 6, 4, 5, 2, 4, 6, 6, 5, 5, 6, 5, 3, 4, 5
    .byte 5, 6, 2, 6, 6, 5, 6, 5, 6, 4, 3, 5, 6, 5, 4, 3
    .byte 5, 6, 4, 3, 5, 5, 6, 5, 6, 4, 4, 4, 4, 5, 3, 6
    .byte 4, 5, 3, 5, 5, 4, 5, 4, 6, 4, 5, 4, 4, 3, 4, 6
    .byte 6, 3, 5, 5, 5, 5, 5, 4, 5, 6, 5, 4, 4, 5, 4, 5
    .byte 5, 6, 6, 6, 5, 6, 4, 4, 4, 6, 5, 4, 5, 5, 5, 5
    .byte 5, 4, 4, 5, 6, 6, 5, 5, 3, 5, 4, 5, 5, 5, 6, 4
    .byte 6, 5, 3, 6, 5, 4, 6, 5, 5, 5, 4, 5, 6, 5, 4, 4
    .byte 5, 5, 5, 4, 6, 4, 5, 4, 4, 4, 5, 6, 4, 5, 6, 5
    .byte 5, 4, 5, 5, 5, 5, 4, 5, 4, 5, 3, 6, 6, 5, 4, 5
    .byte 6, 6, 5, 4, 5, 4, 5, 3, 6, 6, 5, 5, 5, 5, 4, 4
    .byte 5, 5, 6, 5, 4, 6, 6, 4, 6, 4, 4, 5, 4, 5, 5, 6
    .byte 4, 5, 4, 5, 5, 4, 5, 5, 6, 4, 5, 5, 5, 3, 5, 6
    .byte 5, 6, 6, 4, 5, 4, 4, 4, 4, 5, 6, 5, 5, 5, 5, 5
    .byte 6, 4, 6, 5, 3, 4, 6, 5, 6, 5, 4, 3, 4, 5, 4, 6
    .byte 5, 6, 4, 5, 4, 5, 6, 3, 6, 4, 5, 4, 4, 5, 5, 6
    .byte 3, 6, 5, 5, 3, 5, 6, 4, 4, 4, 5, 5, 5, 4, 5, 4
    .byte 4, 6, 4, 5, 6, 4, 6, 5, 5, 5, 5, 4, 3, 5, 5, 5
    .byte 2, 6, 5, 5, 5, 3, 6, 5, 6, 4, 5, 4, 4, 3, 6, 6
    .byte 4, 5, 4, 3, 5, 6, 4, 6, 5, 4, 5, 4, 5, 6, 6, 5
    .byte 4, 4, 3, 5, 4, 5, 5, 5, 5, 4, 5, 5, 4, 5, 5, 5
    .byte 5, 6, 5, 4, 3, 5, 5, 5, 6, 6, 6, 4, 5, 5, 4, 4
    .byte 5, 4, 6, 5, 4, 3, 6, 4, 3, 6, 6, 5, 5, 4, 4, 5
    .byte 6, 5, 5, 6, 5, 4, 5, 4, 6, 4, 5, 2, 6, 5, 1, 6
    .byte 6, 5, 5, 5, 5, 5, 5, 6, 6, 2, 5, 6, 2, 5, 4, 6
    .byte 5, 5, 3, 6, 6, 6, 6, 6, 5, 4, 4, 4, 5, 5, 6, 4
    .byte 4, 6, 4, 4, 5, 6, 5, 5, 4, 5, 5, 5, 5, 6, 6, 6
    .byte 4, 5, 5, 5, 4, 5, 6, 4, 5, 5, 5, 4, 5, 5, 5, 5
    .byte 2, 5, 6, 5, 5, 5, 5, 4, 6, 3, 6, 5, 4, 6, 5, 5
    .byte 3, 5, 3, 5, 4, 6, 5, 4, 6, 4, 2, 6, 6, 5, 5, 4
    .byte 6, 6, 3, 5, 5, 5, 5, 3, 5, 6, 5, 3, 6, 6, 4, 5
    .byte 4, 5, 5, 6, 4, 4, 5, 5, 5, 3, 4, 5, 6, 5, 4, 5
    .byte 4, 6, 4, 5, 6, 5, 5, 5, 6, 4, 5, 6, 6, 3, 5, 4
    .byte 6, 6, 5, 5, 4, 6, 4, 5, 6, 6, 5, 4, 5, 5, 4, 4
    .byte 6, 4, 4, 5, 6, 5, 4, 5, 6, 6, 5, 5, 5, 5, 4, 5
    .byte 6, 5, 5, 5, 5, 5, 4, 5, 6, 5, 4, 4, 6, 5, 4, 4
    .byte 5, 6, 4, 6, 6, 5, 5, 5, 5, 4, 6, 5, 5, 6, 5, 5
    .byte 3, 4, 6, 4, 5, 5, 4, 5, 5, 4, 6, 4, 3, 6, 5, 5
    .byte 4, 4, 4, 5, 3, 6, 4, 4, 4, 4, 3, 6, 6, 6, 5, 6
    .byte 6, 5, 3, 5, 5, 6, 6, 4, 5, 5, 5, 4, 6, 6, 4, 5
    .byte 5, 6, 5, 5, 4, 4, 5, 5, 4, 4, 5, 6, 6, 4, 4, 6
    .byte 5, 6, 5, 6, 6, 3, 6, 5, 4, 5, 6, 3, 5, 5, 4, 4
    .byte 6, 5, 6, 5, 4, 6, 5, 5, 4, 4, 5, 5, 4, 6, 5, 5
    .byte 5, 5, 4, 3, 5, 5, 4, 4, 5, 5, 3, 6, 6, 5, 5, 4
    .byte 6, 4, 6, 4, 4, 4, 6, 5, 3, 6, 4, 6, 5, 4, 6, 5
    .byte 5, 3, 5, 6, 6, 5, 5, 5, 3, 6, 2, 5, 6, 4, 5, 5
    .byte 6, 3, 5, 6, 4, 4, 5, 4, 5, 6, 6, 4, 4, 5, 3, 6
    .byte 5, 5, 5, 6, 6, 5, 4, 4, 5, 4, 5, 5, 3, 6, 5, 6
    .byte 4, 6, 5, 4, 3, 4, 6, 5, 5, 5, 6, 4, 4, 4, 4, 5
    .byte 5, 6, 5, 6, 4, 5, 6, 4, 3, 5, 5, 6, 5, 4, 5, 4
    .byte 5, 5, 4, 5, 6, 4, 6, 5, 5, 6, 6, 4, 5, 6, 4, 5
    .byte 5, 5, 6, 5, 5, 4, 5, 6, 4, 4, 5, 6, 3, 4, 6, 6
    .byte 6, 3, 5, 5, 6, 4, 5, 4, 7, 5, 6, 4, 4, 6, 3, 5
    .byte 6, 5, 5, 5, 6, 6, 3, 4, 6, 5, 3, 5, 5, 4, 5, 5
    .byte 5, 5, 4, 6, 6, 4, 5, 4, 6, 4, 5, 4, 5, 4, 5, 5
    .byte 5, 3, 5, 5, 4, 5, 4, 6, 5, 4, 5, 4, 4, 5, 6, 6
    .byte 5, 5, 4, 5, 5, 5, 4, 6, 5, 6, 4, 4, 5, 5, 4, 4
    .byte 6, 5, 5, 5, 5, 6, 5, 5, 6, 5, 6, 5, 4, 5, 6, 5
    .byte 6, 4, 5, 5, 4, 5, 6, 6, 4, 5, 5, 4, 3, 5, 6, 5
    .byte 5, 6, 6, 4, 5, 5, 4, 6, 5, 6, 5, 6, 4, 4, 5, 4
    .byte 3, 6, 5, 6, 6, 4, 5, 4, 5, 5, 6, 5, 5, 4, 7, 4
    .byte 4, 5, 5, 4, 4, 5, 3, 6, 5, 4, 6, 5, 6, 5, 5, 6
    .byte 4, 4, 3, 6, 4, 5, 6, 6, 6, 4, 2, 5, 6, 6, 4, 5
    .byte 6, 6, 3, 5, 5, 5, 6, 3, 5, 5, 6, 3, 5, 5, 4, 6
    .byte 4, 4, 4, 6, 5, 4, 6, 5, 5, 5, 3, 5, 5, 4, 4, 4
    .byte 5, 6, 4, 4, 7, 5, 5, 4, 6, 6, 4, 5, 5, 5, 5, 4
    .byte 4, 6, 5, 6, 6, 5, 5, 4, 5, 4, 6, 5, 5, 5, 5, 4
    .byte 4, 3, 6, 4, 4, 6, 4, 5, 5, 5, 6, 3, 2, 5, 6, 5
    .byte 5, 4, 5, 5, 3, 5, 3, 5, 3, 5, 4, 5, 5, 6, 6, 5
    .byte 6, 4, 4, 6, 5, 6, 6, 3, 4, 5, 4, 3, 6, 6, 5, 5
    .byte 6, 5, 5, 4, 5, 3, 5, 4, 4, 5, 6, 6, 6, 4, 4, 5
    .byte 6, 5, 6, 6, 5, 4, 6, 4, 5, 6, 6, 4, 5, 6, 4, 5
    .byte 6, 5, 7, 5, 5, 5, 6, 6, 4, 5, 5, 6, 5, 5, 6, 5
    .byte 5, 4, 3, 5, 5, 5, 5, 6, 5, 5, 4, 5, 5, 5, 5, 4
    .byte 5, 4, 4, 4, 5, 4, 5, 6, 3, 6, 5, 4, 5, 6, 5, 6
    .byte 5, 4, 4, 6, 6, 6, 6, 4, 4, 4, 4, 4, 5, 5, 7, 5
    .byte 5, 5, 6, 4, 6, 3, 5, 2, 6, 6, 6, 5, 4, 6, 3, 5
    .byte 5, 5, 6, 6, 5, 6, 5, 3, 5, 5, 6, 5, 4, 6, 6, 6
    .byte 4, 4, 6, 4, 4, 4, 5, 5, 5, 6, 4, 5, 5, 5, 4, 6
    .byte 4, 6, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 4
    .byte 5, 6, 5, 4, 6, 6, 6, 4, 5, 3, 5, 6, 5, 5, 5, 5
    .byte 6, 5, 6, 4, 4, 5, 4, 6, 5, 5, 4, 6, 6, 6, 4, 5
    .byte 5, 5, 6, 4, 3, 5, 4, 6, 4, 5, 6, 6, 6, 4, 5, 6
    .byte 5, 4, 6, 5, 4, 4, 5, 6, 4, 5, 5, 5, 4, 5, 6, 4
    .byte 4, 5, 5, 4, 4, 5, 5, 5, 5, 6, 5, 4, 5, 5, 5, 5
    .byte 6, 5, 4, 4, 6, 6, 4, 5, 6, 6, 4, 6, 6, 5, 5, 5
    .byte 7, 4, 6, 4, 5, 5, 5, 5, 5, 3, 5, 6, 6, 4, 5, 5
    .byte 6, 5, 6, 4, 4, 6, 4, 6, 5, 5, 4, 5, 6, 6, 4, 5
    .byte 4, 6, 5, 5, 4, 4, 5, 4, 5, 3, 5, 6, 5, 4, 3, 6
    .byte 4, 6, 4, 6, 6, 4, 5, 4, 5, 4, 6, 3, 6, 5, 2, 5
    .byte 7, 5, 5, 5, 5, 6, 4, 5, 6, 3, 5, 5, 3, 6, 5, 4
    .byte 4, 5, 5, 6, 4, 4, 7, 4, 3, 5, 5, 5, 4, 4, 5, 4
    .byte 5, 6, 4, 5, 6, 4, 5, 4, 3, 5, 5, 4, 4, 5, 4, 6
    .byte 5, 4, 5, 5, 5, 5, 6, 6, 4, 3, 4, 5, 4, 5, 4, 6
    .byte 5, 6, 3, 6, 6, 4, 6, 4, 6, 4, 4, 5, 6, 5, 3, 4
    .byte 5, 6, 4, 4, 5, 5, 5, 4, 4, 5, 6, 5, 4, 6, 5, 5
    .byte 3, 5, 5, 5, 4, 4, 6, 5, 5, 5, 5, 5, 4, 4, 5, 6
    .byte 6, 4, 3, 6, 5, 4, 5, 5, 5, 6, 4, 5, 4, 4, 5, 4
    .byte 6, 5, 5, 4, 5, 5, 4, 5, 6, 5, 5, 5, 4, 5, 4, 5
    .byte 5, 6, 6, 6, 6, 5, 4, 6, 5, 4, 5, 5, 4, 5, 5, 5
    .byte 5, 5, 4, 4, 4, 6, 5, 5, 4, 6, 4, 5, 4, 5, 6, 4
    .byte 5, 5, 6, 3, 5, 5, 5, 5, 4, 4, 5, 6, 5, 6, 5, 5
    .byte 4, 4, 5, 5, 5, 4, 5, 5, 5, 5, 4, 6, 6, 5, 5, 6
    .byte 4, 6, 4, 6, 5, 5, 5, 4, 5, 5, 5, 6, 6, 6, 5, 5
    .byte 4, 5, 5, 4, 5, 5, 7, 5, 4, 4, 6, 5, 6, 5, 6, 5
    .byte 6, 5, 6, 4, 3, 5, 4, 6, 4, 6, 4, 6, 5, 6, 4, 5
    .byte 4, 5, 4, 5, 5, 5, 6, 5, 5, 5, 3, 6, 6, 4, 4, 4
    .byte 5, 6, 5, 4, 6, 5, 6, 5, 6, 4, 5, 6, 5, 4, 5, 4
    .byte 5, 5, 5, 4, 3, 5, 4, 5, 6, 5, 6, 6, 5, 6, 4, 5
    .byte 4, 7, 5, 5, 3, 5, 5, 4, 4, 4, 5, 6, 6, 4, 4, 5
    .byte 4, 6, 5, 4, 5, 4, 6, 5, 5, 3, 4, 6, 5, 5, 5, 5
    .byte 5, 5, 5, 4, 4, 4, 4, 5, 5, 5, 4, 5, 6, 5, 4, 5
    .byte 4, 6, 5, 5, 3, 5, 4, 5, 4, 5, 5, 6, 6, 4, 6, 5
    .byte 5, 4, 5, 4, 5, 4, 5, 6, 5, 4, 5, 4, 5, 6, 5, 5
    .byte 4, 5, 6, 4, 3, 5, 6, 5, 5, 5, 5, 5, 5, 5, 4, 6
    .byte 6, 5, 4, 5, 5, 5, 4, 5, 5, 5, 5, 6, 6, 4, 4, 5
    .byte 6, 5, 6, 5, 5, 4, 5, 5, 6, 4, 6, 5, 7, 4, 4, 5
    .byte 6, 6, 5, 5, 5, 6, 4, 5, 6, 5, 5, 5, 5, 6, 4, 5
    .byte 5, 6, 6, 5, 4, 5, 4, 5, 5, 5, 5, 6, 6, 5, 4, 5
    .byte 4, 4, 5, 5, 5, 5, 5, 5, 4, 4, 4, 5, 6, 4, 4, 4
    .byte 6, 4, 5, 5, 5, 5, 3, 5, 4, 5, 3, 5, 5, 6, 5, 4
    .byte 5, 4, 6, 6, 4, 6, 6, 5, 3, 5, 6, 5, 5, 4, 5, 5
    .byte 5, 6, 5, 6, 6, 4, 5, 5, 4, 6, 5, 4, 5, 5, 4, 4
    .byte 5, 5, 6, 5, 5, 6, 5, 6, 5, 5, 5, 5, 4, 6, 6, 5
    .byte 5, 5, 5, 5, 4, 4, 6, 5, 4, 4, 5, 6, 5, 3, 5, 6
    .byte 5, 6, 5, 6, 6, 4, 6, 5, 5, 5, 5, 5, 4, 5, 5, 5
    .byte 5, 6, 5, 5, 4, 5, 5, 4, 6, 6, 6, 5, 5, 5, 5, 4
    .byte 5, 4, 6, 6, 5, 4, 6, 5, 4, 6, 6, 5, 4, 4, 5, 5
    .byte 6, 6, 6, 5, 6, 5, 4, 5, 6, 5, 5, 3, 6, 5, 2, 6
    .byte 5, 5, 5, 6, 6, 5, 5, 6, 6, 3, 5, 5, 3, 5, 5, 6
    .byte 5, 5, 4, 6, 5, 6, 6, 5, 5, 5, 5, 5, 6, 6, 6, 5
    .byte 4, 7, 5, 4, 6, 6, 5, 5, 4, 5, 6, 4, 5, 6, 5, 5
    .byte 4, 5, 5, 5, 4, 5, 6, 5, 5, 5, 5, 5, 4, 5, 5, 6


msg_PPPPPPPOOOOOOO:
    .asciz "usage: solver PPPPPPPOOOOOOO\n"

msg_space:
    .asciz " "

msg_newline:
    .asciz "\n"
    
msg_not_found:
    .asciz "not found\n"


.bss


state:
    .zero 14

path:
    .zero 12

solution_depth:
    .byte 0


    .text

    j       main

    .globl apply_move

apply_move:
    li      t0, 3
    la      t1, move_source
    la      t2, move_twist

    # move_source[move][i] = move_source + (a1 * 7 + i)
    slli    t3, a1, 3       # t1 = a1 * 8
    sub     t3, t3, a1      # t1 = t1 - a1
    add     t1, t1, t3      # move_source + (a1 * 7)
    add     t2, t2, t3      # move_twist + (a1 * 7)

    # i = 0
    lbu     t3, 0(t1)       # load move_source[move][0]
    lbu     t4, 0(t2)       # load move_twist[move][0]

    add     t3, a0, t3      # state + from
    lbu     t5, 0(t3)       # load state->p[from]
    lbu     t6, 7(t3)       # load state->o[from]

    add     t6, t6, t4      # state->o[from] + move_twist[move][i]

    bltu    t6, t0, no_sub3_0
    addi    t6, t6, -3

no_sub3_0:
    sb      t5, 0(a2)       # store result->p[0]
    sb      t6, 7(a2)       # store result->o[0]

    # i = 1
    lbu     t3, 1(t1)
    lbu     t4, 1(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_1
    addi    t6, t6, -3

no_sub3_1:
    sb      t5, 1(a2)
    sb      t6, 8(a2)

    # i = 2
    lbu     t3, 2(t1)
    lbu     t4, 2(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_2
    addi    t6, t6, -3

no_sub3_2:
    sb      t5, 2(a2)
    sb      t6, 9(a2)

    # i = 3
    lbu     t3, 3(t1)
    lbu     t4, 3(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_3
    addi    t6, t6, -3

no_sub3_3:
    sb      t5, 3(a2)
    sb      t6, 10(a2)

    # i = 4
    lbu     t3, 4(t1)
    lbu     t4, 4(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_4
    addi    t6, t6, -3

no_sub3_4:
    sb      t5, 4(a2)
    sb      t6, 11(a2)

    # i = 5
    lbu     t3, 5(t1)
    lbu     t4, 5(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_5
    addi    t6, t6, -3

no_sub3_5:
    sb      t5, 5(a2)
    sb      t6, 12(a2)

    # i = 6
    lbu     t3, 6(t1)
    lbu     t4, 6(t2)

    add     t3, a0, t3
    lbu     t5, 0(t3)
    lbu     t6, 7(t3)

    add     t6, t6, t4

    bltu    t6, t0, no_sub3_6
    addi    t6, t6, -3

no_sub3_6:
    sb      t5, 6(a2)
    sb      t6, 13(a2)

    ret


    .globl rank_permutation

rank_permutation:
    li      t0, 0           # p = 0
    li      t1, 0           # smaller = 0

    # i = 0
    lbu     t2, 0(a0)       # load state->p[0]
    # j = 1
    lbu     t3, 1(a0)       # load state->p[1]
    bgeu    t3, t2, skip1   # if p[j] >= p[i], skip
    addi    t0, t0, 1
skip1: 
    # j = 2
    lbu     t3, 2(a0)       # load state->p[2]
    bgeu    t3, t2, skip2   # if p[j] >= p[i], skip
    addi    t0, t0, 1
skip2: 
    # j = 3
    lbu     t3, 3(a0)       # load state->p[3]
    bgeu    t3, t2, skip3   # if p[j] >= p[i], skip
    addi    t0, t0, 1
skip3: 
    # j = 4
    lbu     t3, 4(a0)  
    bgeu    t3, t2, skip4
    addi    t0, t0, 1
skip4: 
    # j = 5
    lbu     t3, 5(a0)  
    bgeu    t3, t2, skip5
    addi    t0, t0, 1
skip5: 
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip6
    addi    t0, t0, 1

skip6:
    # i = 1
    lbu     t2, 1(a0)
    # j = 2
    lbu     t3, 2(a0)
    bgeu    t3, t2, skip7
    addi    t1, t1, 1
skip7: 
    # j = 3
    lbu     t3, 3(a0)
    bgeu    t3, t2, skip8
    addi    t1, t1, 1
skip8: 
    # j = 4
    lbu     t3, 4(a0)  
    bgeu    t3, t2, skip9
    addi    t1, t1, 1
skip9: 
    # j = 5
    lbu     t3, 5(a0)  
    bgeu    t3, t2, skip10
    addi    t1, t1, 1
skip10: 
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip11
    addi    t1, t1, 1
skip11:
    slli    t3, t0, 2
    slli    t4, t0, 1
    add     t0, t1, t3
    add     t0, t0, t4
    # i = 2
    li t1, 0
    lbu     t2, 2(a0)
    # j = 3
    lbu     t3, 3(a0)
    bgeu    t3, t2, skip12
    addi    t1, t1, 1
skip12:
    # j = 4
    lbu     t3, 4(a0)
    bgeu    t3, t2, skip13
    addi    t1, t1, 1
skip13: 
    # j = 5
    lbu     t3, 5(a0)
    bgeu    t3, t2, skip14
    addi    t1, t1, 1
skip14: 
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip15
    addi    t1, t1, 1
skip15:
    slli    t3, t0, 2
    add     t0, t0, t3
    add     t0, t0, t1
    # i = 3
    li t1, 0
    lbu     t2, 3(a0)
    # j = 4
    lbu     t3, 4(a0)
    bgeu    t3, t2, skip16
    addi    t1, t1, 1
skip16: 
    # j = 5
    lbu     t3, 5(a0)
    bgeu    t3, t2, skip17
    addi    t1, t1, 1
skip17: 
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip18
    addi    t1, t1, 1
skip18:
    slli    t0, t0, 2
    add     t0, t0, t1
    # i = 4
    li t1, 0
    lbu     t2, 4(a0)
    # j = 5
    lbu     t3, 5(a0)
    bgeu    t3, t2, skip19
    addi    t1, t1, 1
skip19: 
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip20
    addi    t1, t1, 1
skip20:
    slli    t3, t0, 1
    add     t0, t0, t3
    add     t0, t0, t1
    # i = 5
    li t1, 0
    lbu     t2, 5(a0)
    # j = 6
    lbu     t3, 6(a0)  
    bgeu    t3, t2, skip21
    addi    t1, t1, 1
skip21:
    slli    t0, t0, 1
    add     t0, t0, t1

    mv      a0, t0          # return p
    ret


    .globl rank_orientation

rank_orientation:
    # li      t0, 0           # o = 0

    # lbu     t1, 7(a0)       # t1 = state->o[0]
    # add     t0, t0, t1      # t0 = (o << 1) + o + o[0]
    lbu     t0, 7(a0)       # o = state->o[0]

    lbu     t1, 8(a0)       # t1 = state->o[1]
    slli    t2, t0, 1       # t2 = o << 1
    add     t0, t2, t0      # t0 = (o << 1) + o
    add     t0, t0, t1      # t0 = (o << 1) + o + o[1]

    lbu     t1, 9(a0)       # state->o[2]
    slli    t2, t0, 1       # t2 = o << 1
    add     t0, t2, t0      # t0 = (o << 1) + o
    add     t0, t0, t1      # t0 = (o << 1) + o + o[2]

    lbu     t1, 10(a0)      # state->o[3]
    slli    t2, t0, 1       # t2 = o << 1
    add     t0, t2, t0      # t0 = (o << 1) + o
    add     t0, t0, t1      # t0 = (o << 1) + o + o[3]

    lbu     t1, 11(a0)      # state->o[4]
    slli    t2, t0, 1       # t2 = o << 1
    add     t0, t2, t0      # t0 = (o << 1) + o
    add     t0, t0, t1      # t0 = (o << 1) + o + o[4]
    
    lbu     t1, 12(a0)      # state->o[5]
    slli    t2, t0, 1       # t2 = o << 1
    add     t0, t2, t0      # t0 = (o << 1) + o
    add     t0, t0, t1      # t0 = (o << 1) + o + o[5]

    mv      a0, t0          # return o
    ret


    .globl valid

valid:
    li      t0, 0           # sum = 0
    li      t1, 7           # t1 = 7
    li      t2, 3           # t2 = 3

    # i = 0
    lbu     t3, 0(a0)       # load state->p[0]
    lbu     t4, 7(a0)       # load state->o[0]
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid

    add     t0, t0, t4

    # i = 1
    lbu t3, 1(a0)           # load state->p[1]
    lbu t4, 8(a0)           # load state->o[1]
    bgeu t3, t1, invalid
    bgeu t4, t2, invalid
    # j = 0
    lbu t5, 0(a0)           # load state->p[0]
    beq t3, t5, invalid

    add t0, t0, t4

    # i = 2
    lbu     t3, 2(a0)
    lbu     t4, 9(a0)
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid
    # j = 0
    lbu     t5, 0(a0)
    beq     t3, t5, invalid
    # j = 1
    lbu     t5, 1(a0)
    beq     t3, t5, invalid

    add     t0, t0, t4

    # i = 3
    lbu     t3, 3(a0)
    lbu     t4, 10(a0)
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid
    # j = 0
    lbu     t5, 0(a0)
    beq     t3, t5, invalid
    # j = 1
    lbu     t5, 1(a0)
    beq     t3, t5, invalid
    # j = 2
    lbu     t5, 2(a0)
    beq     t3, t5, invalid

    add     t0, t0, t4

    # i = 4
    lbu     t3, 4(a0)
    lbu     t4, 11(a0)
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid
    # j = 0
    lbu     t5, 0(a0)
    beq     t3, t5, invalid
    # j = 1
    lbu     t5, 1(a0)
    beq     t3, t5, invalid
    # j = 2
    lbu     t5, 2(a0)
    beq     t3, t5, invalid
    # j = 3
    lbu     t5, 3(a0)
    beq     t3, t5, invalid

    add     t0, t0, t4

    # i = 5
    lbu     t3, 5(a0)
    lbu     t4, 12(a0)
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid
    # j = 0
    lbu     t5, 0(a0)
    beq     t3, t5, invalid
    # j = 1
    lbu     t5, 1(a0)
    beq     t3, t5, invalid
    # j = 2
    lbu     t5, 2(a0)
    beq     t3, t5, invalid
    # j = 3
    lbu     t5, 3(a0)
    beq     t3, t5, invalid
    # j = 4
    lbu     t5, 4(a0)
    beq     t3, t5, invalid

    add     t0, t0, t4

    # i = 6
    lbu     t3, 6(a0)
    lbu     t4, 13(a0)
    bgeu    t3, t1, invalid
    bgeu    t4, t2, invalid
    # j = 0
    lbu     t5, 0(a0)
    beq     t3, t5, invalid
    # j = 1
    lbu     t5, 1(a0)
    beq     t3, t5, invalid
    # j = 2
    lbu     t5, 2(a0)
    beq     t3, t5, invalid
    # j = 3
    lbu     t5, 3(a0)
    beq     t3, t5, invalid
    # j = 4
    lbu     t5, 4(a0)
    beq     t3, t5, invalid
    # j = 5
    lbu     t5, 5(a0)
    beq     t3, t5, invalid

    add     t0, t0, t4

    li      t1, 0
    beq     t0, t1, valid_return
    li      t1, 3
    beq     t0, t1, valid_return
    li      t1, 6
    beq     t0, t1, valid_return
    li      t1, 9
    beq     t0, t1, valid_return
    li      t1, 12
    beq     t0, t1, valid_return

invalid:
    li a0, 0
    ret

valid_return:
    li      a0, 1
    ret


    .globl parse_state

parse_state:
    li      t0, 49          # '1'
    li      t1, 55          # '7'
    li      t2, 51          # '3'
    # i = 0
    lbu     t3, 0(a0)       # load  input[i]
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 7(a0)       # load input[7 + i]
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49     # input[i] - '1'
    sb      t3, 0(a1)       # store p[i]

    addi    t4, t4, -49     # input[7 + i] - '1'
    sb      t4, 7(a1)       # store o[i]
    # i = 1
    lbu     t3, 1(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 8(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 1(a1)

    addi    t4, t4, -49
    sb      t4, 8(a1)
    # i = 2
    lbu     t3, 2(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 9(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 2(a1)

    addi    t4, t4, -49
    sb      t4, 9(a1)
    # i = 3
    lbu     t3, 3(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 10(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 3(a1)

    addi    t4, t4, -49
    sb      t4, 10(a1)
    # i = 4
    lbu     t3, 4(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 11(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 4(a1)

    addi    t4, t4, -49
    sb      t4, 11(a1)
    # i = 5
    lbu     t3, 5(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 12(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 5(a1)

    addi    t4, t4, -49
    sb      t4, 12(a1)
    # i = 6
    lbu     t3, 6(a0)
    bltu    t3, t0, invalid
    bltu    t1, t3, invalid

    lbu     t4, 13(a0)
    bltu    t4, t0, invalid
    bltu    t2, t4, invalid

    addi    t3, t3, -49
    sb      t3, 6(a1)

    addi    t4, t4, -49
    sb      t4, 13(a1)

    lbu     t3, 14(a0)      # load input[14]
    bne     t3, zero, invalid   # input[14] == '\0'

    mv      a0, a1
    j       valid           # tail jump to valid

    
    .globl heuristic

heuristic:
    add     t0, a3, a0      # t0 = permutation_table + p
    lbu     t0, 0(t0)       # load permutation_table[p]

    add     t1, a2, a1      # t1 = orientation_table + o
    lbu     t1, 0(t1)       # load orientation_table[o]

    bgeu    t1, t0, heuristic_use_o  # if t1 >= t0 then heuristic_use_o

    mv      a0, t0          # return p
    ret

heuristic_use_o:
    mv      a0, t1          # return o
    ret


    .globl depth_limit_dfs_iterative

depth_limit_dfs_iterative:
    addi    sp, sp, -224

    # 要先保存原本的 ra 和 s registers：
    sw      s6, 192(sp)
    sw      s5, 196(sp)
    sw      s4, 200(sp)
    sw      s3, 204(sp)
    sw      s2, 208(sp)
    sw      s1, 212(sp)
    sw      s0, 216(sp)
    sw      ra, 220(sp)

    mv      s0, sp          # s0 = stack[0] 的位址
    li      s1, 0           # s1 = depth
    mv      s2, a1          # a1 = limit
    mv      s3, a2          # a2 = orientation_table
    mv      s4, a3          # a3 = permutation_table

    lbu     t0, 0(a0)       # load state[0]
    sb      t0, 0(s0)       # stoe stack[0]

    lbu     t0, 1(a0)
    sb      t0, 1(s0)

    lbu     t0, 2(a0)
    sb      t0, 2(s0)
    
    lbu     t0, 3(a0)
    sb      t0, 3(s0)

    lbu     t0, 4(a0)
    sb      t0, 4(s0)

    lbu     t0, 5(a0)
    sb      t0, 5(s0)

    lbu     t0, 6(a0)
    sb      t0, 6(s0)

    lbu     t0, 7(a0)
    sb      t0, 7(s0)

    lbu     t0, 8(a0)
    sb      t0, 8(s0)

    lbu     t0, 9(a0)
    sb      t0, 9(s0)

    lbu     t0, 10(a0)
    sb      t0, 10(s0)

    lbu     t0, 11(a0)
    sb      t0, 11(s0)

    lbu     t0, 12(a0)
    sb      t0, 12(s0)

    lbu     t0, 13(a0)
    sb      t0, 13(s0)

    sb      zero, 14(s0)    # store stack[0].next_move = 0;

    # while loop
dfs_loop:
    slli    t0, s1, 4       # depth * 16
    add     t0, s0, t0      # stack[depth] = s0 + depth*16
    
    lbu     t1, 14(t0)      # load stack[depth].next_move

    ## if(stack[depth].next_move == 0)
    bne     t1, zero, next_move_bigger_than_MOVES

    mv      a0, t0
    jal     ra, rank_permutation # rank_permutation(&stack[depth].state) 
    mv      s5, a0          # s5 = p

    slli    t0, s1, 4
    add     t0, s0, t0 
    mv      a0, t0
    jal     ra, rank_orientation # rank_orientation(&stack[depth].state)
    mv      s6, a0          # s6 = o

    ## if (p == 0 && o == 0)
    bne     s5, zero, depth_equal_limit
    bne     s6, zero, depth_equal_limit

    la      t0, solution_depth
    sb      s1, 0(t0)
    li      a0, 1

    # restore
dfs_return:
    lw      s6, 192(sp)
    lw      s5, 196(sp)
    lw      s4, 200(sp)
    lw      s3, 204(sp)
    lw      s2, 208(sp)
    lw      s1, 212(sp)
    lw      s0, 216(sp)
    lw      ra, 220(sp)
    
    addi    sp, sp, 224
    
    ret

depth_equal_limit:
    bne     s1, s2, heuristic_bigger_than_limit
    bne     s1, zero, depth_sub_one

    li      a0, 0
    j       dfs_return

depth_sub_one:
    addi    s1, s1, -1

    j       dfs_loop

heuristic_bigger_than_limit:
    mv      a0, s5
    mv      a1, s6
    mv      a2, s3
    mv      a3, s4
    jal     ra, heuristic

    add     t2, a0, s1      # heuristic + depth
    bgeu    s2, t2, next_move_bigger_than_MOVES
    bne     s1, zero, depth_sub_one

    li      a0, 0
    j       dfs_return

next_move_bigger_than_MOVES: 
    slli    t0, s1, 4
    add     t0, s0, t0 
    lbu     t1, 14(t0)      # load stack[depth].next_move

    li      t2, 9
    bltu    t1, t2, check_depth_and_move_face
    bne     s1, zero, depth_sub_one
    
    li      a0, 0
    j       dfs_return
    
check_depth_and_move_face:
    # load stack[depth].next_move
    slli    t0, s1, 4       # depth * 16
    add     t0, s0, t0      # t0 = stack[depth] = s0 + depth * 16
    lbu     t1, 14(t0)      # t1 = stack[depth].next_move

    # load path
    la      t5, path        # t5 = path[0]

    beq     s1, zero, dfs_apply_move

    # load path[depth - 1]
    addi    t6, s1, -1      # depth - 1
    add     t6, t5, t6      # path[0] + depth - 1
    lbu     t6, 0(t6)       # t6 = path[depth - 1]

    # load move_face[move]
    la      t2, move_face   # t2 = move_face[0]
    add     t3, t2, t1      # move_face[0] + move
    lbu     t3, 0(t3)       # t3 = move_face[move]

    # load move_face[path[depth - 1]]
    add     t4, t2, t6      # move_face[0] + path[depth - 1]
    lbu     t4, 0(t4)       # t4 = move_face[path[depth - 1]]
    
    bne     t3, t4, dfs_apply_move
    addi    t1, t1, 1
    sb      t1, 14(t0)

    j       dfs_loop

dfs_apply_move: 
    add     t5, t5, s1      # path[0] + depth
    sb      t1, 0(t5)       # path[depth] = move

    mv      a0, t0
    mv      a1, t1

    addi    t0, s1, 1       # depth + 1
    slli    t0, t0, 4       # (depth + 1) * 16
    add     t0, s0, t0      # &stack[depth + 1] = s0 + (depth + 1) * 16
    mv      a2, t0          # a2 = &stack[depth + 1].state
    jal     ra, apply_move

    slli    t0, s1, 4       # depth * 16
    add     t0, s0, t0      # stack[depth] = s0 + depth * 16
    lbu     t1, 14(t0)      # load stack[depth].next_move

    addi    t1, t1, 1       # stack[depth].next_move + 1
    sb      t1, 14(t0)      # store stack[depth].next_move

    addi    s1, s1, 1       # ++depth

    slli    t0, s1, 4       # depth * 16
    add     t0, s0, t0      # stack[depth] = s0 + depth * 16
    sb      zero, 14(t0)    # store stack[depth].next_move = 0

    j       dfs_loop


#     .globl _start
# _start:
#     lw      a0, 0(sp)       # argc
#     addi    a1, sp, 4       # argv
#     j       main

    .globl main

main:

    la      s4, state

    # li      t0, 2
    # bne     a0, t0, input_error

    # lw      a0, 4(a1)       # a0 = argv[1]
    # mv      a1, s4          # a1 = &state
    # jal     ra, parse_state

    la      a0, input_state
    mv      a1, s4
    jal     ra, parse_state

    beq     a0, zero, input_error
    j       input_correct

input_error:
    # # print
    # li      a0, 2
    # la      a1, msg_PPPPPPPOOOOOOO
    # li      a2, 29
    # li      a7, 64          
    # ecall
    # #return2
    # li      a0, 2
    # li      a7, 93
    # ecall
    
    # print usage message
    la      a0, msg_PPPPPPPOOOOOOO
    li      a7, 4
    ecall

    # exit
    li      a7, 10
    ecall

input_correct:
    mv      a0, s4
    jal     ra, rank_permutation
    mv      s0, a0          # s0 = p

    mv      a0, s4
    jal     ra, rank_orientation
    mv      s1, a0          # s1 = o

    la      s2, orientation_table
    la      s3, permutation_table

    mv      a0, s0
    mv      a1, s1
    mv      a2, s2
    mv      a3, s3
    jal     ra, heuristic

    mv      s0, a0          # s0 = start
    li      s1, 12

loop_for_depth_limit_dfs_iterative:
    bgeu    s0, s1, not_found

    mv      a0, s4
    mv      a1, s0
    mv      a2, s2
    mv      a3, s3
    jal     ra, depth_limit_dfs_iterative
    
    bne     a0, zero, print

    addi    s0, s0, 1
    j       loop_for_depth_limit_dfs_iterative

print: 

    # print
    li      s0, 0        # i = 0
    la      s1, solution_depth
    lbu     s1, 0(s1)

print_loop:
    beq     s0, s1, found

    la      t2, path
    add     t2, t2, s0      # path + i
    lbu     t2, 0(t2)       # load path[i]

    slli    t2, t2, 2
    la      t3, move_names
    add     t3, t3, t2
    lw      t3, 0(t3)

    # 判斷字串長度
    lbu     t4, 1(t3)
    beq     t4, zero, print_one_char

    # li      a0, 1           # stdout
    # mv      a1, t3          # buffer address
    # li      a2, 2           # bytes
    # li      a7, 64          # SYS_write
    # ecall

    mv      a0, t3
    li      a7, 4
    ecall

    j       next_print_loop

print_one_char:   
    # li      a0, 1           # stdout
    # mv      a1, t3          # buffer address
    # li      a2, 1           # bytes
    # li      a7, 64          # SYS_write
    # ecall

    mv      a0, t3
    li      a7, 4

    ecall

next_print_loop:

    addi    s0, s0, 1

    beq     s0, s1, found

    # li      a0, 1
    # la      a1, msg_space
    # li      a2, 1
    # li      a7, 64
    # ecall

    la      a0, msg_space
    li      a7, 4
    ecall

    j       print_loop
    
found: 
    # li      a0, 1           # stdout
    # la      a1, msg_newline # buffer address
    # li      a2, 1           # bytes
    # li      a7, 64          # SYS_write
    # ecall

    la      a0, msg_newline
    li      a7, 4
    ecall

    j       output_failed

not_found: 
    # li      a0, 1
    # la      a1, msg_not_found
    # li      a2, 10
    # li      a7, 64          
    # ecall

    la      a0, msg_not_found
    li      a7, 4
    ecall

    j       output_failed
 
output_failed: 
    li      a0, 0
    li      a7, 10
    ecall

