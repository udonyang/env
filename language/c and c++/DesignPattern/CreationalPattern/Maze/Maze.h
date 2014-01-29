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
