# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-project)

define file_cpp
/**
 * @file Main.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

#include <gtkmm/application.h>

using namespace $(PROJECT)::$(NAME);

int main(int argc, char* argv[])
{
	auto app = Gtk::Application::create(argc, argv, "org.gtkmm.example");
	return app->run();
}

endef

define gresource_xml
<?xml version="1.0" encoding="UTF-8"?>
<gresources>
  <gresource>
  </gresource>
</gresources>
endef

.PHONY: gtk-program $(full_program_name).cpp $(full_program_makefile) $(resource_dir)/gresource.xml

gtk-program: $(full_program_name).cpp $(full_program_makefile) $(gtk_program_resource_path)/gresource.xml

$(full_program_makefile) : | $(program_path)
	@echo "Creating file $@"
	@cp $(template_path)/GtkProgramTmp.mk $@
	@$(SED) -i -e 's/@program_name@/$(NAME)/' $@

$(gtk_program_resource_path)/gresource.xml: | $(gtk_program_resource_path)
	@echo "Creating file $@"
	@$(file > $@,$(gresource_xml))

include BuildRules.mk