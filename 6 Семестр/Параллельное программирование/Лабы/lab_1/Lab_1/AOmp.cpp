#pragma once
#include <vector>
//#include "state.h"
#include "binTree.h"

std::vector<State*> aOMP(Map* map) {

	BinTree open = BinTree();
	BinTree close = BinTree(new State(map, NULL));

	State* min = close.min();

	for (; min->getCost() != 0; min = open.min(), close.add(min), open.del(min))
	{
		int zero = min->getMap()->find(0);
		State* states[4] = { 0, 0, 0, 0 };

#pragma omp parallel sections 
		{

#pragma omp section 
			{
				if (zero / map->getCols() != 0) {
					State* s = new State(min->getMap()->shift(0), min);
					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
						//open.add(s);
						states[0] = s;
					}
				}
			}

#pragma omp section 
			{
				if (zero % map->getCols() != map->getCols() - 1) {
					State* s = new State(min->getMap()->shift(1), min);
					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
						//open.add(s);
						states[1] = s;
					}
				}
			}

#pragma omp section 
			{
				if (zero / map->getCols() != map->getLines() - 1) {
					State* s = new State(min->getMap()->shift(2), min);
					if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
						//open.add(s);
						states[2] = s;
					}
				}
			}

#pragma omp section 
			{
				if (zero % map->getCols() != 0) {
					State* s = new State(min->getMap()->shift(3), min);
					if ((close.find(s) == NULL) && (open.find(s) == NULL)) {
						//open.add(s);
						states[3] = s;
					}
				}
			}

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