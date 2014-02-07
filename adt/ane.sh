#!/bin/bash

air_bin_dir="/works/AIR4.0/bin"
as_dir="/works/git/ANE-AlertView/as"
src_dir="/works/git/ANE-AlertView/adt"

ane_name="AlertView.ane"
package_name="jp.ng1056.ane.AlertView"
swc_version="23"

#iOSのSWC
${air_bin_dir}/acompc -source-path ${as_dir}/ios -include-classes ${package_name} -swf-version $swc_version -output ${src_dir}/ios/ane.swc
#iOSのSWCの解凍
unzip -o -d ${src_dir}/ios ${src_dir}/ios/ane.swc
#不要ファイル削除
rm ${src_dir}/ios/catalog.xml

#defaultのSWC
${air_bin_dir}/acompc -source-path ${as_dir}/default -include-classes ${package_name} -swf-version ${swc_version} -output ${src_dir}/default/ane.swc
#iOSのSWCの解凍
unzip -o -d ${src_dir}/default ${src_dir}/default/ane.swc
#不要ファイル削除
rm ${src_dir}/default/catalog.xml
rm ${src_dir}/default/ane.swc


#aneファイル作成
${air_bin_dir}/adt -package -target ane ${src_dir}/${ane_name} ${src_dir}/extension.xml -swc ${src_dir}/ios/ane.swc -platform iPhone-ARM -C ${src_dir}/ios . -platform default -C ${src_dir}/default .