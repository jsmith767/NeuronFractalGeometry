%Combines two structs 'G1' & 'G2' into 'G'. Think of it like adding G2 to G1.  Leaves fields empty which they both don't share (Be careful with plotting later!)  

function G = combineStruct(G1,G2)
G = G1;
lengthG1 = length(G1);
fn=fieldnames(G2);
    for i=1:length(G2)
        for j=1:length(fn)
              G(lengthG1+i).(fn{j})=G2(i).(fn{j});
        end
    end
end