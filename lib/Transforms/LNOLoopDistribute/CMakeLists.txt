add_llvm_loadable_module( LNOLoopDistribute
	LNOLoopDistribute.cpp

	DEPENDS
	intrinsics_gen
	PLUGIN_TOOL
	opt
)

include_directories("${LLVM_MAIN_SRC_DIR}/tools/polly/include")
include_directories("${LLVM_MAIN_SRC_DIR}/tools/polly/lib/External/isl/include")
include_directories("${LLVM_BINARY_DIR}/tools/polly/include")
include_directories("${LLVM_BINARY_DIR}/tools/polly/lib/External/isl/include")
