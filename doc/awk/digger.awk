BEGIN{
	print \
				"Got " ARGV[ARGC-2] " argument\n"\
				"Read from "  "\n"\
				"Write to " ENVIRON[i] "and " ENVIRON[o] "\n"\
				"Analyzing...\n"
	}
/Input/{
	print $0 >> "test.out"
	}
END{
	print "Analyze complete\n"
	}
