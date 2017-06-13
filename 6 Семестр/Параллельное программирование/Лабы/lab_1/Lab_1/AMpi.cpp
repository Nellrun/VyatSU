#include <mpi.h>
#include "binTree.h"
#include <vector>
#include <set>
#include <iostream>

#define DIRECTION_UP 0
#define DIRECTION_RIGHT 1
#define DIRECTION_DOWN 2
#define DIRECTION_LEFT 3

bool breakCond(Map* map, int direction, int zero = -1) {
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

void t(State* min, BinTree* open, BinTree* close, std::multiset<State*, compare>* hashes, int i, Map* target = NULL) {
	State* s;
	int zero;
	
	if (target) s = new State(min->getMap()->shift(i, &zero), min, target);
	else s = new State(min->getMap()->shift(i, &zero), min);

	bool f = false;

	for (std::multiset<State*, compare>::iterator iter = hashes->find(s); iter != hashes->end(); iter++) {
		if (cmp((*iter), s)) {
			f = true;
			break;
		}
	}

	if (!f) {
		open->add(s);
		hashes->insert(s);
	}

	bool v = breakCond(s->getMap(), i, zero);

	if (v) {
		State* s2;
		if (target) s2 = new State(s->getMap()->shift(i), min, target);
		else s2 = new State(s->getMap()->shift(i), min);

		f = false;

		for (std::multiset<State*, compare>::iterator iter = hashes->find(s); iter != hashes->end(); iter++) {
			if (cmp((*iter), s)) {
				f = true;
				delete s2;
				break;
			}
		}

		if (!f) {
			open->add(s);
			hashes->insert(s);
		}
	}

	v = breakCond(s->getMap(), (i + 1) % 4, zero);

	if (v) {
		State* s2;
		if (target) s2 = new State(s->getMap()->shift((i + 1) % 4), min, target);
		else s2 = new State(s->getMap()->shift((i + 1) % 4), min);

		f = false;

		for (std::multiset<State*, compare>::iterator iter = hashes->find(s); iter != hashes->end(); iter++) {
			if (cmp((*iter), s)) {
				f = true;
				delete s2;
				break;
			}
		}

		if (!f) {
			open->add(s);
			hashes->insert(s);
		}
	}

	//if ((open->find(s) == NULL) && (close->find(s) == NULL)) {
	//	open->add(s);
	//	hashes->insert(s);
	//}
}

std::vector<Map*> aMPI(Map* map) {
	Map* one = ones(map->lines, map->cols);
	
	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	std::multiset<State*, compare> hashes;

	if (rank == 0) {
		BinTree* open = new BinTree();
		BinTree* close = new BinTree(new State(map, NULL, one));
		
		State* min = close->min();

		for (; ; min = open->min(), close->add(min), open->del(min))
		{
			//unsigned long hash = min->getHash();
			//unsigned long resHash;
			MPI_Status stat;
			//MPI_Send(&hash, 1, MPI_UNSIGNED_LONG, 1, 1, MPI_COMM_WORLD);
			//MPI_Recv(&resHash, 1, MPI_UNSIGNED_LONG, 1, 1, MPI_COMM_WORLD, &stat);

			int* m = new int[map->lines * map->cols];
			int* sendM = min->getMap()->map;

			MPI_Send(sendM, map->lines * map->cols, MPI_INT, 1, 1, MPI_COMM_WORLD);
			MPI_Recv(m, map->lines * map->cols, MPI_INT, 1, 1, MPI_COMM_WORLD, &stat);

			Map* resMap = new Map(map->lines, map->cols, m);
			State* resState = new State(resMap, NULL);


			bool f = false;
			bool resF = false;

			for (std::multiset<State*, compare>::iterator iter = hashes.find(resState); iter != hashes.end(); iter++) {
				if (cmp(resState, (*iter))) {
					min = (*iter);
					f = true;
					break;
				}
			}

			MPI_Send(&f, 1, MPI_C_BOOL, 1, 1, MPI_COMM_WORLD);
			MPI_Recv(&resF, 1, MPI_C_BOOL, 1, 1, MPI_COMM_WORLD, &stat);

			if (f || resF) break;

			int zero = min->getMap()->find(0);
			bool v[4] = { false, false, false, false };

			if (zero / map->getCols() != 0) v[0] = true;
			if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
			if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
			if (zero % map->getCols() != 0) v[3] = true;

			for (int i = 0; i < 4; i++) {
				if (v[i]) t(min, open, close, &hashes, i);
			}
		}

		std::vector<Map*> vect;

		State* s = min;
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

		MPI_Status stat;

		int size;
		MPI_Recv(&size, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, &stat);
		int* m = new int[size];
		MPI_Recv(m, size, MPI_INT, 1, 1, MPI_COMM_WORLD, &stat);


		int step = (map->cols * map->lines);
		for (int i = 0; i < size ; i+= step) {
			Map* elem = new Map(map->lines, map->cols, &m[i]);
			solution.push_back(elem);
			//printMap(elem);
		}

		//vect.resize(size);

		return solution;
	}
	else {
		BinTree* open = new BinTree();
		//BinTree* close = new BinTree(new State(one, NULL, map));

		//State* min = close->min();

		State* min = new State(one, NULL, map);

		for (; ; min = open->min(), /*close->add(min),*/ open->del(min))
		{
			//unsigned long hash = min->getHash();
			//unsigned long resHash;
			MPI_Status stat;
			//MPI_Send(&hash, 1, MPI_UNSIGNED_LONG, 0, 1, MPI_COMM_WORLD);
			//MPI_Recv(&resHash, 1, MPI_UNSIGNED_LONG, 0, 1, MPI_COMM_WORLD, &stat);

			int* m = new int[map->lines * map->cols];
			int* sendM = min->getMap()->map;

			MPI_Send(sendM, map->lines * map->cols, MPI_INT, 0, 1, MPI_COMM_WORLD);
			MPI_Recv(m, map->lines * map->cols, MPI_INT, 0, 1, MPI_COMM_WORLD, &stat);

			Map* resMap = new Map(map->lines, map->cols, m);
			State* resState = new State(resMap, NULL);

			bool f = false;
			bool resF = false;

			for (std::multiset<State*, compare>::iterator iter = hashes.find(resState); iter != hashes.end(); iter++) {
				if (cmp(resState, (*iter))) {
					min = (*iter);
					f = true;
					break;
				}
			}

			MPI_Send(&f, 1, MPI_C_BOOL, 0, 1, MPI_COMM_WORLD);
			MPI_Recv(&resF, 1, MPI_C_BOOL, 0, 1, MPI_COMM_WORLD, &stat);

			if (f || resF) break;

			int zero = min->getMap()->find(0);
			bool v[4] = { false, false, false, false };

			if (zero / map->getCols() != 0) v[0] = true;
			if (zero % map->getCols() != map->getCols() - 1) v[1] = true;
			if (zero / map->getCols() != map->getLines() - 1) v[2] = true;
			if (zero % map->getCols() != 0) v[3] = true;

			for (int i = 0; i < 4; i++) {
				if (v[i]) t(min, open, NULL, &hashes, i, resMap);
			}
		}

		//std::cout << "Send data" << std::endl;

		std::vector<Map*> solution;

		State* s = min;
		do
		{
			solution.push_back(s->getMap());
			s = s->getParent();
		} while (s != NULL);

		int size = solution.size() * map->cols * map->lines;

		MPI_Send(&size, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);

		int* m = new int[size];

		unsigned i = 0;
		for (auto elem : solution) {
			//printMap(elem);
			for (int j = 0; j < (map->cols * map->lines); j++) {
				m[i] = elem->map[j];
				i++;
			}
		}

		MPI_Send(m, size, MPI_INT, 0, 1, MPI_COMM_WORLD);
	}

	return std::vector<Map*>();
}
