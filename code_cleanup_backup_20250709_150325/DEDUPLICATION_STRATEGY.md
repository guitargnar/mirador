# DEDUPLICATION STRATEGY REPORT
Generated: 2025-07-09 11:04:43

## EXECUTIVE SUMMARY
- Total files in ai_framework_git: 2843
- Total files in mirador: 11216
- Identical files (can be safely removed): 2705
- Files with different versions (need review): 6
- Unique to ai_framework_git: 132
- Unique to mirador: 8505

**Potential space savings: 54.61 MB**

## RECOMMENDED ACTIONS

### 1. SAFE TO DELETE (Identical Files)
These files exist in both directories with identical content.
**Recommendation**: Keep in mirador (active project), delete from ai_framework_git

#### Python Scripts (52 files)
- final_validation.py (2232 bytes)
- mirador_chain_debugger.py (17926 bytes)
- mirador_config_generator.py (23094 bytes)
- mirador_dashboard.py (2447 bytes)
- mirador_memory.py (10074 bytes)
- mirador_model_analyzer.py (26330 bytes)
- mirador_model_diagnostic.py (17314 bytes)
- mirador_performance_tester.py (15485 bytes)
- setup.py (365 bytes)
- track_opportunity.py (3220 bytes)
... and 42 more


#### Shell Scripts (388 files)
- comprehensive_performance_test.sh (1426 bytes)
- create_new_model.sh (1679 bytes)
- evening_optimization_review.sh (553 bytes)
- mirador_conductor.sh (900 bytes)
- monitor_mirador_performance.sh (1214 bytes)
- opportunity_dashboard.sh (1571 bytes)
- prepare_release.sh (1129 bytes)
- quick_opportunity.sh (591 bytes)
- robust_chain_runner_macos.sh (732 bytes)
- validate_production_readiness.sh (2556 bytes)
... and 378 more


#### Modelfiles (174 files)
- decision_enhancer.modelfile (564 bytes)
- digital_asset_curator.modelfile (878 bytes)
- enhanced_agent_fast_v6.modelfile (1270 bytes)
- financial_planning_expert_v7.modelfile (710 bytes)
- louisville_expert_v2.modelfile (1289 bytes)
- matthew_advisor_enhanced.modelfile (1315 bytes)
- opportunity_analyst.modelfile (1123 bytes)
- performance_anxiety_coach.modelfile (778 bytes)
- sales_content_creator.modelfile (1332 bytes)
- touring_readiness_coach.modelfile (935 bytes)
... and 164 more


### 2. REQUIRES MANUAL REVIEW (Different Versions)
These files exist in both directories but have different content.
**Action Required**: Review each file to determine which version to keep

#### robust_chain_runner.sh
- ai_framework_git: 757 bytes
- mirador: 772 bytes
- mirador version is 15 bytes larger

#### README.md
- ai_framework_git: 8082 bytes
- mirador: 16215 bytes
- mirador version is 8133 bytes larger

#### mirador-enhanced
- ai_framework_git: 4197 bytes
- mirador: 595 bytes
- ai_framework_git version is 3602 bytes larger

#### USAGE_INSTRUCTIONS.md
- ai_framework_git: 5348 bytes
- mirador: 6368 bytes
- mirador version is 1020 bytes larger

#### CLAUDE.md
- ai_framework_git: 1996 bytes
- mirador: 6847 bytes
- mirador version is 4851 bytes larger

#### optimization_tests/metrics.jsonl
- ai_framework_git: 322 bytes
- mirador: 161 bytes
- ai_framework_git version is 161 bytes larger


### 3. UNIQUE TO AI_FRAMEWORK_GIT
Files that only exist in ai_framework_git - evaluate if needed

#### Unique Python Scripts
- enhanced_model_analyzer.py (27266 bytes)
- mirador_analyzer.py (12507 bytes)
- mirador_output_analyzer.py (22825 bytes)
- ollama_model_extractor.py (23873 bytes)
- output_analyzer.py (16833 bytes)
... and 2 more


#### Unique Shell Scripts
- analyze_model_versions.sh (2169 bytes)
- quick_opportunity_fixed.sh (444 bytes)

#### Unique Modelfiles
- advocates_meeting_optimizer_modelfile (1314 bytes)
- ai_career_strategist_modelfile (1134 bytes)
- daily_micro_action_modelfile (925 bytes)
- home_sale_optimizer_modelfile (1240 bytes)
- company_ai_advocate_modelfile (1240 bytes)
... and 3 more


### 4. UNIQUE TO MIRADOR
Files that only exist in mirador - these are likely newer additions

- BEST_PRACTICES_INTEGRATION.md (5753 bytes)
- COMPLETE_WORK_INVENTORY.md (5326 bytes)
- FinanceDomainPromptLibrary.md (2942 bytes)
- MATTHEW_INTEGRATION_GUIDE.md (6585 bytes)
- MIRADOR_REAL_WORLD_TEST_SCENARIOS.md (22633 bytes)
- MIRADOR_VISUAL_DOCS.md (3579 bytes)
- MiradorFrameworkActionableImplementationSteps.md (14500 bytes)
- PAIN_POINT_DEMOS.md (7767 bytes)
- README_ENHANCED.md (10723 bytes)
- TEST_RESULTS_ANALYSIS.md (4703 bytes)
- file_reviewer.modelfile (883 bytes)
- message_bus.py (25567 bytes)
- optimize_system.sh (11511 bytes)
- presentation_generator.py (23279 bytes)
- run_web_dashboard.sh (632 bytes)
- webhook_test_server.py (6600 bytes)

## DEDUPLICATION SCRIPT
```bash
#!/bin/bash
# Run this script to remove duplicate files from ai_framework_git
# CAUTION: This will permanently delete files!

echo 'This will delete duplicate files from ai_framework_git'
echo 'Press Ctrl+C to cancel, or Enter to continue'
read

# Create backup directory
backup_dir='/Users/matthewscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)'
echo 'Creating backup at: $backup_dir'
cp -r /Users/matthewscott/ai_framework_git "$backup_dir"

# Remove duplicate files
cd /Users/matthewscott/ai_framework_git
```

## NEXT STEPS
1. **Review Different Versions**: Manually compare the 6 files with different versions
2. **Backup ai_framework_git**: Create a full backup before any deletions
3. **Run Deduplication**: Execute the generated script to remove duplicates
4. **Migrate Unique Files**: Copy any needed unique files from ai_framework_git to mirador
5. **Archive ai_framework_git**: Once verified, archive or remove the old directory