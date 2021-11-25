if [file exists work] {vdel -all}
vlib work
vlog -f files.f
onbreak {resume}
set NoQuitOnFinish 1
#vsim -voptargs=+acc work.TB_Lab2_mux
vsim -voptargs=+acc work.TB_Lab2_mux
do wave.do
run 50ms
