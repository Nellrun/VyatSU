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

#define TESTS 50

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

// Вывод головоломки
void printMap(Map* map) {
	std::cout << std::endl;
	for (int i = 0; i < map->lines; ++i) {
		for (int j = 0; j < map->cols; ++j) {
			std::cout << map->map[i*map->cols + j] << '\t';
		}
		std::cout << std::endl;
	}
	std::cout << std::endl;
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

// Алгоритм поиска решения головоломки
//std::vector<State*> a(Map* map) {
//	//std::vector<State*> open;
//	//std::vector<State*> close;
//
//	BinTree open = BinTree(new State(map, NULL));
//	BinTree close = BinTree();
//
//	//int mi = minInd(open);
//
//	State* min = open.min();
//
//	close.add(min);
//	open.del(min);
//
//	unsigned int maxLen = 1;
//
//	while (min->getCost() != 0) {
//
//		//printMap(min->getMap());
//
//		int zero = min->getMap()->find(0);
//
//		if (zero / map->getCols() != 0) {
//			State* s = new State(min->getMap()->shift(0), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				open.add(s);
//				// printMap(s->getMap());
//			}
//		}
//
//		if (zero % map->getCols() != map->getCols() - 1) {
//			State* s = new State(min->getMap()->shift(1), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				open.add(s);
//				// printMap(s->getMap());
//			}
//		}
//
//		if (zero / map->getCols() != map->getLines() - 1) {
//			State* s = new State(min->getMap()->shift(2), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				open.add(s);
//				// printMap(s->getMap());
//			}
//		}
//
//		if (zero % map->getCols() != 0) {
//			State* s = new State(min->getMap()->shift(3), min);
//			if ((close.find(s) == NULL) && (open.find(s) == NULL)) {
//				open.add(s);
//				// printMap(s->getMap());
//			}
//		}
//
//		min = open.min();
//
//		close.add(min);
//		open.del(min);
//
//		if ( (unsigned int)close.getLen() > maxLen) {
//			maxLen = close.getLen();
//		}
//	}
//
//	//std::cout << "Max Length = " << maxLen << std::endl;
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

bool cmp(State* a, State* b) {
	Map* am = a->getMap();
	Map* bm = b->getMap();
	int len = am->getCols() * am->getLines();
	for (int i = 0; i < len; i++) {
		if (am->map[i] != bm->map[i]) return false;
	}
	return true;
}

bool exists(std::multiset<State>* ms, State* s) {
	std::multiset<State>::iterator iter = ms->find(*s);

	for (; iter != ms->end(); iter++) {
		State s1 = State(*iter);
		//if (cmp(&s1, s)) return true;
		if (s1.getCost() == s->getCost()) return true;
	}

	return false;
}

std::vector<State*> a(Map* map) {
	std::multiset<State> open;
	std::multiset<State> close;
	std::multiset<State, comparator> fs;

	State* min = new State(map, NULL);

	close.insert(*min);

	unsigned int maxLen = 1;

	while (min->getCost() != 0) {

		//printMap(min->getMap());

		int zero = min->getMap()->find(0);

		if (zero / map->getCols() != 0) {
			State* s = new State(min->getMap()->shift(0), min);
			if (!(exists(&open, s)) && !(exists(&close, s))) {
				open.insert(*s);
				fs.insert(*s);
				// printMap(s->getMap());
			}
		}

		if (zero % map->getCols() != map->getCols() - 1) {
			State* s = new State(min->getMap()->shift(1), min);
			if (!(exists(&open, s)) && !(exists(&close, s))) {
				open.insert(*s);
				fs.insert(*s);
				// printMap(s->getMap());
			}
		}

		if (zero / map->getCols() != map->getLines() - 1) {
			State* s = new State(min->getMap()->shift(2), min);
			if (!(exists(&open, s)) && !(exists(&close, s))) {
				open.insert(*s);
				fs.insert(*s);
				// printMap(s->getMap());
			}
		}

		if (zero % map->getCols() != 0) {
			State* s = new State(min->getMap()->shift(3), min);
			if (!(exists(&open, s)) && !(exists(&close, s))) {
				open.insert(*s);
				fs.insert(*s);
				// printMap(s->getMap());
			}
		}



		std::multiset<State>::iterator iter = fs.begin();

		min = new State(*iter);

		close.insert(*iter);
		open.erase(*iter);
		fs.erase(iter);

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

int main(int argc, char const *argv[]) {
	int lines, cols;
	Map* map;

	std::cout << "Write matrix's dimensions: ";
	std::cin >> lines >> cols;
	std::cout << lines << " " << cols << std::endl;

	if ( (lines <= 1) || (cols <= 1) ) {
		std::cout << "wrong martix's parameters" << std::endl;
		system("Pause");
		exit(0);
	}

	//map = generateMap(lines, cols);


	//std::multiset<Test> s;

	//s.insert(Test(1));

	//s.insert(Test(1));

	//s.insert(Test(2));
	//s.insert(Test(0));

	//std::multiset<Test>::iterator i = s.begin();
	//i++;


	//for (std::multiset<Test>::iterator i = s.begin(); i != s.end(); i++) {
	//	i;
	//}



	//State b = s.find(a);

	//s.insert(5);

	double t = 0;

	for (int i = 0; i < TESTS; i++) {
		srand(i);
		map = generateMap(lines, cols);
		//printMap(map);

		std::cout << "Case #" << i + 1 << ": ";
		clock_t time = clock();
		std::vector<State*> ans = a(map);

		//printMap(map);
		//printMap(ans[0]->getMap());

		time = clock() - time;
		std::cout << (double) time / 1000 << std::endl;
		t += (double)time / 1000;

	}
	//std::cout << "==========" << std::endl << "Solution" << std::endl << "==========";

	//for (int i = ans.size() - 1; i >= 0; i--) {
	//	printMap(ans[i]->getMap());
	//}

	//std::cout << "==========" << std::endl << "TIME: " << (double) time / 1000 << std::endl << "==========" << std::endl;

	std::cout << "Average time = " << t / TESTS << std::endl;

	system("pause");

	return 0;
}