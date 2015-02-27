# stage48-member-ranking

How to run:
- put your voting files in `votes` folder
- run `ruby runner.rb`
- have your result in `vote_result.list`

Every voting file:
- has no leading blank lines
- has exactly 20 positive votes (with no blank lines in between)
- has blank line after 20 positive votes (only if you have negative votes)
- has 0 to 5 negative votes, put after the blank line (with no blank lines in between)
- has no trailing blank lines
- has no duplicate members in different lines
- can be in `.txt` or no extension

Every line in voting file:
- has eligible member's name (refer to ithebigc's opening post)
- has to be sorted from your number 1 to number 25 (and don't forget the blank line between the positive votes and negative ones)
- doesn't need that vote value, why bother typing it if computer can do it
- can have line number or not, whatever pleases you

Voting files that don't follow rules above are considered invalid and will not be taken into votes counting.

Example of a valid voting file:
```
Morikawa Ayaka
Fujita Nana
Ichikawa Manami
Ino Miyabi
Iriyama Anna
Iwata Karen
Kawaei Rina
Kojima Haruna
Kojima Natsuki
Maeda Ami
Matsui Sakiko
Muto Tomu
Nakamura Mariko
Nakanishi Chiyori
Nakata Chisato
Nishiyama Rena
Shimazaki Haruka
Takahashi Minami
Takita Kayoko
Taniguchi Megu

Tatsuya Makiho
Abe Maria
Aigasa Moe
Goto Moe
Ishida Haruka
```
