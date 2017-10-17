/*
Christopher Stump
ITCS 4102 C++ Lab One
*/

#include<iostream>
#include<cstdlib>
#include<ctime>
#include<stdio.h>
using namespace std;

void matrixFunction();
void isPresent();
void showMenu();
void wordsInString();

//This is the function for calculating the sum of the upper matrix.
void matrixFunction(){
    int size = 0, sum = 0;


    //Ask the user for the size of the matrix.
    do{
        cout << "Please input the size of the square matrix: ";
        cin >> size;
        cin.ignore();
    } while(size < 2);
    cout << "\nThe size of the matrix is: " << size << "\n\n";

    int matrix[size][size];
    srand((unsigned)time(0));
    int randomInt;

    //Fill the matrix with random numbers 1-9.
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            randomInt = (rand()%10);
            matrix[j][i] = randomInt;
            cout << randomInt << " ";
        }
        cout << "\n";
    }

    //Addition of all upper matrix elements.
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
            if(i > j){
                sum += matrix[i][j];
            }
        }
    }
    cout << "\nThe sum of the upper matrix is: " << sum << endl;
    cout << "****************************************************" << endl;
    showMenu();
}

//This is the function for counting how many words are in a string.
void wordsInString(){
    char str[80];

	cout << "Enter a string: ";
	cin.getline(str,80);

	int words = 0; // Holds number of words

	for(int i = 0; str[i] != '\0'; i++)
	{
		if (str[i] == ' ') //Checking for spaces
		{
			words++;
		}
	}

	cout << "The number of words = " << words+1 << endl;
	cout << "****************************************************" << endl;
	showMenu();
}

//This is the function that determines if a substring is present.
void isPresent(){
    string userText, searchText;

    cout << "Enter text: "; //Get the user text.
    getline(cin, userText);

    cout << "Search for text: "; //What they want to search for.
    getline(cin, searchText);
    cout << endl;

    if (userText.find(searchText) != std::string::npos) {
        cout << "YES!" << '\n';
    } else{
        cout << "NO!";
    }
    cout << "****************************************************" << endl;
    showMenu();
}

//This is the function that allows the user to choose which program to use.
void showMenu(){
    //Allow the user to choose which program to use.
    char selection;
    cout << "Choose from the menu below: " << endl;
    cout << "A. Upper Matrix Summation" << endl;
    cout << "B. Count Words In A String" << endl;
    cout << "C. Check For A Substring" << endl;
    cout << "D. Exit Entire Program" << endl;
    cout << "Choice: ";
    cin >> selection;
    cin.ignore();
    cout << "****************************************************" << endl;
    switch(selection)
    {
        case 'a':
        case 'A':
            matrixFunction();
            break;
        case 'b':
        case 'B':
            wordsInString();
            break;
        case 'c':
        case 'C':
            isPresent();
            break;
        case 'd':
        case 'D':
            break;
        default:
            cout << "That is not a valid menu choice.";
    }

}
int main(){
    showMenu();
    return (0);
}
