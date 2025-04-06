base_dir=${HOME}/workspace
opencv_dir=${base_dir}/opencv  # 4.11.0
opencv_contrib_dir=${base_dir}/opencv_contrib  # 4.11.0
cp embindgen.py ${opencv_dir}/modules/js/generator/
cp -r modules ${opencv_contrib_dir}
