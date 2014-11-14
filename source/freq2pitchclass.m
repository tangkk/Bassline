function midipitchClass = freq2pitchclass(f)

midiNumber = round(12.*log2(f./440)+69);
midipitchClass = mod (midiNumber, 12);
midipitchClass = midipitchClass + 1;

% pitchclass = [];
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
% for i = 1:1:length(midipitchClass)
%     switch (midipitchClass(i))
%         case 1
%             pitchclass = [pitchclass, 'C'];
%         case 2
%             pitchclass = [pitchclass, 'C#'];
%         case 3
%             pitchclass = [pitchclass, 'D'];
%         case 4
%             pitchclass = [pitchclass, 'D#'];
%         case 5
%             pitchclass = [pitchclass, 'E'];
%         case 6
%             pitchclass = [pitchclass, 'F'];
%         case 7
%             pitchclass = [pitchclass, 'F#'];
%         case 8
%             pitchclass = [pitchclass, 'G'];
%         case 9
%             pitchclass = [pitchclass, 'G#'];
%         case 10
%             pitchclass = [pitchclass, 'A'];
%         case 11
%             pitchclass = [pitchclass, 'A#'];
%         case 12
%             pitchclass = [pitchclass, 'B'];
%     end
% end