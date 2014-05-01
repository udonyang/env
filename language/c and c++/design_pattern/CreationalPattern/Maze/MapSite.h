#ifndef MAP_SITE_H
#define MAP_SITE_H

enum Direction {North, South, East, West};

class MapSite {
  public:
    virtual void enter() = 0;
};

class Room: public MapSite {
  public:
    Room(int id);

    MapSite* getSide(Direction) const;
    void setSide(Direction, MapSite*);

    virtual void enter();
  
  private:
    static const char NSIDE = 4;
    MapSite* sides[NSIDE];
    int id;
};

class Wall: public MapSite {
  public:
    Wall();
    virtual void enter();
};

class Door: public MapSite {
  public: 
    Door(Room* = 0, Room* = 0);

    virtual void enter();
    Room* otherSideFrom(Room*);

  private:
    Room* room1, room2;
    bool isOpen;
};

#endif // MAP_SITE_H
