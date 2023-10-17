# IPVA_loneliness
# October 2023
Stata (.do) code pertaining to the paper 'Being Silenced, Loneliness and Being Heard: understanding pathways to Intimate Partner Violence & Abuse in young adults. A mixed-methods study. Authors: Maria Barnes, Eszter Szilassy, Annie Herbert, Jon Heron, Gene Feder, Abigail Fraser, Laura D Howe, Christine Barter.

*The paper was published in 2022, in BMC Public Health: https://bmcpublichealth.biomedcentral.com/articles/10.1186/s12889-022-13990-4

Short abstract: 
Background - International research shows the significance and impact of intimate partner violence and abuse (IPVA) as a public health issue for young adults. There is a lack of qualitative research exploring pathways to IPVA.
Methods - The current mixed-methods study used qualitative interviews and analysis of longitudinal cohort data, to explore experiences of pathways to IPVA. Semi-structured Interviews alongside Life History Calendars were undertaken to explore 17 young women’s (19-25 years) experiences and perceptions of pathways to IPVA in their relationships. Thematic analysis was undertaken. 
Based on themes identified in the qualitative analysis, quantitative analysis was conducted in data from 2127 female and 1145 male participants of the Avon Longitudinal Study of Parents and Children (ALSPAC) birth cohort study. We fitted regression models to assess the association of child maltreatment, parental domestic violence, and peer-to-peer victimisation, by age 12, with loneliness during adolescence (ages 13-14), and the association of loneliness during adolescence with IPVA (age 18-21). Mediation analysis estimated the direct effects of maltreatment on IPVA, and indirect effects through loneliness.
Findings - All women interviewed experienced at least one type of maltreatment, parental domestic violence, or bullying during childhood. Nearly all experienced IPVA and most had been multi-victimised. Findings indicated a circular pathway: early trauma led to isolation and loneliness, negative labelling and being silenced through negative responses to help seeking, leading to increased experiences of loneliness and intensifying vulnerability to further violence and abuse in young adulthood. The pathway was compounded by intersectionality. Potential ways to break this cycle of loneliness included being heard and supported, especially by teachers. Quantitative analysis confirmed an association between child maltreatment and loneliness in adolescence, and an association between loneliness in adolescence and experience of IPVA in young adult relationships. 
Conclusion - It is likely that negative labelling and loneliness mediate pathways to IPVA, especially among more disadvantaged young women. The impact of early maltreatment on young people’s wellbeing and own relationships is compounded by disadvantage, disability and ethnicity. Participants’ resilience was enabled by support in the community.    

The do files relate to the quantitative analyses run for the paper. 

mediation_in_imputed.do is run first, looping over all 20 imputed datasets for women and men separately (imputations were carried out separately), feeding out different effect estimates (controlled direct, natural direct, natural indirect, and total effect) into an Excel file, as well as their standard errors and p-values.  

pooling_mediation_estimates.do is then run to append all these Excel files together and pool betas, standard errors, and p-values.

Thank you to Dr Alice Carter (https://research-information.bris.ac.uk/en/persons/alice-r-carter-2), who shared her Stata scripts with me that pooled mediation estimates in imputed data, that I then updated to fit my own project.
