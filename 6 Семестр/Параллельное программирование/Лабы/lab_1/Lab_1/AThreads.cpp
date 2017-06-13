#pragma once
#include "binTree.h"
//#include "state.h"
#include <vector>
#include <thread>

#define DIRECTION_UP 0
#define DIRECTION_RIGHT 1
#define DIRECTION_DOWN 2
#define DIRECTION_LEFT 3

//bool cmp(State* a, State* b) {
//	Map* am = a->getMap();
//	Map* bm = b->getMap();
//	int len = am->getCols() * am->getLines();
//
//	for (int i = 0; i < len; i++) {
//		if (am->map[i] != bm->map[i]) return false;
//	}
//	return true;
//}

void t(State* min, BinTree* open, BinTree* close, int i, State** states) {
	State* s = new State(min->getMap()->shift(i), min);
	if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
		states[i] = s;
	}
	else {
		states[i] = NULL;
	}
}


//bool breakCond(Map* map, int direction, int zero = -1) {
//	if (zero == -1) {
//		zero = map->find(0);
//	}
//
//	switch (direction)
//	{
//	case DIRECTION_UP: if (zero / map->getCols() != 0) return true;
//		break;
//	case DIRECTION_RIGHT: if (zero % map->getCols() != map->getCols() - 1) return true;
//		break;
//	case DIRECTION_DOWN: if (zero / map->getCols() != map->getLines() - 1) return true;
//		break;
//	case DIRECTION_LEFT: if (zero % map->getCols() != 0) return true;
//		break;
//	default:
//		return false;
//	}
//	return false;
//}
//
//void t(State* min, BinTree* open, BinTree* close, int direction, State** states) {
//	int k = direction * 3;
//	int zero;
//
//	State* s = new State(min->getMap()->shift(direction, &zero), min);
//	if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
//		states[k] = s;
//	}
//
//	Map* map = s->getMap();
//
//	bool v = breakCond(map, direction, zero);
//
//	if (v) {
//		State* s2 = new State(s->getMap()->shift(direction), s);
//		if ((open->find(s2) == NULL) && (close->find(s2) == NULL)) {
//			states[k + 1] = s2;
//		}
//	}
//
//	v = breakCond(map, (direction + 1) % 4, zero);
//
//	if (v) {
//		State* s3 = new State(s->getMap()->shift((direction + 1) % 4), s);
//		if ((open->find(s3) == NULL) && (close->find(s3) == NULL)) {
//			states[k + 2] = s3;
//		}
//	}
//}
//
//std::vector<State*> aThreads(Map* map) {
//
//	BinTree* open = new BinTree();
//	BinTree* close = new BinTree(new State(map, NULL));
//
//	State* min = close->min();
//	std::vector<std::thread> threads;
//
//	for (; min->getCost() != 0; min = open->min(), close->add(min), open->del(min))
//	{
//		int zero = min->getMap()->find(0);
//		State* states[12] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
//		bool v[4] = { false, false, false, false };
//
//		if (zero / map->getCols() != 0) v[0] = true;
//		if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
//		if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
//		if (zero % map->getCols() != 0) v[3] = true;
//
//		//std::thread* threads[4];
//
//		for (int i = 0; i < 4; i++) {
//			if (v[i])
//				//threads[i] = new std::thread(t, std::ref(min), open, close, i, std::ref(states));
//				//threads.emplace_back(t, std::ref(min), open, close, i, std::ref(states));
//				threads.emplace_back(t, min, open, close, i, states);
//				//t(min, open, close, i, states);
//		}
//
//		for (auto &thr : threads) {
//			thr.join();
//		}
//
//		threads.clear();
//
//		for (int i = 0; i < 12; i++)
//		{
//			if (states[i]) {
//				open->add(states[i]);
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

void t2(State* min, BinTree* open, BinTree* close, int direction, State** states) {
	int k = direction * 4;
	Map* map = min->getMap();
	int zero = map->find(0);

	bool v[4] = { false, false, false, false };

	if (zero / map->getCols() != 0) v[0] = true;
	if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
	if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
	if (zero % map->getCols() != 0) v[3] = true;

	for (int i = 0; i < 4; i++) {
		states[k + i] = NULL;
		if (v[i]) {
			State* s = new State(map->shift(i), min);
			if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
				states[k + i] = s;
			}
		}
	}
}

//std::vector<State*> aThreads(Map* map) {
//
//	BinTree* open = new BinTree(new State(map, NULL));
//	BinTree* close = new BinTree();
//
//	State* min;
//	State** states;
//
//	std::vector<std::thread> threads;
//	std::vector<State*> mins;
//
//	int stateSize = std::thread::hardware_concurrency() << 2;
//	//states = new State*[stateSize];
//	states = new State*[16];
//
//	for (;;) {
//		mins.clear();
//		for (int i = 0; (i < 4) && (open->len > 0); i++) {
//			min = open->min();
//			close->add(min);
//			open->del(min);
//			mins.push_back(min);
//		}
//
//		int i = 0;
//		for (auto m : mins) {
//			threads.emplace_back(t2, min, open, close, i, states);
//			i++;
//		}
//
//		for (auto& thr : threads) {
//			thr.join();
//		}
//
//		threads.clear();
//
//		for (unsigned i = 0; i < mins.size()*4; i++) {
//			if (!states[i]) continue;
//
//			//if (states[i]) open->add(states[i]);
//
//			bool f = false;
//			for (unsigned j = i + 1; j < mins.size()*4; j++) {
//				if (!states[j]) continue;
//				if (cmp(states[i], states[j])) {
//					f = true;
//					break;
//				}
//			}
//
//			if (!f) {
//				open->add(states[i]);
//			}
//		}
//
//		min = open->min();
//		if (min->getCost() == 0) break;
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

//TODO:
//Использовать мельничный алгоритм
//Попробовать с различной длиной лопастей
//Использовать встроенные сбалансированные деревья

//bool breakCond(Map* map, int direction, int zero = -1) {
//	if (zero == -1) {
//		zero = map->find(0);
//	}
//
//	switch (direction)
//	{
//	case DIRECTION_UP: if (zero / map->getCols() != 0) return true;
//		break;
//	case DIRECTION_RIGHT: if (zero % map->getCols() != map->getCols() - 1) return true;
//		break;
//	case DIRECTION_DOWN: if (zero / map->getCols() != map->getLines() - 1) return true;
//		break;
//	case DIRECTION_LEFT: if (zero % map->getCols() != 0) return true;
//		break;
//	default:
//		return false;
//	}
//	return false;
//}
//
//void t2(State* min, BinTree* open, BinTree* close, int direction, std::vector<State*> *states) {
//	//Map* map = min->getMap();
//	//int zero;
//	//int zeroHor;
//
//	//State* sVert = min;
//	//State* sHor = sVert;
//
//	for (int i = 0; i < 2; i++, direction++) {
//		Map* map = min->getMap();
//		int zero = map->find(0);
//		int zeroHor;
//
//		State* sVert = min;
//		State* sHor = sVert;
//
//		if (!breakCond(map, direction, zero)) {
//			continue;
//		}
//
//		for (map = map->shift(direction, &zero);; map = map->shift(direction, &zero)) {
//			sHor = sVert;
//			zeroHor = zero;
//			bool f = true;
//			for (Map* mapHor = map;; mapHor = mapHor->shift((direction + 1) % 4, &zeroHor)) {
//				State *sopen, *sclose;
//				State *s = new State(mapHor, sHor);
//				sopen = open->find(s);
//				sclose = close->find(s);
//				if ((sopen == NULL) && (sclose == NULL)) {
//					//states[k] = s;
//					states->push_back(s);
//					sHor = s;
//				}
//				else {
//					if (sopen != NULL)
//						sHor = sopen;
//					else
//						sHor = sclose;
//				}
//
//				if (f) {
//					sVert = sHor;
//					f = false;
//				}
//
//				if (!breakCond(mapHor, (direction + 1) % 4, zeroHor)) break;
//			}
//
//			if (!breakCond(map, direction, zero)) break;
//		}
//	}
//}
//
//void t(State* min, BinTree* open, BinTree* close, int direction, std::vector<State*> *states) {
//	int zero = min->getMap()->find(0);
//
//	for (int i = 0; i < 2; i++, direction++) {
//
//		Map* map = min->getMap();
//
//		bool v = breakCond(map, direction, zero);
//		State* s;
//
//		if (v) {
//
//			s = new State(min->getMap()->shift(direction, &zero), min);
//			if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
//				states->push_back(s);
//			}
//
//		}
//		else {
//			continue;
//		}
//
//		map = s->getMap();
//
//		v = breakCond(map, direction, zero);
//
//		if (v) {
//			State* s = new State(min->getMap()->shift(direction, &zero), min);
//			if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
//				states->push_back(s);
//			}
//		}
//
//		v = breakCond(map, direction + 1, zero);
//
//		if (v) {
//			State* s = new State(min->getMap()->shift(direction, &zero), min);
//			if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
//				states->push_back(s);
//			}
//		}
//	}
//}

//void t(State* min, BinTree* open, BinTree* close, int direction, State** states) {
//	int k = direction * 3;
//	int zero;
//
//	State* s = new State(min->getMap()->shift(direction, &zero), min);
//	if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
//		states[k] = s;
//		//states[i] = s;
//	}
//
//	Map* map = s->getMap();
//	//zero = map->find(0);
//
//	bool v = breakCond(map, direction, zero);
//
//	if (v) {
//		State* s2 = new State(s->getMap()->shift(direction), s);
//		if ((open->find(s2) == NULL) && (close->find(s2) == NULL)) {
//			states[k + 1] = s2;
//		}
//	}
//
//	v = false;
//	v = breakCond(map, (direction + 1) % 4, zero);
//
//	if (v) {
//		State* s3 = new State(s->getMap()->shift((direction + 1) % 4), s);
//		if ((open->find(s3) == NULL) && (close->find(s3) == NULL)) {
//			states[k + 2] = s3;
//		}
//	}
//}



//std::vector<State*> aThreads(Map* map) {
//
//	BinTree* open = new BinTree();
//	BinTree* close = new BinTree(new State(map, NULL));
//
//	State* min = close->min();
//	std::thread* threads[2];
//	State** states;
//
//	states = new State*[map->cols * map->lines];
//	//HANDLE threads[4];
//
//	for (; min->getCost() != 0; min = open->min(), close->add(min), open->del(min))
//	{
//		for (int i = 0; i < map->cols * map->lines; i++) states[i] = 0;
//
//		int zero = min->getMap()->find(0);
//		bool v[4] = { false, false, false, false };
//		std::vector<State*> vectors[2];
//
//		//if (zero / map->getCols() != 0) v[0] = true;
//		//if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
//		//if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
//		//if (zero % map->getCols() != 0) v[3] = true;
//
//
//		for (int i = 0; i < 2; i ++) {
//			//if (v[i])
//				//threads[i] = CreateThread()
//				threads[i] = new std::thread(t2, std::ref(min), std::ref(open), std::ref(close), i * 2, &vectors[i]);
//		}
//
//		//WaitForMultipleObjects(4, threads, TRUE, INFINITE);
//
//		for (int i = 0; i < 2; i++) {
//			//if (v[i])
//				threads[i]->join();
//				for (auto elem : vectors[i]) open->add(elem);
//		}
//
//		//for (int i = 0; i < map->cols * map->lines; i++)
//		//{
//		//	if (states[i]) {
//		//		//if (i % 3 == 0) close->add(states[i]);
//		//		//else 
//		//			open->add(states[i]);
//		//	}
//		//}
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