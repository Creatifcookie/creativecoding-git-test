/*
** Cyclist Count by Year At Selected Commuter Locations
** data from:
** https://data.cityofnewyork.us/d/m6ar-24vj?category=Transportation&view_name=Cyclist-Count-by-Year-At-Selected-Commuter-Locatio
** your task: create a unique data visualization.
** for more information on working with data in Processing, see: https://processing.org/tutorials/data/
*/

String[] headers;
int[][] data; 

void setup(){
   size(1000,500);
  // load csv file into String array
  String [] lines = loadStrings("Cyclist_Count_by_Year_At_Selected_Commuter_Locations.csv");
 
  //split the first line into an array and load it into our global headers array
  headers = split(lines[0], ",");
  //println(headers);
  
  //create a temporary 2D String array.
  //we'll think of it as a 28 row x 9 column matrix
  String[][] tempData = new String[lines.length-1][headers.length];
  
  //Curious to see how many rows and columns we're loading into our tempData?
  //uncomment this line below.
  //println( lines.length-1 + " rows by " + headers.length + " cols.");
  
  //loop through each of the subsequent lines after the header row and
  //assign each to the row index of our tempData matrix 
  for(int i = 1; i < lines.length; i++){
    tempData[i-1] = split(lines[i], ",");//assigns an array to each temData row
   
  }
  
  //construct our global data matrix.
  //we can also think of this as a 28 row x 9 col matrix
  data = new int[tempData.length][tempData[0].length];
  
  //loop through each of the rows and columns of our tempData matrix.
  //a.k.a. nested for loops.
  for(int i = 0; i < tempData.length; i++){ //for each row
    for(int j = 0; j < tempData[i].length; j++){ //and for each col
      
      /*
      * since our raw data has "" (quotes) around each entry,
      * we need a way to remove them.  Let's use the handy split() method.
      * The delimiter is a " (double quotes) but we need to escape it using a forward slash.
      * for more info on escape characters in Java see:
      * http://stackoverflow.com/questions/1367322/what-are-all-the-escape-characters-in-java
      * example: split(""1024"", "\"") becomes --> {"", "1024", ""}  
      */
      String[] tempCellValue = split(tempData[i][j], "\"");
      // our middle entry contains the data, so we write tempCellValue[1]
      // handle our blank data OR data containing "N/A" by replacing with 0s 
      if(tempCellValue[1].equals("") || tempCellValue[1].equals("N/A")){
        data[i][j] = 0;
        
        
      }
      else {
        data[i][j] = Integer.parseInt(tempCellValue[1]);
        //println(tempCellValue);
      }
    }
  }
}
void draw(){
  // draw something awesome with the data matrix and headers array
  // to access individual data cells all you have to do is call data[row][col],
  // where row is an int row number, and col is an int column number
  
  //i want to make a bar graph plotting the # of cyclists per year
  //i want to declare the number of bars
  //then plot rectangles based of the data[row (1++)][column (2)]
  background (0);
  int x = 10; //starting x coordinate of the bar graph over 10 to make it look more centered.

 
    
    
    for (int i=0; i<data.length; i++){ //loops through the rows to pull each data point from the brooklyn bridge
    rect(x, 20 ,25, (data[i][2])/6); //defines the rectangle starting at the height = # of cyclists
    colorMode(HSB);
    fill(data[i][2] / 10, 255, 255);//makes the colors change based on hue saturation brightness color mode
    //fill(28, data[i][2] / 10, 238); //makes the rectangles aquamarine lessing the opacity (updated to change the color range as "i" increases
   
   x+=35;//moves over the x coordinate by 20 to start th next rectangle bar
  }
  textSize(32); //sets text size
  text("Cyclist Data Visualization over the Brooklyn Bridge by Years", 0, 450); //adds title to the bottom
  fill(0, 102, 153);//add color property
  for (int i=0; i<data.length; i++){//adds the years from the array over the # of cyclists bar graph
  textSize(10);
  fill(255);
  text(data[i][0], x-980, 15 );
 x+=35 ;
  }
 fill(28, 231, 238);

}



