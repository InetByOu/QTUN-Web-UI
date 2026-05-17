php_data_dir="/data/adb/php7"
qtun_worker="/data/adb/QTUN/scripts/webui.sh"
rm_data() {
    rm -rf ${php_data_dir}
    rm -rf ${qtun_worker}
}

rm_data