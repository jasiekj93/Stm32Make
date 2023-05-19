# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

#$(call check-name)
define check-name
$(if $(NAME),,$\
	$(error ERROR: Variable 'NAME' is empty!))
endef

#$(call check-namespace)
define check-namespace
$(if $(NAMESPACE),,$\
	$(error ERROR: Variable 'NAMESPACE' is empty!))
endef
