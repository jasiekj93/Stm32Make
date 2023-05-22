# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-namespace)

define file_hpp
#pragma once

/**
 * @file $(NAME).hpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

namespace $(full_namespace)
{
	class $(NAME)
	{
	public:
		$(NAME)();

	};
}

endef

define file_cpp
#include "$(NAME).hpp"

using namespace $(full_namespace);

$(NAME)::$(NAME)()
{

}

endef

define file_test_cpp
/**
 * @file $(NAME).test.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

#include <$(path)/$(NAME).hpp>

#include <CppUTest/TestHarness.h>

using namespace $(full_namespace);

TEST_GROUP($(NAME)Test)
{
	void setup()
	{

	}

	void teardown()
	{
		
	}
};

TEST($(NAME)Test, example)
{
	FAIL("TODO");
}

endef


.PHONY: class $(full_name).hpp $(full_name).cpp $(full_test_name).test.cpp

class: $(full_name).hpp $(full_name).cpp $(full_test_name).test.cpp

include BuildRules.mk