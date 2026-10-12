# 定義常數和圖片資料
.equ  RED,    0xFF0000
.equ  GREEN,  0x00FF00
.equ  BLUE,   0x0000FF
.equ  WHITE,  0xFFFFFF
.equ  YELLOW, 0xFFFF00
.equ  ORANGE, 0xFFA500
.equ  DELAY,  8192

    .data

input_state:
    .asciz "21345671111111"

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

# 第 i 個 facelet 現在是什麼顏色
visual_facelets:
    .byte 0,0,0,0        # U = WHITE
    .byte 1,1,1,1        # D = YELLOW
    .byte 2,2,2,2        # F = GREEN
    .byte 3,3,3,3        # B = BLUE
    .byte 4,4,4,4        # L = ORANGE
    .byte 5,5,5,5        # R = RED

# RGB lookup table
led_colors:
    .word WHITE
    .word YELLOW
    .word GREEN
    .word BLUE
    .word ORANGE
    .word RED

# 第 i 個 facelet 要畫到 LED Matrix 的哪個位置
facelet_xy:
    .byte  9, 0,   13, 0,     9, 3,   13, 3      # U
    .byte  9,14,   13,14,     9,17,   13,17      # D
    .byte  9, 7,   13, 7,     9,10,   13,10      # F
    .byte 27, 7,   31, 7,    27,10,   31,10      # B
    .byte  0, 7,    4, 7,     0,10,    4,10      # L
    .byte 18, 7,   22, 7,    18,10,   22,10      # R

led_move_R:
    .byte 0,9,2,11, 4,14,6,12, 8,5,10,7, 3,13,1,15, 16,17,18,19, 22,20,23,21
led_move_R2:
    .byte 0,5,2,7, 4,1,6,3, 8,14,10,12, 11,13,9,15, 16,17,18,19, 23,22,21,20
led_move_Rp:
    .byte 0,14,2,12, 4,9,6,11, 8,1,10,3, 7,13,5,15, 16,17,18,19, 21,23,20,22

led_move_B:
    .byte 21,23,2,3, 4,5,16,18, 8,9,10,11, 14,12,15,13, 1,17,0,19, 20,7,22,6
led_move_B2:
    .byte 7,6,2,3, 4,5,1,0, 8,9,10,11, 15,14,13,12, 23,17,21,19, 20,18,22,16
led_move_Bp:
    .byte 18,16,2,3, 4,5,23,21, 8,9,10,11, 13,15,12,14, 6,17,7,19, 20,0,22,1

led_move_D:
    .byte 0,1,2,3, 6,4,7,5, 8,9,18,19, 12,13,22,23, 16,17,14,15, 20,21,10,11
led_move_D2:
    .byte 0,1,2,3, 7,6,5,4, 8,9,14,15, 12,13,10,11, 16,17,22,23, 20,21,18,19
led_move_Dp:
    .byte 0,1,2,3, 5,7,4,6, 8,9,22,23, 12,13,18,19, 16,17,10,11, 20,21,14,15

led_move_index:
    .word led_move_R
    .word led_move_R2
    .word led_move_Rp
    .word led_move_B
    .word led_move_B2
    .word led_move_Bp
    .word led_move_D
    .word led_move_D2
    .word led_move_Dp

inverse_move:
    .byte 2,1,0,5,4,3,8,7,6

.bss

state:
    .zero 14

path:
    .zero 12

solution_depth:
    .byte 0

visual_tmp:
    .zero 24

    .text

    j       main

    .globl apply_move

apply_move:
    la      a3, move_source
    # move_source[move][i] = move_source + (a1 * 7 + i)
    slli    t0, a1, 3       # t0 = a1 * 8
    sub     t0, t0, a1      # t0 = t0 - a1
    add     a3, a3, t0      # move_source + move * 7

    lbu     t0, 0(a3)       # load move_source[move][0]
    lbu     t1, 1(a3)       # load move_source[move][1]
    lbu     t2, 2(a3)
    lbu     t3, 3(a3)
    lbu     t4, 4(a3)
    lbu     t5, 5(a3)
    lbu     t6, 6(a3)

    add     t0, a0, t0      # state + move_source[move][0]
    add     t1, a0, t1      # state + move_source[move][1]
    add     t2, a0, t2
    add     t3, a0, t3
    add     t4, a0, t4
    add     t5, a0, t5
    add     t6, a0, t6

    # permutation
    lbu     a4, 0(t0)       # load state.p[move_source[move][0]]
    sb      a4, 0(a2)       # store state->p[0]

    lbu     a4, 0(t1)       # load state.p[move_source[move][1]]
    sb      a4, 1(a2)       # store state->p[1]

    lbu     a4, 0(t2)
    sb      a4, 2(a2)

    lbu     a4, 0(t3)
    sb      a4, 3(a2)

    lbu     a4, 0(t4)
    sb      a4, 4(a2)

    lbu     a4, 0(t5)
    sb      a4, 5(a2)

    lbu     a4, 0(t6)
    sb      a4, 6(a2)

    # orientation
    lbu     t0, 7(t0)       # load state.o[move_source[move][0]]
    lbu     t1, 7(t1)       # load state.o[move_source[move][1]]
    lbu     t2, 7(t2)
    lbu     t3, 7(t3)
    lbu     t4, 7(t4)
    lbu     t5, 7(t5)
    lbu     t6, 7(t6)

    # move = R R' B B'
    beq     a1, zero, R

    li      a5, 2
    beq     a1, a5, R

    li      a5, 3
    beq     a1, a5, B

    li      a5, 5
    beq     a1, a5, B
    
    j       store_orientation
R:  
    li      a5, 3
    addi    t0, t0, 1      # state.o[move_source[move][0]] + move_twist[move][0]
    bltu    t0, a5, no_sub3_0
    addi    t0, t0, -3
no_sub3_0:
    addi    t1, t1, 2
    bltu    t1, a5, no_sub3_1
    addi    t1, t1, -3
no_sub3_1:
    addi    t3, t3, 2
    bltu    t3, a5, no_sub3_2
    addi    t3, t3, -3
no_sub3_2:
    addi    t4, t4, 1
    bltu    t4, a5, store_orientation
    addi    t4, t4, -3
    j       store_orientation
B:
    li      a5, 3
    addi    t3, t3, 1
    bltu    t3, a5, no_sub3_3
    addi    t3, t3, -3
no_sub3_3:
    addi    t4, t4, 2
    bltu    t4, a5, no_sub3_4
    addi    t4, t4, -3
no_sub3_4:
    addi    t5, t5, 1
    bltu    t5, a5, no_sub3_5
    addi    t5, t5, -3
no_sub3_5:
    addi    t6, t6, 2
    bltu    t6, a5, store_orientation
    addi    t6, t6, -3

store_orientation:
    sb      t0, 7(a2)       # load state->o[0]
    sb      t1, 8(a2)       # load state->o[1]
    sb      t2, 9(a2)
    sb      t3, 10(a2)
    sb      t4, 11(a2)
    sb      t5, 12(a2)
    sb      t6, 13(a2)
    
    ret


    .globl rank_permutation

rank_permutation:
    # load all
    lbu     t0, 0(a0)
    lbu     t1, 1(a0)
    lbu     t2, 2(a0)
    lbu     t3, 3(a0)
    lbu     t4, 4(a0)
    lbu     t5, 5(a0)
    lbu     t6, 6(a0)

    li      a0, 0           # p = 0
    li      a1, 0           # smaller = 0

    # i = 0
    # j = 1
    bgeu    t1, t0, skip1   # if p[j] >= p[i], skip
    addi    a0, a0, 1
skip1: 
    # j = 2
    bgeu    t2, t0, skip2   # if p[j] >= p[i], skip
    addi    a0, a0, 1
skip2: 
    # j = 3
    bgeu    t3, t0, skip3   # if p[j] >= p[i], skip
    addi    a0, a0, 1
skip3: 
    # j = 4
    bgeu    t4, t0, skip4
    addi    a0, a0, 1
skip4: 
    # j = 5
    bgeu    t5, t0, skip5
    addi    a0, a0, 1
skip5: 
    # j = 6
    bgeu    t6, t0, skip6
    addi    a0, a0, 1

skip6:
    # i = 1
    # j = 2
    bgeu    t2, t1, skip7
    addi    a1, a1, 1
skip7: 
    # j = 3
    bgeu    t3, t1, skip8
    addi    a1, a1, 1
skip8: 
    # j = 4
    bgeu    t4, t1, skip9
    addi    a1, a1, 1
skip9: 
    # j = 5
    bgeu    t5, t1, skip10
    addi    a1, a1, 1
skip10: 
    # j = 6
    bgeu    t6, t1, skip11
    addi    a1, a1, 1
skip11: 
    slli    a2, a0, 1
    add     a1, a2, a1
    slli    a0, a0, 2
    add     a0, a0, a1

    # i = 2
    li      a1, 0
    # j = 3
    bgeu    t3, t2, skip12
    addi    a1, a1, 1
skip12:
    # j = 4
    bgeu    t4, t2, skip13
    addi    a1, a1, 1
skip13: 
    # j = 5
    bgeu    t5, t2, skip14
    addi    a1, a1, 1
skip14: 
    # j = 6
    bgeu    t6, t2, skip15
    addi    a1, a1, 1
skip15:
    add     a1, a0, a1
    slli    a0, a0, 2
    add     a0, a0, a1

    # i = 3
    li      a1, 0
    # j = 4
    bgeu    t4, t3, skip16
    addi    a1, a1, 1
skip16: 
    # j = 5
    bgeu    t5, t3, skip17
    addi    a1, a1, 1
skip17: 
    # j = 6
    bgeu    t6, t3, skip18
    addi    a1, a1, 1
skip18:
    slli    a0, a0, 2
    add     a0, a0, a1

    # i = 4
    li      a1, 0
    # j = 5
    bgeu    t5, t4, skip19
    addi    a1, a1, 1
skip19: 
    # j = 6
    bgeu    t6, t4, skip20
    addi    a1, a1, 1
skip20:
    add     a1, a0, a1
    slli    a0, a0, 1
    add     a0, a0, a1

    # i = 5
    li      a1, 0
    # j = 6 
    bgeu    t6, t5, skip21
    addi    a1, a1, 1
skip21:
    slli    a0, a0, 1       # p << 1
    add     a0, a0, a1      # (p << 1) + smaller

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
    add     a0, t0, t1      # a0 = (o << 1) + o + o[5]

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
    li      a0, 0
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
    addi    sp, sp, -240    # 16-byte stack alignment

    # 要先保存原本的 ra 和 s registers：
    sw      s8, 192(sp)
    sw      s7, 196(sp)
    sw      s6, 200(sp)
    sw      s5, 204(sp)
    sw      s4, 208(sp)
    sw      s3, 212(sp)
    sw      s2, 216(sp)
    sw      s1, 220(sp)
    sw      s0, 224(sp)
    sw      ra, 228(sp)

    mv      s0, sp          # s0 = stack[0] 的位址
    li      s1, 0           # s1 = depth
    mv      s2, a1          # a1 = limit
    mv      s3, a2          # a2 = orientation_table
    mv      s4, a3          # a3 = permutation_table

    # load path
    la      s7, path        # s7 = path[0]
    # load move_face[move]
    la      s8, move_face   # s8 = move_face[0] 

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
    add     a0, s0, t0      # stack[depth] = s0 + depth*16
    
    lbu     t1, 14(a0)      # load stack[depth].next_move

    ## if(stack[depth].next_move == 0)
    bne     t1, zero, next_move_bigger_than_MOVES

    # mv      a0, t0
    jal     ra, rank_permutation # rank_permutation(&stack[depth].state) 
    mv      s5, a0          # s5 = p

    slli    t0, s1, 4
    # add     t0, s0, t0 
    # mv      a0, t0
    add     a0, s0, t0 
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
    lw      s8, 192(sp)
    lw      s7, 196(sp)
    lw      s6, 200(sp)
    lw      s5, 204(sp)
    lw      s4, 208(sp)
    lw      s3, 212(sp)
    lw      s2, 216(sp)
    lw      s1, 220(sp)
    lw      s0, 224(sp)
    lw      ra, 228(sp)
    
    addi    sp, sp, 240
    
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
    # mv      a0, s5
    # mv      a1, s6
    # mv      a2, s3
    # mv      a3, s4
    # jal     ra, heuristic

    # function inlining
    add     t0, s4, s5      # t0 = permutation_table + p
    lbu     t0, 0(t0)       # load permutation_table[p]

    add     t1, s3, s6      # t1 = orientation_table + o
    lbu     t1, 0(t1)       # load orientation_table[o]

    bgeu    t1, t0, use_o   # if t1 >= t0 then heuristic_use_o

    add     t2, t0, s1      # p + depth
    j       max_p_and_o
use_o:
    add     t2, t1, s1      # o + depth
max_p_and_o:
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
    # # load stack[depth].next_move
    # slli    t0, s1, 4       # depth * 16
    # add     t0, s0, t0      # t0 = stack[depth] = s0 + depth * 16
    # lbu     t1, 14(t0)      # t1 = stack[depth].next_move 

    # load path
    # la      t5, path        # t5 = path[0]

    beq     s1, zero, dfs_apply_move

    # load path[depth - 1]
    addi    t6, s1, -1      # depth - 1
    add     t6, s7, t6      # path[0] + depth - 1
    lbu     t6, 0(t6)       # t6 = path[depth - 1]

    # load move_face[move]
    # la      t2, move_face   # t2 = move_face[0] 
    add     t3, s8, t1      # move_face[0] + move
    lbu     t3, 0(t3)       # t3 = move_face[move]

    # load move_face[path[depth - 1]]
    add     t4, s8, t6      # move_face[0] + path[depth - 1]
    lbu     t4, 0(t4)       # t4 = move_face[path[depth - 1]]
    
    bne     t3, t4, dfs_apply_move
    addi    t1, t1, 1
    sb      t1, 14(t0)

    j       dfs_loop

dfs_apply_move: 
    add     t5, s7, s1      # path[0] + depth
    sb      t1, 0(t5)       # path[depth] = move

    mv      a0, t0
    mv      a1, t1

    # addi    t0, s1, 1       # depth + 1
    # slli    t0, t0, 4       # (depth + 1) * 16
    # add     t0, s0, t0      # &stack[depth + 1] = s0 + (depth + 1) * 16
    # mv      a2, t0          # a2 = &stack[depth + 1].state
    addi     a2, t0, 16      # t0 = &stack[depth]
    
    jal     ra, apply_move

    slli    t0, s1, 4       # depth * 16
    add     t0, s0, t0      # stack[depth] = s0 + depth * 16
    lbu     t1, 14(t0)      # load stack[depth].next_move

    addi    t1, t1, 1       # stack[depth].next_move + 1
    sb      t1, 14(t0)      # store stack[depth].next_move

    addi    s1, s1, 1       # ++depth
    # slli    t0, s1, 4       # depth * 16
    # add     t0, s0, t0      # stack[depth] = s0 + depth * 16
    addi    t0, t0, 16      # t0 = &stack[depth]

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
    
    # bne     a0, zero, print
    bne     a0, zero, solution

    addi    s0, s0, 1
    j       loop_for_depth_limit_dfs_iterative

print: 
    # print
    li      s0, 0           # i = 0
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

    # # 判斷字串長度
    # lbu     t4, 1(t3)
    # beq     t4, zero, print_one_char

    # li      a0, 1           # stdout
    # mv      a1, t3          # buffer address
    # li      a2, 2           # bytes
    # li      a7, 64          # SYS_write
    # ecall

    mv      a0, t3
    li      a7, 4
    ecall

    # j       next_print_loop

# print_one_char:   
#     # li      a0, 1           # stdout
#     # mv      a1, t3          # buffer address
#     # li      a2, 1           # bytes
#     # li      a7, 64          # SYS_write
#     # ecall

#     mv      a0, t3
#     li      a7, 4

#     ecall

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


solution:
    la      s0, LED_MATRIX_0_BASE     # s0 = LED Matrix 起始位址
    li      t0, LED_MATRIX_0_SIZE
    add     s2, s0, t0                # s2 = framebuffer 終點
    li      t0, LED_MATRIX_0_WIDTH
    slli    s1, t0, 2                 # s1 = stride = WIDTH * 4 bytes

    la      s3, visual_facelets
    la      s4, led_colors
    la      s5, facelet_xy

    la      s6, led_move_index

    la      s7, path
    
    la      t0, solution_depth
    lbu     s8, 0(t0)          # s8 = solution_depth

    beqz    s8, solved

    la      s9, inverse_move

    add     s10, s7, s8
    addi    s10, s10, -1

reverse_loop:
    lbu     t6, 0(s10)      # t6 = path[i]
    
    add     t0, s9, t6      # t6 = inverse_move[path[i]]
    lbu     t6, 0(t0)

    slli    t0, t6, 2       # path
    add     t0, s6, t0
    lw      a0, 0(t0)    
    jal     apply_visual_move

    addi    s10, s10, -1
    addi    s8, s8, -1
    bnez    s8, reverse_loop

    li      t4, 0
    li      t5, 24

draw_cube:
    add     t0, s3, t4      # t0 = visual_facelets + i
    lbu     t1, 0(t0)       # t1 = visual_facelets[i]

    slli    t0, t1, 2       # offset = color_id * 4
    add     t0, s4, t0      # t0 = led_colors + offset
    lw      a2, 0(t0)       # a2 = led_colors[offset]

    slli    t0, t4, 1       # offset = i * 2
    add     t0, s5, t0      # t0 = facelet_xy + offset
    lbu     a0, 0(t0)       # a0 = x
    lbu     a1, 1(t0)       # a1 = y

    jal     ra, draw_facelet

    addi    t4, t4, 1
    bne     t4, t5, draw_cube

    jal     ra, delay

    la      t0, solution_depth
    lbu     s8, 0(t0)       # s8 = solution_depth    

path_loop:
    # repeat solution_depth times
    lbu     t6, 0(s7)
    addi    s7, s7, 1

    slli    t0, t6, 2       # path
    add     t0, s6, t0
    lw      a0, 0(t0)
    jal     apply_visual_move

    li      t4, 0
    li      t5, 24

draw:
    add     t0, s3, t4      # t0 = visual_facelets + i
    lbu     t1, 0(t0)       # t1 = visual_facelets[i]

    slli    t0, t1, 2       # offset = color_id * 4
    add     t0, s4, t0      # t0 = led_colors + offset
    lw      a2, 0(t0)       # a2 = led_colors[offset]

    slli    t0, t4, 1       # offset = i * 2
    add     t0, s5, t0      # t0 = facelet_xy + offset
    lbu     a0, 0(t0)       # a0 = x
    lbu     a1, 1(t0)       # a1 = y

    jal     ra, draw_facelet

    addi    t4, t4, 1
    bne     t4, t5, draw
    
    jal     delay

    addi    s8, s8, -1
    bnez    s8, path_loop

    j       done
    
solved:
    li      t4, 0
    li      t5, 24

solved_draw:
    add     t0, s3, t4
    lbu     t1, 0(t0)

    slli    t0, t1, 2
    add     t0, s4, t0
    lw      a2, 0(t0)

    slli    t0, t4, 1
    add     t0, s5, t0
    lbu     a0, 0(t0)
    lbu     a1, 1(t0)

    jal     ra, draw_facelet

    addi    t4, t4, 1
    bne     t4, t5, solved_draw

    jal     ra, delay

    j       done

done:
    j       print

apply_visual_move:
    la      t5, visual_tmp
    li      t2, 0            # i = 0

move:
    # source = move_R[i]
    add     t3, a0, t2
    lbu     t0, 0(t3)

    # color = visual_facelets[source]
    add     t3, s3, t0
    lbu     t1, 0(t3)

    # visual_tmp[i] = color
    add     t3, t5, t2
    sb      t1, 0(t3)

    addi    t2, t2, 1
    li      t4, 24
    bne     t2, t4, move

    li      t2, 0          # i = 0

copy_back:
    add     t3, t5, t2     # t3 = &visual_tmp[i]
    lbu     t0, 0(t3)      # t0 = visual_tmp[i]

    add     t3, s3, t2     # t3 = &visual_facelets[i]
    sb      t0, 0(t3)      # visual_facelets[i] = t0

    addi    t2, t2, 1
    li      t4, 24
    bne     t2, t4, copy_back

    ret


draw_facelet:
    # address = BASE + (y * 35 + x) * 4
    mv      t2, s0          # t2 = LED_BASE
    mv      t0, a1
    beqz    t0, at_row
# 往下走 INIT_Y 列
skip_row:
    add     t2, t2, s1      # 往下走 1 列
    addi    t0, t0, -1
    bnez    t0, skip_row
# 往右走 INIT_X 格
at_row: 
    mv      t0, a0
    slli    t0, t0, 2       # 往右走 INIT_X * 4 bytes 
    add     t2, t2, t0    

    mv      a0, a2
    mv      a1, t2
# 把 4×3 圖畫上去
facelet:
    li      t0, 3           # 還有 3 列要畫
    mv      t1, a1          # t1 = 目前這一列的起始位址
facelet_row:
    li      t2, 4           # 每列還有 4 顆要畫
    mv      t3, t1          # t3 = 目前 pixel 位址
facelet_col:
    sw      a0, 0(t3)       # a0 = color 寫到 LED Matrix
    
    addi    t3, t3, 4       # t3 = 下一個 pixel 位址

    addi    t2, t2, -1
    bnez    t2, facelet_col

    add     t1, t1, s1      # t1 = 下一列起始位址
    addi    t0, t0, -1
    bnez    t0, facelet_row

    ret

delay:
    li    t0, DELAY
delay_loop:
    addi  t0, t0, -1
    bnez  t0, delay_loop
    ret