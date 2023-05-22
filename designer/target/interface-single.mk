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
		virtual ~$(NAME)() {}


		static $(NAME)* getInstance();

	protected:
		static $(NAME)* instance;
	};
}

endef

define file_cpp
#include "$(NAME).hpp"
#include <assert.h>

using namespace $(full_namespace);

$(NAME)* $(NAME)::instance = nullptr;

$(NAME)* $(NAME)::getInstance()
{
    assert(instance);
    return instance;
}

endef

.PHONY: interface-single $(full_name).hpp $(full_name).cpp

interface-single: $(full_name).hpp $(full_name).cpp

include BuildRules.mk