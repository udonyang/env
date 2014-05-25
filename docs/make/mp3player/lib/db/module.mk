local_src		:= $(wildcard $(subdirectory)/*.[cyl])

$(eval $(call make-library,$(subdirectory)/libdb.a,$(local_src)))
