
###############################
###############################
# How to use:
#
# set variables below to the
# correct location of the
# appropriate files
###############################

# Uncomment one of the following two lines and set it to your vrep path:
VREPDIR=$HOME/V-REP_PRO_EDU_V3_2_2_64_Linux # Set to Vrep directory
# VREPDIR=/Applications/V-REP_PRO_EDU_V3_2_2_Mac/vrep.app/Contents/MacOS # OSX

# set the path to your clone of github.com/ahundt/grl
GRL_DIR=$HOME/grl
# set the path below to your grl cmake build directory, likely
BUILDDIR=$GRL_DIR/build

# the path to the libraries after you built everything
LIBDIR=/lib # Change if using eclipse or OSX
# LIBDIR=/lib/Debug/ # OSX Xcode build location

# the extension to use for the libraries, .so on linux .dylib on OS X
LIBEXT=.so
# LIBEXT=.dylib

# the path to your clone of github.com/ahundt/robone
ROBONE_DIR=$HOME/robone
###############################
###############################

# these are all the possible libraries that may be loaded for grl integration
for arg in "libagast" "libv_repExtGrlInverseKinematics" "libcamodocal_brisk" "libcamodocal_calib" "libcamodocal_camera_models" "libcamodocal_camera_systems" "libcamodocal_chessboard"  "libcamodocal_fivepoint" "libcamodocal_pugixml" "libcamodocal_DBoW2" "libcamodocal_gpl" "libcamodocal_sparse_graph" "libv_repExtHandEyeCalibration" "libv_repExtPivotCalibration" "libcamodocal_DUtilsCV" "libcamodocal_infrastr_calib" "libcamodocal_visual_odometry" "libfusionTrack64" "libv_repExtKukaLBRiiwa" "libcamodocal_DUtils" "libcamodocal_location_recognition" "libcamodocal_DVision" "libcamodocal_pose_estimation" "libceres" "libcamodocal_features2d" "libcamodocal_pose_graph" "libdevice64" "libv_repExtAtracsysFusionTrack"
do
    ln -s $BUILDDIR/$LIBDIR/$arg$LIBEXT $VREPDIR
done

ln -s $GRL_DIR/modules/grl/src/lua/grl.lua $VREPDIR

# This file allows you to load paths for the simulation to follow
ln -s $ROBONE_DIR/modules/robone/data/vrepAddOnFunc_RoboneSimulationLoadCutFile.lua $VREPDIR

# This is the simulation file you open with V-REP
ln -s $ROBONE_DIR/robone/data/RoboneSimulation.ttt

# This is for the specific case of linuxbrew, you probably don't need this
#
# vrep won't pick up the correct libraries if everything is built with linuxbrew
# so change the dynamic library path loaded by vrep
#
# TODO: This solution isn't perfect, it may pick up versions conflicting with those
#       used to build vrep, resulting in mysterious crashes. Try to use the libraries
#       in the same directory as vrep whenever possible. 
if [ -d $HOME/.linuxbrew ] ; then
    ln -s $HOME/.linuxbrew/lib $VREPDIR
    patchelf --set-rpath '$ORIGIN:$ORIGIN/lib' $VREPDIR/vrep
fi