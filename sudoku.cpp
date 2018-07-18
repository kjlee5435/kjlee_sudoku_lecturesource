/*
 *  sudoku.cpp
 *  sudoku
 *
 *  Created by KwangJo on 10. 10. 8..
 *  Copyright 2010 Yonsei. All rights reserved.
 *
 */

#include "sudoku.h"

int item[9][9];
int board[9][9];
bool fixed[9][9];

vector<int*> set1[9];//가로, 세로, 3*3개씩 있음
vector<int*> set2[9];
vector<int*> set3[9];

bool Check(vector<int*> *_test)
{
	for(int i=0;i<9;i++)
	{
		for(int j=0;j<9;j++)
		{
			if((*_test[i][j])==0) continue;
			for(int k=0;k<9;k++)
			{
				if(j==k) continue;
				if((*_test[i][j]) == (*_test[i][k]))
				{
					return false;
				}
			}
		}
	}
	
	return true;
}

bool FindSet()
{
	int index = -1;
	int counter =0;
	for(int i=0;i<9;i++)
	{
		for(int j=0;j<9;j++)
		{
			item[i][j] = rand()%9+1;
			
			if(index !=j)
			{
				index = -1;
				counter = 0;
			}
			
			if(!( Check(set1) && Check(set2) && Check(set3)) )
			{
				if(index == -1)
				{
					index = j;
				}
				else
				{
					counter++;
				}
				
				if(counter == 100) return false;
				item[i][j] = 0;
				j--;
			}
		}
	}
	return true;
}

//사용자가 입력하는 Board배열을 확인
bool IsFinish()
{
	int sum1[9], sum2[9], sum3[9];
	
	memset(sum1, 0,sizeof(int)*9);
	memset(sum2, 0, sizeof(int)*9);
	memset(sum3, 0, sizeof(int)*9);
	for(int i=0;i<9;i++)
	{
		for(int j=0;j<9;j++)
		{
			sum1[(i/3)*3+j/3]+=board[i][j];
			sum2[i] +=board[i][j];
			sum3[j] +=board[i][j];
		}
	}
	
	for(int i=0;i<9;i++)
	{
		if(sum1[i]!=45 || sum2[i]!=45 || sum3[i]!=45)
			return false;
	}
	return true;
}

//게임 초기화 함수
void Init()
{
	memset(item, 0, sizeof(int)*9*9);
	memset(board, 0, sizeof(int)*9*9);
	srand(time(0));
	
	for(int i=0;i<9;i++)
	{
		set1[i].clear();
		set2[i].clear();
		set3[i].clear();
	}
	
	for(int i=0;i<9;i++)
	{
		for(int j=0;j<9;j++)
		{
			set1[(i/3)*3+j/3].push_back(&item[i][j]);
			set2[i].push_back(&item[i][j]);
			set3[j].push_back(&item[i][j]);
			fixed[i][j] = false;
		}
	}
	
	
	
	//item 배열 생성(스도쿠 배열)
	while(!FindSet())
	{
		memset(item,0,sizeof(int)*9*9);
	}
	
	//item 배열에서 랜덤으로 숫자 입력
	int cpycnt =0;
	int showcnt = 10 + rand()%61; //10~40개의 결과를 보여줌
	
	while(cpycnt != showcnt)
	{
		for(int i=0;i<9;i++)
		{
			for(int j=0;j<9;j++)
			{
				if(board[i][j] == 0)
				{
					if(rand()%257 == 1)
					{
						fixed[i][j] = true;
						board[i][j] = item[i][j];
						cpycnt++;
						if(cpycnt == showcnt) return;
						printf("%d,%d\n",cpycnt, showcnt);
					}
				}
				
			}
		}
		
	}
	
}
