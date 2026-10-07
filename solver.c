// Version 1 - 2026/09/30: Replace the BFS table-based solver with Depth-Limited DFS
// Version 2 - 2026/09/30: Add IDDFS with same-face move pruning
// Version 3 - 2026/10/01: Add orientation/permutation pattern databases and convert IDDFS to IDA*
// Version 4 - 2026/10/02: Replace recursive IDA* DFS with an explicit stack
// Version 5 - 2026/10/02: RV32I-friendly C optimization
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* version5: add begin */
static const uint8_t orientation_table[729] = {
0, 5, 5, 4, 4, 5, 4, 6, 3, 6, 3, 4, 4, 3, 5, 5, 
1, 5, 5, 4, 4, 5, 5, 3, 3, 5, 4, 4, 3, 6, 4, 5, 
4, 5, 4, 4, 4, 4, 2, 3, 5, 4, 5, 5, 4, 5, 5, 4, 
5, 4, 3, 5, 3, 5, 4, 5, 4, 5, 5, 5, 4, 4, 5, 5, 
4, 5, 4, 5, 4, 5, 4, 5, 4, 4, 4, 5, 5, 5, 3, 4, 
4, 5, 3, 5, 4, 5, 4, 5, 4, 5, 4, 4, 4, 4, 5, 5, 
4, 4, 5, 4, 5, 5, 5, 4, 5, 4, 4, 5, 4, 5, 3, 5, 
6, 5, 5, 4, 6, 4, 5, 5, 4, 5, 5, 6, 5, 4, 6, 5, 
4, 5, 6, 4, 4, 5, 5, 6, 3, 4, 4, 5, 6, 4, 3, 5, 
2, 5, 4, 5, 5, 5, 3, 5, 5, 5, 4, 5, 4, 5, 6, 5, 
5, 5, 5, 5, 3, 6, 4, 3, 4, 3, 5, 4, 5, 5, 2, 5, 
4, 5, 4, 5, 4, 5, 4, 4, 4, 4, 3, 5, 4, 5, 5, 4, 
4, 5, 3, 5, 6, 4, 5, 5, 4, 5, 4, 5, 5, 5, 4, 4, 
5, 5, 4, 4, 5, 5, 5, 5, 4, 4, 5, 4, 6, 5, 5, 5, 
6, 6, 5, 4, 3, 4, 4, 5, 5, 6, 4, 6, 5, 5, 5, 5, 
5, 4, 5, 5, 3, 5, 4, 4, 5, 4, 5, 5, 5, 4, 3, 3, 
5, 4, 4, 5, 5, 6, 4, 3, 4, 4, 4, 4, 2, 5, 4, 4, 
4, 4, 5, 4, 4, 4, 4, 4, 5, 5, 4, 3, 5, 5, 5, 5, 
4, 5, 2, 4, 5, 3, 4, 5, 3, 4, 5, 5, 4, 5, 5, 3, 
4, 4, 4, 5, 6, 4, 5, 4, 5, 3, 5, 4, 5, 5, 5, 4, 
5, 4, 5, 4, 3, 3, 5, 3, 4, 4, 5, 5, 4, 4, 4, 5, 
5, 4, 5, 4, 4, 3, 3, 5, 4, 4, 5, 3, 5, 2, 4, 4, 
5, 4, 4, 4, 5, 5, 5, 5, 5, 4, 5, 4, 5, 4, 5, 4, 
5, 5, 4, 5, 5, 5, 5, 4, 5, 5, 4, 5, 3, 4, 4, 5, 
4, 4, 5, 4, 5, 5, 5, 3, 4, 3, 3, 4, 2, 3, 3, 5, 
4, 4, 5, 5, 4, 5, 5, 2, 5, 4, 4, 5, 4, 4, 4, 4, 
5, 5, 5, 2, 5, 5, 5, 4, 5, 4, 1, 5, 6, 5, 2, 5, 
5, 4, 3, 4, 5, 4, 5, 5, 4, 5, 6, 3, 4, 4, 4, 4, 
4, 5, 4, 4, 5, 3, 4, 5, 4, 4, 3, 5, 5, 5, 4, 5, 
4, 5, 5, 6, 5, 4, 6, 5, 5, 5, 5, 4, 5, 5, 5, 5, 
3, 5, 4, 5, 4, 4, 5, 5, 3, 4, 5, 5, 4, 4, 4, 5, 
4, 5, 4, 5, 4, 5, 4, 4, 5, 4, 4, 5, 5, 4, 4, 5, 
5, 4, 5, 5, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 
5, 3, 4, 5, 6, 4, 5, 5, 5, 4, 4, 5, 4, 5, 4, 4, 
5, 5, 4, 4, 5, 5, 4, 5, 5, 4, 6, 4, 4, 5, 4, 5, 
6, 5, 6, 6, 5, 5, 4, 5, 2, 5, 5, 5, 5, 5, 3, 4, 
3, 4, 5, 5, 4, 4, 3, 6, 6, 5, 5, 5, 5, 5, 6, 4, 
4, 5, 5, 4, 4, 5, 6, 5, 5, 4, 5, 6, 5, 3, 4, 4, 
5, 5, 5, 6, 5, 6, 4, 5, 5, 5, 6, 4, 4, 5, 4, 4, 
4, 4, 5, 4, 4, 5, 4, 5, 4, 3, 4, 5, 5, 5, 5, 5, 
5, 5, 4, 4, 5, 4, 4, 5, 3, 5, 3, 4, 3, 5, 4, 4, 
5, 4, 5, 5, 5, 2, 4, 4, 3, 4, 3, 4, 4, 5, 3, 4, 
5, 5, 4, 5, 4, 5, 4, 5, 4, 5, 5, 5, 4, 5, 5, 5, 
5, 5, 6, 5, 4, 5, 6, 5, 4, 5, 3, 5, 5, 4, 3, 4, 
4, 4, 5, 4, 4, 5, 4, 5, 6, 5, 4, 5, 5, 4, 4, 5, 
5, 5, 4, 5, 4, 5, 3, 5, 5
};

static const uint8_t permutation_table[5040] = {
0, 7, 7, 6, 6, 6, 7, 5, 6, 1, 6, 6, 6, 6, 6, 6, 
1, 6, 1, 6, 6, 7, 6, 5, 7, 3, 3, 6, 6, 6, 5, 5, 
6, 6, 4, 4, 4, 5, 5, 4, 6, 5, 6, 4, 5, 5, 3, 5, 
5, 5, 4, 6, 5, 4, 6, 4, 6, 4, 4, 5, 6, 5, 3, 4, 
5, 5, 5, 5, 6, 5, 5, 4, 6, 4, 5, 5, 6, 3, 6, 4, 
7, 6, 4, 4, 3, 6, 4, 4, 6, 5, 5, 5, 6, 6, 4, 3, 
6, 4, 4, 5, 5, 5, 4, 5, 6, 6, 4, 4, 4, 5, 4, 5, 
6, 5, 5, 4, 5, 5, 3, 5, 7, 4, 5, 5, 5, 5, 4, 5, 
5, 6, 4, 5, 5, 4, 5, 5, 6, 5, 6, 5, 5, 5, 5, 6, 
5, 5, 5, 6, 3, 5, 6, 5, 3, 4, 4, 6, 6, 2, 4, 5, 
5, 6, 5, 5, 6, 3, 6, 5, 3, 4, 4, 5, 6, 6, 6, 6, 
6, 3, 5, 4, 5, 5, 5, 5, 3, 5, 2, 5, 6, 5, 5, 6, 
6, 5, 5, 2, 5, 5, 1, 6, 6, 5, 5, 6, 6, 5, 6, 5, 
5, 2, 6, 6, 2, 5, 5, 6, 6, 5, 5, 7, 3, 4, 6, 5, 
3, 5, 4, 5, 5, 2, 5, 5, 5, 6, 5, 5, 6, 3, 6, 4, 
5, 5, 5, 3, 6, 5, 3, 4, 6, 6, 5, 5, 4, 6, 5, 5, 
5, 3, 5, 6, 2, 7, 5, 4, 6, 5, 4, 5, 5, 6, 6, 5, 
4, 6, 4, 4, 4, 5, 6, 4, 5, 5, 6, 3, 5, 5, 4, 5, 
6, 4, 5, 5, 4, 6, 4, 6, 5, 5, 4, 4, 4, 5, 5, 5, 
5, 4, 5, 5, 5, 5, 3, 6, 5, 4, 5, 6, 4, 5, 6, 6, 
4, 4, 5, 5, 5, 4, 5, 6, 5, 6, 4, 6, 6, 3, 5, 5, 
5, 6, 6, 3, 5, 6, 3, 5, 5, 6, 5, 5, 5, 6, 6, 5, 
5, 3, 6, 5, 2, 5, 6, 5, 6, 5, 6, 5, 2, 5, 6, 6, 
1, 6, 6, 5, 5, 2, 6, 5, 6, 5, 5, 5, 5, 2, 6, 5, 
6, 5, 4, 6, 5, 3, 7, 4, 6, 6, 3, 5, 4, 6, 4, 3, 
5, 6, 6, 4, 6, 6, 5, 3, 4, 6, 6, 3, 6, 5, 3, 5, 
6, 5, 6, 5, 5, 6, 5, 6, 5, 3, 5, 5, 2, 6, 6, 4, 
4, 5, 5, 5, 4, 6, 5, 5, 3, 5, 5, 4, 5, 4, 6, 4, 
4, 5, 5, 5, 4, 4, 5, 5, 5, 5, 4, 6, 6, 5, 6, 5, 
6, 5, 3, 5, 4, 5, 5, 4, 5, 6, 5, 4, 6, 6, 5, 6, 
3, 4, 4, 6, 5, 6, 6, 5, 6, 3, 5, 4, 5, 6, 6, 5, 
2, 6, 3, 5, 5, 5, 5, 6, 4, 4, 6, 5, 5, 4, 6, 3, 
6, 5, 6, 4, 4, 6, 4, 5, 5, 5, 5, 5, 5, 6, 5, 4, 
5, 4, 4, 5, 5, 5, 6, 6, 6, 5, 4, 4, 3, 6, 6, 3, 
6, 6, 5, 3, 5, 6, 4, 5, 5, 5, 5, 6, 6, 2, 5, 2, 
6, 4, 5, 6, 6, 5, 1, 6, 5, 5, 4, 6, 6, 5, 5, 2, 
5, 3, 5, 5, 5, 6, 5, 6, 6, 5, 4, 4, 4, 5, 5, 5, 
5, 4, 5, 5, 5, 5, 4, 6, 4, 6, 5, 3, 6, 5, 3, 4, 
5, 5, 6, 5, 5, 5, 5, 5, 5, 3, 5, 6, 2, 6, 6, 4, 
6, 4, 4, 5, 5, 5, 6, 5, 5, 7, 4, 3, 3, 6, 5, 3, 
6, 6, 6, 3, 5, 6, 4, 6, 5, 4, 4, 6, 5, 5, 5, 5, 
5, 5, 4, 5, 5, 5, 4, 5, 5, 5, 4, 5, 6, 4, 4, 5, 
5, 5, 6, 5, 3, 5, 6, 6, 3, 5, 6, 4, 4, 4, 6, 6, 
5, 6, 4, 6, 5, 4, 5, 6, 4, 6, 6, 3, 5, 5, 3, 4, 
6, 5, 5, 5, 5, 6, 5, 6, 4, 3, 5, 6, 2, 6, 6, 5, 
7, 5, 4, 5, 5, 5, 5, 6, 5, 6, 5, 5, 5, 5, 5, 5, 
6, 4, 6, 5, 5, 4, 4, 5, 3, 7, 5, 5, 5, 5, 5, 5, 
5, 4, 4, 6, 6, 6, 5, 4, 4, 5, 4, 4, 6, 6, 6, 4, 
5, 5, 6, 4, 6, 4, 4, 4, 6, 5, 5, 5, 4, 5, 4, 6, 
4, 4, 5, 6, 3, 6, 5, 3, 5, 4, 5, 6, 4, 6, 6, 5, 
4, 5, 6, 4, 4, 3, 5, 5, 5, 6, 4, 5, 5, 4, 5, 6, 
4, 6, 4, 6, 5, 4, 5, 5, 5, 5, 4, 6, 6, 6, 5, 4, 
4, 6, 4, 3, 6, 6, 6, 5, 6, 5, 4, 4, 4, 5, 4, 5, 
5, 7, 4, 4, 4, 5, 6, 3, 6, 5, 6, 4, 5, 5, 4, 5, 
5, 6, 5, 4, 6, 3, 4, 4, 5, 4, 5, 6, 6, 6, 4, 5, 
5, 4, 5, 4, 3, 5, 5, 4, 6, 3, 5, 5, 4, 6, 4, 5, 
4, 5, 4, 4, 4, 3, 6, 5, 6, 4, 6, 5, 5, 4, 4, 6, 
5, 5, 2, 7, 5, 5, 6, 6, 5, 5, 3, 5, 5, 5, 5, 3, 
4, 6, 4, 3, 6, 4, 6, 5, 4, 5, 5, 5, 6, 3, 4, 4, 
5, 3, 6, 6, 6, 5, 4, 6, 4, 4, 4, 5, 4, 6, 5, 4, 
4, 4, 6, 5, 5, 5, 4, 6, 5, 4, 6, 5, 5, 6, 5, 7, 
4, 5, 3, 6, 5, 5, 4, 5, 6, 5, 6, 5, 2, 5, 6, 5, 
3, 5, 6, 4, 5, 3, 4, 6, 5, 6, 6, 5, 6, 3, 4, 5, 
5, 5, 2, 5, 6, 6, 5, 6, 6, 4, 3, 5, 6, 6, 5, 3, 
5, 5, 4, 3, 4, 5, 6, 6, 5, 3, 5, 3, 5, 5, 2, 6, 
5, 5, 4, 4, 4, 5, 5, 5, 5, 3, 4, 5, 3, 4, 4, 6, 
6, 4, 5, 6, 6, 5, 6, 5, 6, 6, 4, 4, 4, 5, 5, 4, 
6, 6, 5, 5, 6, 5, 5, 4, 6, 4, 3, 5, 6, 6, 4, 5, 
6, 6, 4, 4, 5, 5, 6, 4, 5, 5, 6, 4, 4, 5, 4, 6, 
1, 6, 6, 5, 6, 6, 6, 5, 6, 2, 5, 5, 5, 5, 6, 5, 
2, 5, 2, 6, 5, 6, 5, 5, 6, 4, 5, 5, 5, 4, 6, 5, 
5, 7, 4, 4, 3, 5, 5, 4, 6, 6, 6, 4, 6, 6, 4, 4, 
5, 5, 6, 7, 3, 4, 6, 4, 4, 4, 5, 4, 5, 4, 3, 5, 
5, 6, 5, 6, 6, 4, 4, 4, 3, 5, 6, 5, 4, 4, 5, 3, 
5, 4, 6, 5, 4, 5, 4, 5, 4, 5, 4, 6, 4, 5, 5, 4, 
6, 5, 5, 5, 4, 4, 5, 4, 3, 6, 5, 6, 6, 4, 5, 5, 
6, 5, 5, 6, 4, 4, 6, 4, 6, 5, 5, 2, 5, 5, 3, 6, 
5, 7, 5, 5, 4, 5, 5, 4, 6, 3, 6, 4, 3, 6, 5, 5, 
2, 5, 6, 5, 4, 4, 6, 3, 5, 3, 6, 5, 4, 5, 4, 5, 
3, 6, 3, 5, 5, 5, 5, 4, 5, 5, 6, 4, 4, 5, 4, 5, 
3, 5, 6, 6, 5, 4, 6, 6, 5, 3, 4, 5, 4, 4, 6, 5, 
5, 6, 3, 4, 5, 6, 5, 6, 5, 5, 4, 5, 6, 5, 5, 4, 
5, 5, 4, 4, 4, 4, 6, 5, 5, 4, 6, 5, 6, 5, 4, 5, 
5, 5, 6, 5, 5, 5, 4, 6, 4, 5, 4, 5, 5, 5, 4, 5, 
5, 6, 6, 5, 2, 5, 5, 4, 3, 5, 6, 5, 6, 3, 5, 5, 
4, 6, 5, 5, 6, 3, 5, 4, 6, 6, 3, 4, 6, 6, 4, 5, 
6, 5, 4, 5, 5, 6, 6, 4, 5, 4, 5, 4, 4, 5, 6, 5, 
4, 3, 5, 4, 6, 4, 3, 5, 6, 4, 5, 4, 4, 5, 5, 6, 
4, 4, 3, 6, 4, 5, 4, 5, 5, 4, 4, 5, 6, 5, 6, 5, 
5, 6, 4, 4, 4, 6, 5, 3, 5, 6, 6, 4, 5, 6, 5, 4, 
6, 5, 4, 4, 4, 5, 4, 5, 4, 6, 5, 4, 5, 4, 6, 5, 
6, 4, 7, 4, 3, 5, 5, 5, 4, 4, 6, 5, 5, 5, 6, 4, 
6, 5, 5, 4, 3, 6, 5, 6, 4, 6, 5, 6, 5, 5, 4, 5, 
4, 6, 5, 3, 6, 6, 4, 5, 5, 4, 4, 5, 5, 6, 6, 5, 
5, 4, 5, 4, 4, 5, 6, 5, 5, 6, 5, 5, 4, 4, 6, 4, 
3, 5, 5, 6, 6, 4, 5, 4, 4, 5, 5, 4, 6, 4, 6, 4, 
4, 5, 7, 5, 5, 5, 6, 4, 6, 5, 6, 5, 4, 5, 5, 6, 
4, 5, 5, 6, 5, 5, 4, 5, 6, 5, 5, 5, 5, 4, 5, 4, 
6, 5, 5, 5, 6, 5, 3, 6, 6, 5, 5, 5, 6, 5, 5, 4, 
5, 6, 5, 3, 4, 6, 4, 6, 5, 4, 6, 5, 5, 5, 6, 6, 
5, 4, 4, 5, 4, 5, 6, 6, 5, 6, 5, 5, 3, 4, 5, 5, 
4, 5, 5, 5, 6, 4, 5, 4, 5, 5, 6, 5, 4, 4, 6, 5, 
2, 5, 7, 5, 6, 5, 5, 4, 5, 3, 6, 5, 5, 5, 5, 6, 
3, 4, 3, 6, 4, 5, 6, 5, 5, 5, 5, 3, 4, 6, 4, 5, 
5, 5, 5, 5, 5, 5, 6, 5, 4, 4, 5, 4, 4, 5, 6, 6, 
5, 5, 4, 6, 6, 5, 5, 6, 5, 5, 4, 5, 5, 5, 6, 5, 
5, 5, 4, 5, 6, 5, 4, 6, 3, 6, 5, 4, 6, 5, 5, 6, 
6, 4, 4, 6, 6, 5, 5, 4, 4, 5, 4, 4, 5, 6, 5, 5, 
4, 3, 6, 4, 5, 5, 5, 4, 6, 5, 6, 3, 2, 6, 5, 5, 
5, 5, 5, 5, 4, 6, 3, 5, 5, 5, 6, 5, 3, 4, 5, 4, 
4, 4, 5, 5, 6, 4, 3, 6, 5, 5, 5, 6, 5, 4, 5, 4, 
6, 4, 4, 6, 5, 4, 5, 5, 5, 6, 5, 5, 5, 4, 5, 5, 
6, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 4, 5, 5, 4, 6, 
5, 4, 5, 6, 6, 5, 5, 6, 5, 5, 5, 6, 4, 4, 6, 6, 
6, 4, 6, 4, 5, 4, 4, 4, 6, 5, 6, 4, 5, 6, 3, 6, 
6, 5, 5, 5, 5, 6, 4, 4, 5, 4, 3, 6, 5, 4, 5, 5, 
5, 5, 4, 5, 5, 4, 5, 4, 5, 5, 4, 4, 6, 5, 5, 5, 
4, 3, 5, 4, 5, 5, 3, 6, 6, 4, 6, 4, 4, 6, 5, 6, 
4, 4, 3, 6, 4, 5, 4, 6, 5, 6, 4, 4, 6, 5, 5, 4, 
5, 4, 5, 5, 6, 5, 5, 5, 5, 5, 5, 5, 4, 5, 6, 5, 
5, 4, 6, 6, 5, 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 6, 
6, 5, 5, 6, 6, 5, 5, 5, 5, 4, 5, 5, 4, 6, 4, 6, 
4, 5, 5, 5, 5, 3, 6, 5, 5, 5, 6, 6, 5, 4, 4, 7, 
6, 6, 4, 4, 5, 4, 5, 5, 4, 5, 5, 5, 6, 5, 5, 5, 
6, 5, 6, 4, 4, 5, 6, 5, 3, 6, 5, 4, 4, 6, 5, 5, 
5, 4, 5, 6, 5, 5, 5, 4, 4, 5, 4, 5, 5, 5, 6, 5, 
4, 4, 5, 5, 4, 5, 6, 4, 5, 5, 5, 4, 3, 5, 5, 4, 
5, 6, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 5, 6, 4, 6, 
5, 6, 5, 6, 6, 4, 6, 6, 5, 5, 5, 6, 5, 5, 5, 7, 
4, 6, 4, 5, 5, 4, 5, 5, 5, 5, 4, 6, 5, 4, 5, 5, 
5, 5, 4, 5, 6, 5, 6, 5, 4, 4, 5, 5, 5, 5, 6, 4, 
6, 5, 6, 4, 3, 6, 5, 5, 5, 6, 5, 6, 5, 6, 4, 5, 
6, 6, 6, 4, 4, 5, 5, 5, 4, 5, 5, 5, 5, 5, 4, 5, 
6, 4, 6, 6, 4, 5, 6, 5, 5, 4, 4, 7, 5, 3, 6, 4, 
4, 5, 4, 5, 5, 4, 4, 4, 5, 6, 4, 5, 6, 5, 5, 4, 
5, 6, 5, 6, 4, 3, 6, 3, 5, 4, 5, 5, 5, 4, 2, 5, 
5, 6, 5, 6, 7, 5, 5, 3, 6, 5, 6, 2, 5, 5, 1, 6, 
6, 5, 5, 6, 6, 6, 5, 6, 5, 2, 5, 6, 2, 5, 5, 5, 
5, 5, 5, 6, 3, 4, 6, 4, 2, 6, 5, 6, 5, 3, 5, 4, 
5, 5, 5, 5, 5, 3, 6, 4, 2, 6, 5, 5, 5, 6, 5, 5, 
6, 3, 4, 6, 6, 6, 6, 5, 3, 4, 3, 4, 4, 6, 5, 6, 
5, 6, 3, 6, 5, 5, 5, 4, 5, 4, 4, 6, 7, 5, 4, 4, 
4, 5, 4, 4, 5, 4, 6, 5, 5, 6, 5, 4, 3, 6, 5, 6, 
2, 5, 5, 5, 5, 3, 7, 5, 6, 4, 5, 4, 5, 3, 5, 6, 
7, 4, 4, 6, 6, 4, 6, 5, 6, 6, 3, 4, 3, 5, 5, 3, 
6, 5, 6, 4, 5, 6, 4, 4, 5, 6, 5, 4, 5, 5, 4, 4, 
6, 6, 5, 5, 6, 6, 5, 5, 5, 4, 6, 4, 3, 5, 6, 4, 
5, 5, 5, 5, 4, 5, 5, 4, 3, 5, 5, 4, 5, 4, 5, 4, 
4, 5, 5, 4, 4, 4, 5, 5, 4, 5, 5, 5, 5, 6, 6, 5, 
5, 5, 4, 5, 4, 5, 5, 4, 4, 6, 4, 5, 5, 6, 5, 6, 
3, 6, 5, 6, 4, 5, 6, 4, 5, 4, 4, 6, 6, 5, 5, 4, 
4, 5, 4, 4, 5, 5, 6, 4, 4, 5, 5, 5, 5, 6, 6, 5, 
5, 4, 6, 4, 4, 4, 5, 6, 4, 6, 3, 5, 6, 5, 4, 5, 
5, 5, 4, 6, 4, 4, 5, 4, 4, 4, 3, 6, 6, 3, 3, 4, 
5, 5, 4, 4, 6, 4, 5, 4, 6, 3, 5, 6, 5, 4, 6, 4, 
6, 5, 4, 3, 2, 6, 5, 4, 6, 6, 6, 5, 5, 6, 3, 5, 
4, 6, 6, 6, 3, 4, 5, 3, 4, 5, 6, 5, 6, 4, 4, 5, 
4, 6, 5, 5, 6, 4, 5, 4, 4, 3, 5, 6, 5, 4, 5, 4, 
6, 4, 6, 4, 4, 5, 3, 6, 4, 5, 3, 6, 6, 6, 4, 4, 
5, 5, 6, 4, 3, 6, 3, 6, 4, 4, 5, 5, 5, 4, 6, 6, 
4, 4, 5, 5, 4, 4, 4, 7, 5, 5, 5, 5, 4, 5, 6, 4, 
3, 5, 5, 4, 4, 4, 5, 5, 4, 6, 5, 4, 5, 4, 5, 5, 
6, 5, 5, 4, 6, 5, 5, 4, 6, 6, 5, 6, 6, 5, 5, 4, 
6, 5, 6, 4, 4, 5, 5, 4, 5, 4, 6, 6, 6, 4, 5, 5, 
5, 5, 6, 4, 4, 6, 5, 6, 5, 5, 4, 5, 6, 5, 3, 5, 
6, 5, 6, 4, 3, 5, 3, 5, 4, 5, 5, 5, 5, 4, 5, 6, 
5, 4, 5, 6, 4, 4, 4, 5, 4, 4, 5, 6, 5, 3, 5, 3, 
5, 4, 4, 5, 5, 4, 2, 5, 4, 5, 3, 5, 6, 5, 5, 3, 
5, 4, 5, 5, 4, 6, 5, 6, 4, 5, 5, 5, 5, 3, 6, 6, 
5, 5, 4, 6, 6, 4, 4, 6, 5, 6, 6, 4, 4, 6, 3, 5, 
5, 4, 6, 6, 5, 5, 6, 5, 4, 4, 4, 6, 4, 5, 5, 6, 
6, 6, 4, 5, 5, 4, 6, 5, 5, 5, 5, 7, 6, 4, 4, 5, 
6, 5, 6, 5, 5, 4, 6, 5, 4, 5, 5, 6, 4, 4, 6, 4, 
4, 5, 4, 5, 4, 4, 4, 4, 5, 7, 5, 5, 6, 5, 5, 3, 
6, 4, 6, 6, 4, 4, 5, 5, 4, 5, 5, 5, 4, 3, 5, 6, 
6, 5, 5, 6, 6, 4, 4, 5, 5, 5, 5, 3, 6, 5, 2, 5, 
5, 4, 6, 6, 6, 6, 4, 6, 5, 3, 4, 6, 3, 6, 5, 5, 
4, 6, 4, 5, 5, 5, 6, 5, 4, 5, 4, 5, 6, 5, 5, 4, 
4, 6, 5, 3, 5, 5, 6, 4, 5, 4, 6, 5, 4, 7, 6, 6, 
3, 5, 6, 4, 3, 4, 6, 5, 6, 6, 5, 5, 5, 4, 4, 6, 
4, 4, 6, 5, 6, 4, 4, 5, 6, 4, 6, 4, 4, 6, 5, 6, 
4, 4, 3, 5, 5, 5, 3, 5, 6, 5, 5, 6, 3, 5, 6, 5, 
3, 5, 6, 4, 5, 2, 4, 6, 6, 5, 5, 6, 5, 3, 4, 5, 
5, 6, 2, 6, 6, 5, 6, 5, 6, 4, 3, 5, 6, 5, 4, 3, 
5, 6, 4, 3, 5, 5, 6, 5, 6, 4, 4, 4, 4, 5, 3, 6, 
4, 5, 3, 5, 5, 4, 5, 4, 6, 4, 5, 4, 4, 3, 4, 6, 
6, 3, 5, 5, 5, 5, 5, 4, 5, 6, 5, 4, 4, 5, 4, 5, 
5, 6, 6, 6, 5, 6, 4, 4, 4, 6, 5, 4, 5, 5, 5, 5, 
5, 4, 4, 5, 6, 6, 5, 5, 3, 5, 4, 5, 5, 5, 6, 4, 
6, 5, 3, 6, 5, 4, 6, 5, 5, 5, 4, 5, 6, 5, 4, 4, 
5, 5, 5, 4, 6, 4, 5, 4, 4, 4, 5, 6, 4, 5, 6, 5, 
5, 4, 5, 5, 5, 5, 4, 5, 4, 5, 3, 6, 6, 5, 4, 5, 
6, 6, 5, 4, 5, 4, 5, 3, 6, 6, 5, 5, 5, 5, 4, 4, 
5, 5, 6, 5, 4, 6, 6, 4, 6, 4, 4, 5, 4, 5, 5, 6, 
4, 5, 4, 5, 5, 4, 5, 5, 6, 4, 5, 5, 5, 3, 5, 6, 
5, 6, 6, 4, 5, 4, 4, 4, 4, 5, 6, 5, 5, 5, 5, 5, 
6, 4, 6, 5, 3, 4, 6, 5, 6, 5, 4, 3, 4, 5, 4, 6, 
5, 6, 4, 5, 4, 5, 6, 3, 6, 4, 5, 4, 4, 5, 5, 6, 
3, 6, 5, 5, 3, 5, 6, 4, 4, 4, 5, 5, 5, 4, 5, 4, 
4, 6, 4, 5, 6, 4, 6, 5, 5, 5, 5, 4, 3, 5, 5, 5, 
2, 6, 5, 5, 5, 3, 6, 5, 6, 4, 5, 4, 4, 3, 6, 6, 
4, 5, 4, 3, 5, 6, 4, 6, 5, 4, 5, 4, 5, 6, 6, 5, 
4, 4, 3, 5, 4, 5, 5, 5, 5, 4, 5, 5, 4, 5, 5, 5, 
5, 6, 5, 4, 3, 5, 5, 5, 6, 6, 6, 4, 5, 5, 4, 4, 
5, 4, 6, 5, 4, 3, 6, 4, 3, 6, 6, 5, 5, 4, 4, 5, 
6, 5, 5, 6, 5, 4, 5, 4, 6, 4, 5, 2, 6, 5, 1, 6, 
6, 5, 5, 5, 5, 5, 5, 6, 6, 2, 5, 6, 2, 5, 4, 6, 
5, 5, 3, 6, 6, 6, 6, 6, 5, 4, 4, 4, 5, 5, 6, 4, 
4, 6, 4, 4, 5, 6, 5, 5, 4, 5, 5, 5, 5, 6, 6, 6, 
4, 5, 5, 5, 4, 5, 6, 4, 5, 5, 5, 4, 5, 5, 5, 5, 
2, 5, 6, 5, 5, 5, 5, 4, 6, 3, 6, 5, 4, 6, 5, 5, 
3, 5, 3, 5, 4, 6, 5, 4, 6, 4, 2, 6, 6, 5, 5, 4, 
6, 6, 3, 5, 5, 5, 5, 3, 5, 6, 5, 3, 6, 6, 4, 5, 
4, 5, 5, 6, 4, 4, 5, 5, 5, 3, 4, 5, 6, 5, 4, 5, 
4, 6, 4, 5, 6, 5, 5, 5, 6, 4, 5, 6, 6, 3, 5, 4, 
6, 6, 5, 5, 4, 6, 4, 5, 6, 6, 5, 4, 5, 5, 4, 4, 
6, 4, 4, 5, 6, 5, 4, 5, 6, 6, 5, 5, 5, 5, 4, 5, 
6, 5, 5, 5, 5, 5, 4, 5, 6, 5, 4, 4, 6, 5, 4, 4, 
5, 6, 4, 6, 6, 5, 5, 5, 5, 4, 6, 5, 5, 6, 5, 5, 
3, 4, 6, 4, 5, 5, 4, 5, 5, 4, 6, 4, 3, 6, 5, 5, 
4, 4, 4, 5, 3, 6, 4, 4, 4, 4, 3, 6, 6, 6, 5, 6, 
6, 5, 3, 5, 5, 6, 6, 4, 5, 5, 5, 4, 6, 6, 4, 5, 
5, 6, 5, 5, 4, 4, 5, 5, 4, 4, 5, 6, 6, 4, 4, 6, 
5, 6, 5, 6, 6, 3, 6, 5, 4, 5, 6, 3, 5, 5, 4, 4, 
6, 5, 6, 5, 4, 6, 5, 5, 4, 4, 5, 5, 4, 6, 5, 5, 
5, 5, 4, 3, 5, 5, 4, 4, 5, 5, 3, 6, 6, 5, 5, 4, 
6, 4, 6, 4, 4, 4, 6, 5, 3, 6, 4, 6, 5, 4, 6, 5, 
5, 3, 5, 6, 6, 5, 5, 5, 3, 6, 2, 5, 6, 4, 5, 5, 
6, 3, 5, 6, 4, 4, 5, 4, 5, 6, 6, 4, 4, 5, 3, 6, 
5, 5, 5, 6, 6, 5, 4, 4, 5, 4, 5, 5, 3, 6, 5, 6, 
4, 6, 5, 4, 3, 4, 6, 5, 5, 5, 6, 4, 4, 4, 4, 5, 
5, 6, 5, 6, 4, 5, 6, 4, 3, 5, 5, 6, 5, 4, 5, 4, 
5, 5, 4, 5, 6, 4, 6, 5, 5, 6, 6, 4, 5, 6, 4, 5, 
5, 5, 6, 5, 5, 4, 5, 6, 4, 4, 5, 6, 3, 4, 6, 6, 
6, 3, 5, 5, 6, 4, 5, 4, 7, 5, 6, 4, 4, 6, 3, 5, 
6, 5, 5, 5, 6, 6, 3, 4, 6, 5, 3, 5, 5, 4, 5, 5, 
5, 5, 4, 6, 6, 4, 5, 4, 6, 4, 5, 4, 5, 4, 5, 5, 
5, 3, 5, 5, 4, 5, 4, 6, 5, 4, 5, 4, 4, 5, 6, 6, 
5, 5, 4, 5, 5, 5, 4, 6, 5, 6, 4, 4, 5, 5, 4, 4, 
6, 5, 5, 5, 5, 6, 5, 5, 6, 5, 6, 5, 4, 5, 6, 5, 
6, 4, 5, 5, 4, 5, 6, 6, 4, 5, 5, 4, 3, 5, 6, 5, 
5, 6, 6, 4, 5, 5, 4, 6, 5, 6, 5, 6, 4, 4, 5, 4, 
3, 6, 5, 6, 6, 4, 5, 4, 5, 5, 6, 5, 5, 4, 7, 4, 
4, 5, 5, 4, 4, 5, 3, 6, 5, 4, 6, 5, 6, 5, 5, 6, 
4, 4, 3, 6, 4, 5, 6, 6, 6, 4, 2, 5, 6, 6, 4, 5, 
6, 6, 3, 5, 5, 5, 6, 3, 5, 5, 6, 3, 5, 5, 4, 6, 
4, 4, 4, 6, 5, 4, 6, 5, 5, 5, 3, 5, 5, 4, 4, 4, 
5, 6, 4, 4, 7, 5, 5, 4, 6, 6, 4, 5, 5, 5, 5, 4, 
4, 6, 5, 6, 6, 5, 5, 4, 5, 4, 6, 5, 5, 5, 5, 4, 
4, 3, 6, 4, 4, 6, 4, 5, 5, 5, 6, 3, 2, 5, 6, 5, 
5, 4, 5, 5, 3, 5, 3, 5, 3, 5, 4, 5, 5, 6, 6, 5, 
6, 4, 4, 6, 5, 6, 6, 3, 4, 5, 4, 3, 6, 6, 5, 5, 
6, 5, 5, 4, 5, 3, 5, 4, 4, 5, 6, 6, 6, 4, 4, 5, 
6, 5, 6, 6, 5, 4, 6, 4, 5, 6, 6, 4, 5, 6, 4, 5, 
6, 5, 7, 5, 5, 5, 6, 6, 4, 5, 5, 6, 5, 5, 6, 5, 
5, 4, 3, 5, 5, 5, 5, 6, 5, 5, 4, 5, 5, 5, 5, 4, 
5, 4, 4, 4, 5, 4, 5, 6, 3, 6, 5, 4, 5, 6, 5, 6, 
5, 4, 4, 6, 6, 6, 6, 4, 4, 4, 4, 4, 5, 5, 7, 5, 
5, 5, 6, 4, 6, 3, 5, 2, 6, 6, 6, 5, 4, 6, 3, 5, 
5, 5, 6, 6, 5, 6, 5, 3, 5, 5, 6, 5, 4, 6, 6, 6, 
4, 4, 6, 4, 4, 4, 5, 5, 5, 6, 4, 5, 5, 5, 4, 6, 
4, 6, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 5, 4, 
5, 6, 5, 4, 6, 6, 6, 4, 5, 3, 5, 6, 5, 5, 5, 5, 
6, 5, 6, 4, 4, 5, 4, 6, 5, 5, 4, 6, 6, 6, 4, 5, 
5, 5, 6, 4, 3, 5, 4, 6, 4, 5, 6, 6, 6, 4, 5, 6, 
5, 4, 6, 5, 4, 4, 5, 6, 4, 5, 5, 5, 4, 5, 6, 4, 
4, 5, 5, 4, 4, 5, 5, 5, 5, 6, 5, 4, 5, 5, 5, 5, 
6, 5, 4, 4, 6, 6, 4, 5, 6, 6, 4, 6, 6, 5, 5, 5, 
7, 4, 6, 4, 5, 5, 5, 5, 5, 3, 5, 6, 6, 4, 5, 5, 
6, 5, 6, 4, 4, 6, 4, 6, 5, 5, 4, 5, 6, 6, 4, 5, 
4, 6, 5, 5, 4, 4, 5, 4, 5, 3, 5, 6, 5, 4, 3, 6, 
4, 6, 4, 6, 6, 4, 5, 4, 5, 4, 6, 3, 6, 5, 2, 5, 
7, 5, 5, 5, 5, 6, 4, 5, 6, 3, 5, 5, 3, 6, 5, 4, 
4, 5, 5, 6, 4, 4, 7, 4, 3, 5, 5, 5, 4, 4, 5, 4, 
5, 6, 4, 5, 6, 4, 5, 4, 3, 5, 5, 4, 4, 5, 4, 6, 
5, 4, 5, 5, 5, 5, 6, 6, 4, 3, 4, 5, 4, 5, 4, 6, 
5, 6, 3, 6, 6, 4, 6, 4, 6, 4, 4, 5, 6, 5, 3, 4, 
5, 6, 4, 4, 5, 5, 5, 4, 4, 5, 6, 5, 4, 6, 5, 5, 
3, 5, 5, 5, 4, 4, 6, 5, 5, 5, 5, 5, 4, 4, 5, 6, 
6, 4, 3, 6, 5, 4, 5, 5, 5, 6, 4, 5, 4, 4, 5, 4, 
6, 5, 5, 4, 5, 5, 4, 5, 6, 5, 5, 5, 4, 5, 4, 5, 
5, 6, 6, 6, 6, 5, 4, 6, 5, 4, 5, 5, 4, 5, 5, 5, 
5, 5, 4, 4, 4, 6, 5, 5, 4, 6, 4, 5, 4, 5, 6, 4, 
5, 5, 6, 3, 5, 5, 5, 5, 4, 4, 5, 6, 5, 6, 5, 5, 
4, 4, 5, 5, 5, 4, 5, 5, 5, 5, 4, 6, 6, 5, 5, 6, 
4, 6, 4, 6, 5, 5, 5, 4, 5, 5, 5, 6, 6, 6, 5, 5, 
4, 5, 5, 4, 5, 5, 7, 5, 4, 4, 6, 5, 6, 5, 6, 5, 
6, 5, 6, 4, 3, 5, 4, 6, 4, 6, 4, 6, 5, 6, 4, 5, 
4, 5, 4, 5, 5, 5, 6, 5, 5, 5, 3, 6, 6, 4, 4, 4, 
5, 6, 5, 4, 6, 5, 6, 5, 6, 4, 5, 6, 5, 4, 5, 4, 
5, 5, 5, 4, 3, 5, 4, 5, 6, 5, 6, 6, 5, 6, 4, 5, 
4, 7, 5, 5, 3, 5, 5, 4, 4, 4, 5, 6, 6, 4, 4, 5, 
4, 6, 5, 4, 5, 4, 6, 5, 5, 3, 4, 6, 5, 5, 5, 5, 
5, 5, 5, 4, 4, 4, 4, 5, 5, 5, 4, 5, 6, 5, 4, 5, 
4, 6, 5, 5, 3, 5, 4, 5, 4, 5, 5, 6, 6, 4, 6, 5, 
5, 4, 5, 4, 5, 4, 5, 6, 5, 4, 5, 4, 5, 6, 5, 5, 
4, 5, 6, 4, 3, 5, 6, 5, 5, 5, 5, 5, 5, 5, 4, 6, 
6, 5, 4, 5, 5, 5, 4, 5, 5, 5, 5, 6, 6, 4, 4, 5, 
6, 5, 6, 5, 5, 4, 5, 5, 6, 4, 6, 5, 7, 4, 4, 5, 
6, 6, 5, 5, 5, 6, 4, 5, 6, 5, 5, 5, 5, 6, 4, 5, 
5, 6, 6, 5, 4, 5, 4, 5, 5, 5, 5, 6, 6, 5, 4, 5, 
4, 4, 5, 5, 5, 5, 5, 5, 4, 4, 4, 5, 6, 4, 4, 4, 
6, 4, 5, 5, 5, 5, 3, 5, 4, 5, 3, 5, 5, 6, 5, 4, 
5, 4, 6, 6, 4, 6, 6, 5, 3, 5, 6, 5, 5, 4, 5, 5, 
5, 6, 5, 6, 6, 4, 5, 5, 4, 6, 5, 4, 5, 5, 4, 4, 
5, 5, 6, 5, 5, 6, 5, 6, 5, 5, 5, 5, 4, 6, 6, 5, 
5, 5, 5, 5, 4, 4, 6, 5, 4, 4, 5, 6, 5, 3, 5, 6, 
5, 6, 5, 6, 6, 4, 6, 5, 5, 5, 5, 5, 4, 5, 5, 5, 
5, 6, 5, 5, 4, 5, 5, 4, 6, 6, 6, 5, 5, 5, 5, 4, 
5, 4, 6, 6, 5, 4, 6, 5, 4, 6, 6, 5, 4, 4, 5, 5, 
6, 6, 6, 5, 6, 5, 4, 5, 6, 5, 5, 3, 6, 5, 2, 6, 
5, 5, 5, 6, 6, 5, 5, 6, 6, 3, 5, 5, 3, 5, 5, 6, 
5, 5, 4, 6, 5, 6, 6, 5, 5, 5, 5, 5, 6, 6, 6, 5, 
4, 7, 5, 4, 6, 6, 5, 5, 4, 5, 6, 4, 5, 6, 5, 5, 
4, 5, 5, 5, 4, 5, 6, 5, 5, 5, 5, 5, 4, 5, 5, 6
};
/* version5: add end */

enum {
    CUBIES = 7,
    PERMUTATIONS = 5040,
    ORIENTATIONS = 729,
    STATES = PERMUTATIONS * ORIENTATIONS,
    MOVES = 9
};

typedef struct {
    uint8_t p[CUBIES], o[CUBIES];
} state_t;

/*@ predicate valid_state(state_t *state) =
      (\forall integer i; 0 <= i < CUBIES ==>
         state->p[i] < CUBIES && state->o[i] < 3) &&
      (\forall integer i, j; 0 <= i < j < CUBIES ==>
         state->p[i] != state->p[j]) &&
      (state->o[0] + state->o[1] + state->o[2] + state->o[3] +
       state->o[4] + state->o[5] + state->o[6]) % 3 == 0;
 */

static const char *const move_names[MOVES] = {"R",  "R2", "R'", "B", "B2",
                                              "B'", "D",  "D2", "D'"};
static const uint8_t inverse_move[MOVES] = {2, 1, 0, 5, 4, 3, 8, 7, 6};

/* version5: add begin */
static const uint8_t move_face[MOVES] = {
    0, 0, 0,   // R, R2, R'
    1, 1, 1,   // B, B2, B'
    2, 2, 2    // D, D2, D'
};
/* version5: add end */

/* Each destination takes a cubie from source[face][destination]. */
/* version5: mark */
/*
static const uint8_t source[3][CUBIES] = {
    {1, 4, 2, 0, 3, 5, 6},
    {0, 1, 2, 4, 5, 6, 3},
    {0, 2, 5, 3, 1, 4, 6},
};
static const uint8_t twist[3][CUBIES] = {
    {1, 2, 0, 2, 1, 0, 0},
    {0, 0, 0, 1, 2, 1, 2},
    {0, 0, 0, 0, 0, 0, 0},
};
*/
/* version5: add begin*/
static const uint8_t move_source[MOVES][CUBIES] = {
    {1, 4, 2, 0, 3, 5, 6}, // R
    {4, 3, 2, 1, 0, 5, 6}, // R2
    {3, 0, 2, 4, 1, 5, 6}, // R'

    {0, 1, 2, 4, 5, 6, 3}, // B
    {0, 1, 2, 5, 6, 3, 4}, // B2
    {0, 1, 2, 6, 3, 4, 5}, // B'

    {0, 2, 5, 3, 1, 4, 6}, // D
    {0, 5, 4, 3, 2, 1, 6}, // D2
    {0, 4, 1, 3, 5, 2, 6}  // D'
};

static const uint8_t move_twist[MOVES][CUBIES] = {
    {1, 2, 0, 2, 1, 0, 0}, // R
    {0, 0, 0, 0, 0, 0, 0}, // R2
    {1, 2, 0, 2, 1, 0, 0}, // R'

    {0, 0, 0, 1, 2, 1, 2}, // B
    {0, 0, 0, 0, 0, 0, 0}, // B2
    {0, 0, 0, 1, 2, 1, 2}, // B'

    {0, 0, 0, 0, 0, 0, 0}, // D
    {0, 0, 0, 0, 0, 0, 0}, // D2
    {0, 0, 0, 0, 0, 0, 0}  // D'
};
/* version5: add end*/

/* The three quarter-turns preserve the fixed front-upper-left corner. */
/*@ requires face < 3;
    assigns \nothing;
    ensures \forall integer i; 0 <= i < CUBIES ==>
              \result.p[i] == state.p[source[face][i]];
    ensures \forall integer i; 0 <= i < CUBIES ==>
              \result.o[i] == (state.o[source[face][i]] + twist[face][i]) % 3;
 */
/* version5: mark */
/*
static state_t quarter_turn(state_t state, uint8_t face)
{
    state_t result;
    */
    /*@ loop invariant 0 <= i <= CUBIES;
        loop invariant \forall integer j; 0 <= j < i ==>
          result.p[j] == state.p[source[face][j]];
        loop invariant \forall integer j; 0 <= j < i ==>
          result.o[j] == (state.o[source[face][j]] + twist[face][j]) % 3;
        loop assigns i, result.p[0..6], result.o[0..6];
        loop variant CUBIES - i;
    */
    /* version5: mark */
    /*
    for (uint8_t i = 0; i < CUBIES; ++i) {
        uint8_t from = source[face][i];
        result.p[i] = state.p[from];
        // result.o[i] = (uint8_t) ((state.o[from] + twist[face][i]) % 3U); // version5: mark
        */
        /* version5: add begin*/
        /*
        result.o[i] = (uint8_t) ((state.o[from] + twist[face][i]));
        if(result.o[i] >= 3){
            result.o[i] = result.o[i] - 3;
        }
        */
        /* version5: add end*/
        /*
    }
    return result;
}
*/

static state_t apply_move(state_t state, uint8_t move)
{
    /* version5: mark */
    /*
    uint8_t turns = (uint8_t) (move % 3U + 1U);
    for (uint8_t i = 0; i < turns; ++i)
        state = quarter_turn(state, (uint8_t) (move / 3U));
    return state;
    */

    /* version5: add begin */
    state_t result;

    for (uint8_t i = 0; i < CUBIES; ++i) {
        uint8_t from = move_source[move][i];
        result.p[i] = state.p[from];

        result.o[i] = (uint8_t) ((state.o[from] + move_twist[move][i]));

        if(result.o[i] >= 3){
            result.o[i] = result.o[i] - 3;
        }
    }

    return result;
    /*
    switch(move){
        case 0:
            return quarter_turn(state, 0);
        case 1:
            state = quarter_turn(state, 0);
            return quarter_turn(state, 0);
        case 2:
            state = quarter_turn(state, 0);
            state = quarter_turn(state, 0);
            return quarter_turn(state, 0);
        case 3:
            return quarter_turn(state, 1);
        case 4:
            state = quarter_turn(state, 1);
            return quarter_turn(state, 1);
        case 5:
            state = quarter_turn(state, 1);
            state = quarter_turn(state, 1);
            return quarter_turn(state, 1);
        case 6:
            return quarter_turn(state, 2);
        case 7:
            state = quarter_turn(state, 2);
            return quarter_turn(state, 2);
        case 8:
            state = quarter_turn(state, 2);
            state = quarter_turn(state, 2);
            return quarter_turn(state, 2);

        default:
            return state;
    }
    */
    /* version5: add end */
}

/* version5: add begin */
static uint16_t rank_permutation(const state_t *state){
    uint16_t p = 0;
    /*
    for (uint8_t i = 0; i < CUBIES; ++i) {
        uint8_t smaller = 0;
        */
        /*@ loop invariant i + 1 <= j <= CUBIES;
            loop invariant smaller <= j - i - 1;
            loop assigns j, smaller;
            loop variant CUBIES - j;
         */
        /*
        for (uint8_t j = (uint8_t) (i + 1U); j < CUBIES; ++j)
            if (state->p[j] < state->p[i])
                ++smaller;
        // p = p * (CUBIES - i) + smaller;

        switch (i) {
            case 0:
                p = (p << 3) - p; // *7
                break;
            case 1:
                p = (p << 2) + (p << 1); // *6
                break;
            case 2:
                p = (p << 2) + p; // *5
                break;
            case 3:
                p = (p << 2); // *4
                break;
            case 4:
                p = (p << 1) + p; // *3
                break;
            case 5:
                p = p << 1; // *2
                break;
            case 6:
                break; // *1
        }

        p = p + smaller;
    }
    */

    // unrolling
    uint8_t smaller;

    /* i = 0 */
    smaller = 0;
    for (uint8_t j = 1; j < CUBIES; ++j)
        if (state->p[j] < state->p[0])
            ++smaller;
    // p = (p << 3) - p + smaller; // p * 7; p = 0
    p = smaller;

    /* i = 1 */
    smaller = 0;
    for (uint8_t j = 2; j < CUBIES; ++j)
        if (state->p[j] < state->p[1])
            ++smaller;
    p = (p << 2) + (p << 1) + smaller; // p * 6

    /* i = 2 */
    smaller = 0;
    for (uint8_t j = 3; j < CUBIES; ++j)
        if (state->p[j] < state->p[2])
            ++smaller;
    p = (p << 2) + p + smaller; // p * 5

    /* i = 3 */
    smaller = 0;
    for (uint8_t j = 4; j < CUBIES; ++j)
        if (state->p[j] < state->p[3])
            ++smaller;    
    p = (p << 2) + smaller; // p * 4

    /* i = 4 */    
    smaller = 0;
    for (uint8_t j = 5; j < CUBIES; ++j)
        if (state->p[j] < state->p[4])
            ++smaller;    
    p = (p << 1) + p + smaller; // p * 3

    /* i = 5 */    
    smaller = 0;
    // for (uint8_t j = 6; j < CUBIES; ++j)
    if (state->p[6] < state->p[5])
        ++smaller;        
    p = (p << 1) + smaller; // p * 2

    /* i = 6 */    
    /*
    smaller = 0;
    for (uint8_t j = 7; j < CUBIES; ++j) // CUBIES = 7
        if (state->p[j] < state->p[6])
            ++smaller; // smaller = 0
    p = p + smaller;
    */

    return p;
}

static uint16_t rank_orientation(const state_t *state){
    uint16_t o = 0;
    /*@ loop invariant 0 <= i <= 6;
        loop invariant (i == 0 ==> o == 0) && (i == 1 ==> o < 3) &&
          (i == 2 ==> o < 9) && (i == 3 ==> o < 27) &&
          (i == 4 ==> o < 81) && (i == 5 ==> o < 243) &&
          (i == 6 ==> o < 729);
        loop assigns i, o;
        loop variant 6 - i;
     */
    for (uint8_t i = 0; i < 6; ++i)
        // o = o * 3U + state->o[i];
        o = (o << 1) + o + state->o[i];
    return o;
}
/* version5: add end */

/*@ requires \valid_read(state);
    requires \forall integer i; 0 <= i < CUBIES ==>
      0 <= state->p[i] < CUBIES;
    requires \forall integer i, j; 0 <= i < j < CUBIES ==>
      state->p[i] != state->p[j];
    requires \forall integer i; 0 <= i < CUBIES ==>
      0 <= state->o[i] < 3;
    assigns \nothing;
    ensures \result < STATES;
 */
static uint32_t rank_state(const state_t *state)
{   
    // uint32_t p = 0, o = 0; // version5: mark
    /*@ loop invariant 0 <= i <= CUBIES;
        loop invariant (i == 0 ==> p == 0) && (i == 1 ==> p <= 6) &&
          (i == 2 ==> p <= 41) && (i == 3 ==> p <= 209) &&
          (i == 4 ==> p <= 839) && (i == 5 ==> p <= 2519) &&
          (i >= 6 ==> p <= 5039);
        loop assigns i, p;
        loop variant CUBIES - i;
     */
    
    /* version5: mark */
    /*
    for (uint8_t i = 0; i < CUBIES; ++i) {
        uint8_t smaller = 0;
        */

        /*@ loop invariant i + 1 <= j <= CUBIES;
            loop invariant smaller <= j - i - 1;
            loop assigns j, smaller;
            loop variant CUBIES - j;
         */

        /* version5: mark */
        /*
        for (uint8_t j = (uint8_t) (i + 1U); j < CUBIES; ++j)
            if (state->p[j] < state->p[i])
                ++smaller;
        p = p * (CUBIES - i) + smaller;
    }
    */

    /*@ loop invariant 0 <= i <= 6;
        loop invariant (i == 0 ==> o == 0) && (i == 1 ==> o < 3) &&
          (i == 2 ==> o < 9) && (i == 3 ==> o < 27) &&
          (i == 4 ==> o < 81) && (i == 5 ==> o < 243) &&
          (i == 6 ==> o < 729);
        loop assigns i, o;
        loop variant 6 - i;
     */
    
    /* version5: mark */
    /*
    for (uint8_t i = 0; i < 6; ++i)
        o = o * 3U + state->o[i];
    */

    /* version5: add begin */
    uint32_t p = rank_permutation(state);
    uint32_t o = rank_orientation(state);
    /* version5: add end */
    return p * ORIENTATIONS + o;
}

/*@ requires \valid(state); requires rank < STATES; assigns *state; */
static void unrank_state(uint32_t rank, state_t *state)
{
    uint8_t available[CUBIES] = {0, 1, 2, 3, 4, 5, 6};
    uint32_t p = rank / ORIENTATIONS, o = rank % ORIENTATIONS, f = 720;
    uint8_t sum = 0;
    for (uint8_t i = 0; i < CUBIES; ++i) {
        uint8_t q = (uint8_t) (p / f);
        p %= f;
        state->p[i] = available[q];
        for (uint8_t j = q; j + 1U < CUBIES - i; ++j)
            available[j] = available[j + 1U];
        if (i < 5)
            f /= 6U - i;
    }
    for (uint8_t i = 6; i-- > 0;) {
        state->o[i] = (uint8_t) (o % 3U);
        sum = (uint8_t) (sum + state->o[i]);
        o /= 3U;
    }
    state->o[6] = (uint8_t) ((3U - sum % 3U) % 3U);
}

/*@ requires \valid_read(state);
    requires \initialized(&state->p[0..6]) && \initialized(&state->o[0..6]);
    assigns \nothing;
    ensures \result != 0 ==> \forall integer i; 0 <= i < CUBIES ==>
      state->p[i] < CUBIES && state->o[i] < 3;
    ensures \result != 0 ==> \forall integer i, j; 0 <= i < j < CUBIES ==>
      state->p[i] != state->p[j];
    ensures \result != 0 ==>
      (state->o[0] + state->o[1] + state->o[2] + state->o[3] +
       state->o[4] + state->o[5] + state->o[6]) % 3 == 0;
    ensures complete: valid_state(state) ==> \result != 0;
 */
static int valid(const state_t *state)
{
    uint8_t sum = 0;
    /*@ loop invariant 0 <= i <= CUBIES;
        loop invariant sum <= 2 * i;
        loop invariant sum == (i > 0 ? state->o[0] : 0) +
          (i > 1 ? state->o[1] : 0) + (i > 2 ? state->o[2] : 0) +
          (i > 3 ? state->o[3] : 0) + (i > 4 ? state->o[4] : 0) +
          (i > 5 ? state->o[5] : 0) + (i > 6 ? state->o[6] : 0);
        loop invariant \forall integer j; 0 <= j < i ==>
          state->p[j] < CUBIES && state->o[j] < 3;
        loop invariant \forall integer j, k; 0 <= j < k < i ==>
          state->p[j] != state->p[k];
        loop assigns i, sum;
        loop variant CUBIES - i;
    */
    for (uint8_t i = 0; i < CUBIES; ++i) {
        if (state->p[i] >= CUBIES || state->o[i] >= 3)
            return 0;
        /*@ loop invariant 0 <= j <= i;
            loop invariant \forall integer k; 0 <= k < j ==>
              state->p[k] != state->p[i];
            loop assigns j;
            loop variant i - j;
        */
        for (uint8_t j = 0; j < i; ++j)
            if (state->p[j] == state->p[i])
                return 0;
        sum = (uint8_t) (sum + state->o[i]);
    }
    return sum == 0 || sum == 3 || sum == 6 || sum == 9 || sum == 12; // version5: add
    // return sum % 3U == 0; // version5: mark
}

/* version1: Depth-Limited DFS mark */
/*
static uint8_t *build_table(uint8_t *diameter)
{
    uint8_t *toward_solved = malloc(STATES);
    uint32_t *queue = malloc((size_t) STATES * sizeof *queue);
    uint16_t permutation[3][PERMUTATIONS], orientation[3][ORIENTATIONS];
    uint32_t head = 0, tail = 1, level_end = 1;
    state_t state;
    if (!toward_solved || !queue) {
        free(toward_solved);
        free(queue);
        return NULL;
    }
    for (uint16_t rank = 0; rank < PERMUTATIONS; ++rank) {
        unrank_state((uint32_t) rank * ORIENTATIONS, &state);
        for (uint8_t face = 0; face < 3; ++face) {
            state_t next = quarter_turn(state, face);
            permutation[face][rank] =
                (uint16_t) (rank_state(&next) / ORIENTATIONS);
        }
    }
    for (uint16_t rank = 0; rank < ORIENTATIONS; ++rank) {
        unrank_state(rank, &state);
        for (uint8_t face = 0; face < 3; ++face) {
            state_t next = quarter_turn(state, face);
            orientation[face][rank] =
                (uint16_t) (rank_state(&next) % ORIENTATIONS);
        }
    }
    memset(toward_solved, UINT8_MAX, STATES);
    queue[0] = 0;
    toward_solved[0] = 0;
    *diameter = 0;
    while (head < tail) {
        if (head == level_end) {
            level_end = tail;
            ++*diameter;
        }
        uint32_t here = queue[head++];
        uint16_t p = (uint16_t) (here / ORIENTATIONS);
        uint16_t o = (uint16_t) (here % ORIENTATIONS);
        for (uint8_t face = 0; face < 3; ++face) {
            uint16_t next_p = p, next_o = o;
            for (uint8_t turn = 0; turn < 3; ++turn) {
                next_p = permutation[face][next_p];
                next_o = orientation[face][next_o];
                uint32_t there = (uint32_t) next_p * ORIENTATIONS + next_o;
                if (toward_solved[there] == UINT8_MAX) {
                    uint8_t move = (uint8_t) (face * 3U + turn);
                    toward_solved[there] = inverse_move[move];
                    queue[tail++] = there;
                }
            }
        }
    }
    free(queue);
    if (tail != STATES) {
        free(toward_solved);
        return NULL;
    }
    return toward_solved;
}
*/

/*@ requires valid_read_string(input);
    requires \valid(state);
    assigns state->p[0..6], state->o[0..6];
    ensures \result != 0 ==> input[14] == '\0';
    ensures \result != 0 ==> \forall integer i; 0 <= i < CUBIES ==>
      state->p[i] < CUBIES && state->o[i] < 3;
    ensures \result != 0 ==> \forall integer i, j; 0 <= i < j < CUBIES ==>
      state->p[i] != state->p[j];
    ensures \result != 0 ==>
      (state->o[0] + state->o[1] + state->o[2] + state->o[3] +
       state->o[4] + state->o[5] + state->o[6]) % 3 == 0;
    ensures \result != 0 ==> \forall integer i; 0 <= i < CUBIES ==>
      state->p[i] == input[i] - '1';
    ensures \result != 0 ==> \forall integer i; 0 <= i < CUBIES ==>
      state->o[i] == input[i + CUBIES] - '1';
 */
static int parse_state(const char *input, state_t *state)
{
    /*@ loop invariant 0 <= i <= 14;
        loop invariant i <= strlen(input);
        loop invariant i <= 7 ==> \initialized(&state->p[0..i-1]);
        loop invariant i >= 7 ==> \initialized(&state->p[0..6]);
        loop invariant i >= 7 ==> \initialized(&state->o[0..i-8]);
        loop invariant \forall integer j; 0 <= j < i && j < CUBIES ==>
          state->p[j] == input[j] - '1';
        loop invariant \forall integer j; 0 <= j < i - CUBIES ==>
          state->o[j] == input[j + CUBIES] - '1';
        loop assigns i, state->p[0..6], state->o[0..6];
        loop variant 14 - i;
     */
    /* version5: mark */
    /*
    for (int i = 0; i < 14; ++i) {
        int limit = i < 7 ? 7 : 3;
        if (input[i] < '1' || input[i] > '0' + limit)
            return 0;
        (i < 7 ? state->p : state->o)[i % 7] = (uint8_t) (input[i] - '1');
    }
    */

    /* version5: add begin */
    for (uint8_t i = 0; i < CUBIES; ++i) {
        if (input[i] < '1' || input[i] > '7')
            return 0;

        if (input[7 + i] < '1' || input[7 + i] > '3')
            return 0;

        state->p[i] = (uint8_t) (input[i] - '1');
        state->o[i] = (uint8_t) (input[7 + i] - '1');
    }
    /* version5: add end */

    return input[14] == '\0' && valid(state);
}

/* stdout is fully buffered off a terminal, so a write error surfaces at the
 * flush, not at the printf that queued the bytes. Every exit path that has
 * produced output goes through here.
 */
static int output_failed(void)
{
    return fflush(stdout) != 0 || ferror(stdout);
}

static int self_test(void)
{
    const state_t solved = {{0, 1, 2, 3, 4, 5, 6}, {0}};
    state_t state;
    for (uint8_t move = 0; move < MOVES; ++move) {
        state = solved;
        state = apply_move(state, move);
        state = apply_move(state, inverse_move[move]);
        if (memcmp(&solved, &state, sizeof solved))
            return 0;
    }
    for (uint32_t rank = 0; rank < STATES; ++rank) {
        unrank_state(rank, &state);
        if (!valid(&state) || rank_state(&state) != rank)
            return 0;
    }
    return 1;
}

/* version3: PDB heuristic and IDA* add begin */
/* version5: mark*/
/*
// orientation table
static uint8_t *build_orientation_table(uint8_t *diameter)
{
    //step1. 配置記憶體
    uint8_t *orientation_dist = malloc(ORIENTATIONS); //這個 orientation 到 solved 至少需要幾步
    uint32_t *queue = malloc((size_t) ORIENTATIONS * sizeof *queue); //BFS 使用的佇列
    
    uint16_t orientation[3][ORIENTATIONS]; //加速產生下一個 state 

    uint32_t head = 0, tail = 1, level_end = 1; //BFS queue 的管理資訊
    //head: 下一個要取出的 queue index //tail: 下一個新 state 要放入的位置 //level_end: 目前 BFS 深度這一層的結束位置
    state_t state; 
    if (!orientation_dist || !queue) { //配置失敗檢查
        free(orientation_dist);
        free(queue);
        return NULL;
    }
    
    //step3. 建立 orientation transition table
    for (uint16_t rank = 0; rank < ORIENTATIONS; ++rank) {
        unrank_state(rank, &state); //完整 rank = 0 × 729 + orientation rank
        for (uint8_t face = 0; face < 3; ++face) {
            state_t next = quarter_turn(state, face);
            orientation[face][rank] =
                (uint16_t) (rank_state(&next) % ORIENTATIONS); //取出新的 orientation rank
        }
    }
    
    //step4. 初始化 BFS
    memset(orientation_dist, UINT8_MAX, ORIENTATIONS); //UINT8_MAX = 255 //memset(起始位址, 填入的值, byte數量);
    queue[0] = 0; //先把 solved state 放入 BFS
    orientation_dist[0] = 0; //先把 solved state 放入 BFS
    *diameter = 0; //所有 state 中，最大的最短距離

    //step5. 真正的 BFS
    while (head < tail) { //BFS queue 尚有 state 沒處理，就繼續搜尋
        if (head == level_end) { //記錄 BFS 目前進入哪個深度
            level_end = tail; //目前這一層在 queue 中的結束位置
            ++*diameter;
        }
        uint32_t here = queue[head++]; //取得下一個 state 的 rank，然後 head 加 1
        uint16_t o = (uint16_t) here; //拆出 orientation rank
        for (uint8_t face = 0; face < 3; ++face) { //產生 9 種 move
            uint16_t next_o = o;
            for (uint8_t turn = 0; turn < 3; ++turn) {
                next_o = orientation[face][next_o];
                uint32_t there = (uint32_t) next_o; //新的 orientation rank
                // 存 orientation_dist
                if (orientation_dist[there] == UINT8_MAX) {
                    orientation_dist[there] = orientation_dist[here] + 1;
                    queue[tail++] = there;
                }
            }
        }
    }
    
    //結束與回傳
    free(queue);
    if (tail != ORIENTATIONS) { //確認是否真的拜訪全部 729 個 state
        free(orientation_dist);
        return NULL;
    }
    return orientation_dist;
}

static uint8_t *build_permutation_table(uint8_t *diameter)
{
    //step1. 配置記憶體
    uint8_t *permutation_dist = malloc(PERMUTATIONS); //這個 permutation 到 solved 至少需要幾步
    uint32_t *queue = malloc((size_t) PERMUTATIONS * sizeof *queue); //BFS 使用的佇列
    
    uint16_t permutation[3][PERMUTATIONS]; //加速產生下一個 state

    uint32_t head = 0, tail = 1, level_end = 1; //BFS queue 的管理資訊
    //head: 下一個要取出的 queue index //tail: 下一個新 state 要放入的位置 //level_end: 目前 BFS 深度這一層的結束位置
    state_t state; 
    if (!permutation_dist || !queue) { //配置失敗檢查
        free(permutation_dist);
        free(queue);
        return NULL;
    }
    
    //step3. 建立 permutation transition table
    for (uint16_t rank = 0; rank < PERMUTATIONS; ++rank) {
        unrank_state((uint32_t) rank * ORIENTATIONS, &state); //完整 rank = permutation rank × 729 + 0
        for (uint8_t face = 0; face < 3; ++face) {
            state_t next = quarter_turn(state, face);
            permutation[face][rank] =
                (uint16_t) (rank_state(&next) / ORIENTATIONS); //取出新的 permutation rank
        }
    }
    
    //step4. 初始化 BFS
    memset(permutation_dist, UINT8_MAX, PERMUTATIONS); //UINT8_MAX = 255 //memset(起始位址, 填入的值, byte數量);
    queue[0] = 0; //先把 solved state 放入 BFS
    permutation_dist[0] = 0; //先把 solved state 放入 BFS
    *diameter = 0; //所有 state 中，最大的最短距離
    
    //step5. 真正的 BFS
    while (head < tail) { //BFS queue 尚有 state 沒處理，就繼續搜尋
        if (head == level_end) { //記錄 BFS 目前進入哪個深度
            level_end = tail; //目前這一層在 queue 中的結束位置
            ++*diameter;
        }
        uint32_t here = queue[head++]; //取得下一個 state 的 rank，然後 head 加 1
        uint16_t p = (uint16_t) here; //拆出 permutation rank
        for (uint8_t face = 0; face < 3; ++face) { //產生 9 種 move
            uint16_t next_p = p;
            for (uint8_t turn = 0; turn < 3; ++turn) {
                next_p = permutation[face][next_p];
                uint32_t there = (uint32_t) next_p; //新的 permutation rank
                // 存 permutation_dist
                if (permutation_dist[there] == UINT8_MAX) {
                    permutation_dist[there] = permutation_dist[here] + 1;
                    queue[tail++] = there;
                }
            }
        }
    }
    
    //結束與回傳
    free(queue);
    if (tail != PERMUTATIONS) { //確認是否真的拜訪全部 5040 個 state
        free(permutation_dist);
        return NULL;
    }
    return permutation_dist;
}
*/

// static uint8_t heuristic(const state_t *state, const uint8_t *orientation_table, const uint8_t *permutation_table){ // version5: mark
static uint8_t heuristic(const uint16_t p, const uint16_t o, const uint8_t *orientation_table, const uint8_t *permutation_table){ // version5: add
    /* version5: mark */
    /*
    uint32_t rank = rank_state(state);
    
    uint16_t p = (uint16_t)(rank / ORIENTATIONS);
    uint16_t o = (uint16_t)(rank % ORIENTATIONS);
    */
    
    uint8_t heuristic_p = permutation_table[p];
    uint8_t heuristic_o = orientation_table[o];
    
    return heuristic_p > heuristic_o ? heuristic_p : heuristic_o;
}
/* version3: PDB heuristic and IDA* add end */
/* version1: Depth-Limited DFS add begin */
static uint8_t path[11];
static uint8_t solution_depth;

// static int depth_limit_dfs(state_t state, uint8_t depth, uint8_t limit){ // version3: PDB heuristic and IDA* mark
/* version4: iterative DFS with explicit stack mark*/
/*
static int depth_limit_dfs(state_t state, uint8_t depth, uint8_t limit, uint8_t *orientation_table, uint8_t *permutation_table){ // version3: PDB heuristic and IDA* add
    //1. solved?
    if(rank_state(&state) == 0){
        solution_depth = depth; //找到答案時，記錄用了幾步
        return 1;
    }
    //2. depth limit reached?
    if(depth == limit){
        return 0;
    }
    
    // version3: PDB heuristic and IDA* add begin
    if(heuristic(&state, orientation_table, permutation_table) + depth > limit){
        return 0;
    }
    // version3: PDB heuristic and IDA* add end

    //3. try 9 moves
    for(uint8_t move = 0; move < MOVES; ++move){
        // Version2: IDDFS and move pruning add begin
        if (depth > 0 && move / 3 == path[depth - 1] / 3) {
            continue;
        }
        // Version2: IDDFS and move pruning add end 
        state_t next = apply_move(state, move); //把「move 編號 0~8」轉成：哪個面 + 做幾次 quarter turn
        path[depth] = move;
        // 繼續往下一層搜尋
        // if(depth_limit_dfs(next, depth + 1, limit)){ // version3: PDB heuristic and IDA* mark
        if(depth_limit_dfs(next, depth + 1, limit, orientation_table, permutation_table)){ // version3: PDB heuristic and IDA* add
            return 1;
        }
    }
    //9 個 move 都失敗
    return 0;
}
*/
/* version1: Depth-Limited DFS add end */

/* version4: iterative DFS with explicit stack add begin*/
typedef struct {
    state_t state;
    uint8_t next_move;
} dfs_frame_t;

static int depth_limit_dfs_iterative(state_t state, uint8_t limit, const uint8_t *orientation_table,const uint8_t *permutation_table)
{
    dfs_frame_t stack[12];
    stack[0].state = state;
    stack[0].next_move = 0;
    uint8_t depth = 0;
    
    //while loop:
    while(1){
        // 1. solved?
        //     -> return 1;
        /* version5: add begin */
        if(stack[depth].next_move == 0){
            uint16_t p = rank_permutation(&stack[depth].state);
            uint16_t o = rank_orientation(&stack[depth].state);
            if (p == 0 && o == 0){
            /* version5: add end */
            // if(rank_state(&stack[depth].state) == 0){ // versoin5: mark
                solution_depth = depth;
                return 1;
            }
            // 2. depth limit / heuristic pruning
            //     if depth == 0: return 0;
            //     -> pop; continue
            if(depth == limit){
                if(depth == 0){
                    return 0;
                }
                // pop
                --depth;
                continue;
            }

            // if(heuristic(&stack[depth].state, orientation_table, permutation_table) + depth > limit){ // version5: mark
            if(heuristic(p, o, orientation_table, permutation_table) + depth > limit){ // version5: add
                // pop
                if(depth == 0){
                    return 0;
                }
                --depth;
                continue;
            }
        }
        // 3. 9 moves 都試完?
        //     -> true
        //         if depth == 0: return 0;
        //         -> pop; continue
        //     -> false
        //         -> push next state
        if(stack[depth].next_move >= MOVES){   
            // pop
            if(depth == 0){
                return 0;
            }
            --depth;
            continue;
        }
        
        // move pruning // 先把目前要試的 move 存起來
        uint8_t move = stack[depth].next_move;
        // if (depth > 0 && move / 3 == path[depth - 1] / 3) { version5: mark
        if(depth > 0 && move_face[move] == move_face[path[depth - 1]]){ // version5: add
            stack[depth].next_move++;
            continue;
        }
        

        path[depth] = move;

        // 算 next state
        state_t next_state = apply_move(stack[depth].state, move);
        // 更新當前 next move
        stack[depth].next_move++;

        // push
        ++depth;
        stack[depth].state = next_state;
        stack[depth].next_move = 0;
    }
}
/* version4: iterative DFS with explicit stack add end*/

int main(int argc, char **argv)
{
    state_t state;
    //uint8_t diameter; /* version1: Depth-Limited DFS mark */
    /* version3: PDB heuristic and IDA* add begin */
    /* version5: mark*/
    /*
    uint8_t orientation_diameter;
    uint8_t permutation_diameter;
    */
    /* version3: PDB heuristic and IDA* add end */

    if (argc == 2 && !strcmp(argv[1], "--self-test")) {
        if (!self_test()) {
            fputs("self-test failed\n", stderr);
            return 1;
        }
        /* version1: Depth-Limited DFS mark */
        /*
        uint8_t *table = build_table(&diameter);
        if (!table) {
            fputs("could not build complete state table\n", stderr);
            return 1;
        }
        free(table);
        if (diameter != 11) {
            fputs("BFS check failed\n", stderr);
            return 1;
        }
        puts("3674160 states; diameter 11");
        */

        /* version5: add begin */
        /* version5: mark */
        /*
        // check pdb table
        uint8_t *orientation_runtime = build_orientation_table(&orientation_diameter);
        uint8_t *permutation_runtime = build_permutation_table(&permutation_diameter);
        for (uint16_t i = 0; i < ORIENTATIONS; ++i) {
            if (orientation_runtime[i] != orientation_table[i]) {
                printf("orientation mismatch at %u\n", i);
                return 1;
            }
        }
        for (uint16_t i = 0; i < PERMUTATIONS; ++i) {
            if (permutation_runtime[i] != permutation_table[i]) {
                printf("permutation mismatch at %u\n", i);
                return 1;
            }
        }
        puts("PDB tables match");
        */
        /* version5: add end */

        /* version3: PDB heuristic and IDA* add begin */
        /* version5: mark */
        /*
        uint8_t *orientation_table = build_orientation_table(&orientation_diameter);
        if (!orientation_table) {
            fputs("could not build complete state orientation table\n", stderr);
            return 1;
        }
        
        uint8_t *permutation_table = build_permutation_table(&permutation_diameter);
        if (!permutation_table) {
            fputs("could not build complete state permutation table\n", stderr);
            free(orientation_table);
            return 1;
        }
        free(orientation_table);
        free(permutation_table);
        
        if (orientation_diameter != 6) {
            fputs("orientation diameter check failed\n", stderr);
            return 1;
        }
        if (permutation_diameter != 7) {
            fputs("permutation diameter check failed\n", stderr);
            return 1;
        }
        puts("orientation_diameter 6; permutation_diameter 7");
        */
        /* version3: PDB heuristic and IDA* add end */

        // puts("self-test passed"); /* version1: Depth-Limited DFS add */ // version3: PDB heuristic and IDA* mark
        return output_failed();
    }
    if (argc != 2 || !parse_state(argv[1], &state)) {
        /* C99 5.1.2.2.1 lets argv[0] be null when argc is 0. */
        fprintf(stderr, "usage: %s PPPPPPPOOOOOOO\n",
                argc > 0 && argv[0] ? argv[0] : "solver");
        return 2;
    }
    /* version1: Depth-Limited DFS mark */
    /*
    uint8_t *table = build_table(&diameter);
    if (!table) {
        fputs("could not build complete state table\n", stderr);
        return 1;
    }

    const char *separator = "";
    for (uint32_t rank = rank_state(&state); rank; rank = rank_state(&state)) {
        uint8_t move = table[rank];
        printf("%s%s", separator, move_names[move]);
        separator = " ";
        state = apply_move(state, move);
    }
    putchar('\n');
    free(table);
    */

    /* version3: PDB heuristic and IDA* add begin */
    /* version5: mark */
    /*
    uint8_t *orientation_table = build_orientation_table(&orientation_diameter);
    if (!orientation_table) {
        fputs("could not build complete state orientation table\n", stderr);
        return 1;
    }

    uint8_t *permutation_table = build_permutation_table(&permutation_diameter);
    if (!permutation_table) {
        fputs("could not build complete state permutation table\n", stderr);
        free(orientation_table);
        return 1;
    }
    */
    /* version3: PDB heuristic and IDA* add end */
    
    /* version1: Depth-Limited DFS add begin */
    //uint8_t limit = 11; /* version2: IDDFS and move pruning mark */
    int found = 0; /* version2: IDDFS and move pruning add */
    const char *separator = "";

    /* version2: IDDFS and move pruning add begin */
    /* version3: PDB heuristic and IDA* mark */
    /*
    for(uint8_t limit = 0; limit <= 11; ++limit){ // 從 0 一直試到 11
        if(depth_limit_dfs(state, 0, limit)){ 
    */
    /* version3: PDB heuristic and IDA* add begin */
    
    /* version5: add begin */
    uint16_t start_p = rank_permutation(&state);
    uint16_t start_o = rank_orientation(&state);
    uint8_t start = heuristic(start_p, start_o, orientation_table, permutation_table);
    /* version5: add end */
    // uint8_t start = heuristic(&state, orientation_table, permutation_table); // version5: mark
    for (uint8_t limit = start; limit <= 11; ++limit){
        // if(depth_limit_dfs(state, 0, limit, orientation_table, permutation_table)){ // version4: iterative DFS with explicit stack mark
        if(depth_limit_dfs_iterative(state, limit, orientation_table, permutation_table)){ // version4: iterative DFS with explicit stack add
    /* version3: PDB heuristic and IDA* add end */
            for(uint8_t i = 0; i < solution_depth; ++i){
                printf("%s%s", separator, move_names[path[i]]);
                separator = " ";
            }
            putchar('\n');
            found = 1;
            break;
        }
    }
    if(found==0){
        puts("not found");
    }

    /* version3: PDB heuristic and IDA* add begin */
    /* version5: mark*/
    /*
    free(orientation_table);
    free(permutation_table);
    */
    /* version3: PDB heuristic and IDA* add end */

    /* version2: IDDFS and move pruning add end */

    /* version2: IDDFS and move pruning mark */
    /*
    if(depth_limit_dfs(state, 0, limit)){
        for(uint8_t i = 0; i < solution_depth; ++i){
            printf("%s%s", separator, move_names[path[i]]);
                separator = " ";
        }
        putchar('\n');
    }
    else{
        puts("not found");
    }
    */
    /* version1: Depth-Limited DFS add end */
    return output_failed();
}
