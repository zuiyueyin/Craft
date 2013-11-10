#ifndef _db_h_
#define _db_h_

#include "map.h"

#define DB_NAME "craft.db"

int db_init();
void db_close();
void db_save_state(double x, double y, double z, double rx, double ry);
int db_load_state(double *x, double *y, double *z, double *rx, double *ry);
void db_insert_block(int p, int q, int x, int y, int z, int w);
int db_select_block(int x, int y, int z);
void db_update_chunk(Map *map, int p, int q);

#endif
