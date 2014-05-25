#ifndef MAZE_H
#define MAZE_H

#include "MapSite.h"
#include <unordered_map>

class Maze {
  public:
    Maze();

    void addRoom(Room*);
    Room *roomId(int) const;

  private:
    std::unordered_map<int, Room*> id2Room;
};

class MazeFactory {
  public:
    MazeFactory();

    virtual Maze* makeMaze() const {
      return new Maze;
    };
    virtual Wall* makeWall() const {
      return new Wall;
    };
    virtual Room* makeRoom(int n) const {
      return new Room(n);
    };
    virtual Door* makeDoor(Room *r1, Room *r2) const {
      return new Door(r1, r2);
    };
};

#endif // MAZE_H
