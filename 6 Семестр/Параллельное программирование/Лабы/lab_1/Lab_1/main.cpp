//#pragma once
//#include <iostream>
//#include <cstdlib>
//#include <vector>
//#include <cmath>
//#include <ctime>
//#include "binTree.h"
//#include "Map.h"
//#include "state.h"
//#include <ctime>
//#include <set>
//#include <omp.h>
//#include <thread>
//#include "a.h"
//#include "mpi.h"
//
//#define TESTS 10
//
//bool check(Map*);
//
//// Генерация поля
//Map* generateMap(int lines, int cols) {
//	int len = lines*cols;
//	Map* map = new Map(lines, cols);
//	map->lines = lines;
//	map->cols = cols;
//
//	for (int i = 0; i < len; ++i)
//	{
//		map->map[i] = i + 1;
//	}
//	map->map[len - 1] = 0;
//
//	do
//	{
//		for (int i = 0; i < len - 1; ++i) {
//			int k = rand() % (len - 1);
//			int m = map->map[k];
//			map->map[k] = map->map[i];
//			map->map[i] = m;
//		}
//	} while (!check(map));
//
//	return map;
//}
//
//Map* readMap(int lines, int cols) {
//	int len = lines*cols;
//	Map* map = new Map(lines, cols);
//	map->lines = lines;
//	map->cols = cols;
//
//	for (int i = 0; i < len; ++i)
//	{
//		std::cin >> map->map[i];
//	}
//
//	return map;
//}
//
//bool check(Map* map) {
//	int len = map->lines*map->cols;
//	int n = 0;
//	int pos = 0;
//
//	for (int i = 0; i < len; ++i) {
//		if (map->map[i] == 0) {
//			pos = (i / map->cols) + 1;
//			continue;
//		}
//		for (int j = i; j < len; ++j) {
//			if (map->map[i] > map->map[j]) n += 1;
//		}
//	}
//
//	if (len & 1) {
//		if (n % 2 == 0) return true;
//	}
//	else {
//		if ((pos % 2 == 0) && (n & 1)) return true;
//		if ((pos & 1) && (n % 2 == 0)) return true;
//	}
//
//	return false;
//}
//
////bool cmp(State* a, State* b) {
////	Map* am = a->getMap();
////	Map* bm = b->getMap();
////	int len = am->getCols() * am->getLines();
////	for (int i = 0; i < len; i++) {
////		if (am->map[i] != bm->map[i]) return false;
////	}
////	return true;
////}
//
////bool exists(std::multiset<State>* ms, State* s) {
////	std::multiset<State>::iterator iter = ms->find(*s);
////
////	for (; iter != ms->end(); iter++) {
////		State s1 = State(*iter);
////		//if (cmp(&s1, s)) return true;
////		if (s1.getCost() == s->getCost()) return true;
////	}
////
////	return false;
////}
////
////std::vector<State*> a(Map* map) {
////	std::multiset<State> open;
////	std::multiset<State> close;
////	std::multiset<State, comparator> fs;
////
////	State* min = new State(map, NULL);
////
////	close.insert(*min);
////
////	unsigned int maxLen = 1;
////
////	while (min->getCost() != 0) {
////
////		//printMap(min->getMap());
////
////		int zero = min->getMap()->find(0);
////		State* states[4] = {0, 0, 0, 0};
////
////
////#pragma omp parallel sections
////		{
////#pragma omp section
////			{
////				if (zero / map->getCols() != 0) {
////					State* s = new State(min->getMap()->shift(0), min);
////					if (!(exists(&open, s)) && !(exists(&close, s))) {
////						states[0] = s;
////						//open.insert(*s);
////						//fs.insert(*s);
////						// printMap(s->getMap());
////					}
////				}
////			}
////#pragma omp section
////			{
////				if (zero % map->getCols() != map->getCols() - 1) {
////					State* s = new State(min->getMap()->shift(1), min);
////					if (!(exists(&open, s)) && !(exists(&close, s))) {
////						states[1] = s;
////						//open.insert(*s);
////						//fs.insert(*s);
////						// printMap(s->getMap());
////					}
////				}
////			}
////#pragma omp section
////			{
////				if (zero / map->getCols() != map->getLines() - 1) {
////					State* s = new State(min->getMap()->shift(2), min);
////					if (!(exists(&open, s)) && !(exists(&close, s))) {
////						states[2] = s;
////						//open.insert(*s);
////						//fs.insert(*s);
////						// printMap(s->getMap());
////					}
////				}
////			}
////#pragma omp section
////			{
////				if (zero % map->getCols() != 0) {
////					State* s = new State(min->getMap()->shift(3), min);
////					if (!(exists(&open, s)) && !(exists(&close, s))) {
////						states[3] = s;
////						//open.insert(*s);
////						//fs.insert(*s);
////						// printMap(s->getMap());
////					}
////				}
////			}
////		}
////
////		for (int i = 0; i < 4; i++) {
////			if (states[i]) {
////				fs.insert(*states[i]);
////				open.insert(*states[i]);
////			}
////		}
////
////		std::multiset<State>::iterator iter = fs.begin();
////
////		min = new State(*iter);
////
////		close.insert(*iter);
////		open.erase(*iter);
////		fs.erase(iter);
////
////	}
////
////	std::vector<State*> solution;
////
////	State* s = min;
////	do
////	{
////		solution.push_back(s);
////		s = s->getParent();
////	} while (s != NULL);
////
////	return solution;
////}
//
////int main(int argc, char *argv[]){
////	int lines, cols;
////	Map* map;
////
////	//if ( (lines <= 1) || (cols <= 1) ) {
////	//	std::cout << "wrong martix's parameters" << std::endl;
////	//	system("Pause");
////	//	exit(0);
////	//}
////
////	double t = 0;
////	std::vector<State*> ans;
////
////	//std::cout << "Enter matrix's dimensions: ";
////	//std::cin >> lines >> cols;
////
////	for (int i = 0; i < TESTS; i++) {
////		srand(i);
////		//std::cout << lines << " " << cols << std::endl;
////		//std::cout << "Enter matrix: ";
////
////		std::cin >> lines >> cols;
////		map = readMap(lines, cols);
////		//map = generateMap(lines, cols);
////
////		std::cout << "Parallel Case #" << i + 1 << ": ";
////
////		if (!check(map)) {
////			std::cout << "This puzzle doesn't have solution" << std::endl;
////			continue;
////		}
////
////		clock_t time = clock();
////		//printMap(map);
////		ans = aThreads(map);
////
////		time = clock() - time;
////		std::cout << (double) time / CLOCKS_PER_SEC << " sec" << std::endl;
////		t += (double)time / CLOCKS_PER_SEC;
////
////		std::cout << "Linear Case #" << i + 1 << ": ";
////		time = clock();
////		ans = aLin(map);
////		time = clock() - time;
////		std::cout << (double)time / CLOCKS_PER_SEC << " sec" << std::endl;
////
////	}
////	//std::cout << "==========" << std::endl << "Solution" << std::endl << "==========";
////
////	//for (int i = ans.size() - 1; i >= 0; i--) {
////	//	printMap(ans[i]->getMap());
////	//}
////
////	std::cout << "==========" << std::endl << "Average time = " << t / TESTS << std::endl << "==========" << std::endl;
////
////	//std::cout << "Average time = " << t / TESTS << std::endl;
////
////	system("pause");
////
////	return 0;
////}
//
//bool stepChecker(Map* a, Map* b) {
//	// 1
//	int zeroA = a->find(0);
//	// 5
//	int zeroB = b->find(0);
//
//	bool v = false;
//
//	int direction = -1;
//
//	int y = zeroA / a->getCols() - zeroB / a->getCols();
//	int x = (zeroA % a->getCols()) - (zeroB % a->getCols());
//
//	if (y == 1) direction = 0;
//	else if (y == -1) direction = 2;
//	else if (x == 1) direction = 3;
//	else if (x == -1) direction = 1;
//
//	if ( (abs(x) < 2) && (y == 0) ) v = true;
//	else if ( (abs(y) < 2) && (x == 0) ) v = true;
//
//	if (!v) return false;
//	
//	if (direction == -1) return true;
//
//	Map* a_ = a->shift(direction);
//
//	for (int i = 0; i < a->getCols() * a->getLines(); i++) {
//		if (a_->map[i] != b->map[i]) return false;
//	}
//
//	delete a_;
//	return true;
//}
//
//Map* getTest(int i) {
//	int test3x3[] = { 1, 2, 3, 6, 4, 5, 7, 8, 0 };
//
//	int tests[3][16] = {
//		{ 13, 11, 10, 9, 8, 6, 5, 12, 2, 4, 3, 14, 7, 15, 1, 0 },
//		{ 14, 6, 9, 12, 2, 5, 11, 15, 1, 3, 8, 10, 13, 7, 4, 0 },
//		{ 12, 6, 13, 11, 15, 9, 8, 2, 3, 14, 7, 5, 4, 10, 1, 0 }
//	};
//
//	int tests5x5[5][25] = {
//		{ 4, 13, 6, 11, 8, 24, 3, 22, 23, 7, 2, 10, 16, 21, 18, 14, 15, 17, 9, 1, 12, 20, 5, 19, 0 },
//		{ 16, 1, 18, 11, 3, 12, 20, 9, 22, 2, 19, 21, 5, 17, 13, 7, 15, 4, 14, 23, 6, 24, 10, 8, 0 }, 
//		{ 5, 12, 11, 18, 2, 15, 6, 4, 17, 7, 16, 1, 22, 21, 19, 14, 3, 23, 24, 10, 13, 8, 20, 9, 0 },
//		{ 6, 18, 5, 10, 2, 14, 8, 22, 17, 7, 20, 11, 19, 13, 4, 21, 3, 1, 24, 15, 23, 9, 16, 12, 0 },
//		{ 17, 1, 2, 6, 21, 13, 18, 7, 4, 16, 15, 14, 10, 20, 24, 8, 19, 5, 22, 3, 12, 11, 23, 9, 0 }
//	};
//
//	int test4x3[] = { 3, 10, 2, 7, 6, 4, 1, 5, 8, 11, 9, 0 };
//	int test4x5[] = { 18, 15, 1, 8, 9, 6, 19, 13, 2, 11, 5, 16, 3, 10, 12, 4, 17, 7, 14, 0 };
//
//	switch (i)
//	{
//	case 0: 
//		return new Map(4, 4, &tests[0][0]);
//		//return new Map(3, 3, &test3x3[0]);
//	case 1:
//		return new Map(4, 4, &tests[1][0]);
//	case 2:
//		return new Map(5, 5, &tests5x5[0][0]);
//	case 3:
//		return new Map(5, 5, &tests5x5[1][0]);
//	case 4:
//		return new Map(5, 5, &tests5x5[2][0]);
//	case 5:
//		return new Map(5, 5, &tests5x5[3][0]);
//	case 6:
//		return new Map(5, 5, &tests5x5[4][0]);
//	case 7:
//		return new Map(4, 4, &tests[2][0]);
//	case 8:
//		return new Map(4, 3, &test4x3[0]);
//	case 9:
//		return new Map(4, 5, &test4x5[0]);
//	default:
//		break;
//	}
//}
//
//
////MPI
//int main(int argc, char* argv[]) {
//	Map* map;
//
//	MPI_Init(&argc, &argv);
//
//	int rank;
//	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
//
//	for (int i = 0; i < TESTS; i++) {
//		//if (i == 2) continue;
//
//		map = getTest(i);
//
//		clock_t time = clock();
//		std::vector<Map*> a = aMPI(map);
//
//		//if ((rank == 0) && (i == 0)) {
//		//	for (auto mp : a) {
//		//		printMap(mp);
//		//		system("pause");
//		//	}
//		//}
//
//		if (rank == 0) {
//			time = clock() - time;
//			std::cout << "Parallel Case #" << i + 1 << ": ";
//			std::cout << (double)time / CLOCKS_PER_SEC << " sec" << std::endl;
//
//			for (int j = 1; j < a.size(); j++)
//				if (!stepChecker(a[j - 1], a[j])) {
//					std::cout << "Wrong step:" << std::endl;
//					printMap(a[j - 1]);
//					printMap(a[j]);
//					std::cout << std::endl;
//				}
//			
//			time = clock();
//			a = aLin3(map);
//			time = clock() - time;
//			std::cout << "Linear Case #" << i + 1 << ": ";
//			std::cout << (double)time / CLOCKS_PER_SEC << " sec" << std::endl;
//
//			for (int j = 1; j < a.size(); j++)
//				if (!stepChecker(a[j - 1], a[j])) {
//					std::cout << "Wrong step:" << std::endl;
//					printMap(a[j - 1]);
//					printMap(a[j]);
//					std::cout << std::endl;
//				}
//		}
//
//		//if (rank == 0) system("pause");
//
//		MPI_Barrier(MPI_COMM_WORLD);
//	}
//
//	MPI_Finalize();
//
//	//system("pause");
//
//	return 0;
//}

#include "mpi.h"
#include <cstdlib>
#include <iostream>

#define factNum 10

unsigned fact(unsigned a) {
	if (a <= 1) return 1;
	else return a * fact(a - 1);
}

int main(int argc, char* argv[]) {
	MPI_Init(&argc, &argv);

	int rank;
	int size;

	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);


	// Вычитаем наш главный (0-й процесс), который никак не занимается вычислениями
	size--;

	if (rank == 0) {

		//Генерим числа и отсылаем процессам для вычисления
		for (int i = 0; i < factNum; i++) {
			unsigned num = rand() % 50;
			MPI_Send(&num, 1, MPI_UNSIGNED, i % size + 1, 1, MPI_COMM_WORLD);
		}

		unsigned sum = 0;


		//Получаем от процессов результат и находим сумму
		for (int i = 0; i < factNum; i++) {
			unsigned num;
			MPI_Recv(&num, 1, MPI_UNSIGNED, i % size + 1, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			sum += num;
		}

		std::cout << "SUM = " << sum << std::endl;
	}
	else {
		// Все остальные процессы получают число, вычисляют факториал и отправляют обратно
		for (int i = rank - 1; i < factNum; i += size) {
			unsigned num;
			MPI_Recv(&num, 1, MPI_UNSIGNED, 0, 1, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			num = fact(num);
			MPI_Send(&num, 1, MPI_UNSIGNED, 0, 1, MPI_COMM_WORLD);
		}
	}

	MPI_Finalize();
	return 0;
}


//int main(int argc, char* argv[]) {
//	
//	// Размер матрицы
//	int size = 32;
//
//	// Матрицы А и В в векторном виде
//	int* a = new int[size*size];
//	int* b = new int[size*size];
//
//
//	MPI_Init(&argc, &argv);
//	int rank;
//
//	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
//
//	if (rank == 0) {
//		// Генерим матрицы
//
//		for (int i = 0; i < size * size; i++) {
//			a[i] = rand();
//			b[i] = rand();
//		}
//	}
//
//	//Делимся матрицами со всеми
//	MPI_Bcast(a, size*size, MPI_INT, 0, MPI_COMM_WORLD);
//	MPI_Bcast(b, size*size, MPI_INT, 0, MPI_COMM_WORLD);
//
//	//конвертим матрицу в нормальный вид
//	int** aM = new int*[size];
//	int** bM = new int*[size];
//
//	for (int i = 0; i < size; i++) {
//		aM[i] = &a[i*size];
//		bM[i] = &b[i*size];
//	}
//}