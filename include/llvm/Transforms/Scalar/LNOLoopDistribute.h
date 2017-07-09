//======-LNOLoopDistribute.cpp -- Loop Distribution Pass -----------------------* - c++ -*--====//
//
//									The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//=====------------------------------------------------------------------------------------====//
//
// This file implements Loop Distribution Pass based on approximated polyhedral dependecies.
// Right now the algorithm is same as the older Loop Distribution pass.
//
//=====------------------------------------------------------------------------------------====//

#ifndef LLVM_TRANSFORMS_SCALAR_LNOLOOPDISTRIBUTE_H
#define LLVM_TRANSFORMS_SCALAR_LNOLOOPDISTRIBUTE_H

#include "llvm/IR/PassManager.h"

namespace llvm {

class LNOLoopDistributePass : public PassInfoMixin<LNOLoopDistributePass> {
public:
	PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};
}   // end of namespace llvm

#endif // LLVM_TRANSFORMS_SCALAR_LNOLOOPDISTRIBUTE_H

