$(document).ready(function() {
    var rows = parseInt(prompt("Enter the number of rows:"));
    var cols = parseInt(prompt("Enter the number of columns:"));
    var teacherRow = parseInt(prompt("Enter the row index of the teacher's table:"));
    var teacherCol = parseInt(prompt("Enter the column index of the teacher's table:"));
  
    // Initialize the room with empty cells
    var room = [];
    for (var i = 0; i < rows; i++) {
      room[i] = [];
      for (var j = 0; j < cols; j++) {
        room[i][j] = 0; // 0 represents an empty cell
      }
    }
  
    // Place the teacher's table in the room
    room[teacherRow - 1][teacherCol - 1] = 1; // 1 represents the teacher's table
  
    // Place students in the room
    var students = 0;
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        if (room[i][j] == 0 && canReachTeacher(room, i, j, teacherRow - 1, teacherCol - 1)) {
          room[i][j] = 2; // 2 represents a student's seat
          students++;
        }
      }
    }
  
    // Create the GUI of the room
    var grid = $('<div id="grid"></div>');
    for (var i = 0; i < rows; i++) {
      var row = $('<div class="row"></div>');
      for (var j = 0; j < cols; j++) {
        var cell = $('<div class="cell"></div>');
        if (room[i][j] == 1) {
          cell.text("T"); // T represents the teacher's table
        } else if (room[i][j] == 2) {
          cell.text("S"); // S represents a student's seat
        }
        row.append(cell);
      }
      grid.append(row);
    }
    $('body').append(grid);
  
    // Display the number of students and empty cells
    var message = $('<div id="message"></div>');
    message.text("Maximum number of students: " + students + ", Number of empty cells: " + (rows * cols - students - 1));
    $('body').append(message);
  });
  
  // Check if a student can reach the teacher's table from a given cell
  function canReachTeacher(room, row, col, teacherRow, teacherCol) {
    // Check if the cell is not blocked by another student
    if (room[row][col] == 2) {
      return false;
    }
  
    // Check if the student can move horizontally or vertically to reach the teacher's table
    if (row == teacherRow || col == teacherCol) {
      return true;
    }
  
    // Check if the student can move horizontally or vertically to an empty cell that can reach the teacher's table
    for (var i = 0; i < room.length; i++) {
      for (var j = 0; j < room[i].length; j++) {
        if (room[i][j] == 0 && (i == row || j == col) && canReachTeacher(room, i, j, teacherRow, teacherCol)) {
          return true;
        }
      }
    }
  
    return false;
  }