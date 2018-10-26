#include <cstdio>
#include <cmath>

int main(  ) {
	int in, out;
	bool notFirst = false;
	printf( "\nenter num of \'IN\' pins: " );
	scanf( "%d", &in );
	out = log( (float)in ) / log( 2 ) + 1;
	printf( "num of required \'OUT\' pins is %d\n\n", out );
	for ( int check = 0; check < out; ++check ) {
		printf( "    Result(%d) <= ", check );
		for ( int i = 1; i <= in; ++i ) {
			if ( i & ( 1 << check ) ) {
				if ( notFirst ) {
					printf( " or " );
				}
				notFirst = true;
				printf( "A(%d)", i - 1 );
				break;
			}
		}
		notFirst = false;
		printf( ";\n" );
	}
	printf( "\n" );
	
	return 0;
}
