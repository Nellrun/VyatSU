#pragma once
#include <cstdlib>
#include "map.h"
#include "State.h"
#include <functional>

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

/*
3 2
0 1

3 2 0 1

*/

int costFunc(Map* a, Map* b) {
	int len = a->lines*a->cols;
	int sum = 0;

	int* m = new int[len];

	for (int i = 0; i < len; ++i) {
		m[a->map[i]] = i;
	}

	for (int i = 0; i < len; ++i)
	{
		if (b->map[i] == 0) continue;
		//int dx = abs((m[i] % b->cols) - ((b->map[i] - 1) % b->cols));
		//int dy = abs((m[i] / b->cols) - ((b->map[i] - 1) / b->cols));

		int dx = abs((m[b->map[i]] % b->cols) - (i % b->cols));
		int dy = abs((m[b->map[i]] / b->cols) - (i / b->cols));

		sum += dx + dy;
	}

	delete[] m;

	//for (int i = 0; i < len; ++i) {
	//	if (a->map[i] != b->map[i]) sum++;
	//}


	return sum;
}

unsigned long calcHash(Map* map) {
	int len = map->lines * map->cols;
	unsigned long h = 0;
	for (int i = 0; i < len; ++i) {
		h += std::hash<int>{}(map->map[i] << i);
		h += map->map[i] << i;
	}

	return h;
}

State::State(unsigned int hash) {
	this->hash = hash;
}

State::State(Map* map, State* parent) {
		this->steps = parent == NULL ? 0 : parent->getSteps() + 1;
		this->cost = costFunc(map);
		this->parent = parent;
		this->map = map;
		this->hash = calcHash(map);
}

State::State(Map* map, State* parent, Map* b) {
	this->steps = parent == NULL ? 0 : parent->getSteps() + 1;
	this->cost = costFunc(map, b);
	this->parent = parent;
	this->map = map;
	this->hash = calcHash(map);
}

State::~State()
{
	delete map;
}

const State* State::copy() const {
		return this;
}

int State::getF() const {
		return this->f;
}

Map* State::getMap() const {
		return this->map;
}

int State::getSteps() {
		return this->steps;
}

int State::getHash() const {
		return this->hash;
}

int State::getCost() const {
		return this->cost;
}

State* State::getParent() {
		return this->parent;
}

bool cmp(State * a, State * b)
{
	{
		Map* am = a->getMap();
		Map* bm = b->getMap();
		int len = am->getCols() * am->getLines();

		for (int i = 0; i < len; i++) {
			if (am->map[i] != bm->map[i]) return false;
		}
		return true;
	}
}
