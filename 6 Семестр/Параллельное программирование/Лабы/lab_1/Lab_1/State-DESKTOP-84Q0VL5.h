#pragma once
#include <cstdlib>
#include "map.h"

int costFunc(Map* map);
//void costFunc(Map* map, int&, int&);
unsigned int calcHash(Map* map);

class Test {
public:
	int x;

	Test(int x) {
		this->x = x;
	}

	bool operator < (const Test &b) const {
		return x < b.x;
	}
};

class State
{
public:
	int steps;
	int cost;
	int f;
	State* parent;
	Map* map;
	int hash;
public:
	State(Map* map, State* parent) {
		this->steps = parent == NULL ? 0 : parent->getSteps() + 1;
		this->cost = costFunc(map);
		//costFunc(map, this->cost, this->cost);
		this->parent = parent;
		this->map = map;
		this->hash = calcHash(map);
		//this->f = this->steps + this->cost;
	}

	State() {}

	bool operator<(const State b) const {
		return hash < b.hash;
	}

	 const State* copy() const {
		return this;
	}

	int getF() const {
		return this->f;
	}

	Map* getMap() const {
		return this->map;
	}

	int getSteps() {
		return this->steps;
	}

	int getHash() const {
		return this->hash;
	}

	int getCost() const {
		return this->cost;
	}

	State* getParent() {
		return this->parent;
	}
};


struct comparator {
	/*bool operator()(State a, State b) const { return a.getF() < b.getF(); }*/
	bool operator()(State a, State b) const { return a.getCost() < b.getCost(); }
};

//class StateF : State {
//
//	StateF() {}
//
//	StateF(State a) {
//		this->steps = a.getSteps();
//		this->cost = a.getCost();
//		this->parent = a.getParent();
//		this->map = a.getMap();
//		this->hash = a.getHash();
//		this->f = a.getF();
//	}
//
//	bool operator<(const State b) const {
//		return f < b.f;
//	}
//};
// Функция расстояния
int costFunc(Map* map) {
	int len = map->lines*map->cols;
	int sum = 0;
	for (int i = 0; i < len; ++i)
	{
		if (map->map[i] == 0) continue;
		int dx = abs((i % map->cols) - ((map->map[i] - 1) % map->cols));
		int dy = abs((i / map->cols) - ((map->map[i] - 1) / map->cols));
		sum += dx + dy;
	}

	return sum;
}

//void costFunc(Map* map, int &cost, int &f) {
//	int len = map->lines*map->cols;
//	//int sum = 0;
//	cost = 0;
//	f = 0;
//
//	int x;
//
//	for (x = 0; map->map[x] != 0; ++x){}
//
//	for (int i = 0; i < len; ++i)
//	{
//		if (map->map[i] == 0) continue;
//		int dx = abs((i % map->cols) - ((map->map[i] - 1) % map->cols));
//		int dy = abs((i / map->cols) - ((map->map[i] - 1) / map->cols));
//		cost += dx + dy;
//
//		dx = abs((i % map->cols) - ((x) % map->cols));
//		dy = abs((i / map->cols) - ((x) / map->cols));
//		f += dx + dy;
//	}
//
//	f += cost;
//}

unsigned int calcHash(Map* map) {
	int len = map->lines * map->cols;
	unsigned int h = 0;
	for (int i = 0; i < len; ++i) {
		h += std::hash<int>{}(map->map[i] * (1 << i));
	}

	return h;
}