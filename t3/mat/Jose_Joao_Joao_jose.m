
% DATA

R=15000
C=1e-5
f=50
A=230
N_coils=19.1
w=2*pi*f
T=1/f
n=1000
N_P=10
VON=0.7

% TIME VECTOR

t=linspace(0,T*N_P,n+1)


% Transformer

A=A/N_coils

Vs=A*cos(w*t)


% FULL WAVE RECTIFIER



Vlim=3*VON

for i=1:length(t) 
	if Vs(i)>Vlim
		Vo(i)=Vs(i);
	elseif Vs(i)<Vlim
		Vo(i)=-Vs(i);

end
end

%{
% PLOT FULL WAVE REC

plot(t, Vo , "g");
hold on;
%}


% ***** ENVELOPE DETECTOR *****


toff1=(1/w)*atan(1/(w*R*C))
t_off=toff1:T/2:T*10




% **** DECAY FUNCTION ****

% OBS: the decay function takes abs() since we're using values that make the cos goes negative


i=1
for j=1:length(t_off)


	if j==1
		
		while t(i)<(T/2)*j
		
			V0exp(i)= abs(A*cos(w*t_off(j))*exp(-(t(i)-t_off(j))/(R*C)));
		
			i=i+1;
		end
		
	elseif j~=1  
		
		while (T/2)*(j-1)<=t(i) && t(i)<(T/2)*j
		
			V0exp(i)= abs(A*cos(w*t_off(j))*exp(-(t(i)-t_off(j))/(R*C)));
		
			i=i+1;
		end
			
	else
	
	end
end			
	
% I had to introduce the last value manually because t would go out of bound

V0exp(i)= abs(A*cos(w*t_off(j))*exp(-(t(i)-t_off(j))/(R*C)))





length(t)
length(Vo)
length(V0exp)
length(t_off)


%{
% *** Plot Decay function ***

plot(t, V0exp)

%}

% ***** Saw-Tooth Function *****


i=1

for j=1:length(t_off)


	if j==1
		
		while t(i)<t_off(j)
		
		vf(i)=Vo(i);
		
		i=i+1;
		end
		
	
		while V0exp(i)>Vo(i) && t(i)>=t_off(j) 
		
		vf(i)=V0exp(i);
		
		i=i+1;
		end
		
		while  t(i)<(T/2)*j
		
		vf(i)=Vo(i);
		
		i=i+1;
		end
		
		
	elseif j~=1 
		
		while t(i)<t_off(j) 
		
		vf(i)=Vo(i);
		
		i=i+1;
		end
		
		while V0exp(i)>Vo(i)
		
		vf(i)=V0exp(i);
		
		i=i+1;
		end
		
		while t(i)<(T/2)*j
		
		vf(i)=Vo(i);
		
		i=i+1;
		end
			
	
		
	else
	end
			
	

end


% I had to introduce the last value manually because t would go out of bound


vf(i)=Vo(i)
length(vf)

% *** Plot Saw-Tooth ***


 plot(t, vf , "r");
 hold on;





% ***** Voltage Regulator *****

N_D=20
r_D=0.7
R2=1000


V_DC=mean(vf)
V_AC=vf-V_DC


V_AC_final=((N_D*r_D)/(N_D*r_D+R2))*V_AC
V_final=V_AC_final+V_DC
V_ripple=max(V_final)-min(V_final)
disp(V_DC)

plot(t, V_final , "r");
hold on;



















