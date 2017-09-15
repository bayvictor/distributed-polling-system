cd /home/vhuang/src/test/llvm/lex_yacc



#btyacc is a hacked version of the original Berkeley "byacc". The main change to byacc is the addition of backtracking code, allowing you to try both alternatives in case of shift-reduce or reduce-reduce conflicts. As long as no backtracking takes place, speed is comparable to bison. 
 apt-get source byacc-j #- Berkeley YACC parser generator extended to generate Java code
 apt-get source btyacc #- Backtracking parser generator based on byacc
 apt-get source byacc #- public domain Berkeley LALR Yacc parser generator
 apt-get source kimwitu #- Compiler development tool, complementary to lex and yacc
 apt-get source ml-yacc #- Parser generator for Standard ML
 apt-get source perl-byacc #- Berkeley LALR parser generator, Perl version

 apt-get source bison #- YACC-compatible parser generator
apt-get source libbison-dev #- YACC-compatible parser generator #- development library
apt-get source bison++ #- Generate a parser in c or c++ from BNF notation
 apt-get source bisonc++ #- Bison-style parser generator for C++

