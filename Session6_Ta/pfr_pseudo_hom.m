function pfr_pseudo_hom = pfr_pseudo_hom(t,y)
global Stoichiometry deltaH mw SpecificHeatP Viscosity ...
    TubeDiameter CatalystDensity U ...
    VoidFraction MoltenSaltsTemperature G ParticleDiameter NS NR 
for i=1:NS
    mol(i) = y(i)/mw(i);

end
MolarFraction = mol./sum(mol);
Temperature = y(end-1);
Pressure_bar = y(end);
Pressure_Pa = Pressure_bar* 1e5;

DensityMolarGas = 1e-3 * Pressure_Pa;
mw_av = 0;      % Avg. MW.
for i=1:NS
    mw_av = mw_av + MolarFraction(i)*mw(i);
end

DensityMassGas = DensityMolarGas*mw_av; %kg/m3
SuperFicialVelocity = G/DensityMassGas;

%Kinetics Scheme:

ReactionK(1) = exp(19.837 - 18636/Temperature);
ReactionK(2) = exp(18.970 - 14394/Temperature);
ReactionK(3) = exp(20.860 - 15803/Temperature);

ReactionRate(1) = ReactionK(1)* Pressure_bar^2 * MolarFraction(2) * MolarFraction(3); %kmol/kgcat/hr
ReactionRate(2) = ReactionK(2)* Pressure_bar^2 * MolarFraction(2) * MolarFraction(4); %kmol/kgcat/hr
ReactionRate(3) = ReactionK(3)* Pressure_bar^2 * MolarFraction(2) * MolarFraction(4); %kmol/kgcat/hr


end