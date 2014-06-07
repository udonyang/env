#ifndef BOOMED_MAZE_FACTORY_H
#define BOOMED_MAZE_FACTORY_H

#include "Maze.h"

class BoomedWall: public Wall {
};

class RoomWithBomb: public Room {
};

class BoomedMazeFactroy : public MazeFactory {
  public:
    BoomedMazeFactroy();

    virtual Wall* makeWall() const {
      return new BoombedWall;
    }

    virtual Room* makeRoom(int n) const {
      return new RoomWithBomb(n);
    }
};

#endif // BOOMED_MAZE_FACTORY_H
