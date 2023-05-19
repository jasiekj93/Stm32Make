# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Path.mk

$(call check-name)
$(call check-namespace)

class_name := $(NAME)Impl
full_name := $(full_path)/$(class_name)
full_test_name := $(test_path)/$(class_name)

define file_hpp
#pragma once

/**
 * @file $(class_name).hpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%M-%d)
 */

#include <$(path)/$(NAME).hpp>

namespace $(NAMESPACE)
{
	class $(class_name) : public $(NAME)
	{
	public:
		$(class_name)();

	};
}

endef

define file_cpp
#include "$(class_name).hpp"

using namespace $(NAMESPACE);

$(class_name)::$(class_name)()
	: instance(this)
{

}

endef

define file_test_cpp
/**
 * @file $(class_name).test.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%M-%d)
 */

#include <$(path)/$(class_name).hpp>

#include <CppUTest/TestHarness.h>

using namespace $(NAMESPACE);

TEST_GROUP($(class_name)Test)
{
	void setup()
	{

	}

	void teardown()
	{
		
	}
};

TEST($(class_name)Test, example)
{
	FAIL("TODO");
}

endef


.PHONY: interface-single-impl $(full_name).hpp $(full_name).cpp $(full_test_name).test.cpp

interface-single-impl: $(full_name).hpp $(full_name).cpp $(full_test_name).test.cpp

include BuildRules.mk