#pragma once
#include <cstdlib>
#include "Map.h"
#include "state.h"

struct Node {
	Node* left;
	Node* right;
	State* elem;
};

class BinTree
{
public:
	int len;

	BinTree(State* s) {
		this->node = new Node();
		this->node->elem = s;
		len = 1;
	}

	BinTree() {
		this->node = new Node();
		len = 0;
	}

	~BinTree() {
	}

	int getLen() {
		return len;
	}

	void add(State* s) {
		Node* n = this->node;

		len += 1;

		if (n->elem == NULL) {
			n->elem = s;
			return;
		}

//#pragma omp parallel 
//		{
//#pragma omp critical
//			{
//
				do
				{
					if (s->getCost() >= n->elem->getCost()) {
						if (n->right == NULL) {
							n->right = new Node();
							n->right->elem = s;
							break;
						}
						else {
							n = n->right;
						}
					}
					else {
						if (n->left == NULL) {
							n->left = new Node();
							n->left->elem = s;
							break;
						}
						else {
							n = n->left;
						}
					}

				} while (true);
		//	}
		//}
	}

	void del(State* s) {
		Node* n = this->node;
		Node* p = NULL;

		while (n->elem != s)
		{
			p = n;
			if (s->getCost() > n->elem->getCost()) {
				n = n->right;
			}
			else {
				n = n->left;
			}

			if (n == NULL) return;
		}

		len -= 1;

		if ((n->left == NULL) && (n->right == NULL)) {
			if (p == NULL) {
				n->elem = NULL;
				return;
			}
			if (p->left == n) p->left = NULL;
			else p->right = NULL;
			//delete n->elem;
			delete n;
			return;
		}

		if (n->left == NULL) {
			if (p == NULL) {
				this->node = n->right;
				delete n;
				return;
			}
			if (p->left == n) p->left = n->right;
			else p->right = n->right;
			//delete n->elem;
			delete n;
			return;
		}

		if (n->right == NULL) {
			if (p == NULL) {
				this->node = n->left;
				delete n;
				return;
			}
			if (p->left == n) p->left = n->left;
			else p->right = n->left;
			//delete n->elem;
			delete n;
			return;
		}

		if (n->right->left == NULL) {
			n->elem = n->right->elem;
			n->right = n->right->right;
			return;
		}
		else {
			Node* k = n->right;

			while (k->left->left != NULL) {
				k = k->left;
			}

			n->elem = k->left->elem;
			k->left = k->left->right;
		}

	}

	bool cmp(State* a, State* b) {
		Map* am = a->getMap();
		Map* bm = b->getMap();
		int len = am->getCols() * am->getLines();
//#pragma omp parallel for
		for (int i = 0; i < len; i++) {
			if (am->map[i] != bm->map[i]) return false;
		}
		return true;

		//if (a->getCost() < b->getCost()) return true;
		//else return false;
	}

	State* find(State* s) {
		Node* n = this->node;

		if (n->elem == NULL) return NULL;

		while ((n->elem->getHash() != s->getHash()) || (!cmp(n->elem, s)) ) {
		//while ((n->elem->getHash() != s->getHash()) || 
		//	((n->elem->getParent() != NULL) && (n->elem->getParent()->getHash() != s->getParent()->getHash())) ) {
			if (s->getCost() >= n->elem->getCost()) {
				n = n->right;
			}
			else {
				n = n->left;
			}

			if (n == NULL) return NULL;
		}
		return n->elem;
	}

	State* min() {
		Node* n = this->node;

		while (n->left != NULL) n = n->left;

		return n->elem;
	}
private:
	Node* node;
};