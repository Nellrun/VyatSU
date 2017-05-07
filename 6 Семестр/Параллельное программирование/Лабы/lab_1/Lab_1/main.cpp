#include <iostream>
#include <cstdlib>
#include <vector>
#include <cmath>
#include <ctime>
#include "binTree.h"
#include "Map.h"
#include "state.h"
#include <ctime>
#include <set>
#include <omp.h>
#include <thread>

#define TESTS 10

bool check(Map*);

// Генерация поля
Map* generateMap(int lines, int cols) {
	int len = lines*cols;
	Map* map = new Map(lines, cols);
	map->lines = lines;
	map->cols = cols;

	for (int i = 0; i < len; ++i)
	{
		map->map[i] = i + 1;
	}
	map->map[len - 1] = 0;

	do
	{
		for (int i = 0; i < len - 1; ++i) {
			int k = rand() % (len - 1);
			int m = map->map[k];
			map->map[k] = map->map[i];
			map->map[i] = m;
		}
	} while (!check(map));

	return map;
}

Map* readMap(int lines, int cols) {
	int len = lines*cols;
	Map* map = new Map(lines, cols);
	map->lines = lines;
	map->cols = cols;

	for (int i = 0; i < len; ++i)
	{
		std::cin >> map->map[i];
	}

	return map;
}

// Вывод головоломки
void printMap(Map* map) {
	std::cout << std::endl;
	for (int i = 0; i < map->lines; ++i) {
		for (int j = 0; j < map->cols; ++j) {
			std::cout << map->map[i*map->cols + j] << '\t';
		}
		std::cout << std::endl;
	}
	//std::cout << std::endl;
}

void t(State* min, BinTree& open, BinTree& close, int* v, int i, State** states) {
	if (v[i]) {
		State* s = new State(min->getMap()->shift(i), min);
		if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
			states[i] = s;
		}
	}
}

std::vector<State*> a(Map* map) {

	BinTree open = BinTree();
	BinTree close = BinTree(new State(map, NULL));

	State* min = close.min();

	for (; min->getCost() != 0; min = open.min(), close.add(min), open.del(min))
	{
		int zero = min->getMap()->find(0);
		State* states[4] = { 0, 0, 0, 0 };
		int v[4] = { 0, 0, 0, 0 };

		if (zero / map->getCols() != 0) v[0] = 1;
		if (zero % map->getCols() != map->getCols() - 1) v[1] = 1;
		if (zero / map->getCols() != map->getLines() - 1) v[2] = 1;
		if (zero % map->getCols() != 0) v[3] = 1;

		std::thread threads[4];

		for (int i = 0; i < 4; i++) {
			threads[i] = std::thread(t, std::ref(min), std::ref(open), std::ref(close), std::ref(v), i, std::ref(states));
		}

		for (int i = 0; i < 4; i++) {
			threads[i].join();
		}

		for (int i = 0; i < 4; i++)
		{
			if (states[i]) {
				open.add(states[i]);
			}
		}
	}

	std::vector<State*> solution;

	State* s = min;
	do
	{
		solution.push_back(s);
		s = s->getParent();
	} while (s != NULL);

	return solution;
}


bool check(Map* map) {
	int len = map->lines*map->cols;
	int n = 0;
	int pos = 0;

	for (int i = 0; i < len; ++i) {
		if (map->map[i] == 0) {
			pos = (i / map->cols) + 1;
			continue;
		}
		for (int j = i; j < len; ++j) {
			if (map->map[i] > map->map[j]) n += 1;
		}
	}

	if (len & 1) {
		if (n % 2 == 0) return true;
	}
	else {
		if ((pos % 2 == 0) && (n & 1)) return true;
		if ((pos & 1) && (n % 2 == 0)) return true;
	}

	return false;
}

 //Алгоритм поиска решения головоломки
//std::vector<State*> a(Map* map) {
//
//	BinTree open = BinTree();
//	BinTree close = BinTree(new State(map, NULL));
//
//	State* min = close.min();
//
//	std::thread tr1();
//
//	//close.add(min);
//	//open.del(min);
//
//	for(;min->getCost() != 0; min = open.min(), close.add(min), open.del(min))
//	{
//		int zero = min->getMap()->find(0);
//		State* states[4] = { 0, 0, 0, 0 };
//
//
//#pragma omp parallel sections 
//		{
//
//#pragma omp section 
//			{
//				if (zero / map->getCols() != 0) {
//					State* s = new State(min->getMap()->shift(0), min);
//					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//						//open.add(s);
//						states[0] = s;
//					}
//				}
//			}
//
//#pragma omp section 
//			{
//				if (zero % map->getCols() != map->getCols() - 1) {
//					State* s = new State(min->getMap()->shift(1), min);
//					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//						//open.add(s);
//						states[1] = s;
//					}
//				}
//			}
//
//#pragma omp section 
//			{
//				if (zero / map->getCols() != map->getLines() - 1) {
//					State* s = new State(min->getMap()->shift(2), min);
//					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//						//open.add(s);
//						states[2] = s;
//					}
//				}
//			}
//
//#pragma omp section 
//			{
//				if (zero % map->getCols() != 0) {
//					State* s = new State(min->getMap()->shift(3), min);
//					if ((close.find(s) == NULL) && (open.find(s) == NULL)) {
//						//open.add(s);
//						states[3] = s;
//					}
//				}
//			}
//
//		}
//
//		for (int i = 0; i < 4; i++)
//		{
//			if (states[i]) {
//				open.add(states[i]);
//			}
//		}
//	}
//
//	std::vector<State*> solution;
//	
//	State* s = min;
//	do
//	{
//		solution.push_back(s);
//		s = s->getParent();
//	} while (s != NULL);
//
//	return solution;
//}

//bool cmp(State* a, State* b) {
//	Map* am = a->getMap();
//	Map* bm = b->getMap();
//	int len = am->getCols() * am->getLines();
//	for (int i = 0; i < len; i++) {
//		if (am->map[i] != bm->map[i]) return false;
//	}
//	return true;
//}

//bool exists(std::multiset<State>* ms, State* s) {
//	std::multiset<State>::iterator iter = ms->find(*s);
//
//	for (; iter != ms->end(); iter++) {
//		State s1 = State(*iter);
//		//if (cmp(&s1, s)) return true;
//		if (s1.getCost() == s->getCost()) return true;
//	}
//
//	return false;
//}
//
//std::vector<State*> a(Map* map) {
//	std::multiset<State> open;
//	std::multiset<State> close;
//	std::multiset<State, comparator> fs;
//
//	State* min = new State(map, NULL);
//
//	close.insert(*min);
//
//	unsigned int maxLen = 1;
//
//	while (min->getCost() != 0) {
//
//		//printMap(min->getMap());
//
//		int zero = min->getMap()->find(0);
//		State* states[4] = {0, 0, 0, 0};
//
//
//#pragma omp parallel sections
//		{
//#pragma omp section
//			{
//				if (zero / map->getCols() != 0) {
//					State* s = new State(min->getMap()->shift(0), min);
//					if (!(exists(&open, s)) && !(exists(&close, s))) {
//						states[0] = s;
//						//open.insert(*s);
//						//fs.insert(*s);
//						// printMap(s->getMap());
//					}
//				}
//			}
//#pragma omp section
//			{
//				if (zero % map->getCols() != map->getCols() - 1) {
//					State* s = new State(min->getMap()->shift(1), min);
//					if (!(exists(&open, s)) && !(exists(&close, s))) {
//						states[1] = s;
//						//open.insert(*s);
//						//fs.insert(*s);
//						// printMap(s->getMap());
//					}
//				}
//			}
//#pragma omp section
//			{
//				if (zero / map->getCols() != map->getLines() - 1) {
//					State* s = new State(min->getMap()->shift(2), min);
//					if (!(exists(&open, s)) && !(exists(&close, s))) {
//						states[2] = s;
//						//open.insert(*s);
//						//fs.insert(*s);
//						// printMap(s->getMap());
//					}
//				}
//			}
//#pragma omp section
//			{
//				if (zero % map->getCols() != 0) {
//					State* s = new State(min->getMap()->shift(3), min);
//					if (!(exists(&open, s)) && !(exists(&close, s))) {
//						states[3] = s;
//						//open.insert(*s);
//						//fs.insert(*s);
//						// printMap(s->getMap());
//					}
//				}
//			}
//		}
//
//		for (int i = 0; i < 4; i++) {
//			if (states[i]) {
//				fs.insert(*states[i]);
//				open.insert(*states[i]);
//			}
//		}
//
//		std::multiset<State>::iterator iter = fs.begin();
//
//		min = new State(*iter);
//
//		close.insert(*iter);
//		open.erase(*iter);
//		fs.erase(iter);
//
//	}
//
//	std::vector<State*> solution;
//
//	State* s = min;
//	do
//	{
//		solution.push_back(s);
//		s = s->getParent();
//	} while (s != NULL);
//
//	return solution;
//}

int main(int argc, char const *argv[]) {
	int lines, cols;
	Map* map;

	//if ( (lines <= 1) || (cols <= 1) ) {
	//	std::cout << "wrong martix's parameters" << std::endl;
	//	system("Pause");
	//	exit(0);
	//}

	double t = 0;
	std::vector<State*> ans;

	std::cout << "Enter matrix's dimensions: ";
	std::cin >> lines >> cols;

	for (int i = 0; i < TESTS; i++) {
		srand(i);
		//std::cout << lines << " " << cols << std::endl;
		//std::cout << "Enter matrix: ";

		//std::cin >> lines >> cols;
		//map = readMap(lines, cols);
		map = generateMap(lines, cols);

		std::cout << "Case #" << i + 1 << ": ";

		if (!check(map)) {
			std::cout << "This puzzle doesn't have solution" << std::endl;
			continue;
		}

		clock_t time = clock();
		//printMap(map);
		ans = a(map);

		time = clock() - time;
		std::cout << (double) time / CLOCKS_PER_SEC << " sec" << std::endl;
		t += (double)time / CLOCKS_PER_SEC;

	}
	//std::cout << "==========" << std::endl << "Solution" << std::endl << "==========";

	//for (int i = ans.size() - 1; i >= 0; i--) {
	//	printMap(ans[i]->getMap());
	//}

	std::cout << "==========" << std::endl << "Average time = " << t / TESTS << std::endl << "==========" << std::endl;

	//std::cout << "Average time = " << t / TESTS << std::endl;

	system("pause");

	return 0;
}