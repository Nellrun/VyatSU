#pragma once
#include <cstdlib>
#include "map.h"

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
private:
	int steps;
	int cost;
	int f;
	State* parent;
	Map* map;
	unsigned long hash;
public:
	State::State(unsigned int hash);
	State(Map* map, State* parent);
	State::State(Map* map, State* parent, Map* b);
	~State();

	const State* copy() const;

	int getF() const;
	Map* getMap() const;
	int getSteps();
	int getHash() const;
	int getCost() const;
	State* getParent();
};

struct compare {
	bool operator() (const State* a, const State* b) const {
		return a->getHash() < b->getHash();
	}
};

bool cmp(State* a, State* b);