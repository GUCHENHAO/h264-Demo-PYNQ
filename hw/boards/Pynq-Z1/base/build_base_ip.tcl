# Rebuild HLS IP from source
set current_dir [pwd]
cd C:/work/vivado_work/PYNQ-master/boards/ip/hls
set ip [glob -types d *];
foreach item $ip {
   if {[file exist xilinx_com_{$item}_1_0.zip] == 0} {
      puts "Building $item IP"
      exec vivado_hls -f $item/script.tcl
   } else {
      puts "$item IP already built"
   }
}
cd $current_dir
puts "HLS IP builds complete"