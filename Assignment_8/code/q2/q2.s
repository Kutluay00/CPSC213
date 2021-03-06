.pos 0x0
                 ld   $0x1028, r5         
                 ld   $0xfffffff4, r0     # r0 = -12
                 add  r0, r5              # allocate stack ptr
                 ld   $0x200, r0          # r0 = &arg1
                 ld   0x0(r0), r0         # r0 = arg1
                 st   r0, 0x0(r5)         # store arg1 on stack
                 ld   $0x204, r0          # r0 = &arg2
                 ld   0x0(r0), r0         # r0 = arg2
                 st   r0, 0x4(r5)         # store arg2 on stack
                 ld   $0x208, r0          # r0 = &arg3
                 ld   0x0(r0), r0         # r0 = arg3
                 st   r0, 0x8(r5)         # store arg3 on stack
                 gpc  $0x6, r6            # update return address and store it in r6
                 j    0x300               # call foo(arg1, arg2, arg3)
                 ld   $0x20c, r1          # r1 = &return_value
                 st   r0, 0x0(r1)         # return_value = foo(arg1, arg2, arg3)
                 halt                     
.pos 0x200
                 .long 0x0                # arg1
                 .long 0x0                # arg2
                 .long 0x0                # arg3
                 .long 0x0                
.pos 0x300
                 ld   0x0(r5), r0         # r0 = a
                 ld   0x4(r5), r1         # r1 = b
                 ld   0x8(r5), r2         # r2 = c
                 ld   $0xfffffff6, r3     # r3 = -10
                 add  r3, r0              # r0 = a - 10
                 mov  r0, r3              # r3 = a - 10
                 not  r3                  
                 inc  r3                  # r3 = 10 - a
                 bgt  r3, L6              # if a < 10 goto L6 (default case)
                 mov  r0, r3              # r3 = a - 10
                 ld   $0xfffffff8, r4     # r4 = -8
                 add  r4, r3              # r3 = a - 18
                 bgt  r3, L6              # if a > 18 goto L6 (default case)
                 ld   $0x400, r3          # r3 = jump table
                 j    *(r3, r0, 4)        # goto jump table[a - 10]
.pos 0x330
                 add  r1, r2              # r2 = c + b; case 10
                 br   L7                  # break
                 not  r2                  
                 inc  r2                  # r2 = -c; case 12
                 add  r1, r2              # r2 = b - c
                 br   L7                  # break
                 not  r2                  
                 inc  r2                  # r2 = -c
                 add  r1, r2              # r2 = b - c
                 bgt  r2, L0              # if b > c goto L0
                 ld   $0x0, r2            # if b <= c, r2 = 0
                 br   L1                  # goto L1
L0:              ld   $0x1, r2            # r2 = 1
L1:              br   L7                  # break
                 not  r1                  
                 inc  r1                  # r1 = -b
                 add  r2, r1              # r1 = c - b
                 bgt  r1, L2              # if c > b goto L2
                 ld   $0x0, r2            # if c <= b, r2 = 0 = c
                 br   L3                  # goto L3
L2:              ld   $0x1, r2            # r2 = 1
L3:              br   L7                  # break
                 not  r2                  
                 inc  r2                  # r2 = -c
                 add  r1, r2              # r2 = b - c
                 beq  r2, L4              # if b == c goto L4
                 ld   $0x0, r2            # if b != c, r2 = 0
                 br   L5                  # goto L5
L4:              ld   $0x1, r2            # r2 = 1
L5:              br   L7                  # break
L6:              ld   $0x0, r2            # r2 = 0
                 br   L7                  # break
L7:              mov  r2, r0              # r0 = r2
                 j    0x0(r6)             # return r0
.pos 0x400
                 .long 0x330              # case 10
                 .long 0x384              # default
                 .long 0x334              # case 12
                 .long 0x384              # default
                 .long 0x33c              # case 14
                 .long 0x384              # default
                 .long 0x354              # case 16
                 .long 0x384              # default
                 .long 0x36c              
.pos 0x1000
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
