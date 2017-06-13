#pragma once
#include <vector>
#include "state.h"

std::vector<State*> aLin(Map* map);
std::vector<State*> aLin2(Map* map);
std::vector<Map*> aLin3(Map* map);

std::vector<State*> aOMP(Map* map);

std::vector<State*> aThreads(Map* map);

std::vector<Map*> aMPI(Map* map);