# define throwing ID
throw <- c("Rock", "Paper", "Scissors", "End Play")
throw_id <- c(1,2,3,0)

# reset score
win <- 0
loss <- 0
draw <-0

print("Let's play Pao-Ying-Chub(Paper/Rock/Scissor)")

while(TRUE){
  print("Select your action!")
  print("1 = Rock 2 = Paper 3 = Scissors 0 = End Play")
# prompt for a throw
  you <- as.numeric(readLines("stdin", n=1))
# random a throw
  #replicate(50, sample(1:3, size=1))
  cpu <- sample(1:3, size=1)
  
# check if input is only 1,2 or 3  
  if(!(you %in% throw_id)){
    print("Select only 1, 2, or 3 only!")
  }
# check if user want to exit then summarize score
  else if(you == 0){
    print(paste("Win", win, "times"))
    print(paste("Draw", draw, "times"))
    print(paste("Loss", loss, "times"))
    print(paste("Comeback to play later, Bye!"))
    break
  }
# check if it's a draw game
  else if((you == 1 & cpu == 1)|
          (you == 2 & cpu == 2)|
          (you == 3 & cpu == 3)){
    print(paste("You choose", throw[you]))
    print(paste("CPU choose", throw[cpu]))
    print("It's a DRAW game!")
    draw <- draw + 1
  }
# check if it's a win game
  else if ((you == 1 & cpu == 3)|
           (you == 2 & cpu == 1)|
           (you == 3 & cpu == 2)){
    print(paste("You choose", throw[you]))
    print(paste("CPU choose", throw[cpu]))
    print("You Win!")
    win <- win + 1
  }
# check if it's a loss game
  else{
    print(paste("You choose", throw[you]))
    print(paste("CPU choose", throw[cpu]))
    print("You Loss!")
    loss <- loss + 1
  }
}