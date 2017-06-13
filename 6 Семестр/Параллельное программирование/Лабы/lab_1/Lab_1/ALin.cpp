#pragma once
#include <vector>
#include "binTree.h"
#include <set>
#include "a.h"

#define DIRECTION_UP 0
#define DIRECTION_RIGHT 1
#define DIRECTION_DOWN 2
#define DIRECTION_LEFT 3

void addState(State* min, BinTree* open, BinTree* close, std::multiset<State*, compare>* hashes, int i, Map* target = NULL) {
	State* s;

	if (target) s = new State(min->getMap()->shift(i), min, target);
	else s = new State(min->getMap()->shift(i), min);

	//if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
	//	open->add(s);
	//	//hashes->insert(s);
	//}

	for (std::multiset<State*, compare>::iterator iter = hashes->find(s); iter != hashes->end(); iter++) {
		if (cmp((*iter), s)) {
			return;
		}
	}

	open->add(s);
	hashes->insert(s);
}

//Алгоритм поиска решения головоломки
std::vector<State*> aLin(Map* map) {

	BinTree* open = new BinTree();
	BinTree* close = new BinTree(new State(map, NULL));

	std::multiset<State*, compare> hashes;
	State* min = close->min();

	//Map* one = ones(map->lines, map->cols);
	//State* min = new State(one, NULL, map);

	for (; min->getCost() != 0; min = open->min(), close->add(min), open->del(min))
	{
		int zero = min->getMap()->find(0);
		bool v[4] = { false, false, false, false };

		if (zero / map->getCols() != 0) v[0] = true;
		if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
		if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
		if (zero % map->getCols() != 0) v[3] = true;

		for (int i = 0; i < 4; i++) {
			if (v[i]) addState(min, open, close, &hashes, i);
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

//void aLin2(Map* map, std::vector<State*> solution) {
//
//	BinTree open = BinTree();
//	BinTree close = BinTree(new State(map, NULL));
//
//	State* min = close.min();
//
//	for (; min->getCost() != 0; min = open.min(), close.add(min), open.del(min))
//	{
//		int zero = min->getMap()->find(0);
//		State* states[4] = { 0, 0, 0, 0 };
//
//		if (zero / map->getCols() != 0) {
//			State* s = new State(min->getMap()->shift(0), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				states[0] = s;
//			}
//		}
//		if (zero % map->getCols() != map->getCols() - 1) {
//			State* s = new State(min->getMap()->shift(1), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				states[1] = s;
//			}
//		}
//
//		if (zero / map->getCols() != map->getLines() - 1) {
//			State* s = new State(min->getMap()->shift(2), min);
//			if ((open.find(s) == NULL) && (close.find(s) == NULL)) {
//				states[2] = s;
//			}
//		}
//
//		if (zero % map->getCols() != 0) {
//			State* s = new State(min->getMap()->shift(3), min);
//			if ((close.find(s) == NULL) && (open.find(s) == NULL)) {
//
//				states[3] = s;
//			}
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
//	State* s = min;
//	do
//	{
//		solution.push_back(s);
//		s = s->getParent();
//	} while (s != NULL);
//
//}

bool breakCond2(Map* map, int direction, int zero = -1) {
	if (zero == -1) {
		zero = map->find(0);
	}

	switch (direction)
	{
	case DIRECTION_UP: if (zero / map->getCols() != 0) return true;
		break;
	case DIRECTION_RIGHT: if (zero % map->getCols() != map->getCols() - 1) return true;
		break;
	case DIRECTION_DOWN: if (zero / map->getCols() != map->getLines() - 1) return true;
		break;
	case DIRECTION_LEFT: if (zero % map->getCols() != 0) return true;
		break;
	default:
		return false;
	}
	return false;
}

void t(State* min, BinTree* open, BinTree* close, int direction) {
	int k = direction * 3;
	int zero;

	State* s = new State(min->getMap()->shift(direction, &zero), min);
	if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
		//states[k] = s;
		open->add(s);
	}

	Map* map = s->getMap();

	bool v = breakCond2(map, direction, zero);

	if (v) {
		State* s2 = new State(s->getMap()->shift(direction), s);
		if ((open->find(s2) == NULL) && (close->find(s2) == NULL)) {
			//states[k + 1] = s2;
			open->add(s2);
		}
	}

	v = breakCond2(map, (direction + 1) % 4, zero);

	if (v) {
		State* s3 = new State(s->getMap()->shift((direction + 1) % 4), s);
		if ((open->find(s3) == NULL) && (close->find(s3) == NULL)) {
			//states[k + 2] = s3;
			open->add(s3);
		}
	}
}

std::vector<State*> aLin2(Map* map) {

	BinTree* open = new BinTree();
	BinTree* close = new BinTree(new State(map, NULL));

	State* min = close->min();

	for (; min->getCost() != 0; min = open->min(), close->add(min), open->del(min))
	{
		int zero = min->getMap()->find(0);
		bool v[4] = { false, false, false, false };

		if (zero / map->getCols() != 0) v[0] = true;
		if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
		if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
		if (zero % map->getCols() != 0) v[3] = true;

		for (int i = 0; i < 4; i++) {
			if (v[i])
				t(min, open, close, i);
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


void iteration(State* min, BinTree* open, std::multiset<State*, compare>* hashes, Map* target = NULL) {
	Map* map = min->getMap();
	int zero = map->find(0);
	bool v[4] = { false, false, false, false };

	if (zero / map->getCols() != 0) v[0] = true;
	if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
	if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
	if (zero % map->getCols() != 0) v[3] = true;

	for (int i = 0; i < 4; i++) {
		if (v[i]) addState(min, open, NULL, hashes, i, target);
	}
}

std::vector<Map*> aLin3(Map * map)
{
	Map* one = ones(map->lines, map->cols);

	std::multiset<State*, compare> hashes1;
	std::multiset<State*, compare> hashes2;

	BinTree* open1 = new BinTree();
	BinTree* open2 = new BinTree();

	State* min1 = new State(map, NULL, one);
	State* min2 = new State(one, NULL, map);

	//hashes1.insert(min1);
	//hashes2.insert(min2);

	for (;; min1 = open1->min(), min2 = open2->min(), open1->del(min1), open2->del(min2)) {
		
		bool f = false;

		for (std::multiset<State*, compare>::iterator iter = hashes1.find(min2); iter != hashes1.end(); iter++) {
			if (cmp(min2, (*iter))) {
				min1 = (*iter);
				f = true;
				break;
			}
		}

		if (f) break;

		for (std::multiset<State*, compare>::iterator iter = hashes2.find(min1); iter != hashes2.end(); iter++) {
			if (cmp(min1, (*iter))) {
				min2 = (*iter);
				f = true;
				break;
			}
		}

		if (f) break;

		iteration(min1, open1, &hashes1);
		iteration(min2, open2, &hashes2, min1->getMap());
	}

		std::vector<Map*> vect;

		State* s = min1;
		do
		{
			vect.push_back(s->getMap());
			s = s->getParent();
		} while (s != NULL);

		std::vector<Map*> solution;

		for (int i = (vect.size() - 1); i >= 0; i--) {
			solution.push_back(vect[i]);
			//printMap(vect[i]);
		}

		s = min2;
		do
		{
			solution.push_back(s->getMap());
			s = s->getParent();
		} while(s != NULL);

		return solution;
}
