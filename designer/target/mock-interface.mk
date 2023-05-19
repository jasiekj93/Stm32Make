# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Path.mk

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

namespace $(NAMESPACE)::mock
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
using namespace $(NAMESPACE)::mock;

$(class_name)::$(class_name)()
{

}

endef

.PHONY: mock-interface $(full_mock_name).hpp $(full_mock_name).cpp

mock-interface: $(full_mock_name).hpp $(full_mock_name).cpp 

include BuildRules.mk