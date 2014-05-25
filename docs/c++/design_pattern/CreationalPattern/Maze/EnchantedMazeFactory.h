#ifndef ENCHANTED_MAZE_FACTORY_H
#define ENCHANTED_MAZE_FACTORY_H

#include "Maze.h"

class Spell {
};

class EnchantedRoom: public Room {
  public:
    EnchantedRoom(int id, Spell*);
};

class DoorNeedingSpell: public Door {
  public:
    DoorNeedingSpell(Room*, Room*);
};

class EnchantedMazeFactory: public MazeFactory {
  public:
    EnchantedMazeFactory();

    virtual Room *makeRoom(int n) const {
      return new EnchantedRoom(n, castSpell());
    }

    virtual Door* makeDoor(Room *r1, Room *r2) const {
      return new DoorNeedingSpell(r1, r2);
    }
  protected:
    Spell* castSpell() const;
};

#endif // ENCHANTED_MAZE_FACTORY_H
