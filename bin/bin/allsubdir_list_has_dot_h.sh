cat list_of_all_dot_h.txt |tr '\/' '\n'|sed -e "s|^.*\.h$|@|g"|tr '\n' '\/'|tr '@' '\n'|sed -e "s|/./||g"|sort -u



