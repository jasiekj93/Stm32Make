# ------------------------------------------------
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

$(full_mock_name).cpp: | $(test_path)
	@echo "Creating file $@"
	@$(file > $@,$(file_cpp))

$(full_mock_name).hpp: | $(test_path)
	@echo "Creating file $@"
	$(file > $@,$(file_hpp))

$(full_path) $(test_path):
	@echo "Creating directory $@"
	@mkdir -p $@