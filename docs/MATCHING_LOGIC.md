# Matching Logic

## Current Matching Model
The portal uses a basic transparent scoring model designed for university-project explainability.

## Inputs
- Candidate profile skills
- Candidate location
- Candidate experience summary text
- Job required skills
- Job location and job type

## Score Composition
Score is computed out of 100 using weighted components:

- Skill match: up to 70
- Experience/context match: up to 20
- Location match: up to 10

Approximate formula:

Score = SkillMatch + ExperienceMatch + LocationMatch

## Behavior Notes
- Suggestions are generated for student/alumni users.
- Higher scores are shown first.
- Explanatory text is provided in UI for recommendation transparency.
- Dashboard tracks "new matches" based on score thresholds.

## Threshold Guidance
- 75-100: Strong match
- 50-74: Moderate match
- <50: Lower relevance

## Current Limitations
- Heuristic text overlap approach; not ML-based.
- No historical personalization/learning feedback loop.
- No asynchronous score cache yet.
