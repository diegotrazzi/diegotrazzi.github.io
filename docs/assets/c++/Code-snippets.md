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