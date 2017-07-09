//======-------- LNOLoopDistribute.cpp -- LNO Loop Distribution Pass -----------------------* - c++ -*--====//
//
//                  The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//=====--------------------------------------------------------------------------------------------====//
//
// This file implements Loop Distribution Pass based on approximated polyhedral dependecies.
// Right now the algorithm is same as the old Loop Distribution pass.
//
// LNO project has its base in approximating polyhedral dependencies to DDV(Dependence Distance vectors)
// which is a lower abstraciton from polyhedral dependencies. These new set of dependencies are hoped
// give better dependences there.
//
// This Pass will be a helping pass to vectorization at this instance by breaking conflicting dependencies.
//
//=====-------------------------------------------------------------------------------------------====//


#include "llvm/Transforms/Scalar/LNOLoopDistribute.h"
#include "llvm/Analysis/LoopInfo.h"
//#include "llvm/Analysis/LoopPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/OptimizationDiagnosticInfo.h"
#include "llvm/IR/DiagnosticInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "polly/PolyhedralInfo.h"

#define LNOLDIST_NAME "lno-loop-distribute"
#define DEBUG_TYPE LNOLDIST_NAME

using namespace llvm;
using namespace polly;

namespace {
class LNOLoopDistributeForLoop {
public:
	LNOLoopDistributeForLoop(Loop *L, LoopInfo *LI, DominatorTree *DT,
												ScalarEvolution *SE, OptimizationRemarkEmitter *ORE, PolyhedralInfo *PHI)
												: L(L), LI(LI), DT(DT), SE(SE), ORE(ORE), PHI(PHI) {
    if(PHI)
			DDV = PHI->getDDVs(PHI->getScopContainingLoop(L));
  }

	std::vector<DependenceDirectionVector *> *DDV;
	
	bool processLoop()
	{
		int VF = 0;
		const Scop *scop = PHI->getScopContainingLoop(L);
		if(PHI->isParallel(L)) {
			dbgs() << "Loop is parallel, no point in distributing.\n";
		}
		if(scop == nullptr) {
			dbgs() << "Loop dependences cannot be analyzed.\n";
		}
		if(PHI->isVectorizable(L, &VF) && VF > 1){
			dbgs() << "Loop is vectorizable, with VF : " << VF << "\n";
		}

		//TODO: We can split loops based on Vectorization factors we get individual statements.
    if(DDV != nullptr)
      errs() << "Got DDV\n";
    else {
      errs() << "DDV is empty! \n";
      return false;
    }
		return false;
	}

private:
	Loop *L;
	Function *F;

	// Analyses used.
	LoopInfo *LI;
	const LoopAccessInfo *LAI;
	DominatorTree *DT;
	ScalarEvolution *SE;
	OptimizationRemarkEmitter *ORE;
	PolyhedralInfo *PHI;
};

struct LNOLoopDistribute : public FunctionPass {
	LNOLoopDistribute():FunctionPass(ID){
	}

	SmallVector<Loop *, 8> Worklist;
  LoopInfo *LI;
  DominatorTree *DT;
  ScalarEvolution *SE;
  OptimizationRemarkEmitter *ORE;
  PolyhedralInfo *PHI;

	bool runOnFunction(Function &F) override {
		if(skipFunction(F))
			return false;
		LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
		DT = &getAnalysis<DominatorTreeWrapperPass>().getDomTree();
		SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
		ORE = &getAnalysis<OptimizationRemarkEmitterWrapperPass>().getORE();
		PHI = &getAnalysis<PolyhedralInfo>();
		if(PHI != nullptr)
			errs() << "PHI is not null\n";
		else {
			errs() << "PHI is nullptr\n";
			return false;
		}

		for (Loop *TopLevelLoop : *LI)
			for (Loop *L : depth_first(TopLevelLoop))
			// We only handle inner-most loops.
				if (L->empty())
					Worklist.push_back(L);

		// Now walk the identified inner loops.
		bool Changed = false;
		for (Loop *L : Worklist) {
			LNOLoopDistributeForLoop LLDL(L, LI, DT, SE, ORE, PHI);
			Changed |= LLDL.processLoop();	
		}
		return Changed;
	}

 
	void getAnalysisUsage(AnalysisUsage &AU) const override {
		AU.addRequired<ScalarEvolutionWrapperPass>();
		AU.addRequired<LoopInfoWrapperPass>();
		AU.addRequired<PolyhedralInfo>();
		AU.addRequired<DominatorTreeWrapperPass>();
		AU.addPreserved<DominatorTreeWrapperPass>();
		AU.addRequired<OptimizationRemarkEmitterWrapperPass>();
		AU.setPreservesAll();
  }

	static char ID;
};

}
char LNOLoopDistribute::ID = 0;
static const char lnoldist_name[] = "Loop distribution based on polly dependence graph"; 
static RegisterPass<LNOLoopDistribute> X(LNOLDIST_NAME, lnoldist_name);
