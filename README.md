# Pregnancy progress report

Shows how far along you are, in the terminal!

## Installation

Copy the functions from the file `functions.sh` to the end of your `.bashrc` file.

Then run the program as
```
$ pregnency_progress 2022-01-01
```
giving it the date of the last period to see how far along the pregnancy is, along with estimated due date.
The format of the date of the period should be something understood by the `date` utility, I recommend `year-month-day`.

My recommendation is to also add these 2 lines to the end of `.bashrc` to see this on every new terminal tab:
```
pregnency_progress 2022-01-01 | cowthink -n | lolcat
echo
```
