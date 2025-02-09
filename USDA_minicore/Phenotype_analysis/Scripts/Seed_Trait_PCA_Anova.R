# Select numeric features for PCA
pheno <- phenotypes %>%
  dplyr::rename(Seed.Weight = seed_weight, Sub.Population = `sub-population`) %>%
  dplyr::select(Eccentricity, Solidity, Longest.Path, CH.Vertices, CH.Area, 
                Major.Axis, Minor.Axis, Seed.Weight, Perimeter, Area)

# Perform PCA
pcat_result <- prcomp(pheno, center = TRUE, scale. = TRUE)

# Add sub-population info to pheno
pheno$Sub.Population <- phenotypes$`sub-population`

# Extract PCA loadings (variable contributions)
loadings <- as.data.frame(pcat_result$rotation[, 1:2])  # Extract loadings for PC1 & PC2
loadings$variable <- rownames(loadings)  # Add variable names for labeling

# Scale arrows for better visibility
arrow_scale <- 1  # Adjust as needed
loadings <- loadings %>%
  mutate(PC1 = PC1 * arrow_scale, PC2 = PC2 * arrow_scale)

# PCA plot with points and arrows
seed_PCA <- autoplot(pcat_result, data = pheno, colour = 'Sub.Population', size = 2) +
  ggtitle(" ") +
  theme_light() +
  # Add arrows to represent variable contributions (loadings)
  geom_segment(data = loadings, aes(x = 0, y = 0, xend = PC1, yend = PC2), 
               arrow = arrow(type = "closed", length = unit(0.1, "inches")), 
               color = "darkred", linewidth = 0.2) +
  # Add labels for arrows
  geom_text(data = loadings, aes(x = PC1, y = PC2, label = variable), 
            vjust = -1, hjust = -0.5, color = "black", size = 6) +
  # Increase axis label size
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels size
    axis.title = element_text(size = 18, face = "bold"),
    legend.text = element_text(size = 14)  # Increase legend label size# Increase axis titles size
  )

# Display the plot
seed_PCA

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Seed_PCA.tiff", 
       plot = seed_PCA, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large


#------------------------------------------------------------
# Anova for Eccenricity
colnames(phenotypes)[colnames(phenotypes) == "sub-population"] <-"Sub.Populaton"

anova <- aov(Eccentricity ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

Ecc_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Eccentricity), quant = quantile(Eccentricity, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
Ecc_Tk$cld <- cld$Letters
Ecc_Tk$trait <- "Eccentricity"

print(Ecc_Tk)

#------------------------------------------------------------
# Anova for solidity

anova <- aov(Solidity ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

Sol_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Solidity), quant = quantile(Solidity, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
Sol_Tk$cld <- cld$Letters
Sol_Tk$trait <- "Solidity"

print(Sol_Tk)

#------------------------------------------------------------
# Anova for Area
anova <- aov(Area ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

Area_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Area), quant = quantile(Area, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
Area_Tk$cld <- cld$Letters
Area_Tk$trait <- "Area"

print(Area_Tk)

#------------------------------------------------------------
# Anova for CH.Vertices
anova <- aov(CH.Vertices ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

CHV_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(CH.Vertices), quant = quantile(CH.Vertices, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
CHV_Tk$cld <- cld$Letters

CHV_Tk$trait <- "CH.Vertices"

print(CHV_Tk)

#------------------------------------------------------------
# Anova for CH.Area
anova <- aov(CH.Area ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

CHA_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(CH.Area), quant = quantile(CH.Area, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
CHA_Tk$cld <- cld$Letters

CHA_Tk$trait <- "CH.Area"

print(CHA_Tk)

#------------------------------------------------------------
# Anova for Minor.Axis
anova <- aov(Minor.Axis ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

MinA_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Minor.Axis), quant = quantile(Minor.Axis, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
MinA_Tk$cld <- cld$Letters

MinA_Tk$trait <- "Minor.Axis"

print(MinA_Tk)

#------------------------------------------------------------
# Anova for Major Axis
anova <- aov(Major.Axis ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

MajA_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Major.Axis), quant = quantile(Major.Axis, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
MajA_Tk$cld <- cld$Letters

MajA_Tk$trait <- "Major.Axis"

print(MajA_Tk)

#------------------------------------------------------------
# Anova for Perimeter

anova <- aov(Perimeter ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

Per_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Perimeter), quant = quantile(Perimeter, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
Per_Tk$cld <- cld$Letters

Per_Tk$trait <- "Perimeter"

print(Per_Tk)

#------------------------------------------------------------
# Anova for longest path

anova <- aov(Longest.Path ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

Lon_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(Longest.Path), quant = quantile(Longest.Path, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
Lon_Tk$cld <- cld$Letters

Lon_Tk$trait <- "Longest.Path"

print(Lon_Tk)

#------------------------------------------------------------
# Anova for seed weight

anova <- aov(seed_weight ~ Sub.Populaton, data = phenotypes)
summary(anova)

# Tukey's test
tukey <- TukeyHSD(anova)
print(tukey)

# compact letter display
cld <- multcompLetters4(anova, tukey)
print(cld)

# Make sure column names are unique
colnames(phenotypes) <- make.names(colnames(phenotypes), unique = TRUE)

SW_Tk <- phenotypes %>%
  dplyr::group_by(Sub.Populaton) %>%
  dplyr::summarise(mean = mean(seed_weight), quant = quantile(seed_weight, probs = 0.75)) %>%
  dplyr::arrange(desc(mean))


# extracting the compact letter display and adding to the Tk table
cld <- as.data.frame.list(cld$Sub.Populaton)
SW_Tk$cld <- cld$Letters

SW_Tk$trait <- "Seed.Weight"

print(SW_Tk)

#------------------------------------------------------------
# Join all trait anova dataframes for plotting

# List of Dataframes
Trait_Anova <- list(Ecc_Tk, Sol_Tk, Area_Tk, CHV_Tk, CHA_Tk, MinA_Tk, MajA_Tk, Per_Tk, Lon_Tk, SW_Tk)

# Row-bind all dataframes in the list
All_trait_anova <- bind_rows(Trait_Anova)

#------------------------------------------------------------
# Plot Anova for Solidity
solid_anova <- ggplot(phenotypes, aes(Sub.Populaton, Solidity)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Solidity") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = Sol_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

solid_anova

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Solidity_Anova.tiff", 
       plot = solid_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Eccentricity
ecc_anova <- ggplot(phenotypes, aes(Sub.Populaton, Eccentricity)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Eccentricity") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = Ecc_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

ecc_anova

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Eccentricity_Anova.tiff", 
       plot = ecc_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Area
area_anova <- ggplot(phenotypes, aes(Sub.Populaton, Area)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Area") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = Area_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

area_anova

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Area_Anova.tiff", 
       plot = area_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for CH Vertices
CHV_anova <- ggplot(phenotypes, aes(Sub.Populaton, CH.Vertices)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="CH.Vertices") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = CHV_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

CHV_anova

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/CH.Verices_Anova.tiff", 
       plot = CHV_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#----------------------------------------------------------
# Plot Anova for CH Area
CHA_anova <- ggplot(phenotypes, aes(Sub.Populaton, CH.Area)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="CH.Area") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = CHA_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

CHA_anova

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/CH.Area_Anova.tiff", 
       plot = CHA_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#-----------------------------------------------------------
# Plot Anova for Minor Axis
Min_anova <- ggplot(phenotypes, aes(Sub.Populaton, Minor.Axis)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Minor.Axis") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = MinA_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

Min_anova 

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Minor_Axis_Anova.tiff", 
       plot = Min_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Major Axis
Maj_anova <- ggplot(phenotypes, aes(Sub.Populaton, Major.Axis)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Major.Axis") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = MajA_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

Maj_anova 

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Major_Axis_Anova.tiff", 
       plot = Maj_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Minor Axis
per_anova <- ggplot(phenotypes, aes(Sub.Populaton, Perimeter)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Perimeter") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = Per_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

per_anova 

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Perimeter_Anova.tiff", 
       plot = per_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Minor Axis
lon_anova <- ggplot(phenotypes, aes(Sub.Populaton, Longest.Path)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Longest.Path") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = Lon_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

lon_anova 

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Longest.Path_Anova.tiff", 
       plot = lon_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large

#------------------------------------------------------------
# Plot Anova for Seed Weight
sw_anova <- ggplot(phenotypes, aes(Sub.Populaton, seed_weight)) + 
  geom_boxplot(aes(fill = factor(..middle..)), show.legend = FALSE) +
  labs(x="Subpopulation", y="Seed.Weight") +
  theme_bw() + 
  theme(
    axis.text = element_text(size = 18),  # Increase axis tick labels
    axis.title = element_text(size = 20, face = "bold"),  # Increase axis titles
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5)  # Increase title size and center it
  ) +
  geom_text(data = SW_Tk, aes(x = Sub.Populaton, y = quant, label = cld), size = 8, vjust=-1, hjust =-1) +
  scale_fill_brewer(palette = "Blues")

sw_anova 

ggsave("USDA_minicore/Phenotype_analysis/Results_Phenotype_Analysis/Seed_Weight_Anova.tiff", 
       plot = sw_anova, 
       device = "tiff", 
       width = 5, height = 4, 
       dpi = 300, scale = 1)  # Increase scale factor to keep text large
