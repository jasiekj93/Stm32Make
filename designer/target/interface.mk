# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Path.mk

$(call check-name)
$(call check-namespace)

define file_hpp
#pragma once

/**
 * @file $(NAME).hpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%M-%d)
 */

namespace $(NAMESPACE)
{
	class $(NAME)
	{
	public:
		virtual ~$(NAME)() {}

	};
}

endef

.PHONY: interface $(full_name).hpp 

interface: $(full_name).hpp 

include BuildRules.mk