# Code snippets

## Strings

### Read CVS file

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
using namespace std;

int main() {
  //add code below this line
string path = "student/labs/fileslab2.csv";
vector<string> nums;

try {
  ifstream file;
  string read;
  file.open(path);
  if (!file) {
    throw runtime_error("File failed to open.");
  }
  while (getline(file, read)) {
    stringstream ss(read);
    while (getline(ss, read, ',')) {
      nums.push_back(read);
    }
  }
  file.close();
}
  
catch (exception& e) {
  cerr << e.what() << endl;
}

for (int i = 0; i < nums.size(); i+=3) {
  int total = 0;
  for (int j = 0; j < 3; j++) {
    total += stoi(nums.at(i + j));
  }
  cout << "Total: " << total << endl;
}
  
  //add code above this line
  
  return 0;
  
}
```

### Find and Replace text

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

void FindAndReplace(string& lines, string burma, string myanmar) {
  // Get the first string occurrence
  size_t pos = lines.find(burma);
  // Repeat till end of string
  while( pos != string::npos) {
    // Replace this occurrence of Sub String
    lines.replace(pos, burma.size(), myanmar);
    // Get the next occurrence from the current position
    pos = lines.find(burma, pos + myanmar.size());
  }
}

int main(int argc, char** argv) {

////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  
  //add code below this line
  try {
  ifstream file;
  string read;
  file.open(path);
  if (!file) {
    throw runtime_error("File not found.");
  }
  while (getline(file, read)) {
    FindAndReplace(read, "Burma", "Myanmar");
    cout << read;
  }

  file.close();

  } catch (exception& e){
    cerr << e.what() << endl;
  }
  
  //add code above this line
  
  return 0;
  
}
```

### Exercise 01: Number of characters in a file

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv) {

////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  
  //add code below this line
  try{
  ifstream file;
  string read;
  int num_lines = 0;
  int num_characters = 0;
  file.open(path);
  if (!file) {
    throw runtime_error("File not found");
  }

  while(getline(file, read)){
    num_lines++;
    num_characters += read.length();
  }

  cout << num_lines << " line(s)" << endl;
  cout << num_characters << " character(s)" << endl;

  } catch (exception& e){
    cerr << e.what();
  }

  
  //add code above this line
  
  return 0;
  
}
```

### Exercise 02: Sum of columns

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv) {

////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  
  //add code below this line

  try {
  
  ifstream file;
  string read;
  int sum_col1 = 0;
  int sum_col2 = 0;
  int sum_col3 = 0;
  int sum_col4 = 0;
  vector<int> values;

  file.open(path);
  if (!file){
    throw runtime_error("file not found");
  }
  while (getline(file, read)){
    stringstream ss(read);
    while(getline(ss, read, ',')) {
      values.push_back(stoi(read));
    }
  }


  for (int i = 0; i < values.size(); i++) {
    if (i % 4 == 0) {
      sum_col1 += values.at(i);
      // cout << "Value at 1" << endl;
    } else if (i % 4 == 1) {
      sum_col2 += values.at(i);
      // cout << "Value at 2" << endl;
    } else if (i % 4 == 2) {
      sum_col3 += values.at(i);
      // cout << "Value at 3" << endl;
    } else if (i % 4 == 3) {
      sum_col4 += values.at(i); 
      // cout << "Value at 4" << endl;
  }
  }


  cout << sum_col1 / 3 << " ";
  cout << sum_col2 / 3 << " ";
  cout << sum_col3 / 3 << " ";
  cout << sum_col4 / 3 << endl;

  file.close();
  
  }
  catch (exception& e) {
  cerr << e.what() << endl;
}

  //add code above this line
  
  return 0;
  
}
```

### A program that reads a text file and prints the contents in reverse order.

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv) {
////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  //add code below this line
  try {
  ifstream file;
  string read;
  vector<string> values;
  file.open(path);
  if (!file){
    throw runtime_error("file not found");
  }
  while (getline(file, read)){
    stringstream ss(read);
    while(getline(ss, read)) {
      values.push_back(read);
    }
  }
  for (int i = values.size() - 1; i > 0; i--) {
    cout << values.at(i) << " ";
  }
  file.close();
  }
  catch (exception& e) {
  cerr << e.what() << endl;
}
  //add code above this line
  return 0;
}
```

### Exercise 04: reads a tab ('\t') delimited CSV file and prints the name of the oldest person in the file

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv) {

////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  
  //add code below this line
  try {
  ifstream file;
  string read;
  int oldest_age = 0;
  string oldest_person;
  vector<string> values;
  file.open(path);
  if (!file){
    throw runtime_error("file not found");
  }
  while (getline(file, read)){
    stringstream ss(read);
    while(getline(ss, read, '\t')) {
      values.push_back(read);
    }
  }
  for (int i = 0; i < values.size(); i++) {
    // cout << values.at(i) << " ";
    if (i % 3 == 1) {
      if (oldest_age < stoi(values.at(i))) {
        oldest_age = stoi(values.at(i));
        oldest_person = values.at(i-1);
      }
    }
  }
  cout << "The oldest person is " << oldest_person << "." << endl;
  file.close();
  }
  catch (exception& e) {
  cerr << e.what() << endl;
}
  //add code above this line
  return 0;
}
```

### Exercise 05: Reads CSV file and prints all of the cities which reside in the Southern Hemisphere.

```c++
#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv) {

////////// DO NOT EDIT! //////////
  string path = argv[1];        //
//////////////////////////////////  
  //add code below this line
  try {
  ifstream file;
  string read;
  vector<string>cities_in_southern;
  vector<string>values;
  file.open(path);
  if (!file){
    throw runtime_error("file not found");
  }
  file.ignore(39, '\n');
  while (getline(file, read)){
    stringstream ss(read);
    while(getline(ss, read, ',')) {
      values.push_back(read);
      // cout << read << " ";
    }
  }

  for (int i = 0; i < values.size(); i++) {
    if (i % 4 == 2) {
      if (stoi(values.at(i)) < 0) {
          // cout << values.at(i-2);
        cities_in_southern.push_back(values.at(i-2));
      }
    }
  }

  cout << "The following cities are in the Southern Hemisphere: ";
  for (int i = 0; i < cities_in_southern.size(); i++){
  cout << cities_in_southern.at(i);
  if (i < cities_in_southern.size()-1) {
    cout << ", ";
  } else {
    cout << ".";
  }
  }
  file.close();
  }
  catch (exception& e) {
  cerr << e.what() << endl;
}
  //add code above this line
  
  return 0;
  
}
```

### Recursive Tree

```c++
////////// DO NOT EDIT HEADER! //////////
#include <iostream>                    //
#include "CTurtle.hpp"                 //
#include "CImg.h"                      //
using namespace cturtle;               //
using namespace std;                   //
/////////////////////////////////////////

/**
 * @param branch_length An integer 
 * @param angle The angle of degree
 * @param t A Turtle object
 * @return A drawing symbolizing a tree branch
 */

void RecursiveTree(int branch_length, int angle, Turtle& t) {
  
  //add function definitions below
  
if (branch_length > 5) {
    t.forward(branch_length);
    t.right(angle);
    RecursiveTree(branch_length - 15, angle, t);
    t.left(angle * 2);
    RecursiveTree(branch_length - 15, angle, t);
    t.right(angle);
    t.backward(branch_length);
}
  
  //add function definitions above
  
}

int main(int argc, char** argv) {
  
  //add code below this line
  
  TurtleScreen screen(400, 300);
  Turtle tina(screen);
  RecursiveTree(45, 20, tina);
  
  //add code above this line
  
  screen.exitonclick();
  return 0;
  
}
```

### The Hilbert Curve

```c++
////////// DO NOT EDIT HEADER! //////////
#include <iostream>                    //
#include "CTurtle.hpp"                 //
#include "CImg.h"                      //
using namespace cturtle;               //
using namespace std;                   //
/////////////////////////////////////////

/**
 * @param dist, integer 
 * @param rule, integer
 * @param angle, integer
 * @param depth, integer
 * @param t, Turtle
 * @return A drawing of the Hilbert Curve
 */
void Hilbert(int dist, int rule, int angle, int depth, Turtle& t) {
  
  //add function definitions below
  if (depth > 0) {
  if (rule == 1) {
  //rule1 code
  t.left(angle);
  Hilbert(dist, 2, angle, depth - 1, t);
  t.forward(dist);
  t.right(angle);
  Hilbert(dist, 1, angle, depth - 1, t);
  t.forward(dist);
  Hilbert(dist, 1, angle, depth - 1, t);
  t.right(angle);
  t.forward(dist);
  Hilbert(dist, 2, angle, depth - 1, t);
  t.left(angle);
}

  if (rule == 2) {
  //rule2 code
  t.right(angle);
  Hilbert(dist, 1, angle, depth - 1, t);
  t.forward(dist);
  t.left(angle);
  Hilbert(dist, 2, angle, depth - 1, t);
  t.forward(dist);
  Hilbert(dist, 2, angle, depth - 1, t);
  t.left(angle);
  t.forward(dist);
  Hilbert(dist, 1, angle, depth - 1, t);
  t.right(angle);
}
  }
  
  //add function definitions above
  
}

int main(int argc, char** argv) {
  
  //add code below this line
  
  TurtleScreen screen(400, 300);
  Turtle tina(screen);
  tina.speed(TS_FASTEST);
  Hilbert(5, 1, 90, 5, tina);
  //add code above this line
 
  screen.exitonclick();
  return 0;
  
}
```

### Exercie 1 Recursion

```c++
#include <iostream>
using namespace std;

//add function definitions below this line

int RecursiveSum(int i) {
  if (i == 0) {
    return 0;
  } else {
    return (i + RecursiveSum(i - 1));
  }
}

//add function definitions above this line

int main(int argc, char** argv) {
  cout << RecursiveSum(stoi(argv[1])) << endl;
  return 0;
}
```


## Getter and setter

### Exercise 1

```c++
#include <iostream>
using namespace std;

//add class definitions below this line

class Fruit {
  public:
    Fruit(string n, string c) : name(n), color(c) {}

    string GetName() {
      return name;
    }

    void SetName(string s) {
      name = s;
    }

    string GetColor() {
      return color;
    }

    void SetColor(string s) {
      color = s;
    }

  private:
    string name;
    string color;
};

//add class definitions above this line


int main() {
  
  //DO NOT EDIT CODE BELOW THIS LINE

  Fruit fruit("apple", "red");
  cout << fruit.GetName() << endl;
  cout << fruit.GetColor() << endl;
  fruit.SetName("orange");
  fruit.SetColor("orange");
  cout << fruit.GetName() << endl;
  cout << fruit.GetColor() << endl;

  //DO NOT EDIT CODE ABOVE THIS LINE
  
  return 0;
  
}
```

### Exercise 2 (Correct)

```c++
#include <iostream>
using namespace std;

//add class definitions below this line

class Watch {
public:

    Watch(string m, string mo, int d, int w, string ma) : manufacturer(m), model(mo), diameter(d), water_resistance(w), material(ma) {}

    // Setters
    void SetManufacturer(const string& m) { manufacturer = m; }
    void SetModel(const string& m) { model = m; }
    void SetDiameter(int d) { diameter = d; }
    void SetWaterResistance(int w) { water_resistance = w; }
    void SetMaterial(const string& m) { material = m; }

    // Getters
    string GetManufacturer() const { return manufacturer; }
    string GetModel() const { return model; }
    int GetDiameter() const { return diameter; }
    int GetWaterResistance() const { return water_resistance; }
    string GetMaterial() const { return material; }

    // Summary method
    void Summary() const {
        cout << "Manufacturer: " << manufacturer << endl;
        cout << "Model: " << model << endl;
        cout << "Diameter: " << diameter << " mm" << endl;
        cout << "Water Resistance: " << water_resistance << " m" << endl;
        cout << "Material: " << material << endl;
    }

private:
    string manufacturer;
    string model;
    int diameter;
    int water_resistance;
    string material;
};

//add class definitions above this line


int main() {
  
  //DO NOT EDIT CODE BELOW THIS LINE

  Watch my_watch("Omega", "Speedmaster", 42, 50, "steel");
  cout << my_watch.GetManufacturer() << endl;
  cout << my_watch.GetModel() << endl;
  cout << my_watch.GetDiameter() << endl;
  cout << my_watch.GetWaterResistance() << endl;
  cout << my_watch.GetMaterial() << endl;
  my_watch.SetManufacturer("Rolex");
  my_watch.SetModel("Explorer");
  my_watch.SetDiameter(36);
  my_watch.SetWaterResistance(60);
  my_watch.SetMaterial("gold");
  my_watch.Summary();

  //DO NOT EDIT CODE ABOVE THIS LINE
  
  return 0;
  
}
```

### Exercise 3 (Correct)

```c++
#include <iostream>
using namespace std;

class Song {
  
  //add class definitions below this line
    public:
      Song(string a, string t, string al) : artist(a), title(t), album(al) {}

      string GetArtist(){ return artist; }
      string GetTitle(){ return title; }
      string GetAlbum(){ return album; }
      int GetPlayCount(){ return play_count; }
      double GetPayRate(){ return pay_rate; }
      double GetMoneyEarned(){ return money_earned; }

      void SetArtist(string s){ artist = s; }
      void SetTitle(string s){ title = s; }
      void SetAlbum(string s){ album = s; }
      
      void Play(int times){
        for (int i = 0; i < times; i++) {
          UpdatePlayCount();
          UpdateMoneyEarned();
        }
      }
      
      void Stats(){
        cout << artist << endl;
        cout << title << endl;
        cout << album << endl;
        cout << play_count << endl;
        cout << pay_rate << endl;
        cout << money_earned << endl;
      }
  //add class definitions above this line
  
//DO NOT EDIT CODE BELOW THIS LINE

  private:
    string artist;
    string title;
    string album;
    int play_count = 0;
    const double pay_rate = 0.001;
    double money_earned = 0;
    
    void UpdatePlayCount() {
      play_count++;
    }
  
    void UpdateMoneyEarned() {
      money_earned = play_count * pay_rate;
    }
};

int main() {

  Song my_song("Led Zeppelin", "Ten Years Gone", "Physical Graffiti");
  cout << my_song.GetArtist() << endl;
  cout << my_song.GetTitle() << endl;
  cout << my_song.GetAlbum() << endl;
  cout << my_song.GetPlayCount() << endl;
  cout << my_song.GetPayRate() << endl;
  cout << my_song.GetMoneyEarned() << endl;
  my_song.SetArtist("Michael Jackson");
  my_song.SetTitle("Beat It");
  my_song.SetAlbum("Thriller");
  my_song.Play(1000000);
  my_song.Stats();
  
  return 0;
  
}

//DO NOT EDIT CODE ABOVE THIS LINE
```

### Exercise 4 (Correct)

```c++
#include <iostream>
#include <iomanip>
using namespace std;

//add class definitions below this line
class Atm {
  
  public:
    Atm(){
      money = 0;
    }

    double GetMoney() {
      return money;
    }

    void Deposit(double amount) {
      if (amount > 0) {
        money += amount;
      } else {
        cout << "You cannot deposit a negative or 0 amount of money." << endl;
      }
    }

    void Withdraw(double amount){
      if (amount > 0) {
        if (amount > money) {
          cout << "You do not have enough funds to withdraw that amount." << endl;
        } else {
          money -= amount;
        }
      } else {
        cout << "You cannot withdraw a negative or 0 amount of money." << endl;
      }
    }

  private:
    double money;
};
//add class definitions above this line


int main() {
  
  //DO NOT EDIT CODE BELOW THIS LINE

  Atm my_atm;
  my_atm.Deposit(-10);
  my_atm.Deposit(100.02);
  my_atm.Withdraw(-20);
  my_atm.Withdraw(200);
  my_atm.Withdraw(50.22);
  cout << fixed; //prevents value from being truncated or rounded
  cout << setprecision(2); //sets value to 2 decimal places
  cout << my_atm.GetMoney() << endl;

  //DO NOT EDIT CODE ABOVE THIS LINE
  
  return 0;
  
}
```

### Exercise 5 (Correct)

```c++
#include <iostream>
using namespace std;

//add class definitions below this line
class CardBinder {
public:
    // Constructor
    CardBinder() : gold_card(0), silver_card(0) {}

    // Getter functions
    int GetGold() const { return gold_card; }
    int GetSilver() const { return silver_card; }
    int GetTotal() const { return gold_card + silver_card; }

    // Add Gold Cards
    void AddGold(int amount) {
        if (amount <= 0) {
            cout << "You cannot add a negative or 0 amount of cards." << endl;
        } else if (gold_card + silver_card + amount > 20) {
            cout << "You do not have enough binder room." << endl;
        } else {
            gold_card += amount;
        }
    }

    // Remove Gold Cards
    void RemoveGold(int amount) {
        if (amount <= 0) {
            cout << "You cannot remove a negative or 0 amount of cards." << endl;
        } else if (gold_card - amount < 0) {
            cout << "You do not have enough gold cards to remove." << endl;
        } else {
            gold_card -= amount;
        }
    }

    // Add Silver Cards
    void AddSilver(int amount) {
        if (amount <= 0) {
            cout << "You cannot add a negative or 0 amount of cards." << endl;
        } else if (gold_card + silver_card + amount > 20) {
            cout << "You do not have enough binder room." << endl;
        } else {
            silver_card += amount;
        }
    }

    // Remove Silver Cards
    void RemoveSilver(int amount) {
        if (amount <= 0) {
            cout << "You cannot remove a negative or 0 amount of cards." << endl;
        } else if (silver_card - amount < 0) {
            cout << "You do not have enough silver cards to remove." << endl;
        } else {
            silver_card -= amount;
        }
    }

private:
    int gold_card;
    int silver_card;
};
//add class definitions above this line


int main() {
  
  //DO NOT EDIT CODE BELOW THIS LINE

  CardBinder cb;
  cb.AddGold(21);
  cb.AddGold(11);
  cb.AddSilver(-4);
  cb.AddSilver(8);
  cb.RemoveGold(12);
  cb.RemoveGold(4);
  cb.RemoveSilver(-2);
  cb.RemoveSilver(6);
  cout << cb.GetGold() << endl;
  cout << cb.GetSilver() << endl;
  cout << cb.GetTotal() << endl;
  

  //DO NOT EDIT CODE ABOVE THIS LINE
  
  return 0;
  
}
```

## Code inheritance

### Exercise 1 (Correct)

```c++
#include <iostream>
using namespace std;

//DO NOT EDIT code below this line

class CelestialBody {
  public:
    CelestialBody(double s, double m, string c, string n) {
      size = s;
      mass = m;
      atm_composition = c;
      name = n;
    }

    double GetSize() {
      return size;
    }

    double GetMass() {
      return mass;
    }

    string GetComposition() {
      return atm_composition;
    }

    string GetName() {
      return name;
    }
  
  private:
    double size;
    double mass;
    string atm_composition;
    string name;
};

//DO NOT EDIT code above this line

//add class definitions below this line

//DO NOT EDIT//////////////////////////////
class Satellite : public CelestialBody { //
///////////////////////////////////////////
public:
  Satellite(double s, double m, string c, string n, string h) : CelestialBody( s,  m,  c,  n) {
    host_planet = h;
  }

  string GetHostPlanet(){
    return host_planet;
  }

private:
  string host_planet;
  
};  

//DO NOT EDIT///////////////////////////
class Planet : public CelestialBody { //
////////////////////////////////////////
public:
  Planet(double s, double m, string c, string n, string h) : CelestialBody( s,  m,  c,  n) {
    host_star = h;
  }

  string GetHostStar(){
    return host_star;
  }

private:
  string host_star;
  
};
  
  

//add class definitions above this line

int main() {
  
  //DO NOT EDIT code below this line

  Satellite s(2651, 3716, "helium", "Moon", "Earth");
  Planet p(5349, 8910, "nitrogen", "Earth", "Sun");
  Satellite s2(3199, 13452, "nitrogen", "Titan", "Saturn");
  Planet p2(82713, 56834, "hydrogen", "Saturn", "Sun");
  cout << "Satellite name = " << s.GetName() << ", size = " << s.GetSize();
  cout << ", mass = " << s.GetMass() << ", atmospheric composition = " << s.GetComposition();
  cout << ", host planet = " << s.GetHostPlanet() << endl;
  cout << "Planet name = " << p.GetName() << ", size = " << p.GetSize();
  cout << ", mass = " << p.GetMass() << ", atmospheric composition = " << p.GetComposition();
  cout << ", host star = " << p.GetHostStar() << endl;
  cout << "Satellite name = " << s2.GetName() << ", size = " << s2.GetSize();
  cout << ", mass = " << s2.GetMass() << ", atmospheric composition = " << s2.GetComposition();
  cout << ", host planet = " << s2.GetHostPlanet() << endl;
  cout << "Planet name = " << p2.GetName() << ", size = " << p2.GetSize();
  cout << ", mass = " << p2.GetMass() << ", atmospheric composition = " << p2.GetComposition();
  cout << ", host star = " << p2.GetHostStar() << endl;

  //DO NOT EDIT code above this line
  
  return 0;
  
}
```

### Exercise 2 (Correct)

```c++
#include <iostream>
using namespace std;

//DO NOT EDIT code below this line

class Book {
  public:
    Book(string t, string a, string g) {
      title = t;
      author = a;
      genre = g;
    }

    string GetTitle() {
      return title;
    }

    void SetTitle(string new_title) {
      title = new_title;
    }

    string GetAuthor() {
      return author;
    }

    void SetAuthor(string new_author) {
      author = new_author;
    }

    string GetGenre() {
      return genre;
    }
  
    void SetGenre(string new_genre) {
      genre = new_genre;
    }
  
  private: 
    string title;
    string author;
    string genre;
};

//DO NOT EDIT code above this line

//add class definitions below this line

//DO NOT EDIT////////////////////
class BlogPost : public Book { //
/////////////////////////////////

public:
  BlogPost(string t, string a, string g, string web, int w_count, int p_views) : Book( t,  a,  g) {
    website = web;
    word_count = w_count;
    page_views = p_views;
  }

    int GetWordCount() {
      return word_count;
    }

    int GetPageViews() {
      return page_views;
    }

    string GetWebsite() {
      return website;
    }

private:
  string website;
  int word_count;
  int page_views;
};
//add class definitions above this line

int main() {
  
  //DO NOT EDIT code below this line

  BlogPost my_post("Hot Summer Trends", "Amy Gutierrez", "fashion", "Vogue", 2319, 2748);
  cout << my_post.GetTitle() << endl;
  cout << my_post.GetAuthor() << endl;
  cout << my_post.GetGenre() << endl;
  cout << my_post.GetWebsite() << endl;
  cout << my_post.GetWordCount() << endl;
  cout << my_post.GetPageViews() << endl;
  BlogPost codio("Adopting Codio", "Anh Le", "computer science", "Codio", 2500, 5678);
  cout << codio.GetTitle() << endl;
  cout << codio.GetAuthor() << endl;
  cout << codio.GetGenre() << endl;
  cout << codio.GetWebsite() << endl;
  cout << codio.GetWordCount() << endl;
  cout << codio.GetPageViews() << endl;

  //DO NOT EDIT code above this line
  
  return 0;
  
}
```

### Exercise 3 (Correct)

```c++
#include <iostream>
using namespace std;

//DO NOT EDIT code below this line

class Parent1 {
  public:
    string Identify() {
      return "This function is called from Parent1";
    }
};

class Parent2 : public Parent1 {
  public:
    string Identify() {
      return "This function is called from Parent2";
    }
};

//DO NOT EDIT code above this line

//add class definitions below this line

class Child : public Parent2 {
  public:
  string Identify() {
      return "This function is called from Child";
    }

  string Identify2() {
      return Parent2::Identify();
    }

  string Identify3() {
      return Parent1::Identify();
    }
};

//add class definitions above this line

int main() {
  
  //DO NOT EDIT code below this line

  Child c;
  cout << c.Identify() << endl;
  cout << c.Identify2() << endl;
  cout << c.Identify3() << endl;
  
  //DO NOT EDIT code above this line
  
  return 0;
  
}
```

### Exercise 4 (Correct)

```c++
#include <iostream>
using namespace std;

//DO NOT EDIT code below this line

class PiggyBank {
  public:
    PiggyBank(int o, int f, int tn, int tw) {
      ones = o;
      fives = f;
      tens = tn;
      twenties = tw;
    }
  
    int GetOnes() {
      return ones;
    }
  
    void SetOnes(int new_ones) {
      ones = new_ones;
    }
  
    int GetFives() {
      return fives;
    }
  
    void SetFives(int new_fives) {
      fives = new_fives;
    }
  
    int GetTens() {
      return tens;
    }
  
    void SetTens(int new_tens) {
      tens = new_tens;
    }
  
    int GetTwenties() {
      return twenties;
    }
  
    void SetTwenties(int new_twenties) {
      twenties = new_twenties;
    }
  
  private:
    int ones;
    int fives;
    int tens;
    int twenties;
};

//DO NOT EDIT code above this line

//add class definitions below this line

//DO NOT EDIT/////////////////////
class Cash : public PiggyBank { //
//////////////////////////////////
  
  public:

    Cash(int o, int f, int tn, int tw) : PiggyBank(o, f, tn, tw) {}

    void DisplayBills(){
      cout << "One-dollar bill: " << GetOnes() << endl;
      cout << "Five-dollar bill: " << GetFives() << endl;
      cout << "Ten-dollar bill: " << GetTens() << endl;
      cout << "Twenty-dollar bill: " << GetTwenties() << endl;
    }

    void DisplayCashTotal() {
      cout << "Total amount: " << GetOnes() + GetFives()*5 + GetTens()*10 + GetTwenties()*20 << endl;
    }
  
  
  
};  
//add class definitions above this line

int main() {
  
  //DO NOT EDIT code below this line

  Cash c(1, 2, 3, 4);
  c.DisplayBills();
  c.DisplayCashTotal();
  Cash c2(9, 8, 7, 6);
  c2.DisplayBills();
  c2.DisplayCashTotal();

  //DO NOT EDIT code above this line
  
  return 0;
  
}
```

### Exercise 5 (Incorrect)

```c++
#include <iostream>
using namespace std;

//DO NOT EDIT code below this line

class Person {
  public:
    Person(string n, string a) {
      name = n;
      address = a;
    }
  
    string GetName() {
      return name;
    }

    void SetName(string new_name) {
      name = new_name;
    }

    string GetAddress() {
      return address;
    }

    void SetAddress(string new_address) {
      address = new_address;
    }

    string Info() {
      return name + " lives at " + address + ".\n";
    }
  
  private:
    string name;
    string address;
};

//DO NOT EDIT code above this line

//add class definitions below this line

//DO NOT EDIT/////////////////////////////////////////////////
class CardHolder : public Person {                          //
  public:                                                   //
    CardHolder(string n, string a, int an) : Person(n, a) { //
      account_number = an;                                  //
      balance = 0;                                          //
      credit_limit = 5000;                                  //
    }                                                       //
//////////////////////////////////////////////////////////////
    void Sale(double sale_price) {
      balance += sale_price;
    }

    void Payment(double amount) {
      balance -= amount;
    }

    double GetBalance() {
      return balance;
    }

  private:
    int account_number;
    double balance;
    double credit_limit;
};

//DO NOT EDIT/////////////////////////////////////////////////////////////
class PlatinumClient : public CardHolder {                              //
  public:                                                               //
    PlatinumClient(string n, string a, int an) : CardHolder(n, a, an) { //
      cash_back = 0.02;                                                 //
      rewards = 0;                                                      //
    }                                                                   //
//////////////////////////////////////////////////////////////////////////

  double GetRewards(){
    return rewards;
  }

  private:
    double cash_back;
    double rewards;
  
};  
//add class definitions above this line

int main() {
  
  //DO NOT EDIT code below this line

  PlatinumClient pc("Sarah", "101 Main Street", 123364);
  pc.CardHolder::Sale(100);
  cout << pc.GetRewards() << endl;
  pc.Sale(100);
  cout << pc.GetRewards() << endl;
  cout << pc.GetBalance() << endl;
  pc.Payment(50);
  cout << pc.GetBalance() << endl;
  cout << pc.Info() << endl;

  //DO NOT EDIT code above this line
  
  return 0;
  
}
```