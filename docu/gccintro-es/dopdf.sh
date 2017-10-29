#!/bin/sh
###############################################################################
# NAME: dopdf.sh
# DESCRIPTION: Script to make the final PDF file from .po file
# NOTES: Only work for this case
###############################################################################
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Variables and Constants definitions
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Lists of processed files
FILES_REQUIRED_ES="gccintro.es.po"
FILES_REQUIRED_EN="config-local.texi gccintro.texi"
#FILES_REQUIRED_ES="associations.es.po books.es.po gccintro.es.po rms.es.po"
#FILES_REQUIRED_EN="associations.texi books.texi config-local.texi fdl.texi gccintro.texi rms.texi"
FILES_PO2TEXI="gccintro.es.po"
FILES_TEXI2PDF="gccintro.es.po"
FILES_TEMP="fuzzies.tmp conflicts.tmp overfull.tmp underfull.tmp indextype.tmp"
TMP_EXTENSION=".vr .tp .pg .ky .fn .toc .cp .cps .aux .tmp .tmp1 .tmp2 .tmp3 .tmp4"
# Paths
PATH_WK="."
# Counters for results
CNT_TEXT_GOOD=0
CNT_TEXT_BAD=0
CNT_PDF_GOOD=0
CNT_PDF_BAD=0
#
TRACE_ON=0
ONLY_CLEAN=0
CNST_DV=754
#
CLR_NRML="\\033[0;0m"
CLR_ROJ_H="\\033[1;31m"
CLR_VER_H="\\033[1;32m"
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Definitions additionals functions
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Debug
# PROPOSED: Show debbuging messages to user
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: For clean output in Trace Off
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Debug(){
if [ $TRACE_ON -eq 1 -a "X$1" != "X" ]; then
   echo "$1"
fi
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Usage
# PROPOSED: Show messages to help user
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: Exit with error code
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Usage(){
echo "Usage: $0 [-v|-c]"
echo "   -v: Verbose mode"
echo "   -c: Only clean temporary file"
exit 1
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Check_Index
# PROPOSED: 
# PARAMETERS: 
# RETURN: 
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Check_Index(){
echo "Checking the index entries ..."
CNT_CIX=0
CNT_IDX_CLN=0
CNT_IDX_ML=0
STR_INDEX='#. type: cindex'
egrep "^$STR_INDEX|^msgid \"|^msgstr \"|^\"" gccintro.es.po > indextype.tmp
FLG_IDX=0
FLG_MSG=0
FLG_ML=0
STR_LN_ML=""
while read LINEA; do
   #echo "Leida linea: $LINEA"
   echo $LINEA | grep "^$STR_INDEX" > /dev/null
   if [ $? -eq 0 ]; then
      if [ $FLG_IDX -eq 1 -a $FLG_MSG -eq 1 ]; then
         #echo "Salgo con: [${#TXT_IDX}] $TXT_IDX"
         if [ "X$TXT_IDX" = "X" ];then
            CNT_IDX_CLN=`echo $CNT_IDX_CLN + 1 | bc`
            #echo "Cuento vacio: ${CLR_VER_H}$CNT_IDX_CLN${CLR_NRML}"
         fi
         TXT_IDX=''
         FLG_IDX=0
         FLG_MSG=0
      fi
      CNT_CIX=`echo $CNT_CIX + 1 | bc`
      if [ $TRACE_ON -eq 1 ]; then
         printf "\r  %d ${CLR_VER_H}%d${CLR_NRML} ${CLR_ROJ_H}%d${CLR_NRML}" $CNT_CIX $CNT_IDX_CLN $CNT_IDX_ML
      fi
      FLG_IDX=1
   fi
   echo $LINEA | grep "^msgstr \"" > /dev/null
   if [ $? -eq 0 -a $FLG_IDX -eq 1 ]; then
      TXT_IDX="$TXT_IDX"`echo $LINEA | cut -d'"' -f2`
      #echo "${CLR_ROJ_H}Texto${CLR_NRML}:$TXT_IDX"
      FLG_MSG=1
      FLG_ML=0
   fi
   echo $LINEA | grep "^\"" > /dev/null
   if [ $? -eq 0 -a $FLG_IDX -eq 1 -a $FLG_MSG -eq 1 ]; then
      TXT_IDX="$TXT_IDX"`echo $LINEA | cut -d'"' -f2`
      #echo "${CLR_VER_H}Texto${CLR_NRML}:$TXT_IDX"
      if [ $FLG_ML -eq 0 ]; then
         CNT_IDX_ML=`echo $CNT_IDX_ML + 1 | bc`
         #echo "Cuento multilinea: ${CLR_ROJ_H}$CNT_IDX_ML${CLR_NRML}"
         FLG_ML=1
         STR_LN_ML=`echo "$STR_LN_ML $TXT_IDX"`
      fi
   fi
   echo $LINEA | grep "^msgid \"" > /dev/null
   if [ $? -eq 0 ]; then
      if [ $FLG_IDX -eq 1 -a $FLG_MSG -eq 1 ]; then
         #echo "Salgo con: [${#TXT_IDX}] $TXT_IDX"
         if [ "X$TXT_IDX" = "X" ];then
            CNT_IDX_CLN=`echo $CNT_IDX_CLN + 1 | bc`
            #echo "Cuento vacio: ${CLR_ROJ_H}$CNT_IDX_CLN${CLR_NRML}"
         fi
         TXT_IDX=''
         FLG_IDX=0
         FLG_MSG=0
      fi
      #FLG_IDX=0
   fi
done < indextype.tmp
if [ $TRACE_ON -eq 1 ]; then
   printf "\r Examined ${CLR_ROJ_H}%d${CLR_NRML} entries from index\n" $CNT_CIX
   if [ $CNT_IDX_CLN -ne 0 ]; then
      echo "  Founded ${CLR_ROJ_H}$CNT_IDX_CLN${CLR_NRML} entries cindex empty"
   fi
   if [ $CNT_IDX_ML -ne 0 ]; then
      echo "  Founded ${CLR_ROJ_H}$CNT_IDX_ML${CLR_NRML} entries cindex multiline"
      echo -n "   Look lines: "
      for TEXTO in $STR_LN_ML; do
         printf "\n\t%s: " "$TEXTO"
      done
      printf "\n"
   fi
fi
echo "Checked the index entries."
return 0
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Check_Required
# PROPOSED: Check the requeriments for process
# PARAMETERS: Nothing
# RETURN: 1 if any requeriment isn't satisfied
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Check_Required(){
CNT_REQ=0
echo "Checking required files ..."
for FILE in $FILES_REQUIRED_ES; do
   if [ ! -f $FILE ]; then
      echo " ${CLR_ROJ_H}Requeriment unsolved: $FILE${CLR_NRML}"
      CNT_REQ=`echo "$CNT_REQ"+1 | bc`
   fi
done
for FILE in $FILES_REQUIRED_EN; do
   if [ ! -f $FILE ]; then
      echo " ${CLR_ROJ_H}Requeriment unsolved: $FILE${CLR_NRML}"
      CNT_REQ=`echo "$CNT_REQ"+1 | bc`
   fi
done
if [ $CNT_REQ -ne 0 ]; then
   return 1
fi
echo " Looking for unresolved conflict's"
CNT_CONFLICT=0
STR_CONFLICT='<<<<<<< TREE'
CNT_CONFLICT=`grep "^$STR_CONFLICT" gccintro.es.po | wc -l`
if [ $CNT_CONFLICT -ne 0 ]; then
   echo "  There are ${CLR_ROJ_H}$CNT_CONFLICT${CLR_NRML} conflits unresolved"
   if [ $TRACE_ON -eq 1 ]; then
      echo "  See following:"
      grep -n "^$STR_CONFLICT" gccintro.es.po > conflicts.tmp
      echo -n "   lines: "
      CNT=0
      while read LINEA; do
         LIN=`echo $LINEA | cut -d':' -f1`
         printf "%9s" "[$LIN]"
         CNT=`echo $CNT + 1 | bc`
         if [ `echo $CNT % 9 | bc` -eq 0 ]; then
            printf "\n          "
         fi
      done < conflicts.tmp
      printf "\n"
   fi
fi
echo "Checked required files."
# Another chequer
#Check_Index
#echo ""; echo "Press $CLR_VER_H[INTRO]$CLR_NRML key to continue ..."; read KEY
#
return 0
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Clean_Temporary
# PROPOSED: Clean the all temporary files
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: Clean all except the log file
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Clean_Temporary(){
echo "Cleaning temporal files ..."
for EXT in $TMP_EXTENSION; do
   for FIL in $FILES_TEXI2PDF; do
       NAME=`basename $FIL`
       rm -f ${NAME%%.po}${EXT}
       Debug " Deleted: ${NAME%%.po}${EXT}"
   done
done
for FILE in $FILES_TEMP; do
    rm -f ${FILE}
    Debug " Deleted: ${FILE}"
done
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Do_Texi_Files
# PROPOSED: Generate the texi files from the original .po files
# PARAMETERS: Nothing
# RETURN: In global variables
# REMARKS: Run po4a-translate utilitie
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Do_Texi_Files(){
echo "Creating texi files ..."
for FIL in $FILES_PO2TEXI; do
   NAME=`basename $FIL`
   echo " Obtaining the texi of $NAME: ${NAME%%.po}.texi"
   Debug " Command: $ po4a-translate -f texinfo -m ${NAME%%.es.po}.texi -p ${NAME} -l ${NAME%%.po}.texi -k 0.15"
   po4a-translate -f texinfo -m ${NAME%%.es.po}.texi -p ${NAME} -l ${NAME%%.po}.texi -k 0.15
   # Detect mistakes
   if [ $? -eq 0 -a -f ${NAME%%.po}.texi ]; then
      echo "  Texi of $NAME Ok!"
      CNT_TEXT_GOOD=`echo "$CNT_TEXT_GOOD"+1 | bc`
   else
      echo "  Ko Texi of $NAME?" 
      CNT_TEXT_BAD=`echo "$CNT_TEXT_BAD"+1 | bc`
   fi
done
echo "Created texi files."
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Add_Encoding_Spanish
# PROPOSED: Insert the lines to encoding correctly for spanish language
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: Rudimentary
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Add_Encoding_Spanish(){
#
# The encoding @documentencoding "UTF-8"
# The language @documentlanguage "es"
#
echo "Creating new file gccintro.es.texi ..."
LIN_INI=`grep -n 'start of header' gccintro.es.texi | cut -d: -f1`
LIN_FIN=`grep -n 'end of header' gccintro.es.texi | cut -d: -f1`
LIN_TOT=`wc -l gccintro.es.texi | cut -d' ' -f1`
head -${LIN_INI} gccintro.es.texi > gccintro.es.tmp1
head -`echo "${LIN_FIN} - 1" | bc` gccintro.es.texi | tail -n`echo "${LIN_FIN} - ${LIN_INI} - 1" | bc`> gccintro.es.tmp2
echo "@documentencoding UTF-8" > gccintro.es.tmp3
echo "@documentlanguage es"  >> gccintro.es.tmp3
tail -n`echo "${LIN_TOT} - ${LIN_FIN} + 1" | bc` gccintro.es.texi > gccintro.es.tmp4
# Compose the final file
cat gccintro.es.tmp1 > gccintro.es.texi
cat gccintro.es.tmp2 >> gccintro.es.texi
cat gccintro.es.tmp3 >> gccintro.es.texi
cat gccintro.es.tmp4 >> gccintro.es.texi
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Adjust_Tables
# PROPOSED: Make som adjust to texi 
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Adjust_Tables(){
#
MULTITABLE_STR="@multitable @columnfractions"
NEW_COLFRACTION=".05 .41 .41"
#
echo " Adjustement to tables ..."
CNT_TAB=0
grep -n "$MULTITABLE_STR" gccintro.es.texi | while read LINEA; do
  #echo "Lei:$LINEA";
  LN=`echo "$LINEA" | cut -d: -f1`
  TC=`echo "$LINEA" | cut -d: -f2`
  echo "  In line ${CLR_VER_H}$LN${CLR_NRML} found table: ${CLR_ROJ_H}$TC${CLR_NRML}"
  cat gccintro.es.texi | sed -e "s/$TC/$MULTITABLE_STR $NEW_COLFRACTION/g" > gccintro.es.tmp
  mv gccintro.es.tmp gccintro.es.texi
  echo "   table adjusted"
done
echo " Tables adjusted."
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Do_Adjust_to_Ikiwiki
# PROPOSED: Make some adjusts to texi 
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Do_Adjust_to_Ikiwiki(){
#
echo "Procesing gccintro.es.texi ..."
# Counting lines
CNT_LN=`wc -l gccintro.es.texi | cut -d' ' -f1`
#
# Cut first
tail -`echo $CNT_LN -1 | bc` gccintro.es.texi > gccintro.es.texi.tmp
mv gccintro.es.texi.tmp gccintro.es.texi
#
echo "Procesed gccintro.es.texi."
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Do_Adjust_to_Spanish
# PROPOSED: Make some adjusts to texi 
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Do_Adjust_to_Spanish(){
#
echo "Procesing gccintro.es.texi ..."
# Encoding to spanish
Add_Encoding_Spanish
#
# Adjustement table of character ASCII
Adjust_Tables
#
echo "Procesed gccintro.es.texi."
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Do_PDF_File
# PROPOSED: Generate the PDF files from the .texi files
# PARAMETERS: Nothing
# RETURN: In global variables
# REMARKS: Run texi2pdf utilitie
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Do_PDF_File(){
echo "Generating PDF files ..."
for FIL in $FILES_TEXI2PDF; do
   NAME=`basename $FIL`
   echo " Obtaining the PDF of $NAME:${NAME%%.po}.pdf"
   Debug " Command: $ texi2pdf ${NAME%%.po}.texi"
   texi2pdf ${NAME%%.po}.texi
   if [ $? -eq 0 -a -f ${NAME%%.po}.pdf ]; then
      echo "  PDF of $NAME Ok!"
      CNT_PDF_GOOD=`echo "$CNT_PDF_GOOD"+1 | bc`
   else
      echo "  Ko PDF of $NAME?" 
      CNT_PDF_BAD=`echo "$CNT_PDF_BAD"+1 | bc`
   fi
done
echo "Generated PDF files."
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Check_Result
# PROPOSED: Look for warning in the process
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: 
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Check_Result(){
echo "Checking results ..."
CNT_INDEF=0
CNT_INDEF=`grep Undefined gccintro.es.log | sort | uniq | wc -l`
echo " Looking for anomalies"
if [ $CNT_INDEF -ne 0 ]; then
   echo "  There are ${CLR_ROJ_H}$CNT_INDEF${CLR_NRML} items undefined in texi file"
   echo "  See following:"
   grep Undefined gccintro.es.log | sort | uniq
fi
echo " Looking for fuzzies"
CNT_FUZZI=0
CNT_FUZZI=`grep fuzzy *.es.po | cut -d: -f2 | grep '^#, ' | wc -l`
if [ $CNT_FUZZI -ne 0 ]; then
   echo "  There are ${CLR_ROJ_H}$CNT_FUZZI${CLR_NRML} items fuzzy in po file"
   if [ $TRACE_ON -eq 1 ]; then
      echo "  See following:"
      echo -n "   archives: "
      CNT=0
      grep -n '^#, ' *.es.po | grep fuzzy > fuzzies.tmp
      FILE_OLD=""
      while read LINEA; do
         FILE=`echo $LINEA | cut -d':' -f1`
         LINE=`echo $LINEA | cut -d':' -f2`
         if [ "X$FILE_OLD" = "X$FILE" ]; then
            printf "%9s" "[$LINE]"
            CNT=`echo $CNT + 1 | bc`
            if [ `echo $CNT % 7 | bc` -eq 0 ]; then
               printf "\n%21s" ' '
            fi
         else
            printf "\n${CLR_VER_H}%19s${CLR_NRML}: " "$FILE"
            printf "%9s" "[$LINE]"
            CNT=1
         fi
         FILE_OLD=$FILE
      done < fuzzies.tmp
      printf "\n"
   fi
fi
echo " Looking for paragraph untranslated"
CNT_UNTRANS=0
CNT_UNTRANS=`grep '^msgstr ""' *.es.po | cut -d: -f2 | wc -l`
if [ $CNT_UNTRANS -ne 0 ]; then
   CNT_REAL=`echo $CNT_UNTRANS - $CNST_DV | bc`
   echo "  There are ${CLR_ROJ_H}$CNT_REAL${CLR_NRML} paragraph untranslated"
fi
echo " Looking for Overfull's"
CNT_OVERFULL=0
CNT_OVERFULL=`grep '^Overfull' gccintro.es.log | cut -d' ' -f10 | wc -l`
if [ $CNT_OVERFULL -ne 0 ]; then
   echo "  There are ${CLR_ROJ_H}$CNT_OVERFULL${CLR_NRML} lines Overfull"
   if [ $TRACE_ON -eq 1 ]; then
      echo "  See following lines in texi file:"
      grep '^Overfull' gccintro.es.log | cut -d' ' -f10 | sort -n > overfull.tmp
      echo -n "   lines: "
      CNT=0
      while read LINEA; do
         printf "%13s" "[$LINEA]"
         CNT=`echo $CNT + 1 | bc`
         if [ `echo $CNT % 5 | bc` -eq 0 ]; then
            printf "\n          "
         fi
      done < overfull.tmp
      printf "\n"
   fi
fi
echo " Looking for Underfull's"
CNT_OVERFULL=0
CNT_OVERFULL=`grep '^Underfull' gccintro.es.log | cut -d' ' -f9 | wc -l`
if [ $CNT_OVERFULL -ne 0 ]; then
   echo "  There are ${CLR_ROJ_H}$CNT_OVERFULL${CLR_NRML} lines Underfull"
   if [ $TRACE_ON -eq 1 ]; then
      echo "  See following lines in texi file:"
      grep '^Underfull' gccintro.es.log | cut -d' ' -f9 | sort -n > underfull.tmp
      echo -n "   lines: "
      CNT=0
      while read LINEA; do
         printf "%13s" "[$LINEA]"
         CNT=`echo $CNT + 1 | bc`
         if [ `echo $CNT % 5 | bc` -eq 0 ]; then
            printf "\n          "
         fi
      done < underfull.tmp
      printf "\n"
   fi
fi
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# FUNCTION: Show_Result
# PROPOSED: Show the results of the process
# PARAMETERS: Nothing
# RETURN: N/A
# REMARKS: In global variables
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Show_Result(){
echo "Results obtained:"
echo " Texi Files:"
echo "  Corrects: ${CLR_VER_H}$CNT_TEXT_GOOD${CLR_NRML}"
echo "    Failed: ${CLR_ROJ_H}$CNT_TEXT_BAD${CLR_NRML}"
echo " PDF Files:"
echo "  Corrects: ${CLR_VER_H}$CNT_PDF_GOOD${CLR_NRML}"
echo "    Failed: ${CLR_ROJ_H}$CNT_PDF_BAD${CLR_NRML}"
}
#
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Main program
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
INST=`date "+%Y%m%d-%H%M%S"`
if [ $# -eq 1 ]; then
   if [ "$1" = "-v" ]; then
      TRACE_ON=1
   elif [ "$1" = "-c" ]; then
      ONLY_CLEAN=1
   else
      Usage
   fi
elif [ $# -eq 2 -a "$1" = "-v" -a "$2" = "-c" -o $# -eq 2 -a "$2" = "-v" -a "$1" = "-c" ]; then
   TRACE_ON=1
   ONLY_CLEAN=1
elif [ $# -gt 2 ]; then 
   Usage
fi
echo "Let's go: $INST"
cd $PATH_WK
if [ $ONLY_CLEAN -eq 0 ]; then
   Check_Required
   if [ $? -ne 0 ]; then
      echo "Stoping process"
      return 1
   fi
   #echo ""; echo "Press $CLR_VER_H[INTRO]$CLR_NRML key to continue ..."; read KEY
   Do_Texi_Files
   if [ $CNT_TEXT_BAD -ne 0 ]; then
      echo "Errors ocurred when generating texi files"
      echo "Stoping process"
      return 1
   fi
   #
   #echo ""; echo "Press $CLR_VER_H[INTRO]$CLR_NRML key to continue ..."; read KEY
   Do_Adjust_to_Spanish
   Do_Adjust_to_Ikiwiki
   #
   #echo ""; echo "Press $CLR_VER_H[INTRO]$CLR_NRML key to continue ..."; read KEY
   Do_PDF_File
   if [ $CNT_PDF_BAD -ne 0 ]; then
      echo "Errors ocurred when generating PDF files"
      echo "Stoping process"
      return 1
	   fi
   #echo ""; echo "Press $CLR_VER_H[INTRO]$CLR_NRML key to continue ..."; read KEY
   Check_Result
fi
#
echo No invocada la funcion Clean_Temporary
#
if [ $ONLY_CLEAN -eq 0 ]; then
   Show_Result
fi
#
INST=`date "+%Y%m%d-%H%M%S"`
echo "Finish: $INST"
exit 0
###############################################################################
#
###############################################################################
