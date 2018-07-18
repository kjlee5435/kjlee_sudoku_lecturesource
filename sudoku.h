/*
 *  sudoku.h
 *  sudoku
 *
 *  Created by KwangJo on 10. 10. 8..
 *  Copyright 2010 Yonsei. All rights reserved.
 *
 */
#include <vector>
#include <stdlib.h>
using namespace std;

//함수
bool IsFinish(); //board체크해서 확인
void Init(); //모든 변수 초기화

//변수
extern int board[9][9];
extern bool fixed[9][9];