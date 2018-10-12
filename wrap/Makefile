LOG		= compile.log
#FFLAGS		= -c
.SILENT:

# sources
WSRCF90		=  \
		f90wrap_wrap_symmetry.f90 \

SRCF90		=  \
		../src/wrap_symmetry.f90 \

OBJSF90		= $(SRCF90:.f90=.o)

LBD1 = ../src
LIBS =  $(LBD1)/libcomparestructs.a $(LBD1)/libutils.a \
         $(LBD1)/librational.a $(LBD1)/libcombinatorics.a $(LBD1)/libsym.a 

#IMPORTANT: remember to include the *.o and libraries in the call to create
#the shared library!
all: pre_comp $(OBJSF90)
	-rm _symmetry.so
	echo "Creating shared library _symmetry.so"
	-f2py-f90wrap -c -m _symmetry $(WSRCF90) *.o ${LIBS} -I${LDB1} -I.>> /dev/null
	echo "done."

pre_comp:
	+$(MAKE) -C ../src

$(OBJSF90): %.o: %.f90
	echo "Compiling: $^"
	-$(F90) -fPIC -I${LBD1} $^ -o $@ ${LIBS}>> $(LOG) 2>> $(LOG)
	-$(F90) -fPIC -c -I${LBD1} $^
	echo "done."

clean:
	+$(MAKE) clean -C ../src
	-rm *.o *.mod *.so compile.log
