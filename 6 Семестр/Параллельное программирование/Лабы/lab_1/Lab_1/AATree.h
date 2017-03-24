#pragma once
/*
* C++ Program To Implement AA Tree
*/
#include <iostream>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include "state.h"


/*
* Node Declaration
*/
struct node
{
	int count, level;
	State key;
	node *right;
	node *left;
	node *parent;
	node *root;
};

/*
* Class Declaration
*/
class AATree
{
public:
	int lookup(State &);
	void skew(node *);
	bool split(node *);
	void rebal(node *);
	node *insert(node *, node *);
	void print(node *);
	int countnode(node *);

	node* root;

	AATree()
	{
		root = NULL;
	}
};


/*
* Insert String into the Tree
*/
int AATree::lookup(State &key)
{
	node* temp = new node();
	temp->key = key;
	temp->level = 1;
	temp->count = 0;
	temp->left = NULL;
	temp->right = NULL;
	temp->parent = NULL;
	temp = insert(root, temp);
	return temp->count;
}

/*
* Skew Tree
*/

void AATree::skew(node *temp)
{
	node *ptr = temp->left;
	if (temp->parent->left == temp)
		temp->parent->left = ptr;
	else
		temp->parent->right = ptr;
	ptr->parent = temp->parent;
	temp->parent = ptr;
	temp->left = ptr->right;
	if (temp->left != NULL)
		temp->left->parent = temp;
	ptr->right = temp;
	temp->level = (temp->left ? temp->left->level + 1 : 1);
}

/*
* Splitting of AA Tree
*/
bool AATree::split(node *temp)
{
	node* ptr = temp->right;
	if (ptr && ptr->right && (ptr->right->level == temp->level))
	{
		if (temp->parent->left == temp)
			temp->parent->left = ptr;
		else
			temp->parent->right = ptr;
		ptr->parent = temp->parent;
		temp->parent = ptr;
		temp->right = ptr->left;
		if (temp->right != NULL)
			temp->right->parent = temp;
		ptr->left = temp;
		ptr->level = temp->level + 1;
		return true;
	}
	return false;
}

/*
* Rebalancing of AA Tree
*/
void AATree::rebal(node* temp)
{
	temp->left = NULL;
	temp->right = NULL;
	temp->level = 1;
	for (temp = temp->parent; temp != root; temp = temp->parent)
	{
		if (temp->level != (temp->left ? temp->left->level + 1 : 1))
		{
			skew(temp);
			if (temp->right == NULL)
				temp = temp->parent;
			else if (temp->level != temp->right->level)
				temp = temp->parent;
		}
		if (temp->parent != root)
		{
			if (split(temp->parent) == false)
				break;
		}
	}
}

/*
* Insert Function to insert string into the tree
*/
node* AATree::insert(node* temp, node* ins)
{
	if (root == NULL)
	{
		ins->count = 1;
		ins->parent = NULL;
		ins->left = NULL;
		ins->right = NULL;
		root = ins;
		return root;
	}
	if (ins->key.getF() < temp->key.getF())
	{
		if (temp->left)
			return insert(temp->left, ins);
		temp->left = ins;
		ins->parent = temp;
		ins->count = 1;
		rebal(ins);
		return ins;
	}
	if (ins->key.getF() >= temp->key.getF())
	{
		if (temp->right)
			return insert(temp->right, ins);
		temp->right = ins;
		ins->parent = temp;
		ins->count = 1;
		rebal(ins);
		return ins;
	}
	temp->count++;
	delete ins;
	return temp;
}

/*
* Display Tree Elements
*/
void AATree::print(node* temp)
{
	if (!temp)
		return;
	print(temp->left);
	std::cout << "Value: " << temp->key.getF() << "  Count:" << temp->count;
	std::cout << "  Level: " << temp->level << std::endl;
	print(temp->right);
}

/*
* Count number of nodes in AA Tree
*/
int AATree::countnode(node* temp)
{
	if (!temp)
		return 0;
	int count = 1;
	count = count + countnode(temp->left);
	count = count + countnode(temp->right);
	return count;
}