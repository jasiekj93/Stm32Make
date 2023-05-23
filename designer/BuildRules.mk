 ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

$(full_name).cpp: | $(full_path)
	@echo "Creating file $@"
	@$(file > $@,$(file_cpp))

$(full_name).hpp: | $(full_path)
	@echo "Creating file $@"
	$(file > $@,$(file_hpp))

$(full_test_name).test.cpp: | $(test_path)
	@echo "Creating file $@"
	@$(file > $@,$(file_test_cpp))

$(full_mock_name).cpp: | $(mock_path)
	@echo "Creating file $@"
	@$(file > $@,$(file_cpp))

$(full_mock_name).hpp: | $(mock_path)
	@echo "Creating file $@"
	$(file > $@,$(file_hpp))

$(full_program_name).cpp: | $(program_path)
	@echo "Creating file $@"
	@$(file > $@,$(file_cpp))

$(full_program_makefile) : | $(program_path)
	@echo "Creating file $@"
	@cp $(template_path)/ProgramTmp.mk $@
	@$(SED) -i -e 's/@program_name@/$(NAME)/' $@

$(full_path) $(test_path) $(mock_path) $(program_path):
	@echo "Creating directory $@"
	@mkdir -p $@