#include <iostream>
#include <cstdlib>
#include <vector>
#include <cmath>
#include <ctime>

int cols, lines;

bool check(int*);
int calcHash(int*);
int costFunc(int*);

class State
{
private:
	int steps;
	int cost;
	int f;
	State* parent;
	int* map;
	int hash;
public:
	State(int* map, State* parent) {
		this->steps = parent == NULL ? 0 : parent->getSteps() + 1;
		this->cost = costFunc(map);
		this->parent = parent;
		this->map = map;
		this->hash = calcHash(map);
		this->f = this->steps + this->cost;
	}
	~State();

	int getF() {
		return this->f;
	}

	int* getMap() {
		return this->map;
	}

	int getSteps() {
		return this->steps;
	}

	int getHash() {
		return this->hash;
	}

	int getCost() {
		return this->cost;
	}
};

// Генерация поля
int* generateMap() {
	int len = lines*cols;
	int* map = new int[len];

	for (int i = 0; i < len; ++i)
	{
		map[i] = i + 1;
	}
	map[len - 1] = 0;

	do
	{
		for (int i = 0; i < len - 1; ++i) {
			int k = rand() % (len - 1);
			int m = map[k];
			map[k] = map[i];
			map[i] = m;
		}
	} while (!check(map));

	return map;
}

// Вывод головоломки
void printMap(int* map) {
	std::cout << std::endl;
	for (int i = 0; i < lines; ++i) {
		for (int j = 0; j < cols; ++j) {
			std::cout << map[i*cols + j] << '\t';
		}
		std::cout << std::endl;
	}
	std::cout << std::endl;
}

// Процерка решаемости головоломки
// bool check(int* map) {
// 	int len = lines*cols;
// 	int n = 0;

// 	for (int i = 0; i < len; ++i) {
// 		if (map[i] == 0) {
// 			n += (i / cols) + 1;
// 			continue;
// 		}
// 		for (int j = i; j < len; ++j) {
// 			// if (map[j] == 0) continue;
// 			if (map[i] > map[j]) n += 1;
// 		}
// 	}

// 	// printMap(map);
// 	std::cout << "N = " << n << std::endl;

// 	return n % 2 == 0;
// }

bool check(int* map) {
	int len = lines*cols;
	int n = 0;
	int pos = 0;

	for (int i = 0; i < len; ++i) {
		if (map[i] == 0) {
			pos = (i / cols) + 1;
			continue;
		}
		for (int j = i; j < len; ++j) {
			// if (map[j] == 0) continue;
			if (map[i] > map[j]) n += 1;
		}
	}

	if (len & 1) {
		if (n % 2 == 0) return true;
	}
	else {
		if ( (pos % 2 == 0) && (n & 1) ) return true;
		if ( (pos & 1) && (n % 2 == 0) ) return true;
	}

	return false;
	// printMap(map);
	// std::cout << "N = " << n << std::endl;

	// return n % 2 == 0;
}

bool isWin(int* map) {
	int len = lines * cols;

	for (int i = 1; i < len - 1; ++i)
	{
		if (map[i] < map[i - 1]) return false;
	}
	return true;
}

// Функция расстояния
int costFunc(int* map) {
	int len = lines*cols;
	int sum = 0;
	for (int i = 0; i < len; ++i)
	{
		if (map[i] == 0) continue;
		//int dx = abs(i - (map[i] - 1)) % cols;
		//int dy = abs(i - (map[i] - 1)) / cols;

		int dx = abs((i % cols) - ((map[i] - 1) % cols));
		int dy = abs((i / cols) - ((map[i] - 1) / cols));
		sum += dx + dy;
	}

	return sum;
}

int* shift(int* map, int angle) {
	if ((angle < 0) || (angle > 3)) return map;

	int len = lines * cols;
	int* mapc = new int[len];

	int ind = 0;

	for (int i = 0; i < len; ++i) {
		mapc[i] = map[i];
		if (map[i] == 0) ind = i;
	}

	switch (angle) {
	case 0: {
		mapc[ind] = mapc[ind - cols];
		mapc[ind - cols] = 0;
		break;
	}
	case 1: {
		mapc[ind] = mapc[ind + 1];
		mapc[ind + 1] = 0;
		break;
	}
	case 2: {
		mapc[ind] = mapc[ind + cols];
		mapc[ind + cols] = 0;
		break;
	}
	case 3: {
		mapc[ind] = mapc[ind - 1];
		mapc[ind - 1] = 0;
		break;
	}
	}
	return mapc;
}

int calcHash(int* map) {
	int len = lines * cols;
	int h = 0;
	for (int i = 0; i < len; ++i) {
		h += map[i] * (1 << i);
	}

	return h;
}


int minInd(std::vector<State*> v) {
	int ind = 0;
	for (int i = 1; i < v.size(); ++i)
	{
		if (v[i]->getF() < v[ind]->getF()) ind = i;
	}

	return ind;
}

int find(int* map, int n) {
	for (int i = 0; i < lines * cols; ++i) {
		if (map[i] == n) return i;
	}
	return lines * cols - 1;
}

bool cmp(int* m1, int* m2) {
	for (int i = 0; i < lines * cols; ++i) {
		if (m1[i] != m2[i]) return false;
	}
	return true;
}

// Подумать над доработкой функции
int find(std::vector<State*> v, State* s) {
	for (int i = 0; i < v.size(); ++i) {
		if ((v[i]->getHash() == s->getHash()) && (v[i]->getF() < s->getF())) return i;
		// if (v[i]->getHash() == s->getHash()) return i;
		// if (cmp(v[i]->getMap(), s->getMap())) return i;
	}
	return -1;
}

// Алгоритм поиска решения головоломки
State* a(int* map) {
	std::vector<State*> open;
	std::vector<State*> close;

	open.push_back(new State(map, NULL));
	int mi = minInd(open);
	// std::cout << "MI = " << mi << std::endl;


	while (open[mi]->getCost() != 0) {

		// std::cout << "S = " << open[mi]->getSteps() << std::endl;
		// std::cout << "C = " << open[mi]->getCost() << std::endl;
		// std::cout << "F = " << open[mi]->getF() << std::endl << std::endl;

		// std::cout << open.size();

		// printMap(open[mi]->getMap());

		int zero = find(open[mi]->getMap(), 0);

		// 2 + 2 + 1 + 0 + 0 + 3 =
		// 3 + 3 + 2 + 1 + 1 + 3 = 13

		if (zero / cols != 0) {
			State* s = new State(shift(open[mi]->getMap(), 0), open[mi]);
			if ((find(close, s) == -1) && (find(open, s) == -1)) {
				open.push_back(s);
				// printMap(s->getMap());
			}
		}

		if (zero % cols != cols - 1) {
			State* s = new State(shift(open[mi]->getMap(), 1), open[mi]);
			if ((find(close, s) == -1) && (find(open, s) == -1)) {
				open.push_back(s);
				// printMap(s->getMap());
			}
		}

		if (zero / cols != lines - 1) {
			State* s = new State(shift(open[mi]->getMap(), 2), open[mi]);
			if ((find(close, s) == -1) && (find(open, s) == -1)) {
				open.push_back(s);
				// printMap(s->getMap());
			}
		}

		if (zero % cols != 0) {
			State* s = new State(shift(open[mi]->getMap(), 3), open[mi]);
			if ((find(close, s) == -1) && (find(open, s) == -1)) {
				open.push_back(s);
				// printMap(s->getMap());
			}
		}

		close.push_back(open[mi]);
		std::swap(open[mi], open.back());
		//printMap(open.back()->getMap());
		open.pop_back();

		mi = minInd(open);
	}

	return open[mi];
}

int main(int argc, char const *argv[]) {
	int* map;

	srand(55);

	std::cout << "Write matrix's dimensions: ";

	std::cout << lines << " " << cols << std::endl;

	map = generateMap();
	printMap(map);

	// std::cout << calcHash(map);

	State* ans = a(map);

	printMap(ans->getMap());

	std::cin >> lines;

	return 0;
}