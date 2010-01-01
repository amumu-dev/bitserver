
#include <Ice/BuiltinSequences.ice>

module renren {
	struct BitSegment {
		int begin;
		int end;
		Ice::ByteSeq data;
	};
	interface BitServer {
		bool get(int offset);
		Ice::BoolSeq gets(Ice::IntSeq offsets);
		BitSegment getSegment(int begin, int end);
	};
};

