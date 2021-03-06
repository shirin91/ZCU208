#-----------------------<EDIT  HERE>-----------------------
set xpr_name vivado
set top_name design_1_wrapper
set core_cnt 8 
#-----------------------</EDIT HERE>----------------------- 
#----------------------------------------------------------
set origin_dir [file dirname [file dirname [info script]]]
set prj_dir ${origin_dir}/build/ps/
#----------------------------------------------------------
cd ${origin_dir}

# set the workspace
setws ${origin_dir}/build/ps/
#-----------------
# create platform 
#-----------------
platform create -name "zcu208_mts_platform" -hw ${prj_dir}/${top_name}.xsa -proc psu_cortexa53_0 -os standalone 
platform generate
#-------------------
# create application 
#-------------------
app create -name "zcu208_init" -platform zcu208_mts_platform  -template "Empty Application(C)" 
importsources -name zcu208_init -path ./sdk_src/ -linker-script
#--------------
# build project
#--------------
sysproj build -all 

exit


