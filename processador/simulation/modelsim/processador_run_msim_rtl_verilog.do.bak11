transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/ula.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/banco_registradores.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/decod4_16.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/shifter.v}
vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/ram.v}

vlog -vlog01compat -work work +incdir+C:/Users/felip/Desktop/Facul/Repositorio_processador/processador {C:/Users/felip/Desktop/Facul/Repositorio_processador/processador/cpu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
