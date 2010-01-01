
#include <BitServerI.h>
#include <Ice/Ice.h>

int main(int argc, char** argv) {
	int status = 0;
	Ice::CommunicatorPtr ic;
	try{
		ic = Ice::initialize(argc, argv);
		Ice::ObjectAdapterPtr adapter = ic->createObjectAdapter("BitServer");
		renren::BitServerI* obj = new renren::BitServerI;
		obj->initialize();
		adapter->add(obj, ic->stringToIdentity("BitServer"));
		adapter->activate();
		ic->waitForShutdown();
	} catch (const Ice::Exception& e) {
		std::cerr << e << std::endl;
		status = 1;
	} catch (const std::exception& e) {
		std::cerr << e.what() << std::endl;
		status = 1;
	} catch (...) {
		std::cerr << "unknown exception" << std::endl;
		status = 1;
	}
	if (ic) {
		try {
			ic->destroy();
		} catch (const Ice::Exception& e) {
			std::cerr << e << std::endl;
			status = 1;
		} catch (const std::exception& e) {
			std::cerr << e.what() << std::endl;
			status = 1;
		} catch (...) {
			std::cerr << "unknown exception" << std::endl;
			status = 1;
		}
	}
	return status;
}

void
renren::BitServerI::initialize() {
	for (int i=0; i<0xFFFFF;i=i+2) {
		bits_[i]=true;
	}
}

bool
renren::BitServerI::get(::Ice::Int offset,
                        const Ice::Current& current)
{
	if(offset < 0) return false;
    return bits_[offset];
}

::Ice::BoolSeq
renren::BitServerI::gets(const ::Ice::IntSeq& offsets,
                         const Ice::Current& current)
{
    return ::Ice::BoolSeq();
}

::renren::BitSegment
renren::BitServerI::getSegment(::Ice::Int begin,
                               ::Ice::Int end,
                               const Ice::Current& current)
{
    return ::renren::BitSegment();
}
