# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-namespace)

class_name := $(NAME)Mock
test_path := $(test_path)/mock
full_mock_name := $(test_path)/$(class_name)

define file_hpp
#pragma once

/**
 * @file $(class_name).hpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%M-%d)
 */

#include <$(path)/$(NAME).hpp>

namespace $(full_namespace)::mock
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

using namespace $(full_namespace);
using namespace $(full_namespace)::mock;

$(class_name)::$(class_name)()
	: instance(this)
{

}

endef

.PHONY: mock-interface-single $(full_mock_name).hpp $(full_mock_name).cpp

mock-interface-single: $(full_mock_name).hpp $(full_mock_name).cpp 

include BuildRules.mk