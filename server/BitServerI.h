#ifndef __BitServerI_h__
#define __BitServerI_h__

#include <BitServer.h>

#define SIZE_OF_BIT 2147483647
#include <bitset>

namespace renren
{

class BitServerI : virtual public BitServer
{
public:
	void initialize();

    virtual bool get(::Ice::Int,
                     const Ice::Current&);

    virtual ::Ice::BoolSeq gets(const ::Ice::IntSeq&,
                                const Ice::Current&);

    virtual ::renren::BitSegment getSegment(::Ice::Int,
                                            ::Ice::Int,
                                            const Ice::Current&);
private:
	std::bitset<SIZE_OF_BIT> bits_;
};

}

#endif
