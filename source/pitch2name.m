function name = pitch2name(pitch)

name = [];
% A = 69, mod (69, 12) = 9, thus
% C 1
% C# 2
% D 3
% D# 4
% E 5
% F 6
% F# 7
% G 8
% G# 9
% A 10
% A# 11
% B 12
    switch (pitch)
        case -1
            name = 'minor';
        case 0
            name = 'major';
        case 1
            name = 'C';
        case 2
            name = 'C#';
        case 3
            name = 'D';
        case 4
            name = 'D#';
        case 5
            name = 'E';
        case 6
            name = 'F';
        case 7
            name = 'F#';
        case 8
            name = 'G';
        case 9
            name = 'G#';
        case 10
            name = 'A';
        case 11
            name = 'A#';
        case 12
            name = 'B';
    end