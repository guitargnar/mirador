#!/bin/bash
# Safe deletion script for duplicate files in ai_framework_git
# Generated: 2025-07-09 11:04:43

# Safety checks
if [ ! -d '/Users/userscott/ai_framework_git' ]; then
    echo 'Error: ai_framework_git directory not found'
    exit 1
fi

# Create backup
backup_dir="/Users/userscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup at: $backup_dir"
cp -r /Users/userscott/ai_framework_git "$backup_dir"

# Delete duplicate files
cd /Users/userscott/ai_framework_git
deleted_count=0

if [ -f 'sales_content_creator.modelfile' ]; then
    rm 'sales_content_creator.modelfile'
    echo 'Deleted: sales_content_creator.modelfile'
    ((deleted_count++))
fi
if [ -f 'prepare_release.sh' ]; then
    rm 'prepare_release.sh'
    echo 'Deleted: prepare_release.sh'
    ((deleted_count++))
fi
if [ -f 'quick_opportunity.sh' ]; then
    rm 'quick_opportunity.sh'
    echo 'Deleted: quick_opportunity.sh'
    ((deleted_count++))
fi
if [ -f 'repo_tree.txt' ]; then
    rm 'repo_tree.txt'
    echo 'Deleted: repo_tree.txt'
    ((deleted_count++))
fi
if [ -f 'PROJECT_COMPLETE.md' ]; then
    rm 'PROJECT_COMPLETE.md'
    echo 'Deleted: PROJECT_COMPLETE.md'
    ((deleted_count++))
fi
if [ -f 'monitor_mirador_performance.sh' ]; then
    rm 'monitor_mirador_performance.sh'
    echo 'Deleted: monitor_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'doc_index.txt' ]; then
    rm 'doc_index.txt'
    echo 'Deleted: doc_index.txt'
    ((deleted_count++))
fi
if [ -f 'PROJECT_FILE_CATALOG.md' ]; then
    rm 'PROJECT_FILE_CATALOG.md'
    echo 'Deleted: PROJECT_FILE_CATALOG.md'
    ((deleted_count++))
fi
if [ -f 'mirador_model_analyzer.py' ]; then
    rm 'mirador_model_analyzer.py'
    echo 'Deleted: mirador_model_analyzer.py'
    ((deleted_count++))
fi
if [ -f 'create_new_model.sh' ]; then
    rm 'create_new_model.sh'
    echo 'Deleted: create_new_model.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_conductor.sh' ]; then
    rm 'mirador_conductor.sh'
    echo 'Deleted: mirador_conductor.sh'
    ((deleted_count++))
fi
if [ -f 'comprehensive_performance_test.sh' ]; then
    rm 'comprehensive_performance_test.sh'
    echo 'Deleted: comprehensive_performance_test.sh'
    ((deleted_count++))
fi
if [ -f 'mirador-ez' ]; then
    rm 'mirador-ez'
    echo 'Deleted: mirador-ez'
    ((deleted_count++))
fi
if [ -f 'evening_optimization_review.sh' ]; then
    rm 'evening_optimization_review.sh'
    echo 'Deleted: evening_optimization_review.sh'
    ((deleted_count++))
fi
if [ -f 'robust_chain_runner_macos.sh' ]; then
    rm 'robust_chain_runner_macos.sh'
    echo 'Deleted: robust_chain_runner_macos.sh'
    ((deleted_count++))
fi
if [ -f 'validate_production_readiness.sh' ]; then
    rm 'validate_production_readiness.sh'
    echo 'Deleted: validate_production_readiness.sh'
    ((deleted_count++))
fi
if [ -f 'opportunity_dashboard.sh' ]; then
    rm 'opportunity_dashboard.sh'
    echo 'Deleted: opportunity_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'weekly_strategic_deep_dive.sh' ]; then
    rm 'weekly_strategic_deep_dive.sh'
    echo 'Deleted: weekly_strategic_deep_dive.sh'
    ((deleted_count++))
fi
if [ -f 'opportunity_scorer.sh' ]; then
    rm 'opportunity_scorer.sh'
    echo 'Deleted: opportunity_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'decision_enhancer.modelfile' ]; then
    rm 'decision_enhancer.modelfile'
    echo 'Deleted: decision_enhancer.modelfile'
    ((deleted_count++))
fi
if [ -f 'create_brand_specialists.sh' ]; then
    rm 'create_brand_specialists.sh'
    echo 'Deleted: create_brand_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'digital_asset_curator.modelfile' ]; then
    rm 'digital_asset_curator.modelfile'
    echo 'Deleted: digital_asset_curator.modelfile'
    ((deleted_count++))
fi
if [ -f 'opportunity_analyst.modelfile' ]; then
    rm 'opportunity_analyst.modelfile'
    echo 'Deleted: opportunity_analyst.modelfile'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v6.modelfile' ]; then
    rm 'enhanced_agent_fast_v6.modelfile'
    echo 'Deleted: enhanced_agent_fast_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'weekly_review_dashboard.sh' ]; then
    rm 'weekly_review_dashboard.sh'
    echo 'Deleted: weekly_review_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'script_map.txt' ]; then
    rm 'script_map.txt'
    echo 'Deleted: script_map.txt'
    ((deleted_count++))
fi
if [ -f 'ENHANCED_PROMPT_LIBRARY.md' ]; then
    rm 'ENHANCED_PROMPT_LIBRARY.md'
    echo 'Deleted: ENHANCED_PROMPT_LIBRARY.md'
    ((deleted_count++))
fi
if [ -f 'final_validation.py' ]; then
    rm 'final_validation.py'
    echo 'Deleted: final_validation.py'
    ((deleted_count++))
fi
if [ -f 'weekly_touring_readiness_assessment.sh' ]; then
    rm 'weekly_touring_readiness_assessment.sh'
    echo 'Deleted: weekly_touring_readiness_assessment.sh'
    ((deleted_count++))
fi
if [ -f 'OPPORTUNITY_SCORES.md' ]; then
    rm 'OPPORTUNITY_SCORES.md'
    echo 'Deleted: OPPORTUNITY_SCORES.md'
    ((deleted_count++))
fi
if [ -f 'immediate_action_plan.sh' ]; then
    rm 'immediate_action_plan.sh'
    echo 'Deleted: immediate_action_plan.sh'
    ((deleted_count++))
fi
if [ -f 'MIRADOR_ACADEMIC_PAPER.md' ]; then
    rm 'MIRADOR_ACADEMIC_PAPER.md'
    echo 'Deleted: MIRADOR_ACADEMIC_PAPER.md'
    ((deleted_count++))
fi
if [ -f 'PROJECT_STATUS.md' ]; then
    rm 'PROJECT_STATUS.md'
    echo 'Deleted: PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'mirador_system_inventory.txt' ]; then
    rm 'mirador_system_inventory.txt'
    echo 'Deleted: mirador_system_inventory.txt'
    ((deleted_count++))
fi
if [ -f 'MIRADOR_TECHNICAL_PAPER.md' ]; then
    rm 'MIRADOR_TECHNICAL_PAPER.md'
    echo 'Deleted: MIRADOR_TECHNICAL_PAPER.md'
    ((deleted_count++))
fi
if [ -f 'advanced_test_scenarios.sh' ]; then
    rm 'advanced_test_scenarios.sh'
    echo 'Deleted: advanced_test_scenarios.sh'
    ((deleted_count++))
fi
if [ -f 'monthly_personality_review.sh' ]; then
    rm 'monthly_personality_review.sh'
    echo 'Deleted: monthly_personality_review.sh'
    ((deleted_count++))
fi
if [ -f 'optimize_models.sh' ]; then
    rm 'optimize_models.sh'
    echo 'Deleted: optimize_models.sh'
    ((deleted_count++))
fi
if [ -f 'louisville_expert_v2.modelfile' ]; then
    rm 'louisville_expert_v2.modelfile'
    echo 'Deleted: louisville_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'health_check.sh' ]; then
    rm 'health_check.sh'
    echo 'Deleted: health_check.sh'
    ((deleted_count++))
fi
if [ -f 'performance_anxiety_coach.modelfile' ]; then
    rm 'performance_anxiety_coach.modelfile'
    echo 'Deleted: performance_anxiety_coach.modelfile'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v7.modelfile' ]; then
    rm 'financial_planning_expert_v7.modelfile'
    echo 'Deleted: financial_planning_expert_v7.modelfile'
    ((deleted_count++))
fi
if [ -f 'daily_opportunity_scan.sh' ]; then
    rm 'daily_opportunity_scan.sh'
    echo 'Deleted: daily_opportunity_scan.sh'
    ((deleted_count++))
fi
if [ -f 'user_advisor_enhanced.modelfile' ]; then
    rm 'user_advisor_enhanced.modelfile'
    echo 'Deleted: user_advisor_enhanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'comprehensive_opportunity_validation.sh' ]; then
    rm 'comprehensive_opportunity_validation.sh'
    echo 'Deleted: comprehensive_opportunity_validation.sh'
    ((deleted_count++))
fi
if [ -f 'touring_readiness_coach.modelfile' ]; then
    rm 'touring_readiness_coach.modelfile'
    echo 'Deleted: touring_readiness_coach.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_system_specialist.modelfile' ]; then
    rm 'mirador_system_specialist.modelfile'
    echo 'Deleted: mirador_system_specialist.modelfile'
    ((deleted_count++))
fi
if [ -f 'output_quality_analyzer.sh' ]; then
    rm 'output_quality_analyzer.sh'
    echo 'Deleted: output_quality_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'create_action_tracker.sh' ]; then
    rm 'create_action_tracker.sh'
    echo 'Deleted: create_action_tracker.sh'
    ((deleted_count++))
fi
if [ -f 'strategic_music_networking.sh' ]; then
    rm 'strategic_music_networking.sh'
    echo 'Deleted: strategic_music_networking.sh'
    ((deleted_count++))
fi
if [ -f 'LICENSE' ]; then
    rm 'LICENSE'
    echo 'Deleted: LICENSE'
    ((deleted_count++))
fi
if [ -f 'daily_mirador_workflow.sh' ]; then
    rm 'daily_mirador_workflow.sh'
    echo 'Deleted: daily_mirador_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'feedback_loop_optimizer.modelfile' ]; then
    rm 'feedback_loop_optimizer.modelfile'
    echo 'Deleted: feedback_loop_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'requirements.txt' ]; then
    rm 'requirements.txt'
    echo 'Deleted: requirements.txt'
    ((deleted_count++))
fi
if [ -f 'opportunity_confidence_scorer.sh' ]; then
    rm 'opportunity_confidence_scorer.sh'
    echo 'Deleted: opportunity_confidence_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'fix_enhanced_agent.sh' ]; then
    rm 'fix_enhanced_agent.sh'
    echo 'Deleted: fix_enhanced_agent.sh'
    ((deleted_count++))
fi
if [ -f 'feedback_loop_optimizer_fixed.modelfile' ]; then
    rm 'feedback_loop_optimizer_fixed.modelfile'
    echo 'Deleted: feedback_loop_optimizer_fixed.modelfile'
    ((deleted_count++))
fi
if [ -f 'quick_optimize.sh' ]; then
    rm 'quick_optimize.sh'
    echo 'Deleted: quick_optimize.sh'
    ((deleted_count++))
fi
if [ -f 'user_context_provider_v2.modelfile' ]; then
    rm 'user_context_provider_v2.modelfile'
    echo 'Deleted: user_context_provider_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'monitor_mirador_performance_fixed.sh' ]; then
    rm 'monitor_mirador_performance_fixed.sh'
    echo 'Deleted: monitor_mirador_performance_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_self_reflection_guardian.modelfile' ]; then
    rm 'mirador_self_reflection_guardian.modelfile'
    echo 'Deleted: mirador_self_reflection_guardian.modelfile'
    ((deleted_count++))
fi
if [ -f 'PROMPT_LIBRARY.md' ]; then
    rm 'PROMPT_LIBRARY.md'
    echo 'Deleted: PROMPT_LIBRARY.md'
    ((deleted_count++))
fi
if [ -f 'ultimate_performance_dashboard.sh' ]; then
    rm 'ultimate_performance_dashboard.sh'
    echo 'Deleted: ultimate_performance_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'detect_hanging_processes.sh' ]; then
    rm 'detect_hanging_processes.sh'
    echo 'Deleted: detect_hanging_processes.sh'
    ((deleted_count++))
fi
if [ -f 'father_daughter_wisdom_guide.modelfile' ]; then
    rm 'father_daughter_wisdom_guide.modelfile'
    echo 'Deleted: father_daughter_wisdom_guide.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_personality_quick_reference.md' ]; then
    rm 'mirador_personality_quick_reference.md'
    echo 'Deleted: mirador_personality_quick_reference.md'
    ((deleted_count++))
fi
if [ -f 'linkedin_content_expert.modelfile' ]; then
    rm 'linkedin_content_expert.modelfile'
    echo 'Deleted: linkedin_content_expert.modelfile'
    ((deleted_count++))
fi
if [ -f 'personality_integration_summary.md' ]; then
    rm 'personality_integration_summary.md'
    echo 'Deleted: personality_integration_summary.md'
    ((deleted_count++))
fi
if [ -f 'monthly_optimization.sh' ]; then
    rm 'monthly_optimization.sh'
    echo 'Deleted: monthly_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'personal_brand_architect.modelfile' ]; then
    rm 'personal_brand_architect.modelfile'
    echo 'Deleted: personal_brand_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'validate_opportunities.sh' ]; then
    rm 'validate_opportunities.sh'
    echo 'Deleted: validate_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'archive_old_outputs.sh' ]; then
    rm 'archive_old_outputs.sh'
    echo 'Deleted: archive_old_outputs.sh'
    ((deleted_count++))
fi
if [ -f 'track_mirador_roi.sh' ]; then
    rm 'track_mirador_roi.sh'
    echo 'Deleted: track_mirador_roi.sh'
    ((deleted_count++))
fi
if [ -f 'ARCHITECTURE_OVERVIEW.md' ]; then
    rm 'ARCHITECTURE_OVERVIEW.md'
    echo 'Deleted: ARCHITECTURE_OVERVIEW.md'
    ((deleted_count++))
fi
if [ -f 'daily_validation.sh' ]; then
    rm 'daily_validation.sh'
    echo 'Deleted: daily_validation.sh'
    ((deleted_count++))
fi
if [ -f 'system_validation.sh' ]; then
    rm 'system_validation.sh'
    echo 'Deleted: system_validation.sh'
    ((deleted_count++))
fi
if [ -f 'run_test_chains.sh' ]; then
    rm 'run_test_chains.sh'
    echo 'Deleted: run_test_chains.sh'
    ((deleted_count++))
fi
if [ -f 'quick_linkedin_post.sh' ]; then
    rm 'quick_linkedin_post.sh'
    echo 'Deleted: quick_linkedin_post.sh'
    ((deleted_count++))
fi
if [ -f 'audit_models.sh' ]; then
    rm 'audit_models.sh'
    echo 'Deleted: audit_models.sh'
    ((deleted_count++))
fi
if [ -f 'health_wellness_optimizer.modelfile' ]; then
    rm 'health_wellness_optimizer.modelfile'
    echo 'Deleted: health_wellness_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'track_opportunity.py' ]; then
    rm 'track_opportunity.py'
    echo 'Deleted: track_opportunity.py'
    ((deleted_count++))
fi
if [ -f 'test_models_fixed.sh' ]; then
    rm 'test_models_fixed.sh'
    echo 'Deleted: test_models_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'user_context_manager.sh' ]; then
    rm 'user_context_manager.sh'
    echo 'Deleted: user_context_manager.sh'
    ((deleted_count++))
fi
if [ -f 'test_mirador_accuracy.sh' ]; then
    rm 'test_mirador_accuracy.sh'
    echo 'Deleted: test_mirador_accuracy.sh'
    ((deleted_count++))
fi
if [ -f 'IMPLEMENTATION_ROADMAP_20250608.md' ]; then
    rm 'IMPLEMENTATION_ROADMAP_20250608.md'
    echo 'Deleted: IMPLEMENTATION_ROADMAP_20250608.md'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_fast.modelfile' ]; then
    rm 'financial_planning_expert_fast.modelfile'
    echo 'Deleted: financial_planning_expert_fast.modelfile'
    ((deleted_count++))
fi
if [ -f 'weekly_theme_generator.sh' ]; then
    rm 'weekly_theme_generator.sh'
    echo 'Deleted: weekly_theme_generator.sh'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_enforcer.modelfile' ]; then
    rm 'enhanced_agent_enforcer.modelfile'
    echo 'Deleted: enhanced_agent_enforcer.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_enhanced_agent_fast_v7.modelfile' ]; then
    rm 'optimized_enhanced_agent_fast_v7.modelfile'
    echo 'Deleted: optimized_enhanced_agent_fast_v7.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador-unified' ]; then
    rm 'mirador-unified'
    echo 'Deleted: mirador-unified'
    ((deleted_count++))
fi
if [ -f 'june_action_plan.md' ]; then
    rm 'june_action_plan.md'
    echo 'Deleted: june_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'personality_integration_report.md' ]; then
    rm 'personality_integration_report.md'
    echo 'Deleted: personality_integration_report.md'
    ((deleted_count++))
fi
if [ -f 'TEST_CHAIN_ANALYSIS_20250608.md' ]; then
    rm 'TEST_CHAIN_ANALYSIS_20250608.md'
    echo 'Deleted: TEST_CHAIN_ANALYSIS_20250608.md'
    ((deleted_count++))
fi
if [ -f 'mirador_system_specialist_v2.modelfile' ]; then
    rm 'mirador_system_specialist_v2.modelfile'
    echo 'Deleted: mirador_system_specialist_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v7.modelfile' ]; then
    rm 'enhanced_agent_fast_v7.modelfile'
    echo 'Deleted: enhanced_agent_fast_v7.modelfile'
    ((deleted_count++))
fi
if [ -f 'ranked_opportunities.md' ]; then
    rm 'ranked_opportunities.md'
    echo 'Deleted: ranked_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'test_model_performance.sh' ]; then
    rm 'test_model_performance.sh'
    echo 'Deleted: test_model_performance.sh'
    ((deleted_count++))
fi
if [ -f 'WEEKLY_REVIEW_20250608.md' ]; then
    rm 'WEEKLY_REVIEW_20250608.md'
    echo 'Deleted: WEEKLY_REVIEW_20250608.md'
    ((deleted_count++))
fi
if [ -f 'father_daughter_music_mentor.modelfile' ]; then
    rm 'father_daughter_music_mentor.modelfile'
    echo 'Deleted: father_daughter_music_mentor.modelfile'
    ((deleted_count++))
fi
if [ -f 'louisville_expert_v3.modelfile' ]; then
    rm 'louisville_expert_v3.modelfile'
    echo 'Deleted: louisville_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'opportunity_implementation_tracker.md' ]; then
    rm 'opportunity_implementation_tracker.md'
    echo 'Deleted: opportunity_implementation_tracker.md'
    ((deleted_count++))
fi
if [ -f 'weekly_optimization_report.md' ]; then
    rm 'weekly_optimization_report.md'
    echo 'Deleted: weekly_optimization_report.md'
    ((deleted_count++))
fi
if [ -f 'user_parenting_enhanced.modelfile' ]; then
    rm 'user_parenting_enhanced.modelfile'
    echo 'Deleted: user_parenting_enhanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_with_memory.sh' ]; then
    rm 'mirador_with_memory.sh'
    echo 'Deleted: mirador_with_memory.sh'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_enforcer_v2.modelfile' ]; then
    rm 'enhanced_agent_enforcer_v2.modelfile'
    echo 'Deleted: enhanced_agent_enforcer_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'music_industry_networker.modelfile' ]; then
    rm 'music_industry_networker.modelfile'
    echo 'Deleted: music_industry_networker.modelfile'
    ((deleted_count++))
fi
if [ -f 'fix_shell_comments.sh' ]; then
    rm 'fix_shell_comments.sh'
    echo 'Deleted: fix_shell_comments.sh'
    ((deleted_count++))
fi
if [ -f 'test_complete_system.sh' ]; then
    rm 'test_complete_system.sh'
    echo 'Deleted: test_complete_system.sh'
    ((deleted_count++))
fi
if [ -f 'restore_models.sh' ]; then
    rm 'restore_models.sh'
    echo 'Deleted: restore_models.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_config_generator.py' ]; then
    rm 'mirador_config_generator.py'
    echo 'Deleted: mirador_config_generator.py'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v6.modelfile' ]; then
    rm 'financial_planning_expert_v6.modelfile'
    echo 'Deleted: financial_planning_expert_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'user_context_provider.modelfile' ]; then
    rm 'user_context_provider.modelfile'
    echo 'Deleted: user_context_provider.modelfile'
    ((deleted_count++))
fi
if [ -f 'quick_opportunity_test.sh' ]; then
    rm 'quick_opportunity_test.sh'
    echo 'Deleted: quick_opportunity_test.sh'
    ((deleted_count++))
fi
if [ -f 'view_validation_results.sh' ]; then
    rm 'view_validation_results.sh'
    echo 'Deleted: view_validation_results.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_model_diagnostic.py' ]; then
    rm 'mirador_model_diagnostic.py'
    echo 'Deleted: mirador_model_diagnostic.py'
    ((deleted_count++))
fi
if [ -f 'opportunity_evaluator.sh' ]; then
    rm 'opportunity_evaluator.sh'
    echo 'Deleted: opportunity_evaluator.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_unified_reference.md' ]; then
    rm 'mirador_unified_reference.md'
    echo 'Deleted: mirador_unified_reference.md'
    ((deleted_count++))
fi
if [ -f 'enhanced_system_analysis.sh' ]; then
    rm 'enhanced_system_analysis.sh'
    echo 'Deleted: enhanced_system_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'daily_music_career_accelerator.sh' ]; then
    rm 'daily_music_career_accelerator.sh'
    echo 'Deleted: daily_music_career_accelerator.sh'
    ((deleted_count++))
fi
if [ -f 'ARCHITECTURE_DIAGRAMS.md' ]; then
    rm 'ARCHITECTURE_DIAGRAMS.md'
    echo 'Deleted: ARCHITECTURE_DIAGRAMS.md'
    ((deleted_count++))
fi
if [ -f 'benchmark_models.sh' ]; then
    rm 'benchmark_models.sh'
    echo 'Deleted: benchmark_models.sh'
    ((deleted_count++))
fi
if [ -f 'setup_maintenance_cron.sh' ]; then
    rm 'setup_maintenance_cron.sh'
    echo 'Deleted: setup_maintenance_cron.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_memory.py' ]; then
    rm 'mirador_memory.py'
    echo 'Deleted: mirador_memory.py'
    ((deleted_count++))
fi
if [ -f 'track_decisions.sh' ]; then
    rm 'track_decisions.sh'
    echo 'Deleted: track_decisions.sh'
    ((deleted_count++))
fi
if [ -f 'create_dream_specialists.sh' ]; then
    rm 'create_dream_specialists.sh'
    echo 'Deleted: create_dream_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'user_context_provider_v3.modelfile' ]; then
    rm 'user_context_provider_v3.modelfile'
    echo 'Deleted: user_context_provider_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'test_mirador_performance.sh' ]; then
    rm 'test_mirador_performance.sh'
    echo 'Deleted: test_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'user_advisor.modelfile' ]; then
    rm 'user_advisor.modelfile'
    echo 'Deleted: user_advisor.modelfile'
    ((deleted_count++))
fi
if [ -f 'backup_models.sh' ]; then
    rm 'backup_models.sh'
    echo 'Deleted: backup_models.sh'
    ((deleted_count++))
fi
if [ -f 'PERFORMANCE_BENCHMARKS.md' ]; then
    rm 'PERFORMANCE_BENCHMARKS.md'
    echo 'Deleted: PERFORMANCE_BENCHMARKS.md'
    ((deleted_count++))
fi
if [ -f 'optimize_model_parameters.sh' ]; then
    rm 'optimize_model_parameters.sh'
    echo 'Deleted: optimize_model_parameters.sh'
    ((deleted_count++))
fi
if [ -f 'music_career_timeline_strategist.modelfile' ]; then
    rm 'music_career_timeline_strategist.modelfile'
    echo 'Deleted: music_career_timeline_strategist.modelfile'
    ((deleted_count++))
fi
if [ -f 'test_memory_system.sh' ]; then
    rm 'test_memory_system.sh'
    echo 'Deleted: test_memory_system.sh'
    ((deleted_count++))
fi
if [ -f 'smart_chain_selector.sh' ]; then
    rm 'smart_chain_selector.sh'
    echo 'Deleted: smart_chain_selector.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_dashboard.py' ]; then
    rm 'mirador_dashboard.py'
    echo 'Deleted: mirador_dashboard.py'
    ((deleted_count++))
fi
if [ -f 'digital_storyteller.modelfile' ]; then
    rm 'digital_storyteller.modelfile'
    echo 'Deleted: digital_storyteller.modelfile'
    ((deleted_count++))
fi
if [ -f 'system_health_check.sh' ]; then
    rm 'system_health_check.sh'
    echo 'Deleted: system_health_check.sh'
    ((deleted_count++))
fi
if [ -f 'ALGORITHM_DOCUMENTATION.md' ]; then
    rm 'ALGORITHM_DOCUMENTATION.md'
    echo 'Deleted: ALGORITHM_DOCUMENTATION.md'
    ((deleted_count++))
fi
if [ -f 'mirador-smart' ]; then
    rm 'mirador-smart'
    echo 'Deleted: mirador-smart'
    ((deleted_count++))
fi
if [ -f 'mirador_domains.sh' ]; then
    rm 'mirador_domains.sh'
    echo 'Deleted: mirador_domains.sh'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v3.modelfile' ]; then
    rm 'financial_planning_expert_v3.modelfile'
    echo 'Deleted: financial_planning_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'side_income_opportunity_scout.modelfile' ]; then
    rm 'side_income_opportunity_scout.modelfile'
    echo 'Deleted: side_income_opportunity_scout.modelfile'
    ((deleted_count++))
fi
if [ -f 'OPPORTUNITY_SCORES_20250608.md' ]; then
    rm 'OPPORTUNITY_SCORES_20250608.md'
    echo 'Deleted: OPPORTUNITY_SCORES_20250608.md'
    ((deleted_count++))
fi
if [ -f 'guitar_tone_architect.modelfile' ]; then
    rm 'guitar_tone_architect.modelfile'
    echo 'Deleted: guitar_tone_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'detect_hanging.sh' ]; then
    rm 'detect_hanging.sh'
    echo 'Deleted: detect_hanging.sh'
    ((deleted_count++))
fi
if [ -f 'decision_simplifier_v2.modelfile' ]; then
    rm 'decision_simplifier_v2.modelfile'
    echo 'Deleted: decision_simplifier_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'validate_fixes.sh' ]; then
    rm 'validate_fixes.sh'
    echo 'Deleted: validate_fixes.sh'
    ((deleted_count++))
fi
if [ -f 'knowledge_base_analyzer.sh' ]; then
    rm 'knowledge_base_analyzer.sh'
    echo 'Deleted: knowledge_base_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'SECURITY_IMPLEMENTATION.md' ]; then
    rm 'SECURITY_IMPLEMENTATION.md'
    echo 'Deleted: SECURITY_IMPLEMENTATION.md'
    ((deleted_count++))
fi
if [ -f 'output_map.txt' ]; then
    rm 'output_map.txt'
    echo 'Deleted: output_map.txt'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v4.modelfile' ]; then
    rm 'enhanced_agent_fast_v4.modelfile'
    echo 'Deleted: enhanced_agent_fast_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'enhanced_system_status.sh' ]; then
    rm 'enhanced_system_status.sh'
    echo 'Deleted: enhanced_system_status.sh'
    ((deleted_count++))
fi
if [ -f 'setup.py' ]; then
    rm 'setup.py'
    echo 'Deleted: setup.py'
    ((deleted_count++))
fi
if [ -f 'user_career_enhanced.modelfile' ]; then
    rm 'user_career_enhanced.modelfile'
    echo 'Deleted: user_career_enhanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador-intervene' ]; then
    rm 'mirador-intervene'
    echo 'Deleted: mirador-intervene'
    ((deleted_count++))
fi
if [ -f 'cross_model_synthesizer.modelfile' ]; then
    rm 'cross_model_synthesizer.modelfile'
    echo 'Deleted: cross_model_synthesizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'ACTION_TRACKER.md' ]; then
    rm 'ACTION_TRACKER.md'
    echo 'Deleted: ACTION_TRACKER.md'
    ((deleted_count++))
fi
if [ -f 'meta_chain_optimizer.sh' ]; then
    rm 'meta_chain_optimizer.sh'
    echo 'Deleted: meta_chain_optimizer.sh'
    ((deleted_count++))
fi
if [ -f 'extract_top_opportunities.sh' ]; then
    rm 'extract_top_opportunities.sh'
    echo 'Deleted: extract_top_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'user_context_provider_optimized.modelfile' ]; then
    rm 'user_context_provider_optimized.modelfile'
    echo 'Deleted: user_context_provider_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_health_report_20250618_153258.md' ]; then
    rm 'mirador_health_report_20250618_153258.md'
    echo 'Deleted: mirador_health_report_20250618_153258.md'
    ((deleted_count++))
fi
if [ -f 'consolidate_models.sh' ]; then
    rm 'consolidate_models.sh'
    echo 'Deleted: consolidate_models.sh'
    ((deleted_count++))
fi
if [ -f 'mirador' ]; then
    rm 'mirador'
    echo 'Deleted: mirador'
    ((deleted_count++))
fi
if [ -f 'deploy_production_mirador.sh' ]; then
    rm 'deploy_production_mirador.sh'
    echo 'Deleted: deploy_production_mirador.sh'
    ((deleted_count++))
fi
if [ -f 'content_strategist_pro.modelfile' ]; then
    rm 'content_strategist_pro.modelfile'
    echo 'Deleted: content_strategist_pro.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_production_test_suite.sh' ]; then
    rm 'mirador_production_test_suite.sh'
    echo 'Deleted: mirador_production_test_suite.sh'
    ((deleted_count++))
fi
if [ -f 'OPTIMIZATION_SUMMARY.md' ]; then
    rm 'OPTIMIZATION_SUMMARY.md'
    echo 'Deleted: OPTIMIZATION_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'mirador-interactive' ]; then
    rm 'mirador-interactive'
    echo 'Deleted: mirador-interactive'
    ((deleted_count++))
fi
if [ -f 'version_info.sh' ]; then
    rm 'version_info.sh'
    echo 'Deleted: version_info.sh'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v5.modelfile' ]; then
    rm 'financial_planning_expert_v5.modelfile'
    echo 'Deleted: financial_planning_expert_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'MODEL_CONFIGURATION_REFERENCE.md' ]; then
    rm 'MODEL_CONFIGURATION_REFERENCE.md'
    echo 'Deleted: MODEL_CONFIGURATION_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'IMMEDIATE_ACTION_PLAN_20250608.md' ]; then
    rm 'IMMEDIATE_ACTION_PLAN_20250608.md'
    echo 'Deleted: IMMEDIATE_ACTION_PLAN_20250608.md'
    ((deleted_count++))
fi
if [ -f 'business_opportunity_analysis.sh' ]; then
    rm 'business_opportunity_analysis.sh'
    echo 'Deleted: business_opportunity_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'extract_high_value_insights.sh' ]; then
    rm 'extract_high_value_insights.sh'
    echo 'Deleted: extract_high_value_insights.sh'
    ((deleted_count++))
fi
if [ -f 'mirador-collaborate' ]; then
    rm 'mirador-collaborate'
    echo 'Deleted: mirador-collaborate'
    ((deleted_count++))
fi
if [ -f 'mirador_v1.0_complete_20250611.tar.gz' ]; then
    rm 'mirador_v1.0_complete_20250611.tar.gz'
    echo 'Deleted: mirador_v1.0_complete_20250611.tar.gz'
    ((deleted_count++))
fi
if [ -f 'mirador_performance_tester.py' ]; then
    rm 'mirador_performance_tester.py'
    echo 'Deleted: mirador_performance_tester.py'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_optimized.modelfile' ]; then
    rm 'financial_planning_expert_optimized.modelfile'
    echo 'Deleted: financial_planning_expert_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'PRODUCTION_USAGE_GUIDE.md' ]; then
    rm 'PRODUCTION_USAGE_GUIDE.md'
    echo 'Deleted: PRODUCTION_USAGE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'create_user_unified.sh' ]; then
    rm 'create_user_unified.sh'
    echo 'Deleted: create_user_unified.sh'
    ((deleted_count++))
fi
if [ -f 'implementation_roadmap.sh' ]; then
    rm 'implementation_roadmap.sh'
    echo 'Deleted: implementation_roadmap.sh'
    ((deleted_count++))
fi
if [ -f 'weekly_deep_analysis.sh' ]; then
    rm 'weekly_deep_analysis.sh'
    echo 'Deleted: weekly_deep_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'create_executive_summary.sh' ]; then
    rm 'create_executive_summary.sh'
    echo 'Deleted: create_executive_summary.sh'
    ((deleted_count++))
fi
if [ -f 'unified_mirador_reference.md' ]; then
    rm 'unified_mirador_reference.md'
    echo 'Deleted: unified_mirador_reference.md'
    ((deleted_count++))
fi
if [ -f 'outputs_archive_20250618.tar.gz' ]; then
    rm 'outputs_archive_20250618.tar.gz'
    echo 'Deleted: outputs_archive_20250618.tar.gz'
    ((deleted_count++))
fi
if [ -f 'insights_dashboard_fixed.sh' ]; then
    rm 'insights_dashboard_fixed.sh'
    echo 'Deleted: insights_dashboard_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v8.modelfile' ]; then
    rm 'financial_planning_expert_v8.modelfile'
    echo 'Deleted: financial_planning_expert_v8.modelfile'
    ((deleted_count++))
fi
if [ -f 'PYTHON_INTERFACE.md' ]; then
    rm 'PYTHON_INTERFACE.md'
    echo 'Deleted: PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'Evolution from Concept to Production-Ready Personal Life Automation Platform.docx' ]; then
    rm 'Evolution from Concept to Production-Ready Personal Life Automation Platform.docx'
    echo 'Deleted: Evolution from Concept to Production-Ready Personal Life Automation Platform.docx'
    ((deleted_count++))
fi
if [ -f 'mirador-conductor' ]; then
    rm 'mirador-conductor'
    echo 'Deleted: mirador-conductor'
    ((deleted_count++))
fi
if [ -f 'modelfile_map.txt' ]; then
    rm 'modelfile_map.txt'
    echo 'Deleted: modelfile_map.txt'
    ((deleted_count++))
fi
if [ -f 'mirador_maintenance.sh' ]; then
    rm 'mirador_maintenance.sh'
    echo 'Deleted: mirador_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'CURRENT_PROJECT_STATUS.md' ]; then
    rm 'CURRENT_PROJECT_STATUS.md'
    echo 'Deleted: CURRENT_PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'mirador-smart.sh' ]; then
    rm 'mirador-smart.sh'
    echo 'Deleted: mirador-smart.sh'
    ((deleted_count++))
fi
if [ -f 'detect_hanging_macos.sh' ]; then
    rm 'detect_hanging_macos.sh'
    echo 'Deleted: detect_hanging_macos.sh'
    ((deleted_count++))
fi
if [ -f 'EXECUTIVE_SUMMARY_20250608.md' ]; then
    rm 'EXECUTIVE_SUMMARY_20250608.md'
    echo 'Deleted: EXECUTIVE_SUMMARY_20250608.md'
    ((deleted_count++))
fi
if [ -f 'user_realestate_enhanced.modelfile' ]; then
    rm 'user_realestate_enhanced.modelfile'
    echo 'Deleted: user_realestate_enhanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v2.modelfile' ]; then
    rm 'enhanced_agent_fast_v2.modelfile'
    echo 'Deleted: enhanced_agent_fast_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'opportunity_confidence_scorer_fixed.sh' ]; then
    rm 'opportunity_confidence_scorer_fixed.sh'
    echo 'Deleted: opportunity_confidence_scorer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'PROJECT_COMPLETION_REPORT.md' ]; then
    rm 'PROJECT_COMPLETION_REPORT.md'
    echo 'Deleted: PROJECT_COMPLETION_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'optimized_decision_simplifier_v3.modelfile' ]; then
    rm 'optimized_decision_simplifier_v3.modelfile'
    echo 'Deleted: optimized_decision_simplifier_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'generate_domain_plans.sh' ]; then
    rm 'generate_domain_plans.sh'
    echo 'Deleted: generate_domain_plans.sh'
    ((deleted_count++))
fi
if [ -f 'productivity_optimizer.modelfile' ]; then
    rm 'productivity_optimizer.modelfile'
    echo 'Deleted: productivity_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'TOP_OPPORTUNITIES.md' ]; then
    rm 'TOP_OPPORTUNITIES.md'
    echo 'Deleted: TOP_OPPORTUNITIES.md'
    ((deleted_count++))
fi
if [ -f 'advanced_opportunity_analytics.sh' ]; then
    rm 'advanced_opportunity_analytics.sh'
    echo 'Deleted: advanced_opportunity_analytics.sh'
    ((deleted_count++))
fi
if [ -f 'decision_simplifier_v3.modelfile' ]; then
    rm 'decision_simplifier_v3.modelfile'
    echo 'Deleted: decision_simplifier_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_action_prioritizer.modelfile' ]; then
    rm 'optimized_action_prioritizer.modelfile'
    echo 'Deleted: optimized_action_prioritizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'MODEL_INVENTORY.md' ]; then
    rm 'MODEL_INVENTORY.md'
    echo 'Deleted: MODEL_INVENTORY.md'
    ((deleted_count++))
fi
if [ -f 'mirador_qa_comprehensive.sh' ]; then
    rm 'mirador_qa_comprehensive.sh'
    echo 'Deleted: mirador_qa_comprehensive.sh'
    ((deleted_count++))
fi
if [ -f 'test_optimized_chains.sh' ]; then
    rm 'test_optimized_chains.sh'
    echo 'Deleted: test_optimized_chains.sh'
    ((deleted_count++))
fi
if [ -f 'opportunity_validator_v2.modelfile' ]; then
    rm 'opportunity_validator_v2.modelfile'
    echo 'Deleted: opportunity_validator_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'master_guitar_instructor.modelfile' ]; then
    rm 'master_guitar_instructor.modelfile'
    echo 'Deleted: master_guitar_instructor.modelfile'
    ((deleted_count++))
fi
if [ -f 'rank_opportunities.sh' ]; then
    rm 'rank_opportunities.sh'
    echo 'Deleted: rank_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'analyze_test_results.sh' ]; then
    rm 'analyze_test_results.sh'
    echo 'Deleted: analyze_test_results.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_chain_debugger.py' ]; then
    rm 'mirador_chain_debugger.py'
    echo 'Deleted: mirador_chain_debugger.py'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v2.modelfile' ]; then
    rm 'financial_planning_expert_v2.modelfile'
    echo 'Deleted: financial_planning_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'performance_analysis.sh' ]; then
    rm 'performance_analysis.sh'
    echo 'Deleted: performance_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'TECHNICAL_DOCUMENTATION.md' ]; then
    rm 'TECHNICAL_DOCUMENTATION.md'
    echo 'Deleted: TECHNICAL_DOCUMENTATION.md'
    ((deleted_count++))
fi
if [ -f 'user_louisville_enhanced.modelfile' ]; then
    rm 'user_louisville_enhanced.modelfile'
    echo 'Deleted: user_louisville_enhanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'system_maintenance.sh' ]; then
    rm 'system_maintenance.sh'
    echo 'Deleted: system_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'enhanced_system_validation_v2.sh' ]; then
    rm 'enhanced_system_validation_v2.sh'
    echo 'Deleted: enhanced_system_validation_v2.sh'
    ((deleted_count++))
fi
if [ -f 'enhanced_system_validation.sh' ]; then
    rm 'enhanced_system_validation.sh'
    echo 'Deleted: enhanced_system_validation.sh'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v5.modelfile' ]; then
    rm 'enhanced_agent_fast_v5.modelfile'
    echo 'Deleted: enhanced_agent_fast_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'comprehensive_security_gitignore_template.txt' ]; then
    rm 'comprehensive_security_gitignore_template.txt'
    echo 'Deleted: comprehensive_security_gitignore_template.txt'
    ((deleted_count++))
fi
if [ -f 'mirador-rapid' ]; then
    rm 'mirador-rapid'
    echo 'Deleted: mirador-rapid'
    ((deleted_count++))
fi
if [ -f 'insights_dashboard.sh' ]; then
    rm 'insights_dashboard.sh'
    echo 'Deleted: insights_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'engagement_optimizer.modelfile' ]; then
    rm 'engagement_optimizer.modelfile'
    echo 'Deleted: engagement_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'weekly_personality_optimization.sh' ]; then
    rm 'weekly_personality_optimization.sh'
    echo 'Deleted: weekly_personality_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'phase2_readiness_validator.py' ]; then
    rm 'phase2_readiness_validator.py'
    echo 'Deleted: phase2_readiness_validator.py'
    ((deleted_count++))
fi
if [ -f 'personality_optimized_chains.sh' ]; then
    rm 'personality_optimized_chains.sh'
    echo 'Deleted: personality_optimized_chains.sh'
    ((deleted_count++))
fi
if [ -f 'weekly_mirador_optimization.sh' ]; then
    rm 'weekly_mirador_optimization.sh'
    echo 'Deleted: weekly_mirador_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'generate_health_report.sh' ]; then
    rm 'generate_health_report.sh'
    echo 'Deleted: generate_health_report.sh'
    ((deleted_count++))
fi
if [ -f 'financial_planning_expert_v4.modelfile' ]; then
    rm 'financial_planning_expert_v4.modelfile'
    echo 'Deleted: financial_planning_expert_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'QUICK_REFERENCE.md' ]; then
    rm 'QUICK_REFERENCE.md'
    echo 'Deleted: QUICK_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'create_content_specialists.sh' ]; then
    rm 'create_content_specialists.sh'
    echo 'Deleted: create_content_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'model_performance_baseline.json' ]; then
    rm 'model_performance_baseline.json'
    echo 'Deleted: model_performance_baseline.json'
    ((deleted_count++))
fi
if [ -f 'analyze_test_suite_results.sh' ]; then
    rm 'analyze_test_suite_results.sh'
    echo 'Deleted: analyze_test_suite_results.sh'
    ((deleted_count++))
fi
if [ -f 'advanced_automation_suite.sh' ]; then
    rm 'advanced_automation_suite.sh'
    echo 'Deleted: advanced_automation_suite.sh'
    ((deleted_count++))
fi
if [ -f 'mirador-smart-v2' ]; then
    rm 'mirador-smart-v2'
    echo 'Deleted: mirador-smart-v2'
    ((deleted_count++))
fi
if [ -f 'linkedin_voice_architect.modelfile' ]; then
    rm 'linkedin_voice_architect.modelfile'
    echo 'Deleted: linkedin_voice_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'master_insights_organizer_fixed.sh' ]; then
    rm 'master_insights_organizer_fixed.sh'
    echo 'Deleted: master_insights_organizer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'analyze_mirador_value.sh' ]; then
    rm 'analyze_mirador_value.sh'
    echo 'Deleted: analyze_mirador_value.sh'
    ((deleted_count++))
fi
if [ -f 'benchmark_optimized.sh' ]; then
    rm 'benchmark_optimized.sh'
    echo 'Deleted: benchmark_optimized.sh'
    ((deleted_count++))
fi
if [ -f 'prompt_templates.md' ]; then
    rm 'prompt_templates.md'
    echo 'Deleted: prompt_templates.md'
    ((deleted_count++))
fi
if [ -f 'SECURITY.md' ]; then
    rm 'SECURITY.md'
    echo 'Deleted: SECURITY.md'
    ((deleted_count++))
fi
if [ -f 'audio_production_strategist.modelfile' ]; then
    rm 'audio_production_strategist.modelfile'
    echo 'Deleted: audio_production_strategist.modelfile'
    ((deleted_count++))
fi
if [ -f 'master_insights_organizer.sh' ]; then
    rm 'master_insights_organizer.sh'
    echo 'Deleted: master_insights_organizer.sh'
    ((deleted_count++))
fi
if [ -f 'daily_check_enhanced.sh' ]; then
    rm 'daily_check_enhanced.sh'
    echo 'Deleted: daily_check_enhanced.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_content_diagnostic.py' ]; then
    rm 'mirador_content_diagnostic.py'
    echo 'Deleted: mirador_content_diagnostic.py'
    ((deleted_count++))
fi
if [ -f 'monthly_music_breakthrough_analysis.sh' ]; then
    rm 'monthly_music_breakthrough_analysis.sh'
    echo 'Deleted: monthly_music_breakthrough_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'test_performance_macos.sh' ]; then
    rm 'test_performance_macos.sh'
    echo 'Deleted: test_performance_macos.sh'
    ((deleted_count++))
fi
if [ -f 'daily_check.sh' ]; then
    rm 'daily_check.sh'
    echo 'Deleted: daily_check.sh'
    ((deleted_count++))
fi
if [ -f 'morning_intelligence_brief.sh' ]; then
    rm 'morning_intelligence_brief.sh'
    echo 'Deleted: morning_intelligence_brief.sh'
    ((deleted_count++))
fi
if [ -f 'test_balanced_model.modelfile' ]; then
    rm 'test_balanced_model.modelfile'
    echo 'Deleted: test_balanced_model.modelfile'
    ((deleted_count++))
fi
if [ -f 'enhanced_agent_fast_v3.modelfile' ]; then
    rm 'enhanced_agent_fast_v3.modelfile'
    echo 'Deleted: enhanced_agent_fast_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'readiness_validation/phase2_readiness_report.md' ]; then
    rm 'readiness_validation/phase2_readiness_report.md'
    echo 'Deleted: readiness_validation/phase2_readiness_report.md'
    ((deleted_count++))
fi
if [ -f 'diagnostic_output/validate_critical_models.sh' ]; then
    rm 'diagnostic_output/validate_critical_models.sh'
    echo 'Deleted: diagnostic_output/validate_critical_models.sh'
    ((deleted_count++))
fi
if [ -f 'diagnostic_output/model_diagnostic_report.md' ]; then
    rm 'diagnostic_output/model_diagnostic_report.md'
    echo 'Deleted: diagnostic_output/model_diagnostic_report.md'
    ((deleted_count++))
fi
if [ -f 'diagnostic_output/build_critical_models.sh' ]; then
    rm 'diagnostic_output/build_critical_models.sh'
    echo 'Deleted: diagnostic_output/build_critical_models.sh'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_163038/03_financial_analysis.md' ]; then
    rm 'opportunities/20250606_163038/03_financial_analysis.md'
    echo 'Deleted: opportunities/20250606_163038/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_163038/04_action_plan.md' ]; then
    rm 'opportunities/20250606_163038/04_action_plan.md'
    echo 'Deleted: opportunities/20250606_163038/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_163038/02_local_analysis.md' ]; then
    rm 'opportunities/20250606_163038/02_local_analysis.md'
    echo 'Deleted: opportunities/20250606_163038/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_163038/01_opportunities.md' ]; then
    rm 'opportunities/20250606_163038/01_opportunities.md'
    echo 'Deleted: opportunities/20250606_163038/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/02_louisville_analysis.md' ]; then
    rm 'opportunities/20250606_164243_scored/02_louisville_analysis.md'
    echo 'Deleted: opportunities/20250606_164243_scored/02_louisville_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/04_implementation_roadmap.md' ]; then
    rm 'opportunities/20250606_164243_scored/04_implementation_roadmap.md'
    echo 'Deleted: opportunities/20250606_164243_scored/04_implementation_roadmap.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/03_financial_projections.md' ]; then
    rm 'opportunities/20250606_164243_scored/03_financial_projections.md'
    echo 'Deleted: opportunities/20250606_164243_scored/03_financial_projections.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md' ]; then
    rm 'opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md'
    echo 'Deleted: opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/05_risk_analysis.md' ]; then
    rm 'opportunities/20250606_164243_scored/05_risk_analysis.md'
    echo 'Deleted: opportunities/20250606_164243_scored/05_risk_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_164243_scored/01_market_analysis.md' ]; then
    rm 'opportunities/20250606_164243_scored/01_market_analysis.md'
    echo 'Deleted: opportunities/20250606_164243_scored/01_market_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_153122/03_financial_analysis.md' ]; then
    rm 'opportunities/20250606_153122/03_financial_analysis.md'
    echo 'Deleted: opportunities/20250606_153122/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_153122/04_action_plan.md' ]; then
    rm 'opportunities/20250606_153122/04_action_plan.md'
    echo 'Deleted: opportunities/20250606_153122/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_153122/02_local_analysis.md' ]; then
    rm 'opportunities/20250606_153122/02_local_analysis.md'
    echo 'Deleted: opportunities/20250606_153122/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_153122/01_opportunities.md' ]; then
    rm 'opportunities/20250606_153122/01_opportunities.md'
    echo 'Deleted: opportunities/20250606_153122/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_151337/03_financial_analysis.md' ]; then
    rm 'opportunities/20250606_151337/03_financial_analysis.md'
    echo 'Deleted: opportunities/20250606_151337/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_151337/04_action_plan.md' ]; then
    rm 'opportunities/20250606_151337/04_action_plan.md'
    echo 'Deleted: opportunities/20250606_151337/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_151337/02_local_analysis.md' ]; then
    rm 'opportunities/20250606_151337/02_local_analysis.md'
    echo 'Deleted: opportunities/20250606_151337/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'opportunities/20250606_151337/01_opportunities.md' ]; then
    rm 'opportunities/20250606_151337/01_opportunities.md'
    echo 'Deleted: opportunities/20250606_151337/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'weekly_reports/20250613_insights.md' ]; then
    rm 'weekly_reports/20250613_insights.md'
    echo 'Deleted: weekly_reports/20250613_insights.md'
    ((deleted_count++))
fi
if [ -f 'weekly_reports/20250611/weekly_report.md' ]; then
    rm 'weekly_reports/20250611/weekly_report.md'
    echo 'Deleted: weekly_reports/20250611/weekly_report.md'
    ((deleted_count++))
fi
if [ -f 'weekly_reports/20250613/weekly_report.md' ]; then
    rm 'weekly_reports/20250613/weekly_report.md'
    echo 'Deleted: weekly_reports/20250613/weekly_report.md'
    ((deleted_count++))
fi
if [ -f 'config/config.json' ]; then
    rm 'config/config.json'
    echo 'Deleted: config/config.json'
    ((deleted_count++))
fi
if [ -f 'config/intervention.json' ]; then
    rm 'config/intervention.json'
    echo 'Deleted: config/intervention.json'
    ((deleted_count++))
fi
if [ -f 'project_documentation/PRODUCTION_USAGE_GUIDE.md' ]; then
    rm 'project_documentation/PRODUCTION_USAGE_GUIDE.md'
    echo 'Deleted: project_documentation/PRODUCTION_USAGE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'project_documentation/unified_mirador_reference.md' ]; then
    rm 'project_documentation/unified_mirador_reference.md'
    echo 'Deleted: project_documentation/unified_mirador_reference.md'
    ((deleted_count++))
fi
if [ -f 'project_documentation/PROJECT_COMPLETION_REPORT.md' ]; then
    rm 'project_documentation/PROJECT_COMPLETION_REPORT.md'
    echo 'Deleted: project_documentation/PROJECT_COMPLETION_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'tests/run_all_tests.sh' ]; then
    rm 'tests/run_all_tests.sh'
    echo 'Deleted: tests/run_all_tests.sh'
    ((deleted_count++))
fi
if [ -f 'tests/fix_tests.sh' ]; then
    rm 'tests/fix_tests.sh'
    echo 'Deleted: tests/fix_tests.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_creative_entrepreneur.sh' ]; then
    rm 'tests/models/test_creative_entrepreneur.sh'
    echo 'Deleted: tests/models/test_creative_entrepreneur.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_code_reviewer_fix.sh' ]; then
    rm 'tests/models/test_code_reviewer_fix.sh'
    echo 'Deleted: tests/models/test_code_reviewer_fix.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_enhanced_agent.sh' ]; then
    rm 'tests/models/test_enhanced_agent.sh'
    echo 'Deleted: tests/models/test_enhanced_agent.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_master_coder.sh' ]; then
    rm 'tests/models/test_master_coder.sh'
    echo 'Deleted: tests/models/test_master_coder.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_llama3.2_balanced.sh' ]; then
    rm 'tests/models/test_llama3.2_balanced.sh'
    echo 'Deleted: tests/models/test_llama3.2_balanced.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_guitar_expert_precise.sh' ]; then
    rm 'tests/models/test_guitar_expert_precise.sh'
    echo 'Deleted: tests/models/test_guitar_expert_precise.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_fast_agent_focused.sh' ]; then
    rm 'tests/models/test_fast_agent_focused.sh'
    echo 'Deleted: tests/models/test_fast_agent_focused.sh'
    ((deleted_count++))
fi
if [ -f 'tests/models/test_file_reviewer.sh' ]; then
    rm 'tests/models/test_file_reviewer.sh'
    echo 'Deleted: tests/models/test_file_reviewer.sh'
    ((deleted_count++))
fi
if [ -f 'tests/results/test_report_20250520_142559.md' ]; then
    rm 'tests/results/test_report_20250520_142559.md'
    echo 'Deleted: tests/results/test_report_20250520_142559.md'
    ((deleted_count++))
fi
if [ -f 'tests/results/test_report_20250617_113645.md' ]; then
    rm 'tests/results/test_report_20250617_113645.md'
    echo 'Deleted: tests/results/test_report_20250617_113645.md'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_142559/response.json' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_142559/response.json'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_142559/output.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_142559/output.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250617_113646/metadata.txt' ]; then
    rm 'tests/results/file_reviewer_20250617_113646/metadata.txt'
    echo 'Deleted: tests/results/file_reviewer_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250617_113646/response.json' ]; then
    rm 'tests/results/file_reviewer_20250617_113646/response.json'
    echo 'Deleted: tests/results/file_reviewer_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250617_113646/output.txt' ]; then
    rm 'tests/results/file_reviewer_20250617_113646/output.txt'
    echo 'Deleted: tests/results/file_reviewer_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250520_143153/metadata.txt' ]; then
    rm 'tests/results/llama3.2_balanced_20250520_143153/metadata.txt'
    echo 'Deleted: tests/results/llama3.2_balanced_20250520_143153/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250520_143153/response.json' ]; then
    rm 'tests/results/llama3.2_balanced_20250520_143153/response.json'
    echo 'Deleted: tests/results/llama3.2_balanced_20250520_143153/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250520_143153/output.txt' ]; then
    rm 'tests/results/llama3.2_balanced_20250520_143153/output.txt'
    echo 'Deleted: tests/results/llama3.2_balanced_20250520_143153/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250617_113646/metadata.txt' ]; then
    rm 'tests/results/fast_agent_focused_20250617_113646/metadata.txt'
    echo 'Deleted: tests/results/fast_agent_focused_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250617_113646/response.json' ]; then
    rm 'tests/results/fast_agent_focused_20250617_113646/response.json'
    echo 'Deleted: tests/results/fast_agent_focused_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250617_113646/output.txt' ]; then
    rm 'tests/results/fast_agent_focused_20250617_113646/output.txt'
    echo 'Deleted: tests/results/fast_agent_focused_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250617_113717/metadata.txt' ]; then
    rm 'tests/results/master_coder_20250617_113717/metadata.txt'
    echo 'Deleted: tests/results/master_coder_20250617_113717/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250617_113717/response.json' ]; then
    rm 'tests/results/master_coder_20250617_113717/response.json'
    echo 'Deleted: tests/results/master_coder_20250617_113717/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250617_113717/output.txt' ]; then
    rm 'tests/results/master_coder_20250617_113717/output.txt'
    echo 'Deleted: tests/results/master_coder_20250617_113717/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/enhanced_agent_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/enhanced_agent_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250520_142559/response.json' ]; then
    rm 'tests/results/enhanced_agent_20250520_142559/response.json'
    echo 'Deleted: tests/results/enhanced_agent_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250520_142559/output.txt' ]; then
    rm 'tests/results/enhanced_agent_20250520_142559/output.txt'
    echo 'Deleted: tests/results/enhanced_agent_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/creative_entrepreneur_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/creative_entrepreneur_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250520_142559/response.json' ]; then
    rm 'tests/results/creative_entrepreneur_20250520_142559/response.json'
    echo 'Deleted: tests/results/creative_entrepreneur_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250520_142559/output.txt' ]; then
    rm 'tests/results/creative_entrepreneur_20250520_142559/output.txt'
    echo 'Deleted: tests/results/creative_entrepreneur_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250520_143153/metadata.txt' ]; then
    rm 'tests/results/master_coder_20250520_143153/metadata.txt'
    echo 'Deleted: tests/results/master_coder_20250520_143153/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250520_143153/response.json' ]; then
    rm 'tests/results/master_coder_20250520_143153/response.json'
    echo 'Deleted: tests/results/master_coder_20250520_143153/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/master_coder_20250520_143153/output.txt' ]; then
    rm 'tests/results/master_coder_20250520_143153/output.txt'
    echo 'Deleted: tests/results/master_coder_20250520_143153/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_role_20250520_151312/metadata.txt' ]; then
    rm 'tests/results/chain_role_20250520_151312/metadata.txt'
    echo 'Deleted: tests/results/chain_role_20250520_151312/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250617_113717/metadata.txt' ]; then
    rm 'tests/results/llama3.2_balanced_20250617_113717/metadata.txt'
    echo 'Deleted: tests/results/llama3.2_balanced_20250617_113717/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250617_113717/response.json' ]; then
    rm 'tests/results/llama3.2_balanced_20250617_113717/response.json'
    echo 'Deleted: tests/results/llama3.2_balanced_20250617_113717/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/llama3.2_balanced_20250617_113717/output.txt' ]; then
    rm 'tests/results/llama3.2_balanced_20250617_113717/output.txt'
    echo 'Deleted: tests/results/llama3.2_balanced_20250617_113717/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250617_113645/metadata.txt' ]; then
    rm 'tests/results/code_reviewer_fix_20250617_113645/metadata.txt'
    echo 'Deleted: tests/results/code_reviewer_fix_20250617_113645/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250617_113645/response.json' ]; then
    rm 'tests/results/code_reviewer_fix_20250617_113645/response.json'
    echo 'Deleted: tests/results/code_reviewer_fix_20250617_113645/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250617_113645/output.txt' ]; then
    rm 'tests/results/code_reviewer_fix_20250617_113645/output.txt'
    echo 'Deleted: tests/results/code_reviewer_fix_20250617_113645/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/code_reviewer_fix_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/code_reviewer_fix_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250520_142559/response.json' ]; then
    rm 'tests/results/code_reviewer_fix_20250520_142559/response.json'
    echo 'Deleted: tests/results/code_reviewer_fix_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/code_reviewer_fix_20250520_142559/output.txt' ]; then
    rm 'tests/results/code_reviewer_fix_20250520_142559/output.txt'
    echo 'Deleted: tests/results/code_reviewer_fix_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250617_113658/metadata.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250617_113658/metadata.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250617_113658/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250617_113658/response.json' ]; then
    rm 'tests/results/guitar_expert_precise_20250617_113658/response.json'
    echo 'Deleted: tests/results/guitar_expert_precise_20250617_113658/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250617_113658/output.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250617_113658/output.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250617_113658/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_143235/metadata.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_143235/metadata.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_143235/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_143235/response.json' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_143235/response.json'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_143235/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/guitar_expert_precise_20250520_143235/output.txt' ]; then
    rm 'tests/results/guitar_expert_precise_20250520_143235/output.txt'
    echo 'Deleted: tests/results/guitar_expert_precise_20250520_143235/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/file_reviewer_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/file_reviewer_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250520_142559/response.json' ]; then
    rm 'tests/results/file_reviewer_20250520_142559/response.json'
    echo 'Deleted: tests/results/file_reviewer_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/file_reviewer_20250520_142559/output.txt' ]; then
    rm 'tests/results/file_reviewer_20250520_142559/output.txt'
    echo 'Deleted: tests/results/file_reviewer_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250520_142559/metadata.txt' ]; then
    rm 'tests/results/fast_agent_focused_20250520_142559/metadata.txt'
    echo 'Deleted: tests/results/fast_agent_focused_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250520_142559/response.json' ]; then
    rm 'tests/results/fast_agent_focused_20250520_142559/response.json'
    echo 'Deleted: tests/results/fast_agent_focused_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/fast_agent_focused_20250520_142559/output.txt' ]; then
    rm 'tests/results/fast_agent_focused_20250520_142559/output.txt'
    echo 'Deleted: tests/results/fast_agent_focused_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_role_20250520_151507/metadata.txt' ]; then
    rm 'tests/results/chain_role_20250520_151507/metadata.txt'
    echo 'Deleted: tests/results/chain_role_20250520_151507/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250617_113646/metadata.txt' ]; then
    rm 'tests/results/enhanced_agent_20250617_113646/metadata.txt'
    echo 'Deleted: tests/results/enhanced_agent_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250617_113646/response.json' ]; then
    rm 'tests/results/enhanced_agent_20250617_113646/response.json'
    echo 'Deleted: tests/results/enhanced_agent_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/enhanced_agent_20250617_113646/output.txt' ]; then
    rm 'tests/results/enhanced_agent_20250617_113646/output.txt'
    echo 'Deleted: tests/results/enhanced_agent_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250617_113646/metadata.txt' ]; then
    rm 'tests/results/creative_entrepreneur_20250617_113646/metadata.txt'
    echo 'Deleted: tests/results/creative_entrepreneur_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250617_113646/response.json' ]; then
    rm 'tests/results/creative_entrepreneur_20250617_113646/response.json'
    echo 'Deleted: tests/results/creative_entrepreneur_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/creative_entrepreneur_20250617_113646/output.txt' ]; then
    rm 'tests/results/creative_entrepreneur_20250617_113646/output.txt'
    echo 'Deleted: tests/results/creative_entrepreneur_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/metadata.txt' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/metadata.txt'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/step1_output.txt' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/step1_output.txt'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/step1_output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/summary.md' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/summary.md'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/summary.md'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/step1_raw.json' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/step1_raw.json'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/step1_raw.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/step2_raw.json' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/step2_raw.json'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/step2_raw.json'
    ((deleted_count++))
fi
if [ -f 'tests/results/chain_guitar_20250520_143916/step2_output.txt' ]; then
    rm 'tests/results/chain_guitar_20250520_143916/step2_output.txt'
    echo 'Deleted: tests/results/chain_guitar_20250520_143916/step2_output.txt'
    ((deleted_count++))
fi
if [ -f 'tests/chains/test_guitar_chain.sh' ]; then
    rm 'tests/chains/test_guitar_chain.sh'
    echo 'Deleted: tests/chains/test_guitar_chain.sh'
    ((deleted_count++))
fi
if [ -f 'tests/chains/test_role_chain.sh' ]; then
    rm 'tests/chains/test_role_chain.sh'
    echo 'Deleted: tests/chains/test_role_chain.sh'
    ((deleted_count++))
fi
if [ -f 'tests/chains/test_code_chain.sh' ]; then
    rm 'tests/chains/test_code_chain.sh'
    echo 'Deleted: tests/chains/test_code_chain.sh'
    ((deleted_count++))
fi
if [ -f 'tests/chains/test_business_chain.sh' ]; then
    rm 'tests/chains/test_business_chain.sh'
    echo 'Deleted: tests/chains/test_business_chain.sh'
    ((deleted_count++))
fi
if [ -f 'performance_results/performance_report.md' ]; then
    rm 'performance_results/performance_report.md'
    echo 'Deleted: performance_results/performance_report.md'
    ((deleted_count++))
fi
if [ -f 'performance_results/performance_data.json' ]; then
    rm 'performance_results/performance_data.json'
    echo 'Deleted: performance_results/performance_data.json'
    ((deleted_count++))
fi
if [ -f 'optimization_tests/optimized_financial_20250623_144923.txt' ]; then
    rm 'optimization_tests/optimized_financial_20250623_144923.txt'
    echo 'Deleted: optimization_tests/optimized_financial_20250623_144923.txt'
    ((deleted_count++))
fi
if [ -f 'optimization_tests/baseline_decision_20250623_144900.txt' ]; then
    rm 'optimization_tests/baseline_decision_20250623_144900.txt'
    echo 'Deleted: optimization_tests/baseline_decision_20250623_144900.txt'
    ((deleted_count++))
fi
if [ -f 'optimization_tests/baseline_financial_20250623_144810.txt' ]; then
    rm 'optimization_tests/baseline_financial_20250623_144810.txt'
    echo 'Deleted: optimization_tests/baseline_financial_20250623_144810.txt'
    ((deleted_count++))
fi
if [ -f 'honeypot/README.md' ]; then
    rm 'honeypot/README.md'
    echo 'Deleted: honeypot/README.md'
    ((deleted_count++))
fi
if [ -f 'honeypot/fake_credentials.txt' ]; then
    rm 'honeypot/fake_credentials.txt'
    echo 'Deleted: honeypot/fake_credentials.txt'
    ((deleted_count++))
fi
if [ -f 'docs/SIMPLIFIED_COMMANDS.md' ]; then
    rm 'docs/SIMPLIFIED_COMMANDS.md'
    echo 'Deleted: docs/SIMPLIFIED_COMMANDS.md'
    ((deleted_count++))
fi
if [ -f 'docs/USER_INTERVENTION.md' ]; then
    rm 'docs/USER_INTERVENTION.md'
    echo 'Deleted: docs/USER_INTERVENTION.md'
    ((deleted_count++))
fi
if [ -f 'docs/COMPACT_MODE.md' ]; then
    rm 'docs/COMPACT_MODE.md'
    echo 'Deleted: docs/COMPACT_MODE.md'
    ((deleted_count++))
fi
if [ -f 'docs/USAGE.md' ]; then
    rm 'docs/USAGE.md'
    echo 'Deleted: docs/USAGE.md'
    ((deleted_count++))
fi
if [ -f 'docs/PROGRESS_VISUALIZATION.md' ]; then
    rm 'docs/PROGRESS_VISUALIZATION.md'
    echo 'Deleted: docs/PROGRESS_VISUALIZATION.md'
    ((deleted_count++))
fi
if [ -f 'docs/MODELS.md' ]; then
    rm 'docs/MODELS.md'
    echo 'Deleted: docs/MODELS.md'
    ((deleted_count++))
fi
if [ -f 'docs/FUTURE_ENHANCEMENTS.md' ]; then
    rm 'docs/FUTURE_ENHANCEMENTS.md'
    echo 'Deleted: docs/FUTURE_ENHANCEMENTS.md'
    ((deleted_count++))
fi
if [ -f 'docs/UNIFIED_INTERFACE.md' ]; then
    rm 'docs/UNIFIED_INTERFACE.md'
    echo 'Deleted: docs/UNIFIED_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'docs/QUICK_REFERENCE.md' ]; then
    rm 'docs/QUICK_REFERENCE.md'
    echo 'Deleted: docs/QUICK_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'docs/design/BIDIRECTIONAL_COMMUNICATION.md' ]; then
    rm 'docs/design/BIDIRECTIONAL_COMMUNICATION.md'
    echo 'Deleted: docs/design/BIDIRECTIONAL_COMMUNICATION.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/MODEL_SELECTION_CARD.md' ]; then
    rm 'docs/ollama/MODEL_SELECTION_CARD.md'
    echo 'Deleted: docs/ollama/MODEL_SELECTION_CARD.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/MODEL_PROMPT_GUIDE.md' ]; then
    rm 'docs/ollama/MODEL_PROMPT_GUIDE.md'
    echo 'Deleted: docs/ollama/MODEL_PROMPT_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/WORKFLOW_PATTERNS.md' ]; then
    rm 'docs/ollama/WORKFLOW_PATTERNS.md'
    echo 'Deleted: docs/ollama/WORKFLOW_PATTERNS.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/TEMPERATURE_GUIDE.md' ]; then
    rm 'docs/ollama/TEMPERATURE_GUIDE.md'
    echo 'Deleted: docs/ollama/TEMPERATURE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/MODEL_ARCHITECTURE.md' ]; then
    rm 'docs/ollama/MODEL_ARCHITECTURE.md'
    echo 'Deleted: docs/ollama/MODEL_ARCHITECTURE.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/OLLAMA_FAQ.md' ]; then
    rm 'docs/ollama/OLLAMA_FAQ.md'
    echo 'Deleted: docs/ollama/OLLAMA_FAQ.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/OLLAMA_REFERENCE_CARD.md' ]; then
    rm 'docs/ollama/OLLAMA_REFERENCE_CARD.md'
    echo 'Deleted: docs/ollama/OLLAMA_REFERENCE_CARD.md'
    ((deleted_count++))
fi
if [ -f 'docs/ollama/ONE_PAGE_REFERENCE.md' ]; then
    rm 'docs/ollama/ONE_PAGE_REFERENCE.md'
    echo 'Deleted: docs/ollama/ONE_PAGE_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2.zip' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2.zip'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2.zip'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/linkedin-post-templates.md' ]; then
    rm 'Documentation and Saved Assets/linkedin-post-templates.md'
    echo 'Deleted: Documentation and Saved Assets/linkedin-post-templates.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/company-manager-strategy.md' ]; then
    rm 'Documentation and Saved Assets/company-manager-strategy.md'
    echo 'Deleted: Documentation and Saved Assets/company-manager-strategy.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio.zip' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio.zip'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio.zip'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Mirador Prompt Library - Daily Life Optimization & Opportunity Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Mirador Prompt Library - Daily Life Optimization & Opportunity Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Mirador Prompt Library - Daily Life Optimization & Opportunity Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador_emergency_recovery.py' ]; then
    rm 'Documentation and Saved Assets/mirador_emergency_recovery.py'
    echo 'Deleted: Documentation and Saved Assets/mirador_emergency_recovery.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Specialized Ollama Model Files for User.md' ]; then
    rm 'Documentation and Saved Assets/Specialized Ollama Model Files for User.md'
    echo 'Deleted: Documentation and Saved Assets/Specialized Ollama Model Files for User.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Mirador AI Orchestration System_ A Comprehensive Synthesis.pdf' ]; then
    rm 'Documentation and Saved Assets/Mirador AI Orchestration System_ A Comprehensive Synthesis.pdf'
    echo 'Deleted: Documentation and Saved Assets/Mirador AI Orchestration System_ A Comprehensive Synthesis.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/AI_Content_Creation_Risk_Management_Guide.pdf' ]; then
    rm 'Documentation and Saved Assets/AI_Content_Creation_Risk_Management_Guide.pdf'
    echo 'Deleted: Documentation and Saved Assets/AI_Content_Creation_Risk_Management_Guide.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/executive_portfolio_summary.md' ]; then
    rm 'Documentation and Saved Assets/executive_portfolio_summary.md'
    echo 'Deleted: Documentation and Saved Assets/executive_portfolio_summary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main.zip' ]; then
    rm 'Documentation and Saved Assets/mirador-main.zip'
    echo 'Deleted: Documentation and Saved Assets/mirador-main.zip'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/strategic_deployment_guide.md' ]; then
    rm 'Documentation and Saved Assets/strategic_deployment_guide.md'
    echo 'Deleted: Documentation and Saved Assets/strategic_deployment_guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Specialized Ollama Model Files for User (1).md' ]; then
    rm 'Documentation and Saved Assets/Specialized Ollama Model Files for User (1).md'
    echo 'Deleted: Documentation and Saved Assets/Specialized Ollama Model Files for User (1).md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Mirador Multi-Agent AI Orchestration System_ Synthesis and Strategic Recommendations.pptx.pdf' ]; then
    rm 'Documentation and Saved Assets/Mirador Multi-Agent AI Orchestration System_ Synthesis and Strategic Recommendations.pptx.pdf'
    echo 'Deleted: Documentation and Saved Assets/Mirador Multi-Agent AI Orchestration System_ Synthesis and Strategic Recommendations.pptx.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/GitHub Repository Analysis - Initial Findings.md' ]; then
    rm 'Documentation and Saved Assets/GitHub Repository Analysis - Initial Findings.md'
    echo 'Deleted: Documentation and Saved Assets/GitHub Repository Analysis - Initial Findings.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths.zip' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths.zip'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths.zip'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/company-communication-msgs.md' ]; then
    rm 'Documentation and Saved Assets/company-communication-msgs.md'
    echo 'Deleted: Documentation and Saved Assets/company-communication-msgs.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/linkedin-content-strategy 2.md' ]; then
    rm 'Documentation and Saved Assets/linkedin-content-strategy 2.md'
    echo 'Deleted: Documentation and Saved Assets/linkedin-content-strategy 2.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Enhanced Ollama Model Files for M3 Max MacBook Pro.md' ]; then
    rm 'Documentation and Saved Assets/Enhanced Ollama Model Files for M3 Max MacBook Pro.md'
    echo 'Deleted: Documentation and Saved Assets/Enhanced Ollama Model Files for M3 Max MacBook Pro.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Mirador Strategic Analysis_ Deep Reflection & Recommendations.md' ]; then
    rm 'Documentation and Saved Assets/Mirador Strategic Analysis_ Deep Reflection & Recommendations.md'
    echo 'Deleted: Documentation and Saved Assets/Mirador Strategic Analysis_ Deep Reflection & Recommendations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/linkedin_transformation_posts.md' ]; then
    rm 'Documentation and Saved Assets/linkedin_transformation_posts.md'
    echo 'Deleted: Documentation and Saved Assets/linkedin_transformation_posts.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/AI-Powered Personal Advisory System_ Video Script Structure.md' ]; then
    rm 'Documentation and Saved Assets/AI-Powered Personal Advisory System_ Video Script Structure.md'
    echo 'Deleted: Documentation and Saved Assets/AI-Powered Personal Advisory System_ Video Script Structure.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/image 2.png' ]; then
    rm 'Documentation and Saved Assets/image 2.png'
    echo 'Deleted: Documentation and Saved Assets/image 2.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/image.png' ]; then
    rm 'Documentation and Saved Assets/image.png'
    echo 'Deleted: Documentation and Saved Assets/image.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/image 3.png' ]; then
    rm 'Documentation and Saved Assets/image 3.png'
    echo 'Deleted: Documentation and Saved Assets/image 3.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/index.html' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/index.html'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/value_propositions.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/value_propositions.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/value_propositions.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/methodology_slide.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/methodology_slide.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/methodology_slide.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/transformation_story.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/transformation_story.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/transformation_story.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/portfolio_showcase.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/portfolio_showcase.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/portfolio_showcase.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/style.css' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/style.css'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/ai_architecture.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/ai_architecture.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/ai_architecture.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/linkedin-content-strategy.md' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/linkedin-content-strategy.md'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/linkedin-content-strategy.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/ai_journey_timeline.png' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/ai_journey_timeline.png'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/ai_journey_timeline.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-journey-portfolio/app.js' ]; then
    rm 'Documentation and Saved Assets/ai-journey-portfolio/app.js'
    echo 'Deleted: Documentation and Saved Assets/ai-journey-portfolio/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/prepare_release.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/prepare_release.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/prepare_release.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_comprehensive_overview.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_comprehensive_overview.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_comprehensive_overview.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageGuide&ReferenceCard.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageGuide&ReferenceCard.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageGuide&ReferenceCard.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-usage.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-usage.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-usage.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/strategic_analysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/strategic_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/strategic_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorTroubleshootingandOptimizationGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorTroubleshootingandOptimizationGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorTroubleshootingandOptimizationGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-technical.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-technical.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-technical.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/key-commands.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/key-commands.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/key-commands.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TECHNICAL_DOCUMENTATION.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TECHNICAL_DOCUMENTATION.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TECHNICAL_DOCUMENTATION.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_analyzer.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_analyzer.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_analyzer.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_conductor.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_conductor.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_conductor.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/AnalysisofMiradorTerminalOutput-KeyInsights.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/AnalysisofMiradorTerminalOutput-KeyInsights.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/AnalysisofMiradorTerminalOutput-KeyInsights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_action_prioritizer.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_action_prioritizer.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_action_prioritizer.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-ez' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-ez'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-ez'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner_macos.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner_macos.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner_macos.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_production_readiness.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_production_readiness.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_production_readiness.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_strategic_deep_dive.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_strategic_deep_dive.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_strategic_deep_dive.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_scorer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_scorer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkComprehensiveGuidetoPersonalLifeAutomation.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkComprehensiveGuidetoPersonalLifeAutomation.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkComprehensiveGuidetoPersonalLifeAutomation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_review_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_review_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_review_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SYSTEM_TEST_SUITE.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SYSTEM_TEST_SUITE.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SYSTEM_TEST_SUITE.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Model Consolidation Toolkit.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Model Consolidation Toolkit.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Model Consolidation Toolkit.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/generate_architecture_diagram.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/generate_architecture_diagram.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/generate_architecture_diagram.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelCapabilitiesAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelCapabilitiesAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelCapabilitiesAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/immediate_action_plan.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/immediate_action_plan.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/immediate_action_plan.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical-docs.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical-docs.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical-docs.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteImplementationGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteImplementationGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteImplementationGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_exhaustive_commands.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_exhaustive_commands.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_exhaustive_commands.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_usage_guide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_usage_guide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_usage_guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_personality_review.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_personality_review.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_personality_review.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.22.46AM.png' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.22.46AM.png'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.22.46AM.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDocumentationSuiteIndex.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDocumentationSuiteIndex.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDocumentationSuiteIndex.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_implementation_plan.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_implementation_plan.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_implementation_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/instruction_generation_specialist.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/instruction_generation_specialist.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/instruction_generation_specialist.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/output_quality_analyzer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/output_quality_analyzer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/output_quality_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-test-prompts.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-test-prompts.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-test-prompts.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/OptimizedMiradorProjectStructure.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/OptimizedMiradorProjectStructure.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/OptimizedMiradorProjectStructure.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.txt' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.txt'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/requirements.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationCommandsandDeploymentGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationCommandsandDeploymentGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationCommandsandDeploymentGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer_fixed.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer_fixed.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/feedback_loop_optimizer_fixed.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEnhancedCommandInterface.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEnhancedCommandInterface.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEnhancedCommandInterface.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_optimize.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_optimize.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_optimize.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monitor_mirador_performance_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Latest Execution Results Analysis - June 20, 2025.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Latest Execution Results Analysis - June 20, 2025.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Latest Execution Results Analysis - June 20, 2025.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystem_AnUltrathinkAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystem_AnUltrathinkAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystem_AnUltrathinkAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ultimate_performance_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ultimate_performance_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ultimate_performance_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/persona_dossier_extracted.txt' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/persona_dossier_extracted.txt'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/persona_dossier_extracted.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/summary.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/summary.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/summary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteDesignFramework.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteDesignFramework.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableInstructionSystemCompleteDesignFramework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/monthly_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Multi-Agent AI Orchestration System: Synthesis and Strategic Recommendations.pptx' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Multi-Agent AI Orchestration System: Synthesis and Strategic Recommendations.pptx'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Multi-Agent AI Orchestration System: Synthesis and Strategic Recommendations.pptx'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Infrastructure Repair Execution Results Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Infrastructure Repair Execution Results Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Infrastructure Repair Execution Results Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_opportunities.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_opportunities.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_mirador_roi.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_mirador_roi.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_mirador_roi.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorandHumanFlourishing_AComprehensiveAnalysisofHumanCapabilityEnhancement.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorandHumanFlourishing_AComprehensiveAnalysisofHumanCapabilityEnhancement.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorandHumanFlourishing_AComprehensiveAnalysisofHumanCapabilityEnhancement.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_validation.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_validation.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_validation.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/run_test_chains.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/run_test_chains.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/run_test_chains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_linkedin_post.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_linkedin_post.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_linkedin_post.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicRecommendationsSummary.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicRecommendationsSummary.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicRecommendationsSummary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-reference-card.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-reference-card.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-reference-card.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/reference-card.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/reference-card.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/reference-card.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_journey_summary.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_journey_summary.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_journey_summary.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV5ImplementationResults-FinalAssessment.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV5ImplementationResults-FinalAssessment.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV5ImplementationResults-FinalAssessment.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImmediateImprovementActionPlan.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImmediateImprovementActionPlan.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImmediateImprovementActionPlan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_models_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_models_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_models_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_manager.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_manager.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_manager.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_mirador_accuracy.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_mirador_accuracy.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_mirador_accuracy.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV4ImplementationResults-FinalAssessment.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV4ImplementationResults-FinalAssessment.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV4ImplementationResults-FinalAssessment.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_requirements.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_requirements.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_requirements.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_emergency_recovery.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_emergency_recovery.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_emergency_recovery.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_theme_generator.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_theme_generator.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_theme_generator.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Infrastructure Crisis: Strategic Recovery Plan.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Infrastructure Crisis: Strategic Recovery Plan.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador Infrastructure Crisis: Strategic Recovery Plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_commands.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_commands.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_commands.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/usage-instructions.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/usage-instructions.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/usage-instructions.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_specialist_usage.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_specialist_usage.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_specialist_usage.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicPlanningChains(4-6Models)forComplexDecisions.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicPlanningChains(4-6Models)forComplexDecisions.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/StrategicPlanningChains(4-6Models)forComplexDecisions.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/robust_chain_runner.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Review and Phase 2 Preparation - Complete Action Plan.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Review and Phase 2 Preparation - Complete Action Plan.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Review and Phase 2 Preparation - Complete Action Plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_model_performance.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_model_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/test_model_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/REQUIREMENTS.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/REQUIREMENTS.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/REQUIREMENTS.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorChainLibrarywithUsageGuidelines.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorChainLibrarywithUsageGuidelines.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorChainLibrarywithUsageGuidelines.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_optimization_report.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_optimization_report.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_optimization_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorProjectAnalysis&OptimizationReport.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorProjectAnalysis&OptimizationReport.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorProjectAnalysis&OptimizationReport.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionPlanningandImplementationGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionPlanningandImplementationGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionPlanningandImplementationGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainPromptSuiteQuickDecisionChains(2-3Models).md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainPromptSuiteQuickDecisionChains(2-3Models).md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainPromptSuiteQuickDecisionChains(2-3Models).md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorVersionControlSetupCommands.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorVersionControlSetupCommands.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorVersionControlSetupCommands.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_with_memory.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_with_memory.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_with_memory.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorCommandInterfaceTroubleshooting&Fixes.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorCommandInterfaceTroubleshooting&Fixes.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorCommandInterfaceTroubleshooting&Fixes.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/enhanced_agent_enforcer_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/enhanced_agent_enforcer_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/enhanced_agent_enforcer_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/EnhancedMiradorImplementationwithTroubleshooting.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/EnhancedMiradorImplementationwithTroubleshooting.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/EnhancedMiradorImplementationwithTroubleshooting.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/restore_models.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/restore_models.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/restore_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_config_generator.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_config_generator.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_config_generator.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_opportunity_test.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_opportunity_test.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/quick_opportunity_test.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/view_validation_results.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/view_validation_results.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/view_validation_results.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_diagnostic.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_diagnostic.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_model_diagnostic.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.25.23AM.png' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.25.23AM.png'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.25.23AM.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_evaluator.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_evaluator.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_evaluator.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/USAGE_INSTRUCTIONS.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/USAGE_INSTRUCTIONS.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/USAGE_INSTRUCTIONS.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_actionable.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_actionable.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_actionable.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/setup_maintenance_cron.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/setup_maintenance_cron.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/setup_maintenance_cron.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_decisions.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_decisions.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/track_decisions.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/todo.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/todo.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/optimize_model_parameters.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/optimize_model_parameters.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/optimize_model_parameters.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSystemRequirements.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSystemRequirements.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSystemRequirements.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteEnhancedMirador-EZImplementationScripts.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteEnhancedMirador-EZImplementationScripts.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteEnhancedMirador-EZImplementationScripts.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationResultsAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationResultsAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationResultsAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_architecture_diagram.png' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_architecture_diagram.png'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_architecture_diagram.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/smart_chain_selector.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/smart_chain_selector.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/smart_chain_selector.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageInstructions.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageInstructions.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUsageInstructions.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/🎯MiradorRobustPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/🎯MiradorRobustPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/🎯MiradorRobustPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CriticalMiradorImplementationFixes-ImmediateActionRequired.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CriticalMiradorImplementationFixes-ImmediateActionRequired.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CriticalMiradorImplementationFixes-ImmediateActionRequired.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_analysis_findings.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_analysis_findings.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_analysis_findings.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_domains.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_domains.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_domains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPersonalAIOrchestrationFramework.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPersonalAIOrchestrationFramework.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPersonalAIOrchestrationFramework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_technical_docs.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_technical_docs.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_technical_docs.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_fixes.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_fixes.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/validate_fixes.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/knowledge_base_analyzer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/knowledge_base_analyzer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/knowledge_base_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_visual_architecture.html' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_visual_architecture.html'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_visual_architecture.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical_assessment.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical_assessment.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/technical_assessment.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationSequenceGuideStep-by-StepRoadmap.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationSequenceGuideStep-by-StepRoadmap.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationSequenceGuideStep-by-StepRoadmap.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/cross_model_synthesizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/cross_model_synthesizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/cross_model_synthesizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_setup_guide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_setup_guide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_setup_guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/meta_chain_optimizer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/meta_chain_optimizer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/meta_chain_optimizer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveMiradorPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_provider_optimized.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_provider_optimized.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/user_context_provider_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_production_test_suite.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_production_test_suite.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_production_test_suite.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/STRATEGIC_PROMPT_LIBRARY.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/STRATEGIC_PROMPT_LIBRARY.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/STRATEGIC_PROMPT_LIBRARY.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationResultsAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationResultsAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorV3ImplementationResultsAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/version_info.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/version_info.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/version_info.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ACTION_PLANNING_GUIDE.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ACTION_PLANNING_GUIDE.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ACTION_PLANNING_GUIDE.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_synthesis_recommendations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/IMMEDIATE ACTION PLAN - Mirador Content Generation Crisis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/IMMEDIATE ACTION PLAN - Mirador Content Generation Crisis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/IMMEDIATE ACTION PLAN - Mirador Content Generation Crisis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_recommendations.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_recommendations.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_recommendations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_performance_tester.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_performance_tester.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_performance_tester.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/financial_planning_expert_optimized.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/financial_planning_expert_optimized.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/financial_planning_expert_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteMiradorSpecialistModelLibrarywithOptimizedOllamaConfigurations.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteMiradorSpecialistModelLibrarywithOptimizedOllamaConfigurations.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/CompleteMiradorSpecialistModelLibrarywithOptimizedOllamaConfigurations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UserScott-PersonaDossier.docx' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UserScott-PersonaDossier.docx'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UserScott-PersonaDossier.docx'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/compass_artifact_wf-639ebc10-e023-4d93-bb50-4af52b602cda_text_markdown.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/compass_artifact_wf-639ebc10-e023-4d93-bb50-4af52b602cda_text_markdown.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/compass_artifact_wf-639ebc10-e023-4d93-bb50-4af52b602cda_text_markdown.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Model Consolidation - Execution Results Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Model Consolidation - Execution Results Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 1 Model Consolidation - Execution Results Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_roadmap.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_roadmap.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/implementation_roadmap.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainImplementationGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainImplementationGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Mirador-EZChainImplementationGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.24.51AM.png' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.24.51AM.png'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Screenshot2025-06-16at10.24.51AM.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TerminalOutputAnalysis-ImplementationIssuesandSolutions.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TerminalOutputAnalysis-ImplementationIssuesandSolutions.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TerminalOutputAnalysis-ImplementationIssuesandSolutions.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_deep_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_deep_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_deep_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceOptimizationImplementation.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceOptimizationImplementation.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceOptimizationImplementation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Updated Strategic Recommendations for Mirador Crisis Recovery.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Updated Strategic Recommendations for Mirador Crisis Recovery.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Updated Strategic Recommendations for Mirador Crisis Recovery.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/shortcuts-automation.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/shortcuts-automation.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/shortcuts-automation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_maintenance.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_maintenance.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 2 Readiness Assessment and Strategic Recommendations.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 2 Readiness Assessment and Strategic Recommendations.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/Phase 2 Readiness Assessment and Strategic Recommendations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-smart.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-smart.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-smart.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveReviewMiradorAIOrchestrationSystem.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveReviewMiradorAIOrchestrationSystem.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveReviewMiradorAIOrchestrationSystem.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorMulti-AgentProjectSynthesisandRecommendations.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorMulti-AgentProjectSynthesisandRecommendations.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorMulti-AgentProjectSynthesisandRecommendations.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystemAComprehensiveSynthesis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystemAComprehensiveSynthesis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationSystemAComprehensiveSynthesis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/opportunity_confidence_scorer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/DOCUMENTATION_INDEX.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/DOCUMENTATION_INDEX.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/DOCUMENTATION_INDEX.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/QualityAssessmentCommandsforMiradorChainOutput.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/QualityAssessmentCommandsforMiradorChainOutput.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/QualityAssessmentCommandsforMiradorChainOutput.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_prompt_library.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_prompt_library.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_prompt_library.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/fact_validation_specialist.modelfile' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/fact_validation_specialist.modelfile'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/fact_validation_specialist.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MODEL_INVENTORY.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MODEL_INVENTORY.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MODEL_INVENTORY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_qa_comprehensive.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_qa_comprehensive.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_qa_comprehensive.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUseCasesandPersonalLifeApplications.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUseCasesandPersonalLifeApplications.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorUseCasesandPersonalLifeApplications.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/rank_opportunities.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/rank_opportunities.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/rank_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_chain_debugger.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_chain_debugger.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_chain_debugger.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_readme.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_readme.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_readme.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/BREAKTHROUGHRootCauseIdentifiedandFinalSolution.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/BREAKTHROUGHRootCauseIdentifiedandFinalSolution.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/BREAKTHROUGHRootCauseIdentifiedandFinalSolution.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/performance_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/performance_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/performance_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_maintenance.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_maintenance.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/system_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_fact_validator.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_fact_validator.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_fact_validator.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIFrameworkAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorStrategicPromptLibraryTransformingIdeasintoOpportunities.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorStrategicPromptLibraryTransformingIdeasintoOpportunities.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorStrategicPromptLibraryTransformingIdeasintoOpportunities.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceImprovementCommands.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceImprovementCommands.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorPerformanceImprovementCommands.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_immediate_commands.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_immediate_commands.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_immediate_commands.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDevelopmentPrioritiesAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDevelopmentPrioritiesAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorDevelopmentPrioritiesAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_executive_summary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_reference_card.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_reference_card.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_reference_card.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/insights_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_personality_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_personality_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_personality_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveFileReviewAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveFileReviewAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveFileReviewAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/phase2_readiness_validator.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/phase2_readiness_validator.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/phase2_readiness_validator.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TheMiradorJourneyFromAnalysistoProduction-ReadyPersonalAIOrchestration.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TheMiradorJourneyFromAnalysistoProduction-ReadyPersonalAIOrchestration.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/TheMiradorJourneyFromAnalysistoProduction-ReadyPersonalAIOrchestration.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/personality_optimized_chains.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/personality_optimized_chains.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/personality_optimized_chains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_mirador_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_mirador_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/weekly_mirador_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableSystemCompleteImplementationPackage.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableSystemCompleteImplementationPackage.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorActionableSystemCompleteImplementationPackage.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkAnalysis.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkAnalysis.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkAnalysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorTechnicalDocumentation.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorTechnicalDocumentation.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorTechnicalDocumentation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework-TechnicalDocumentation.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework-TechnicalDocumentation.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework-TechnicalDocumentation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorAIOrchestrationFramework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/install_mirador.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/install_mirador.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/install_mirador.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/README.pdf' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/README.pdf'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/README.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-readme.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-readme.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador-readme.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SpecializedMusicCareerDevelopmentChains.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SpecializedMusicCareerDevelopmentChains.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/SpecializedMusicCareerDevelopmentChains.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelInventory.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelInventory.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorModelInventory.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSetupandMaintenanceGuide.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSetupandMaintenanceGuide.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorSetupandMaintenanceGuide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationAnalysisComprehensiveFeedbackReport.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationAnalysisComprehensiveFeedbackReport.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorImplementationAnalysisComprehensiveFeedbackReport.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveQualityAssessmentofMiradorChainOutputs.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveQualityAssessmentofMiradorChainOutputs.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/ComprehensiveQualityAssessmentofMiradorChainOutputs.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/master_insights_organizer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_content_diagnostic.py' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_content_diagnostic.py'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/mirador_content_diagnostic.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorComprehensiveFixImplementationPlan.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorComprehensiveFixImplementationPlan.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorComprehensiveFixImplementationPlan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkRequirements.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkRequirements.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorFrameworkRequirements.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/morning_intelligence_brief.sh' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/morning_intelligence_brief.sh'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/morning_intelligence_brief.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UnifiedMiradorImplementationGuideCompleteSystemIntegration.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UnifiedMiradorImplementationGuideCompleteSystemIntegration.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/UnifiedMiradorImplementationGuideCompleteSystemIntegration.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEcosystemAnalysis_ASophisticatedAIOrchestrationMasterpiece.md' ]; then
    rm 'Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEcosystemAnalysis_ASophisticatedAIOrchestrationMasterpiece.md'
    echo 'Deleted: Documentation and Saved Assets/Synthesize Recommendations for Mirador Multi-Agent Project/MiradorEcosystemAnalysis_ASophisticatedAIOrchestrationMasterpiece.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/chart_script.py' ]; then
    rm 'Documentation and Saved Assets/exported-assets/chart_script.py'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/chart_script.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/chart_script_1.py' ]; then
    rm 'Documentation and Saved Assets/exported-assets/chart_script_1.py'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/chart_script_1.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/AI-Powered Personal Advisory System_ A Complete Po.pdf' ]; then
    rm 'Documentation and Saved Assets/exported-assets/AI-Powered Personal Advisory System_ A Complete Po.pdf'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/AI-Powered Personal Advisory System_ A Complete Po.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/AI-Powered Content Creation Tools for Risk Managem.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/AI-Powered Content Creation Tools for Risk Managem.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/AI-Powered Content Creation Tools for Risk Managem.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai_content_tools_comparison.png' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai_content_tools_comparison.png'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai_content_tools_comparison.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/AI_Content_Creation_Risk_Management_Guide.pdf' ]; then
    rm 'Documentation and Saved Assets/exported-assets/AI_Content_Creation_Risk_Management_Guide.pdf'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/AI_Content_Creation_Risk_Management_Guide.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/script_1.py' ]; then
    rm 'Documentation and Saved Assets/exported-assets/script_1.py'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/script_1.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/script_2.py' ]; then
    rm 'Documentation and Saved Assets/exported-assets/script_2.py'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/script_2.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/script.py' ]; then
    rm 'Documentation and Saved Assets/exported-assets/script.py'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/script.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai_implementation_timeline.png' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai_implementation_timeline.png'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai_implementation_timeline.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/index.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/index.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/presentation-slides.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/presentation-slides.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/presentation-slides.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/linkedin-showcase-post.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/linkedin-showcase-post.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/linkedin-showcase-post.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-advisor-methodology.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-advisor-methodology.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/ai-advisor-methodology.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/style.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/style.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/app.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/app.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-advisor-showcase (1)/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/index.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/index.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-showcase-presentation/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-showcase-presentation/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/style.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/style.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-showcase-presentation/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/app.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/ai-showcase-presentation/app.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/ai-showcase-presentation/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/style_1.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/style_1.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/style_1.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-post-templates.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-post-templates.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-post-templates.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/index.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/index.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/app_1.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/app_1.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/app_1.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/presentation-slides.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/presentation-slides.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/presentation-slides.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/index_1.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/index_1.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/index_1.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-showcase-post.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-showcase-post.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/linkedin-showcase-post.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-methodology.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-methodology.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-methodology.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/style.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/style.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/app.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/app.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/index.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/index.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/style.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/style.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/app.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/app.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-showcase-presentation/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/index.html' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/index.html'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/presentation-slides.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/presentation-slides.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/presentation-slides.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/linkedin-showcase-post.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/linkedin-showcase-post.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/linkedin-showcase-post.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-implementation-framework.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-implementation-framework.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-advisor-methodology.md' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-advisor-methodology.md'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/ai-advisor-methodology.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/style.css' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/style.css'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/app.js' ]; then
    rm 'Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/app.js'
    echo 'Deleted: Documentation and Saved Assets/exported-assets/exported-assets_phase2/ai-advisor-showcase/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/sales_content_creator.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/sales_content_creator.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/sales_content_creator.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/prepare_release.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/prepare_release.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/prepare_release.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/quick_opportunity.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/quick_opportunity.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/quick_opportunity.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/repo_tree.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/repo_tree.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/repo_tree.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monitor_mirador_performance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monitor_mirador_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monitor_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/doc_index.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/doc_index.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/doc_index.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PROJECT_FILE_CATALOG.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PROJECT_FILE_CATALOG.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PROJECT_FILE_CATALOG.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_new_model.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_new_model.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_new_model.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_conductor.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_conductor.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_conductor.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/comprehensive_performance_test.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/comprehensive_performance_test.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/comprehensive_performance_test.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-ez' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-ez'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-ez'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/evening_optimization_review.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/evening_optimization_review.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/evening_optimization_review.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/robust_chain_runner_macos.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/robust_chain_runner_macos.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/robust_chain_runner_macos.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/validate_production_readiness.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/validate_production_readiness.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/validate_production_readiness.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_strategic_deep_dive.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_strategic_deep_dive.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_strategic_deep_dive.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_scorer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_scorer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/decision_enhancer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/decision_enhancer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/decision_enhancer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_brand_specialists.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_brand_specialists.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_brand_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/digital_asset_curator.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/digital_asset_curator.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/digital_asset_curator.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_analyst.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_analyst.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_analyst.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v6.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v6.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_review_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_review_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_review_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/script_map.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/script_map.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/script_map.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/final_validation.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/final_validation.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/final_validation.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_touring_readiness_assessment.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_touring_readiness_assessment.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_touring_readiness_assessment.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/immediate_action_plan.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/immediate_action_plan.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/immediate_action_plan.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PROJECT_STATUS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PROJECT_STATUS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/advanced_test_scenarios.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/advanced_test_scenarios.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/advanced_test_scenarios.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_personality_review.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_personality_review.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_personality_review.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/louisville_expert_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/louisville_expert_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/louisville_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/health_check.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/health_check.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/health_check.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/performance_anxiety_coach.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/performance_anxiety_coach.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/performance_anxiety_coach.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v7.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v7.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v7.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_opportunity_scan.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_opportunity_scan.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_opportunity_scan.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/comprehensive_opportunity_validation.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/comprehensive_opportunity_validation.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/comprehensive_opportunity_validation.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/touring_readiness_coach.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/touring_readiness_coach.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/touring_readiness_coach.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_system_specialist.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_system_specialist.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_system_specialist.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/output_quality_analyzer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/output_quality_analyzer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/output_quality_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_action_tracker.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_action_tracker.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_action_tracker.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/strategic_music_networking.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/strategic_music_networking.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/strategic_music_networking.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/LICENSE' ]; then
    rm 'Documentation and Saved Assets/mirador-main/LICENSE'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/LICENSE'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_mirador_workflow.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_mirador_workflow.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_mirador_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/feedback_loop_optimizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/feedback_loop_optimizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/feedback_loop_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/requirements.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/requirements.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/requirements.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/fix_enhanced_agent.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/fix_enhanced_agent.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/fix_enhanced_agent.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/feedback_loop_optimizer_fixed.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/feedback_loop_optimizer_fixed.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/feedback_loop_optimizer_fixed.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/quick_optimize.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/quick_optimize.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/quick_optimize.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/user_context_provider_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/user_context_provider_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/user_context_provider_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monitor_mirador_performance_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monitor_mirador_performance_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monitor_mirador_performance_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_self_reflection_guardian.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_self_reflection_guardian.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_self_reflection_guardian.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PROMPT_LIBRARY.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PROMPT_LIBRARY.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PROMPT_LIBRARY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/ultimate_performance_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/ultimate_performance_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/ultimate_performance_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/father_daughter_wisdom_guide.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/father_daughter_wisdom_guide.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/father_daughter_wisdom_guide.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_personality_quick_reference.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_personality_quick_reference.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_personality_quick_reference.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/linkedin_content_expert.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/linkedin_content_expert.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/linkedin_content_expert.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/personality_integration_summary.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/personality_integration_summary.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/personality_integration_summary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/personal_brand_architect.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/personal_brand_architect.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/personal_brand_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/validate_opportunities.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/validate_opportunities.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/validate_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/archive_old_outputs.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/archive_old_outputs.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/archive_old_outputs.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/track_mirador_roi.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/track_mirador_roi.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/track_mirador_roi.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/ARCHITECTURE_OVERVIEW.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/ARCHITECTURE_OVERVIEW.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/ARCHITECTURE_OVERVIEW.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_validation.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_validation.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_validation.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/system_validation.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/system_validation.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/system_validation.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/run_test_chains.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/run_test_chains.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/run_test_chains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/quick_linkedin_post.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/quick_linkedin_post.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/quick_linkedin_post.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/audit_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/audit_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/audit_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/health_wellness_optimizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/health_wellness_optimizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/health_wellness_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/track_opportunity.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/track_opportunity.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/track_opportunity.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_models_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_models_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_models_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/user_context_manager.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/user_context_manager.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/user_context_manager.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_mirador_accuracy.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_mirador_accuracy.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_mirador_accuracy.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/IMPLEMENTATION_ROADMAP_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/IMPLEMENTATION_ROADMAP_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/IMPLEMENTATION_ROADMAP_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_fast.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_fast.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_fast.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_theme_generator.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_theme_generator.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_theme_generator.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-unified' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-unified'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-unified'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/june_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/june_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/june_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/personality_integration_report.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/personality_integration_report.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/personality_integration_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/TEST_CHAIN_ANALYSIS_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/TEST_CHAIN_ANALYSIS_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/TEST_CHAIN_ANALYSIS_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_system_specialist_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_system_specialist_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_system_specialist_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v7.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v7.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v7.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/ranked_opportunities.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/ranked_opportunities.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/ranked_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/robust_chain_runner.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/robust_chain_runner.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/robust_chain_runner.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_model_performance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_model_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_model_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/WEEKLY_REVIEW_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/WEEKLY_REVIEW_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/WEEKLY_REVIEW_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/father_daughter_music_mentor.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/father_daughter_music_mentor.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/father_daughter_music_mentor.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/louisville_expert_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/louisville_expert_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/louisville_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_implementation_tracker.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_implementation_tracker.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_implementation_tracker.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_optimization_report.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_optimization_report.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_optimization_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_with_memory.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_with_memory.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_with_memory.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_enforcer_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/music_industry_networker.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/music_industry_networker.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/music_industry_networker.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/fix_shell_comments.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/fix_shell_comments.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/fix_shell_comments.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_complete_system.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_complete_system.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_complete_system.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/restore_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/restore_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/restore_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v6.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v6.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/user_context_provider.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/user_context_provider.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/user_context_provider.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/quick_opportunity_test.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/quick_opportunity_test.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/quick_opportunity_test.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/view_validation_results.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/view_validation_results.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/view_validation_results.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_evaluator.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_evaluator.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_evaluator.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_unified_reference.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_unified_reference.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_unified_reference.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_system_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_system_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_system_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_music_career_accelerator.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_music_career_accelerator.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_music_career_accelerator.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/benchmark_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/benchmark_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/benchmark_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/setup_maintenance_cron.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/setup_maintenance_cron.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/setup_maintenance_cron.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_memory.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_memory.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_memory.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/track_decisions.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/track_decisions.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/track_decisions.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_dream_specialists.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_dream_specialists.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_dream_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/user_context_provider_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/user_context_provider_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/user_context_provider_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_mirador_performance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_mirador_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/backup_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/backup_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/backup_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/optimize_model_parameters.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/optimize_model_parameters.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/optimize_model_parameters.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/music_career_timeline_strategist.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/music_career_timeline_strategist.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/music_career_timeline_strategist.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_memory_system.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_memory_system.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_memory_system.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/smart_chain_selector.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/smart_chain_selector.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/smart_chain_selector.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_dashboard.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_dashboard.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_dashboard.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/digital_storyteller.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/digital_storyteller.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/digital_storyteller.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/README.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/README.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/README.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-smart' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-smart'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-smart'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_domains.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_domains.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_domains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/side_income_opportunity_scout.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/side_income_opportunity_scout.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/side_income_opportunity_scout.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/OPPORTUNITY_SCORES_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/guitar_tone_architect.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/guitar_tone_architect.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/guitar_tone_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/detect_hanging.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/detect_hanging.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/detect_hanging.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/decision_simplifier_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/decision_simplifier_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/decision_simplifier_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/validate_fixes.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/validate_fixes.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/validate_fixes.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/knowledge_base_analyzer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/knowledge_base_analyzer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/knowledge_base_analyzer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/output_map.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/output_map.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/output_map.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v4.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v4.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_system_status.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_system_status.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_system_status.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-intervene' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-intervene'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-intervene'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/cross_model_synthesizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/cross_model_synthesizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/cross_model_synthesizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/ACTION_TRACKER.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/ACTION_TRACKER.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/ACTION_TRACKER.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/meta_chain_optimizer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/meta_chain_optimizer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/meta_chain_optimizer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/extract_top_opportunities.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/extract_top_opportunities.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/extract_top_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/user_context_provider_optimized.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/user_context_provider_optimized.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/user_context_provider_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_health_report_20250618_153258.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_health_report_20250618_153258.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_health_report_20250618_153258.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/consolidate_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/consolidate_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/consolidate_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/deploy_production_mirador.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/deploy_production_mirador.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/deploy_production_mirador.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/content_strategist_pro.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/content_strategist_pro.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/content_strategist_pro.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_production_test_suite.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_production_test_suite.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_production_test_suite.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-interactive' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-interactive'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-interactive'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/version_info.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/version_info.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/version_info.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v5.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v5.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/IMMEDIATE_ACTION_PLAN_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/IMMEDIATE_ACTION_PLAN_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/IMMEDIATE_ACTION_PLAN_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/business_opportunity_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/business_opportunity_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/business_opportunity_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/extract_high_value_insights.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/extract_high_value_insights.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/extract_high_value_insights.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-collaborate' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-collaborate'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-collaborate'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_v1.0_complete_20250611.tar.gz' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_v1.0_complete_20250611.tar.gz'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_v1.0_complete_20250611.tar.gz'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_optimized.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_optimized.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_optimized.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PRODUCTION_USAGE_GUIDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PRODUCTION_USAGE_GUIDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PRODUCTION_USAGE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/implementation_roadmap.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/implementation_roadmap.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/implementation_roadmap.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_deep_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_deep_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_deep_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_executive_summary.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_executive_summary.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_executive_summary.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/unified_mirador_reference.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/unified_mirador_reference.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/unified_mirador_reference.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/outputs_archive_20250618.tar.gz' ]; then
    rm 'Documentation and Saved Assets/mirador-main/outputs_archive_20250618.tar.gz'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/outputs_archive_20250618.tar.gz'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/insights_dashboard_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/insights_dashboard_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/insights_dashboard_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v8.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v8.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v8.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PYTHON_INTERFACE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PYTHON_INTERFACE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-conductor' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-conductor'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-conductor'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/modelfile_map.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/modelfile_map.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/modelfile_map.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_maintenance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_maintenance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/CURRENT_PROJECT_STATUS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/CURRENT_PROJECT_STATUS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/CURRENT_PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-smart.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-smart.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-smart.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/detect_hanging_macos.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/detect_hanging_macos.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/detect_hanging_macos.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/EXECUTIVE_SUMMARY_20250608.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/EXECUTIVE_SUMMARY_20250608.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/EXECUTIVE_SUMMARY_20250608.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_confidence_scorer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/PROJECT_COMPLETION_REPORT.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/PROJECT_COMPLETION_REPORT.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/PROJECT_COMPLETION_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/generate_domain_plans.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/generate_domain_plans.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/generate_domain_plans.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/productivity_optimizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/productivity_optimizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/productivity_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/TOP_OPPORTUNITIES.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/TOP_OPPORTUNITIES.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/TOP_OPPORTUNITIES.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/advanced_opportunity_analytics.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/advanced_opportunity_analytics.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/advanced_opportunity_analytics.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/decision_simplifier_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/decision_simplifier_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/decision_simplifier_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/MODEL_INVENTORY.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/MODEL_INVENTORY.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/MODEL_INVENTORY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_qa_comprehensive.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_qa_comprehensive.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_qa_comprehensive.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunity_validator_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunity_validator_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunity_validator_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/master_guitar_instructor.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/master_guitar_instructor.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/master_guitar_instructor.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/rank_opportunities.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/rank_opportunities.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/rank_opportunities.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/analyze_test_results.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/analyze_test_results.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/analyze_test_results.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/performance_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/performance_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/performance_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/TECHNICAL_DOCUMENTATION.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/TECHNICAL_DOCUMENTATION.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/TECHNICAL_DOCUMENTATION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/system_maintenance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/system_maintenance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/system_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_system_validation_v2.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_system_validation_v2.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_system_validation_v2.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_system_validation.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_system_validation.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_system_validation.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v5.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v5.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/USAGE_INSTRUCTIONS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/USAGE_INSTRUCTIONS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/USAGE_INSTRUCTIONS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-rapid' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-rapid'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-rapid'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/insights_dashboard.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/insights_dashboard.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/insights_dashboard.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/engagement_optimizer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/engagement_optimizer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/engagement_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_personality_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_personality_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_personality_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/personality_optimized_chains.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/personality_optimized_chains.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/personality_optimized_chains.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_mirador_optimization.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_mirador_optimization.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_mirador_optimization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/generate_health_report.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/generate_health_report.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/generate_health_report.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v4.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/financial_planning_expert_v4.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/financial_planning_expert_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/create_content_specialists.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/create_content_specialists.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/create_content_specialists.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/CLAUDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/CLAUDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/CLAUDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/analyze_test_suite_results.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/analyze_test_suite_results.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/analyze_test_suite_results.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/advanced_automation_suite.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/advanced_automation_suite.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/advanced_automation_suite.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador-smart-v2' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador-smart-v2'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador-smart-v2'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/linkedin_voice_architect.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/linkedin_voice_architect.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/linkedin_voice_architect.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/master_insights_organizer_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/master_insights_organizer_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/master_insights_organizer_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/analyze_mirador_value.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/analyze_mirador_value.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/analyze_mirador_value.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/prompt_templates.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/prompt_templates.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/prompt_templates.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/audio_production_strategist.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/audio_production_strategist.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/audio_production_strategist.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/master_insights_organizer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/master_insights_organizer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/master_insights_organizer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_check_enhanced.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_check_enhanced.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_check_enhanced.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_music_breakthrough_analysis.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_music_breakthrough_analysis.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_music_breakthrough_analysis.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_performance_macos.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_performance_macos.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_performance_macos.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/daily_check.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/daily_check.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/daily_check.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/morning_intelligence_brief.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/morning_intelligence_brief.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/morning_intelligence_brief.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/test_balanced_model.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/test_balanced_model.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/test_balanced_model.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/enhanced_agent_fast_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/03_financial_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/03_financial_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/04_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/04_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/02_local_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/02_local_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/01_opportunities.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/01_opportunities.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_163038/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/02_louisville_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/02_louisville_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/02_louisville_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/04_implementation_roadmap.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/04_implementation_roadmap.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/04_implementation_roadmap.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/03_financial_projections.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/03_financial_projections.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/03_financial_projections.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/OPPORTUNITY_SCORE_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/05_risk_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/05_risk_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/05_risk_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/01_market_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/01_market_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_164243_scored/01_market_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/03_financial_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/03_financial_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/04_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/04_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/02_local_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/02_local_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/01_opportunities.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/01_opportunities.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_153122/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/OPPORTUNITY_SUMMARY.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/03_financial_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/03_financial_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/03_financial_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/04_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/04_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/04_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/02_local_analysis.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/02_local_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/02_local_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/01_opportunities.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/01_opportunities.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/opportunities/20250606_151337/01_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_reports/20250613_insights.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_reports/20250613_insights.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_reports/20250613_insights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_reports/20250611/weekly_report.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_reports/20250611/weekly_report.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_reports/20250611/weekly_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/weekly_reports/20250613/weekly_report.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/weekly_reports/20250613/weekly_report.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/weekly_reports/20250613/weekly_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/config/config.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/config/config.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/config/config.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/config/intervention.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/config/intervention.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/config/intervention.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/project_documentation/PRODUCTION_USAGE_GUIDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/project_documentation/PRODUCTION_USAGE_GUIDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/project_documentation/PRODUCTION_USAGE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/project_documentation/unified_mirador_reference.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/project_documentation/unified_mirador_reference.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/project_documentation/unified_mirador_reference.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/project_documentation/PROJECT_COMPLETION_REPORT.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/project_documentation/PROJECT_COMPLETION_REPORT.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/project_documentation/PROJECT_COMPLETION_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/run_all_tests.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/run_all_tests.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/run_all_tests.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/fix_tests.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/fix_tests.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/fix_tests.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_creative_entrepreneur.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_creative_entrepreneur.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_creative_entrepreneur.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_code_reviewer_fix.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_code_reviewer_fix.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_code_reviewer_fix.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_enhanced_agent.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_enhanced_agent.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_enhanced_agent.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_master_coder.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_master_coder.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_master_coder.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_llama3.2_balanced.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_llama3.2_balanced.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_llama3.2_balanced.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_guitar_expert_precise.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_guitar_expert_precise.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_guitar_expert_precise.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_fast_agent_focused.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_fast_agent_focused.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_fast_agent_focused.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/models/test_file_reviewer.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/models/test_file_reviewer.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/models/test_file_reviewer.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/test_report_20250520_142559.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/test_report_20250520_142559.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/test_report_20250520_142559.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/test_report_20250617_113645.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/test_report_20250617_113645.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/test_report_20250617_113645.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250520_143153/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250617_113717/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/master_coder_20250520_143153/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/llama3.2_balanced_20250617_113717/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250617_113645/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/code_reviewer_fix_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250617_113658/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/guitar_expert_precise_20250520_143235/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/file_reviewer_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/fast_agent_focused_20250520_142559/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/enhanced_agent_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/metadata.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/metadata.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/metadata.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/response.json' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/response.json'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/response.json'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/output.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/output.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/results/creative_entrepreneur_20250617_113646/output.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/chains/test_guitar_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/chains/test_guitar_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/chains/test_guitar_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/chains/test_role_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/chains/test_role_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/chains/test_role_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/chains/test_code_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/chains/test_code_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/chains/test_code_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/tests/chains/test_business_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/tests/chains/test_business_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/tests/chains/test_business_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/SIMPLIFIED_COMMANDS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/SIMPLIFIED_COMMANDS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/SIMPLIFIED_COMMANDS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/USER_INTERVENTION.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/USER_INTERVENTION.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/USER_INTERVENTION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/COMPACT_MODE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/COMPACT_MODE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/COMPACT_MODE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/USAGE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/USAGE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/USAGE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/PROGRESS_VISUALIZATION.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/PROGRESS_VISUALIZATION.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/PROGRESS_VISUALIZATION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/MODELS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/MODELS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/MODELS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/FUTURE_ENHANCEMENTS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/FUTURE_ENHANCEMENTS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/FUTURE_ENHANCEMENTS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/UNIFIED_INTERFACE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/UNIFIED_INTERFACE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/UNIFIED_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/QUICK_REFERENCE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/QUICK_REFERENCE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/QUICK_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/design/BIDIRECTIONAL_COMMUNICATION.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/design/BIDIRECTIONAL_COMMUNICATION.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/design/BIDIRECTIONAL_COMMUNICATION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_SELECTION_CARD.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_SELECTION_CARD.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_SELECTION_CARD.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_PROMPT_GUIDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_PROMPT_GUIDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_PROMPT_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/WORKFLOW_PATTERNS.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/WORKFLOW_PATTERNS.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/WORKFLOW_PATTERNS.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/TEMPERATURE_GUIDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/TEMPERATURE_GUIDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/TEMPERATURE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_ARCHITECTURE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_ARCHITECTURE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/MODEL_ARCHITECTURE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_FAQ.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_FAQ.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_FAQ.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_REFERENCE_CARD.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_REFERENCE_CARD.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/OLLAMA_REFERENCE_CARD.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/docs/ollama/ONE_PAGE_REFERENCE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/docs/ollama/ONE_PAGE_REFERENCE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/docs/ollama/ONE_PAGE_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/prepare_release.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/prepare_release.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/prepare_release.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/create_new_model.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/create_new_model.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/create_new_model.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_production_readiness.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_production_readiness.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_production_readiness.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/louisville_expert_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/louisville_expert_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/louisville_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_mirador_accuracy.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_mirador_accuracy.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_mirador_accuracy.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/git_status.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/git_status.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/git_status.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_model_performance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_model_performance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/test_model_performance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/restore_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/restore_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/restore_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/setup_maintenance_cron.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/setup_maintenance_cron.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/setup_maintenance_cron.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/backup_models.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/backup_models.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/backup_models.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/README.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/README.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/README.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_fixes.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_fixes.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/validate_fixes.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/version_info.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/version_info.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/version_info.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/PYTHON_INTERFACE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/PYTHON_INTERFACE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_maintenance.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_maintenance.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_qa_comprehensive.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_qa_comprehensive.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/mirador_qa_comprehensive.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/ollama_models.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/ollama_models.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/ollama_models.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/CLAUDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/CLAUDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/CLAUDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_reports/local_2025_06.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_reports/local_2025_06.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_reports/local_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_reports/financial_2025_06.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_reports/financial_2025_06.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_reports/financial_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_reports/professional_2025_06.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_reports/professional_2025_06.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_reports/professional_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/monthly_reports/wellness_2025_06.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/monthly_reports/wellness_2025_06.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/monthly_reports/wellness_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/high_value_insights/business_insights.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/high_value_insights/business_insights.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/high_value_insights/business_insights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/high_value_insights/real_estate_insights.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/high_value_insights/real_estate_insights.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/high_value_insights/real_estate_insights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/high_value_insights/financial_insights.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/high_value_insights/financial_insights.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/high_value_insights/financial_insights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/high_value_insights/career_insights.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/high_value_insights/career_insights.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/high_value_insights/career_insights.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/setup.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/setup.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/setup.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/test_workflow.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/test_workflow.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/test_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/run_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/run_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/run_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/test_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/test_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/test_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/MODEL_PROMPT_GUIDE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/MODEL_PROMPT_GUIDE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/MODEL_PROMPT_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/run_workflow.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/run_workflow.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/run_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/domain-collab' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/domain-collab'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/domain-collab'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/run_role_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/run_role_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/run_role_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/run-ollama.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/run-ollama.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/run-ollama.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/test_simple.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/test_simple.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/test_simple.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/direct-ollama.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/direct-ollama.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/direct-ollama.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/OLLAMA_REFERENCE_CARD.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/OLLAMA_REFERENCE_CARD.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/OLLAMA_REFERENCE_CARD.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/ollama-easy' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/ollama-easy'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/ollama-easy'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/scripts/ONE_PAGE_REFERENCE.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/scripts/ONE_PAGE_REFERENCE.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/scripts/ONE_PAGE_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/models_before_upgrade.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/models_before_upgrade.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/rollback_script.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/rollback_script.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225456/rollback_script.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/models_before_upgrade.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/models_before_upgrade.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/rollback_script.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/rollback_script.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backups/20250606_081851/rollback_script.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225409/models_before_upgrade.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225409/models_before_upgrade.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/mirador_backups/20250605_225409/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/templates/financial_planning.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/templates/financial_planning.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/templates/financial_planning.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/templates/guitar_practice.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/templates/guitar_practice.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/templates/guitar_practice.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/templates/daily_planning.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/templates/daily_planning.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/templates/daily_planning.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/templates/career_development.txt' ]; then
    rm 'Documentation and Saved Assets/mirador-main/templates/career_development.txt'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/templates/career_development.txt'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/domain_action_plans/financial_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/domain_action_plans/financial_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/domain_action_plans/financial_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/domain_action_plans/health_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/domain_action_plans/health_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/domain_action_plans/health_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/domain_action_plans/business_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/domain_action_plans/business_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/domain_action_plans/business_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/domain_action_plans/career_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/domain_action_plans/career_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/domain_action_plans/career_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/domain_action_plans/real_estate_action_plan.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/domain_action_plans/real_estate_action_plan.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/domain_action_plans/real_estate_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/MASTER_INDEX.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/MASTER_INDEX.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/MASTER_INDEX.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_164709.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_164709.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_163410.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_163410.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_151130.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_151130.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_084544.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_084544.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154817.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154817.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_094827.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_094827.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153213.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153213.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_152012.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_152012.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_130952.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_130952.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_190418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_190418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_153534.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_153534.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_083359.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_083359.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/short_term/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_102056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_102056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095519.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095519.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_084544.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_084544.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145454.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145454.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153213.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153213.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_130952.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_130952.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_185032.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_185032.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090914.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090914.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/career/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_225302.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_225302.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_225302.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_085008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_085008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090813.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090813.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_164709.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_164709.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_083348.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_083348.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_083348.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_163410.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_163410.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_151130.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_151130.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142607.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142607.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142607.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093802.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093802.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_082055.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_082055.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_082055.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142450.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142450.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095519.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095519.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143531.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143531.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_084544.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_084544.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145454.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145454.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154817.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154817.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163208.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163208.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163208.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_001724.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_001724.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_001724.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003452.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003452.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003452.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094827.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094827.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153213.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153213.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_152012.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_152012.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/rapid_20250525_220654.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/rapid_20250525_220654.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_074035.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_074035.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_130952.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_130952.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_185032.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_185032.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_153534.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_153534.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090914.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090914.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153501.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153501.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163314.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163314.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250604_163314.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083359.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083359.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250520_182850.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250520_182850.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250520_182850.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_084304.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_084304.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092331.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092331.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003042.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003042.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154036.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154036.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/all_insights/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_083439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_083439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/long_term/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_085008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_085008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_164709.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_164709.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_151130.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_151130.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093802.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093802.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_142450.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_142450.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143531.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143531.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_084544.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_084544.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154817.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154817.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_102008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_102008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153213.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153213.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_130952.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_130952.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_185032.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_185032.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_153534.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_153534.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090914.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090914.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153501.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153501.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083359.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083359.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092331.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092331.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/financial/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_164709.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_164709.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_102056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_102056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_163410.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_163410.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143531.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143531.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094827.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094827.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_152012.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_152012.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/rapid_20250525_220654.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/rapid_20250525_220654.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_074035.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_074035.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_190418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_190418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153501.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153501.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/collaborate_20250521_084304.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/collaborate_20250521_084304.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092331.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092331.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_003042.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_003042.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/business/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_085008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_085008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090813.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090813.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093802.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093802.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_142450.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_142450.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095519.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095519.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145454.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145454.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/rapid_20250525_220654.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/rapid_20250525_220654.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_113629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_113629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153501.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153501.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/collaborate_20250521_084304.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/collaborate_20250521_084304.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/immediate/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_225302.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_225302.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_225302.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_085008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_085008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090813.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090813.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152000.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152000.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092419.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092419.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_164709.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_164709.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155338.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155338.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153755.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153755.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_083348.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_083348.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_083348.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151710.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151710.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_163410.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_163410.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_151130.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_151130.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151625.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151625.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151553.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151553.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142607.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142607.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142607.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151906.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151906.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093802.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093802.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_082055.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_082055.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_082055.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142450.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142450.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095519.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095519.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143531.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143531.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_084544.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_084544.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154922.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154922.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143606.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143606.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145454.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145454.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154817.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154817.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163208.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163208.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163208.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_001724.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_001724.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_001724.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003452.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003452.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003452.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094827.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094827.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153213.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153213.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092933.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092933.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152911.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152911.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_152012.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_152012.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/rapid_20250525_220654.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/rapid_20250525_220654.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_074035.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_074035.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_130952.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_130952.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190418.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190418.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092008.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092008.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_185032.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_185032.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_153534.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_153534.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153003.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153003.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155421.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155421.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090914.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090914.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153501.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153501.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163314.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163314.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250604_163314.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083359.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083359.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143428.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143428.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250520_182850.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250520_182850.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250520_182850.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100135.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100135.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_084304.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_084304.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152639.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152639.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092331.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092331.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003042.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003042.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154036.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154036.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/by_value/under_10k/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154312.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154312.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_151816.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_151816.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081706.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081706.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090813.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090813.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_143200.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_143200.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152051.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152051.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_225803.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_225803.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090349.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090349.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154549.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154549.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152252.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152252.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093857.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093857.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154140.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154140.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152819.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152819.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_190920.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_190920.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081441.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081441.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152448.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152448.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152705.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152705.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195835.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195835.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153303.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153303.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155203.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155203.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094923.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094923.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092248.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092248.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145454.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145454.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092546.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092546.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153839.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153839.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154503.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154503.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154655.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154655.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145940.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145940.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083123.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083123.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092956.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092956.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153054.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153054.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152752.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152752.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093231.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093231.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155037.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155037.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154840.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154840.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113738.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113738.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113629.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113629.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_125723.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_125723.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152401.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152401.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155255.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155255.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094637.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094637.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_185032.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_185032.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145711.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145711.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152555.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152555.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153540.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153540.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_100439.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_100439.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090914.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090914.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154355.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154355.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153925.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153925.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_200102.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_200102.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152204.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152204.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_150241.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_150241.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_124444.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_124444.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_221453.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_221453.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154056.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154056.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145233.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145233.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095435.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095435.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154224.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154224.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155119.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155119.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092758.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092758.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095951.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095951.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154036.md' ]; then
    rm 'Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154036.md'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/actionable_insights/real_estate/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/bridge.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/bridge.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/bridge.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/mirador.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/mirador.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/mirador.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/conductor.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/conductor.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/conductor.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/core/message_bus.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/core/message_bus.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/core/message_bus.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/core/intervention_manager.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/core/intervention_manager.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/core/intervention_manager.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/core/specialist_handler.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/core/specialist_handler.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/core/specialist_handler.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/core/__init__.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/core/__init__.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/core/__init__.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/test/test_integration.py' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/test/test_integration.py'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/test/test_integration.py'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/workflows/mirador_workflow.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/workflows/mirador_workflow.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/workflows/mirador_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/utils/init.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/utils/init.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/utils/init.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/utils/output_manager.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/utils/output_manager.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/utils/output_manager.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/utils/logging.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/utils/logging.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/utils/logging.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/utils/visualization.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/utils/visualization.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/utils/visualization.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/file_reviewer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/file_reviewer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/file_reviewer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/ux_designer.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/ux_designer.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/ux_designer.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/guitar_expert_precise.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/guitar_expert_precise.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/guitar_expert_precise.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/enhanced_agent.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/enhanced_agent.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/enhanced_agent.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/code_reviewer_fix.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/code_reviewer_fix.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/code_reviewer_fix.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/master_coder.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/master_coder.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/master_coder.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/fast_agent_focused.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/fast_agent_focused.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/fast_agent_focused.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/llama3.2_balanced.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/llama3.2_balanced.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/llama3.2_balanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/models/optimized/creative_entrepreneur.modelfile' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/models/optimized/creative_entrepreneur.modelfile'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/models/optimized/creative_entrepreneur.modelfile'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/chains/run_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/chains/run_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/chains/run_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/mirador-main/src/chains/role_chain.sh' ]; then
    rm 'Documentation and Saved Assets/mirador-main/src/chains/role_chain.sh'
    echo 'Deleted: Documentation and Saved Assets/mirador-main/src/chains/role_chain.sh'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/ai_skills_radar.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/ai_skills_radar.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/ai_skills_radar.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/index.html' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/index.html'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/ai-visual-story-guide.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/ai-visual-story-guide.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/ai-visual-story-guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/transformation_chart.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/transformation_chart.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/transformation_chart.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/ai-presentation-deck.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/ai-presentation-deck.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/ai-presentation-deck.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/complete-asset-guide.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/complete-asset-guide.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/complete-asset-guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/ai_story_carousel.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/ai_story_carousel.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/ai_story_carousel.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/ai_learning_timeline.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/ai_learning_timeline.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/ai_learning_timeline.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/style.css' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/style.css'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/linkedin-content-strategy.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/linkedin-content-strategy.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/linkedin-content-strategy.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/linkedin-templates.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/linkedin-templates.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/linkedin-templates.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio/app.js' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio/app.js'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio/app.js'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Capabilities Assessment - Alignment Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Capabilities Assessment - Alignment Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Capabilities Assessment - Alignment Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - CORRECTED VERSION.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - CORRECTED VERSION.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - CORRECTED VERSION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - MATTHEW'S SYSTEM.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - MATTHEW'S SYSTEM.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - MATTHEW'S SYSTEM.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/FinanceDomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/FinanceDomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/FinanceDomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkActionableImplementationSteps.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkActionableImplementationSteps.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkActionableImplementationSteps.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework: Comprehensive Value Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework: Comprehensive Value Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework: Comprehensive Value Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/TheMiradorFramework.pdf' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/TheMiradorFramework.pdf'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/TheMiradorFramework.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ContentDomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ContentDomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ContentDomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - User Guide.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - User Guide.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - User Guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/AssessmentofChatGPTSuggestionsfortheMiradorFramework.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/AssessmentofChatGPTSuggestionsfortheMiradorFramework.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/AssessmentofChatGPTSuggestionsfortheMiradorFramework.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorChainCatalog.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorChainCatalog.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorChainCatalog.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Complete AI Ecosystem: Test, Optimize, Organize Plan.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Complete AI Ecosystem: Test, Optimize, Organize Plan.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Complete AI Ecosystem: Test, Optimize, Organize Plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/comprehensive_review_todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/comprehensive_review_todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/comprehensive_review_todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorDomain-SpecificChains.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorDomain-SpecificChains.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorDomain-SpecificChains.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorAIFrameworkGuidanceforClaude.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorAIFrameworkGuidanceforClaude.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorAIFrameworkGuidanceforClaude.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/action_steps_todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/action_steps_todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/action_steps_todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Cross-DomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Cross-DomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Cross-DomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/chatgpt_assessment_todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/chatgpt_assessment_todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/chatgpt_assessment_todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/README.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/README.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/README.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Analysis - Initial Assessment.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Analysis - Initial Assessment.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Analysis - Initial Assessment.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ProductivityDomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ProductivityDomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/ProductivityDomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - CORRECTED VERSION.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - CORRECTED VERSION.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - CORRECTED VERSION.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/PYTHON_INTERFACE.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/PYTHON_INTERFACE.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Testing and Optimization - Final Summary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Testing and Optimization - Final Summary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Framework Testing and Optimization - Final Summary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/updated_ecosystem_analysis.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/updated_ecosystem_analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/updated_ecosystem_analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_report.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_report.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_critique_report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkFoundationalPathForward&NextSteps.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkFoundationalPathForward&NextSteps.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MiradorFrameworkFoundationalPathForward&NextSteps.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador.docx' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador.docx'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador.docx'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - Comprehensive Improvement Plan.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - Comprehensive Improvement Plan.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - Comprehensive Improvement Plan.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MusicDomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MusicDomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/MusicDomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - MATTHEW'S SYSTEM.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - MATTHEW'S SYSTEM.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Complete Setup and Usage Guide - MATTHEW'S SYSTEM.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Project Directory Analysis.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Project Directory Analysis.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Project Directory Analysis.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador—AnOrchestratedAIChainingFramework.pdf' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador—AnOrchestratedAIChainingFramework.pdf'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador—AnOrchestratedAIChainingFramework.pdf'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - Google Docs Strategic Recommendations.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - Google Docs Strategic Recommendations.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador Execution Capability Analysis - Google Docs Strategic Recommendations.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/High-Value Project Analysis: Final Report.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/High-Value Project Analysis: Final Report.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/High-Value Project Analysis: Final Report.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/CLAUDE.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/CLAUDE.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/CLAUDE.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_testing_todo.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_testing_todo.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/mirador_testing_todo.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - System Organization and Documentation.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - System Organization and Documentation.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/Mirador AI Framework - System Organization and Documentation.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/BusinessDomainPromptLibrary.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/BusinessDomainPromptLibrary.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/BusinessDomainPromptLibrary.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/EvolvingtheMiradorFrameworkPathwaysforEnhancedPersonalandPrivateDailyUse.md' ]; then
    rm 'Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/EvolvingtheMiradorFrameworkPathwaysforEnhancedPersonalandPrivateDailyUse.md'
    echo 'Deleted: Documentation and Saved Assets/Identifying High-Value Projects from Provided File Paths/EvolvingtheMiradorFrameworkPathwaysforEnhancedPersonalandPrivateDailyUse.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/radar_comparison.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/radar_comparison.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/radar_comparison.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/index.html' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/index.html'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/index.html'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/ai_portfolio_infographic.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/ai_portfolio_infographic.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/ai_portfolio_infographic.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_timeline.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_timeline.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_timeline.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/style.css' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/style.css'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/style.css'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/linkedin-content-strategy.md' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/linkedin-content-strategy.md'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/linkedin-content-strategy.md'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_ecosystem.png' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_ecosystem.png'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/users_ai_ecosystem.png'
    ((deleted_count++))
fi
if [ -f 'Documentation and Saved Assets/ai-transformation-portfolio 2/app.js' ]; then
    rm 'Documentation and Saved Assets/ai-transformation-portfolio 2/app.js'
    echo 'Deleted: Documentation and Saved Assets/ai-transformation-portfolio 2/app.js'
    ((deleted_count++))
fi
if [ -f 'content_diagnostic/content_generation_diagnostic_report.md' ]; then
    rm 'content_diagnostic/content_generation_diagnostic_report.md'
    echo 'Deleted: content_diagnostic/content_generation_diagnostic_report.md'
    ((deleted_count++))
fi
if [ -f 'content_diagnostic/rebuild_failed_models.sh' ]; then
    rm 'content_diagnostic/rebuild_failed_models.sh'
    echo 'Deleted: content_diagnostic/rebuild_failed_models.sh'
    ((deleted_count++))
fi
if [ -f 'content_diagnostic/repair_content_generation.sh' ]; then
    rm 'content_diagnostic/repair_content_generation.sh'
    echo 'Deleted: content_diagnostic/repair_content_generation.sh'
    ((deleted_count++))
fi
if [ -f 'content_diagnostic/validate_content_generation.sh' ]; then
    rm 'content_diagnostic/validate_content_generation.sh'
    echo 'Deleted: content_diagnostic/validate_content_generation.sh'
    ((deleted_count++))
fi
if [ -f 'chain_debug/simplified_chains.json' ]; then
    rm 'chain_debug/simplified_chains.json'
    echo 'Deleted: chain_debug/simplified_chains.json'
    ((deleted_count++))
fi
if [ -f 'chain_debug/chain_debug_report.md' ]; then
    rm 'chain_debug/chain_debug_report.md'
    echo 'Deleted: chain_debug/chain_debug_report.md'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/prepare_release.sh' ]; then
    rm 'mirador_backup_20250606_114405/prepare_release.sh'
    echo 'Deleted: mirador_backup_20250606_114405/prepare_release.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/monitor_mirador_performance.sh' ]; then
    rm 'mirador_backup_20250606_114405/monitor_mirador_performance.sh'
    echo 'Deleted: mirador_backup_20250606_114405/monitor_mirador_performance.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/create_new_model.sh' ]; then
    rm 'mirador_backup_20250606_114405/create_new_model.sh'
    echo 'Deleted: mirador_backup_20250606_114405/create_new_model.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/validate_production_readiness.sh' ]; then
    rm 'mirador_backup_20250606_114405/validate_production_readiness.sh'
    echo 'Deleted: mirador_backup_20250606_114405/validate_production_readiness.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/louisville_expert_v2.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/louisville_expert_v2.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/louisville_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh' ]; then
    rm 'mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh'
    echo 'Deleted: mirador_backup_20250606_114405/monitor_mirador_performance_fixed.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/test_mirador_accuracy.sh' ]; then
    rm 'mirador_backup_20250606_114405/test_mirador_accuracy.sh'
    echo 'Deleted: mirador_backup_20250606_114405/test_mirador_accuracy.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/git_status.txt' ]; then
    rm 'mirador_backup_20250606_114405/git_status.txt'
    echo 'Deleted: mirador_backup_20250606_114405/git_status.txt'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/test_model_performance.sh' ]; then
    rm 'mirador_backup_20250606_114405/test_model_performance.sh'
    echo 'Deleted: mirador_backup_20250606_114405/test_model_performance.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/restore_models.sh' ]; then
    rm 'mirador_backup_20250606_114405/restore_models.sh'
    echo 'Deleted: mirador_backup_20250606_114405/restore_models.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/setup_maintenance_cron.sh' ]; then
    rm 'mirador_backup_20250606_114405/setup_maintenance_cron.sh'
    echo 'Deleted: mirador_backup_20250606_114405/setup_maintenance_cron.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/backup_models.sh' ]; then
    rm 'mirador_backup_20250606_114405/backup_models.sh'
    echo 'Deleted: mirador_backup_20250606_114405/backup_models.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/README.md' ]; then
    rm 'mirador_backup_20250606_114405/README.md'
    echo 'Deleted: mirador_backup_20250606_114405/README.md'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/financial_planning_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/validate_fixes.sh' ]; then
    rm 'mirador_backup_20250606_114405/validate_fixes.sh'
    echo 'Deleted: mirador_backup_20250606_114405/validate_fixes.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/version_info.sh' ]; then
    rm 'mirador_backup_20250606_114405/version_info.sh'
    echo 'Deleted: mirador_backup_20250606_114405/version_info.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/financial_planning_expert_v5.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/PYTHON_INTERFACE.md' ]; then
    rm 'mirador_backup_20250606_114405/PYTHON_INTERFACE.md'
    echo 'Deleted: mirador_backup_20250606_114405/PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/mirador_maintenance.sh' ]; then
    rm 'mirador_backup_20250606_114405/mirador_maintenance.sh'
    echo 'Deleted: mirador_backup_20250606_114405/mirador_maintenance.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/enhanced_agent_fast_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/mirador_qa_comprehensive.sh' ]; then
    rm 'mirador_backup_20250606_114405/mirador_qa_comprehensive.sh'
    echo 'Deleted: mirador_backup_20250606_114405/mirador_qa_comprehensive.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/financial_planning_expert_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/ollama_models.txt' ]; then
    rm 'mirador_backup_20250606_114405/ollama_models.txt'
    echo 'Deleted: mirador_backup_20250606_114405/ollama_models.txt'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/financial_planning_expert_v4.modelfile'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/CLAUDE.md' ]; then
    rm 'mirador_backup_20250606_114405/CLAUDE.md'
    echo 'Deleted: mirador_backup_20250606_114405/CLAUDE.md'
    ((deleted_count++))
fi
if [ -f 'mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile' ]; then
    rm 'mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile'
    echo 'Deleted: mirador_backup_20250606_114405/enhanced_agent_fast_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'Perplexity/AI-Powered Content Creation Tools for Risk Managem.pdf' ]; then
    rm 'Perplexity/AI-Powered Content Creation Tools for Risk Managem.pdf'
    echo 'Deleted: Perplexity/AI-Powered Content Creation Tools for Risk Managem.pdf'
    ((deleted_count++))
fi
if [ -f 'Perplexity/Specialized Ollama Model Files for User.md' ]; then
    rm 'Perplexity/Specialized Ollama Model Files for User.md'
    echo 'Deleted: Perplexity/Specialized Ollama Model Files for User.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025.zip' ]; then
    rm 'Perplexity/perplexity June 21 2025.zip'
    echo 'Deleted: Perplexity/perplexity June 21 2025.zip'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/style_1.css' ]; then
    rm 'Perplexity/perplexity June 21 2025/style_1.css'
    echo 'Deleted: Perplexity/perplexity June 21 2025/style_1.css'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/linkedin-post-templates.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/linkedin-post-templates.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/linkedin-post-templates.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/index.html' ]; then
    rm 'Perplexity/perplexity June 21 2025/index.html'
    echo 'Deleted: Perplexity/perplexity June 21 2025/index.html'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/app_1.js' ]; then
    rm 'Perplexity/perplexity June 21 2025/app_1.js'
    echo 'Deleted: Perplexity/perplexity June 21 2025/app_1.js'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/presentation-slides.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/presentation-slides.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/presentation-slides.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/index_1.html' ]; then
    rm 'Perplexity/perplexity June 21 2025/index_1.html'
    echo 'Deleted: Perplexity/perplexity June 21 2025/index_1.html'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/linkedin-showcase-post.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/linkedin-showcase-post.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/linkedin-showcase-post.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-implementation-framework.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-implementation-framework.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-methodology.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-methodology.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-methodology.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/style.css' ]; then
    rm 'Perplexity/perplexity June 21 2025/style.css'
    echo 'Deleted: Perplexity/perplexity June 21 2025/style.css'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/app.js' ]; then
    rm 'Perplexity/perplexity June 21 2025/app.js'
    echo 'Deleted: Perplexity/perplexity June 21 2025/app.js'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/index.html' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/index.html'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-showcase-presentation/index.html'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/ai-implementation-framework.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/ai-implementation-framework.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-showcase-presentation/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/style.css' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/style.css'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-showcase-presentation/style.css'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/app.js' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-showcase-presentation/app.js'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-showcase-presentation/app.js'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/index.html' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/index.html'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/index.html'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/presentation-slides.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/presentation-slides.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/presentation-slides.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/linkedin-showcase-post.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/linkedin-showcase-post.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/linkedin-showcase-post.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-implementation-framework.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-implementation-framework.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-implementation-framework.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-advisor-methodology.md' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-advisor-methodology.md'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/ai-advisor-methodology.md'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/style.css' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/style.css'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/style.css'
    ((deleted_count++))
fi
if [ -f 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/app.js' ]; then
    rm 'Perplexity/perplexity June 21 2025/ai-advisor-showcase/app.js'
    echo 'Deleted: Perplexity/perplexity June 21 2025/ai-advisor-showcase/app.js'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/mirador_config.json' ]; then
    rm 'optimized_configs/mirador_config.json'
    echo 'Deleted: optimized_configs/mirador_config.json'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/mirador_config.yaml' ]; then
    rm 'optimized_configs/mirador_config.yaml'
    echo 'Deleted: optimized_configs/mirador_config.yaml'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/documentation/model_reference.md' ]; then
    rm 'optimized_configs/documentation/model_reference.md'
    echo 'Deleted: optimized_configs/documentation/model_reference.md'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/documentation/chain_reference.md' ]; then
    rm 'optimized_configs/documentation/chain_reference.md'
    echo 'Deleted: optimized_configs/documentation/chain_reference.md'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile' ]; then
    rm 'optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/user_context_provider_v2.modelfile' ]; then
    rm 'optimized_configs/modelfiles/user_context_provider_v2.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/user_context_provider_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/linkedin_content_expert.modelfile' ]; then
    rm 'optimized_configs/modelfiles/linkedin_content_expert.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/linkedin_content_expert.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/health_wellness_optimizer.modelfile' ]; then
    rm 'optimized_configs/modelfiles/health_wellness_optimizer.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/health_wellness_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/financial_planning_expert_fast.modelfile' ]; then
    rm 'optimized_configs/modelfiles/financial_planning_expert_fast.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/financial_planning_expert_fast.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/mirador_system_specialist_v2.modelfile' ]; then
    rm 'optimized_configs/modelfiles/mirador_system_specialist_v2.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/mirador_system_specialist_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/louisville_expert_v3.modelfile' ]; then
    rm 'optimized_configs/modelfiles/louisville_expert_v3.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/louisville_expert_v3.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/enhanced_agent_enforcer_v2.modelfile' ]; then
    rm 'optimized_configs/modelfiles/enhanced_agent_enforcer_v2.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/enhanced_agent_enforcer_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/financial_planning_expert_v6.modelfile' ]; then
    rm 'optimized_configs/modelfiles/financial_planning_expert_v6.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/financial_planning_expert_v6.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/decision_simplifier_v2.modelfile' ]; then
    rm 'optimized_configs/modelfiles/decision_simplifier_v2.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/decision_simplifier_v2.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/real_estate_analyzer.modelfile' ]; then
    rm 'optimized_configs/modelfiles/real_estate_analyzer.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/real_estate_analyzer.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/modelfiles/productivity_optimizer.modelfile' ]; then
    rm 'optimized_configs/modelfiles/productivity_optimizer.modelfile'
    echo 'Deleted: optimized_configs/modelfiles/productivity_optimizer.modelfile'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/migration_scripts/validate_models.sh' ]; then
    rm 'optimized_configs/migration_scripts/validate_models.sh'
    echo 'Deleted: optimized_configs/migration_scripts/validate_models.sh'
    ((deleted_count++))
fi
if [ -f 'optimized_configs/migration_scripts/update_modelfiles.sh' ]; then
    rm 'optimized_configs/migration_scripts/update_modelfiles.sh'
    echo 'Deleted: optimized_configs/migration_scripts/update_modelfiles.sh'
    ((deleted_count++))
fi
if [ -f 'monthly_reports/local_2025_06.md' ]; then
    rm 'monthly_reports/local_2025_06.md'
    echo 'Deleted: monthly_reports/local_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'monthly_reports/financial_2025_06.md' ]; then
    rm 'monthly_reports/financial_2025_06.md'
    echo 'Deleted: monthly_reports/financial_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'monthly_reports/professional_2025_06.md' ]; then
    rm 'monthly_reports/professional_2025_06.md'
    echo 'Deleted: monthly_reports/professional_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'monthly_reports/wellness_2025_06.md' ]; then
    rm 'monthly_reports/wellness_2025_06.md'
    echo 'Deleted: monthly_reports/wellness_2025_06.md'
    ((deleted_count++))
fi
if [ -f 'high_value_insights/business_insights.md' ]; then
    rm 'high_value_insights/business_insights.md'
    echo 'Deleted: high_value_insights/business_insights.md'
    ((deleted_count++))
fi
if [ -f 'high_value_insights/real_estate_insights.md' ]; then
    rm 'high_value_insights/real_estate_insights.md'
    echo 'Deleted: high_value_insights/real_estate_insights.md'
    ((deleted_count++))
fi
if [ -f 'high_value_insights/financial_insights.md' ]; then
    rm 'high_value_insights/financial_insights.md'
    echo 'Deleted: high_value_insights/financial_insights.md'
    ((deleted_count++))
fi
if [ -f 'high_value_insights/career_insights.md' ]; then
    rm 'high_value_insights/career_insights.md'
    echo 'Deleted: high_value_insights/career_insights.md'
    ((deleted_count++))
fi
if [ -f 'scripts/setup.sh' ]; then
    rm 'scripts/setup.sh'
    echo 'Deleted: scripts/setup.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/test_workflow.sh' ]; then
    rm 'scripts/test_workflow.sh'
    echo 'Deleted: scripts/test_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/run_chain.sh' ]; then
    rm 'scripts/run_chain.sh'
    echo 'Deleted: scripts/run_chain.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/test_chain.sh' ]; then
    rm 'scripts/test_chain.sh'
    echo 'Deleted: scripts/test_chain.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/MODEL_PROMPT_GUIDE.md' ]; then
    rm 'scripts/MODEL_PROMPT_GUIDE.md'
    echo 'Deleted: scripts/MODEL_PROMPT_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'scripts/run_workflow.sh' ]; then
    rm 'scripts/run_workflow.sh'
    echo 'Deleted: scripts/run_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/domain-collab' ]; then
    rm 'scripts/domain-collab'
    echo 'Deleted: scripts/domain-collab'
    ((deleted_count++))
fi
if [ -f 'scripts/run_role_chain.sh' ]; then
    rm 'scripts/run_role_chain.sh'
    echo 'Deleted: scripts/run_role_chain.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/run-ollama.sh' ]; then
    rm 'scripts/run-ollama.sh'
    echo 'Deleted: scripts/run-ollama.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/test_simple.sh' ]; then
    rm 'scripts/test_simple.sh'
    echo 'Deleted: scripts/test_simple.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/direct-ollama.sh' ]; then
    rm 'scripts/direct-ollama.sh'
    echo 'Deleted: scripts/direct-ollama.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/OLLAMA_REFERENCE_CARD.md' ]; then
    rm 'scripts/OLLAMA_REFERENCE_CARD.md'
    echo 'Deleted: scripts/OLLAMA_REFERENCE_CARD.md'
    ((deleted_count++))
fi
if [ -f 'scripts/branded_header.sh' ]; then
    rm 'scripts/branded_header.sh'
    echo 'Deleted: scripts/branded_header.sh'
    ((deleted_count++))
fi
if [ -f 'scripts/ollama-easy' ]; then
    rm 'scripts/ollama-easy'
    echo 'Deleted: scripts/ollama-easy'
    ((deleted_count++))
fi
if [ -f 'scripts/ONE_PAGE_REFERENCE.md' ]; then
    rm 'scripts/ONE_PAGE_REFERENCE.md'
    echo 'Deleted: scripts/ONE_PAGE_REFERENCE.md'
    ((deleted_count++))
fi
if [ -f 'mirador_backups/20250605_225456/models_before_upgrade.txt' ]; then
    rm 'mirador_backups/20250605_225456/models_before_upgrade.txt'
    echo 'Deleted: mirador_backups/20250605_225456/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'mirador_backups/20250605_225456/rollback_script.sh' ]; then
    rm 'mirador_backups/20250605_225456/rollback_script.sh'
    echo 'Deleted: mirador_backups/20250605_225456/rollback_script.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backups/20250606_081851/models_before_upgrade.txt' ]; then
    rm 'mirador_backups/20250606_081851/models_before_upgrade.txt'
    echo 'Deleted: mirador_backups/20250606_081851/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'mirador_backups/20250606_081851/rollback_script.sh' ]; then
    rm 'mirador_backups/20250606_081851/rollback_script.sh'
    echo 'Deleted: mirador_backups/20250606_081851/rollback_script.sh'
    ((deleted_count++))
fi
if [ -f 'mirador_backups/20250605_225409/models_before_upgrade.txt' ]; then
    rm 'mirador_backups/20250605_225409/models_before_upgrade.txt'
    echo 'Deleted: mirador_backups/20250605_225409/models_before_upgrade.txt'
    ((deleted_count++))
fi
if [ -f 'templates/financial_planning.txt' ]; then
    rm 'templates/financial_planning.txt'
    echo 'Deleted: templates/financial_planning.txt'
    ((deleted_count++))
fi
if [ -f 'templates/guitar_practice.txt' ]; then
    rm 'templates/guitar_practice.txt'
    echo 'Deleted: templates/guitar_practice.txt'
    ((deleted_count++))
fi
if [ -f 'templates/daily_planning.txt' ]; then
    rm 'templates/daily_planning.txt'
    echo 'Deleted: templates/daily_planning.txt'
    ((deleted_count++))
fi
if [ -f 'templates/career_development.txt' ]; then
    rm 'templates/career_development.txt'
    echo 'Deleted: templates/career_development.txt'
    ((deleted_count++))
fi
if [ -f 'domain_action_plans/financial_action_plan.md' ]; then
    rm 'domain_action_plans/financial_action_plan.md'
    echo 'Deleted: domain_action_plans/financial_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'domain_action_plans/health_action_plan.md' ]; then
    rm 'domain_action_plans/health_action_plan.md'
    echo 'Deleted: domain_action_plans/health_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'domain_action_plans/business_action_plan.md' ]; then
    rm 'domain_action_plans/business_action_plan.md'
    echo 'Deleted: domain_action_plans/business_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'domain_action_plans/career_action_plan.md' ]; then
    rm 'domain_action_plans/career_action_plan.md'
    echo 'Deleted: domain_action_plans/career_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'domain_action_plans/real_estate_action_plan.md' ]; then
    rm 'domain_action_plans/real_estate_action_plan.md'
    echo 'Deleted: domain_action_plans/real_estate_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/PROJECT_FILE_CATALOG.md' ]; then
    rm 'docs_backup_20250619_070009/PROJECT_FILE_CATALOG.md'
    echo 'Deleted: docs_backup_20250619_070009/PROJECT_FILE_CATALOG.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/OPPORTUNITY_SCORES.md' ]; then
    rm 'docs_backup_20250619_070009/OPPORTUNITY_SCORES.md'
    echo 'Deleted: docs_backup_20250619_070009/OPPORTUNITY_SCORES.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/PROJECT_STATUS.md' ]; then
    rm 'docs_backup_20250619_070009/PROJECT_STATUS.md'
    echo 'Deleted: docs_backup_20250619_070009/PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/mirador_personality_quick_reference.md' ]; then
    rm 'docs_backup_20250619_070009/mirador_personality_quick_reference.md'
    echo 'Deleted: docs_backup_20250619_070009/mirador_personality_quick_reference.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/personality_integration_summary.md' ]; then
    rm 'docs_backup_20250619_070009/personality_integration_summary.md'
    echo 'Deleted: docs_backup_20250619_070009/personality_integration_summary.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/IMPLEMENTATION_ROADMAP_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/IMPLEMENTATION_ROADMAP_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/IMPLEMENTATION_ROADMAP_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/june_action_plan.md' ]; then
    rm 'docs_backup_20250619_070009/june_action_plan.md'
    echo 'Deleted: docs_backup_20250619_070009/june_action_plan.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/personality_integration_report.md' ]; then
    rm 'docs_backup_20250619_070009/personality_integration_report.md'
    echo 'Deleted: docs_backup_20250619_070009/personality_integration_report.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/TEST_CHAIN_ANALYSIS_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/TEST_CHAIN_ANALYSIS_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/TEST_CHAIN_ANALYSIS_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/ranked_opportunities.md' ]; then
    rm 'docs_backup_20250619_070009/ranked_opportunities.md'
    echo 'Deleted: docs_backup_20250619_070009/ranked_opportunities.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/WEEKLY_REVIEW_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/WEEKLY_REVIEW_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/WEEKLY_REVIEW_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/opportunity_implementation_tracker.md' ]; then
    rm 'docs_backup_20250619_070009/opportunity_implementation_tracker.md'
    echo 'Deleted: docs_backup_20250619_070009/opportunity_implementation_tracker.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/weekly_optimization_report.md' ]; then
    rm 'docs_backup_20250619_070009/weekly_optimization_report.md'
    echo 'Deleted: docs_backup_20250619_070009/weekly_optimization_report.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/mirador_unified_reference.md' ]; then
    rm 'docs_backup_20250619_070009/mirador_unified_reference.md'
    echo 'Deleted: docs_backup_20250619_070009/mirador_unified_reference.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/README.md' ]; then
    rm 'docs_backup_20250619_070009/README.md'
    echo 'Deleted: docs_backup_20250619_070009/README.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/OPPORTUNITY_SCORES_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/OPPORTUNITY_SCORES_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/OPPORTUNITY_SCORES_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/ACTION_TRACKER.md' ]; then
    rm 'docs_backup_20250619_070009/ACTION_TRACKER.md'
    echo 'Deleted: docs_backup_20250619_070009/ACTION_TRACKER.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/mirador_health_report_20250618_153258.md' ]; then
    rm 'docs_backup_20250619_070009/mirador_health_report_20250618_153258.md'
    echo 'Deleted: docs_backup_20250619_070009/mirador_health_report_20250618_153258.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/IMMEDIATE_ACTION_PLAN_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/IMMEDIATE_ACTION_PLAN_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/IMMEDIATE_ACTION_PLAN_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/PRODUCTION_USAGE_GUIDE.md' ]; then
    rm 'docs_backup_20250619_070009/PRODUCTION_USAGE_GUIDE.md'
    echo 'Deleted: docs_backup_20250619_070009/PRODUCTION_USAGE_GUIDE.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/unified_mirador_reference.md' ]; then
    rm 'docs_backup_20250619_070009/unified_mirador_reference.md'
    echo 'Deleted: docs_backup_20250619_070009/unified_mirador_reference.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/PYTHON_INTERFACE.md' ]; then
    rm 'docs_backup_20250619_070009/PYTHON_INTERFACE.md'
    echo 'Deleted: docs_backup_20250619_070009/PYTHON_INTERFACE.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/CURRENT_PROJECT_STATUS.md' ]; then
    rm 'docs_backup_20250619_070009/CURRENT_PROJECT_STATUS.md'
    echo 'Deleted: docs_backup_20250619_070009/CURRENT_PROJECT_STATUS.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/EXECUTIVE_SUMMARY_20250608.md' ]; then
    rm 'docs_backup_20250619_070009/EXECUTIVE_SUMMARY_20250608.md'
    echo 'Deleted: docs_backup_20250619_070009/EXECUTIVE_SUMMARY_20250608.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/PROJECT_COMPLETION_REPORT.md' ]; then
    rm 'docs_backup_20250619_070009/PROJECT_COMPLETION_REPORT.md'
    echo 'Deleted: docs_backup_20250619_070009/PROJECT_COMPLETION_REPORT.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/TOP_OPPORTUNITIES.md' ]; then
    rm 'docs_backup_20250619_070009/TOP_OPPORTUNITIES.md'
    echo 'Deleted: docs_backup_20250619_070009/TOP_OPPORTUNITIES.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/MODEL_INVENTORY.md' ]; then
    rm 'docs_backup_20250619_070009/MODEL_INVENTORY.md'
    echo 'Deleted: docs_backup_20250619_070009/MODEL_INVENTORY.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/CLAUDE.md' ]; then
    rm 'docs_backup_20250619_070009/CLAUDE.md'
    echo 'Deleted: docs_backup_20250619_070009/CLAUDE.md'
    ((deleted_count++))
fi
if [ -f 'docs_backup_20250619_070009/prompt_templates.md' ]; then
    rm 'docs_backup_20250619_070009/prompt_templates.md'
    echo 'Deleted: docs_backup_20250619_070009/prompt_templates.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/MASTER_INDEX.md' ]; then
    rm 'actionable_insights/MASTER_INDEX.md'
    echo 'Deleted: actionable_insights/MASTER_INDEX.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_164709.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_164709.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_163410.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_163410.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_151130.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_151130.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_084544.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_084544.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153418.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153418.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_154817.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_154817.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_094827.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_094827.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153213.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153213.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_152012.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_152012.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_130952.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_130952.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_190418.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_190418.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_153534.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_153534.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250606_083359.md' ]; then
    rm 'actionable_insights/short_term/chain_20250606_083359.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/short_term/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/short_term/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/short_term/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/short_term/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/career/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/career/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/career/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/career/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_102056.md' ]; then
    rm 'actionable_insights/career/chain_20250607_102056.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/career/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/career/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/career/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/career/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/career/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/career/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/career/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_095519.md' ]; then
    rm 'actionable_insights/career/chain_20250607_095519.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/career/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_084544.md' ]; then
    rm 'actionable_insights/career/chain_20250606_084544.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/career/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/career/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/career/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153418.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153418.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_145454.md' ]; then
    rm 'actionable_insights/career/chain_20250607_145454.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/career/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153213.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153213.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/career/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/career/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_130952.md' ]; then
    rm 'actionable_insights/career/chain_20250605_130952.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/career/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/career/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/career/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/career/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/career/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_095355.md' ]; then
    rm 'actionable_insights/career/chain_20250607_095355.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_185032.md' ]; then
    rm 'actionable_insights/career/chain_20250605_185032.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/career/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/career/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154629.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154629.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/career/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/career/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_090914.md' ]; then
    rm 'actionable_insights/career/chain_20250606_090914.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/career/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/career/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/career/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/career/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/career/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/career/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/career/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/career/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/career/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/career/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/career/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/career/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/career/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/career/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/career/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/career/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/career/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250604_225302.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250604_225302.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250604_225302.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_085008.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_085008.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_090813.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_090813.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_164709.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_164709.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_102056.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_102056.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_083348.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_083348.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_083348.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_163410.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_163410.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_151130.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_151130.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_142607.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_142607.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_142607.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_093802.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_093802.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/collaborate_20250521_082055.md' ]; then
    rm 'actionable_insights/all_insights/collaborate_20250521_082055.md'
    echo 'Deleted: actionable_insights/all_insights/collaborate_20250521_082055.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_142450.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_142450.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_095519.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_095519.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_143531.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_143531.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_084544.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_084544.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153418.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153418.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_145454.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_145454.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154817.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154817.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250604_163208.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250604_163208.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250604_163208.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_102008.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_102008.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_001724.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_001724.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_001724.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_003452.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_003452.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_003452.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_094827.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_094827.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153213.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153213.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_152012.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_152012.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/rapid_20250525_220654.md' ]; then
    rm 'actionable_insights/all_insights/rapid_20250525_220654.md'
    echo 'Deleted: actionable_insights/all_insights/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_074035.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_074035.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_130952.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_130952.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_190418.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_190418.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_083439.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_083439.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_113629.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_113629.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_095355.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_095355.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_185032.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_185032.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_153534.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_153534.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154629.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154629.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_090914.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_090914.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153501.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153501.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250604_163314.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250604_163314.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250604_163314.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_083359.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_083359.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/collaborate_20250520_182850.md' ]; then
    rm 'actionable_insights/all_insights/collaborate_20250520_182850.md'
    echo 'Deleted: actionable_insights/all_insights/collaborate_20250520_182850.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/collaborate_20250521_084304.md' ]; then
    rm 'actionable_insights/all_insights/collaborate_20250521_084304.md'
    echo 'Deleted: actionable_insights/all_insights/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092331.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092331.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250605_003042.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250605_003042.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/all_insights/chain_20250607_154036.md' ]; then
    rm 'actionable_insights/all_insights/chain_20250607_154036.md'
    echo 'Deleted: actionable_insights/all_insights/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250606_083439.md' ]; then
    rm 'actionable_insights/long_term/chain_20250606_083439.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/long_term/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/long_term/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/long_term/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/long_term/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_085008.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_085008.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_164709.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_164709.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_151130.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_151130.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_093802.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_093802.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_142450.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_142450.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_143531.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_143531.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_084544.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_084544.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153418.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153418.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154817.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154817.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_102008.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_102008.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153213.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153213.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_130952.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_130952.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_083439.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_083439.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_113629.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_113629.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_095355.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_095355.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_185032.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_185032.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_153534.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_153534.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154629.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154629.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_090914.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_090914.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153501.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153501.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_083359.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_083359.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/financial/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/financial/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/financial/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/financial/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092331.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092331.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/financial/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/financial/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/financial/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/business/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/business/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/business/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/business/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_164709.md' ]; then
    rm 'actionable_insights/business/chain_20250606_164709.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_102056.md' ]; then
    rm 'actionable_insights/business/chain_20250607_102056.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/business/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_163410.md' ]; then
    rm 'actionable_insights/business/chain_20250606_163410.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/business/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/business/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/business/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_143531.md' ]; then
    rm 'actionable_insights/business/chain_20250607_143531.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/business/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/business/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/business/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/business/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/business/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/business/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_094827.md' ]; then
    rm 'actionable_insights/business/chain_20250607_094827.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_152012.md' ]; then
    rm 'actionable_insights/business/chain_20250606_152012.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/rapid_20250525_220654.md' ]; then
    rm 'actionable_insights/business/rapid_20250525_220654.md'
    echo 'Deleted: actionable_insights/business/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_074035.md' ]; then
    rm 'actionable_insights/business/chain_20250605_074035.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_190418.md' ]; then
    rm 'actionable_insights/business/chain_20250605_190418.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/business/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/business/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/business/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/business/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/business/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153501.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153501.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/business/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/business/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/business/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/business/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/business/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/business/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/collaborate_20250521_084304.md' ]; then
    rm 'actionable_insights/business/collaborate_20250521_084304.md'
    echo 'Deleted: actionable_insights/business/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/business/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/business/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092331.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092331.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/business/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250605_003042.md' ]; then
    rm 'actionable_insights/business/chain_20250605_003042.md'
    echo 'Deleted: actionable_insights/business/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/business/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/business/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/business/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_085008.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_085008.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_090813.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_090813.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/immediate/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_102056.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_102056.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/immediate/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_093802.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_093802.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_142450.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_142450.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_095519.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_095519.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_145454.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_145454.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_102008.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_102008.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/rapid_20250525_220654.md' ]; then
    rm 'actionable_insights/immediate/rapid_20250525_220654.md'
    echo 'Deleted: actionable_insights/immediate/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_113629.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_113629.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_095355.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_095355.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154629.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154629.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_153501.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_153501.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/immediate/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/collaborate_20250521_084304.md' ]; then
    rm 'actionable_insights/immediate/collaborate_20250521_084304.md'
    echo 'Deleted: actionable_insights/immediate/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/immediate/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/immediate/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/immediate/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250604_225302.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250604_225302.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250604_225302.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_085008.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_085008.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_085008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_090813.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_090813.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152000.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152000.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152000.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092419.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092419.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092419.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153711.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153711.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_164709.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_164709.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_164709.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155338.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155338.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155338.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_102056.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_102056.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_102056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153755.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153755.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153755.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_083348.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_083348.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_083348.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_151710.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_151710.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_151710.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_163410.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_163410.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_163410.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_151130.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_151130.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_151130.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_151625.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_151625.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_151625.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_151553.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_151553.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_151553.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_142607.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_142607.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_142607.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_151906.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_151906.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_151906.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_093802.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_093802.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_093802.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/collaborate_20250521_082055.md' ]; then
    rm 'actionable_insights/by_value/under_10k/collaborate_20250521_082055.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/collaborate_20250521_082055.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_142450.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_142450.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_142450.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_095519.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_095519.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_095519.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_143531.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_143531.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_143531.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_084544.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_084544.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_084544.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154922.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154922.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154922.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_143606.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_143606.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_143606.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153418.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153418.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_145454.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_145454.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154817.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154817.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154817.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250604_163208.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250604_163208.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250604_163208.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_102008.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_102008.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_102008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_001724.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_001724.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_001724.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_003452.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_003452.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_003452.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_094827.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_094827.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_094827.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153213.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153213.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153213.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092933.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092933.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092933.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152911.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152911.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152911.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_152012.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_152012.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_152012.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/rapid_20250525_220654.md' ]; then
    rm 'actionable_insights/by_value/under_10k/rapid_20250525_220654.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/rapid_20250525_220654.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_074035.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_074035.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_074035.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_130952.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_130952.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_130952.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_190418.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_190418.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_190418.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_083439.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_083439.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_113629.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_113629.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092119.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092119.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092008.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092008.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092008.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_095355.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_095355.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_095355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_185032.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_185032.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153629.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153629.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_153534.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_153534.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_153534.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153003.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153003.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153003.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154629.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154629.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155421.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155421.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155421.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_090914.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_090914.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153501.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153501.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153501.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250604_163314.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250604_163314.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250604_163314.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_083359.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_083359.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_083359.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_143428.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_143428.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_143428.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/collaborate_20250520_182850.md' ]; then
    rm 'actionable_insights/by_value/under_10k/collaborate_20250520_182850.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/collaborate_20250520_182850.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_100135.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_100135.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_100135.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/collaborate_20250521_084304.md' ]; then
    rm 'actionable_insights/by_value/under_10k/collaborate_20250521_084304.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/collaborate_20250521_084304.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_152639.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_152639.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_152639.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092331.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092331.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092331.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250605_003042.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250605_003042.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250605_003042.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/by_value/under_10k/chain_20250607_154036.md' ]; then
    rm 'actionable_insights/by_value/under_10k/chain_20250607_154036.md'
    echo 'Deleted: actionable_insights/by_value/under_10k/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154312.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154312.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154312.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_151816.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_151816.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_151816.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_081706.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_081706.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_081706.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_090813.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_090813.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_090813.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_143200.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_143200.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_143200.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152051.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152051.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152051.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_225803.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_225803.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_225803.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_090349.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_090349.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_090349.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154549.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154549.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154549.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152252.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152252.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152252.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_093857.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_093857.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_093857.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154140.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154140.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154140.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152819.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152819.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152819.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_190920.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_190920.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_190920.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_081441.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_081441.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_081441.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152448.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152448.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152448.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152705.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152705.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152705.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_195835.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_195835.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_195835.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_153303.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_153303.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_153303.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_155203.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_155203.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_155203.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_094923.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_094923.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_094923.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_092248.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_092248.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_092248.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_145454.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_145454.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_145454.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_092546.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_092546.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_092546.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_153839.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_153839.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_153839.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154503.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154503.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154503.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154655.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154655.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154655.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_092711.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_092711.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_092711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_145940.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_145940.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_145940.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_083123.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_083123.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_083123.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_092956.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_092956.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_092956.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_153054.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_153054.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_153054.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152752.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152752.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152752.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_093231.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_093231.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_093231.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_090738.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_090738.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_090738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_155037.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_155037.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_155037.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_083439.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_083439.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_083439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154840.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154840.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154840.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_113738.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_113738.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_113738.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_113629.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_113629.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_113629.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_125723.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_125723.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_125723.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152401.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152401.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152401.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_155255.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_155255.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_155255.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_094637.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_094637.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_094637.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_185032.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_185032.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_185032.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_145711.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_145711.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_145711.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152555.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152555.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152555.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_195453.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_195453.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_195453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_153540.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_153540.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_153540.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_100439.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_100439.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_100439.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_090914.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_090914.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_090914.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154355.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154355.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154355.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_153925.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_153925.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_153925.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_200102.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_200102.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_200102.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_152204.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_152204.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_152204.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_150241.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_150241.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_150241.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250605_124444.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250605_124444.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250605_124444.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250606_221453.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250606_221453.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250606_221453.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154056.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154056.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154056.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_145233.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_145233.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_145233.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_095435.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_095435.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_095435.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154224.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154224.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154224.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_155119.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_155119.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_155119.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_092758.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_092758.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_092758.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_095951.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_095951.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_095951.md'
    ((deleted_count++))
fi
if [ -f 'actionable_insights/real_estate/chain_20250607_154036.md' ]; then
    rm 'actionable_insights/real_estate/chain_20250607_154036.md'
    echo 'Deleted: actionable_insights/real_estate/chain_20250607_154036.md'
    ((deleted_count++))
fi
if [ -f 'assets/brand/README.md' ]; then
    rm 'assets/brand/README.md'
    echo 'Deleted: assets/brand/README.md'
    ((deleted_count++))
fi
if [ -f 'assets/brand/logos/logo.svg' ]; then
    rm 'assets/brand/logos/logo.svg'
    echo 'Deleted: assets/brand/logos/logo.svg'
    ((deleted_count++))
fi
if [ -f 'assets/brand/mockups/terminal-mockup.md' ]; then
    rm 'assets/brand/mockups/terminal-mockup.md'
    echo 'Deleted: assets/brand/mockups/terminal-mockup.md'
    ((deleted_count++))
fi
if [ -f 'assets/brand/mockups/dashboard-mockup.html' ]; then
    rm 'assets/brand/mockups/dashboard-mockup.html'
    echo 'Deleted: assets/brand/mockups/dashboard-mockup.html'
    ((deleted_count++))
fi
if [ -f 'assets/brand/logo/mirador-icon.svg' ]; then
    rm 'assets/brand/logo/mirador-icon.svg'
    echo 'Deleted: assets/brand/logo/mirador-icon.svg'
    ((deleted_count++))
fi
if [ -f 'assets/brand/logo/mirador-ascii.txt' ]; then
    rm 'assets/brand/logo/mirador-ascii.txt'
    echo 'Deleted: assets/brand/logo/mirador-ascii.txt'
    ((deleted_count++))
fi
if [ -f 'assets/brand/logo/mirador-logo.svg' ]; then
    rm 'assets/brand/logo/mirador-logo.svg'
    echo 'Deleted: assets/brand/logo/mirador-logo.svg'
    ((deleted_count++))
fi
if [ -f 'assets/brand/colors/mirador-colors.css' ]; then
    rm 'assets/brand/colors/mirador-colors.css'
    echo 'Deleted: assets/brand/colors/mirador-colors.css'
    ((deleted_count++))
fi
if [ -f 'assets/brand/philosophy/manifesto.md' ]; then
    rm 'assets/brand/philosophy/manifesto.md'
    echo 'Deleted: assets/brand/philosophy/manifesto.md'
    ((deleted_count++))
fi
if [ -f 'analysis_output/consolidation_analysis.md' ]; then
    rm 'analysis_output/consolidation_analysis.md'
    echo 'Deleted: analysis_output/consolidation_analysis.md'
    ((deleted_count++))
fi
if [ -f 'analysis_output/backup_models.sh' ]; then
    rm 'analysis_output/backup_models.sh'
    echo 'Deleted: analysis_output/backup_models.sh'
    ((deleted_count++))
fi
if [ -f 'analysis_output/migration_guide.md' ]; then
    rm 'analysis_output/migration_guide.md'
    echo 'Deleted: analysis_output/migration_guide.md'
    ((deleted_count++))
fi
if [ -f 'analysis_output/model_inventory_report.md' ]; then
    rm 'analysis_output/model_inventory_report.md'
    echo 'Deleted: analysis_output/model_inventory_report.md'
    ((deleted_count++))
fi
if [ -f 'analysis_output/retire_models.sh' ]; then
    rm 'analysis_output/retire_models.sh'
    echo 'Deleted: analysis_output/retire_models.sh'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/financial_expert_test.txt' ]; then
    rm 'qa_results/20250606_081619/financial_expert_test.txt'
    echo 'Deleted: qa_results/20250606_081619/financial_expert_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/income_accuracy_result.txt' ]; then
    rm 'qa_results/20250606_081619/income_accuracy_result.txt'
    echo 'Deleted: qa_results/20250606_081619/income_accuracy_result.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/comprehensive_chain_test.txt' ]; then
    rm 'qa_results/20250606_081619/comprehensive_chain_test.txt'
    echo 'Deleted: qa_results/20250606_081619/comprehensive_chain_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/louisville_expert_test.txt' ]; then
    rm 'qa_results/20250606_081619/louisville_expert_test.txt'
    echo 'Deleted: qa_results/20250606_081619/louisville_expert_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/qa_summary.txt' ]; then
    rm 'qa_results/20250606_081619/qa_summary.txt'
    echo 'Deleted: qa_results/20250606_081619/qa_summary.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/enhanced_agent_test.txt' ]; then
    rm 'qa_results/20250606_081619/enhanced_agent_test.txt'
    echo 'Deleted: qa_results/20250606_081619/enhanced_agent_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250606_081619/accuracy_income_test.txt' ]; then
    rm 'qa_results/20250606_081619/accuracy_income_test.txt'
    echo 'Deleted: qa_results/20250606_081619/accuracy_income_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/financial_expert_test.txt' ]; then
    rm 'qa_results/20250605_200008/financial_expert_test.txt'
    echo 'Deleted: qa_results/20250605_200008/financial_expert_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/income_accuracy_result.txt' ]; then
    rm 'qa_results/20250605_200008/income_accuracy_result.txt'
    echo 'Deleted: qa_results/20250605_200008/income_accuracy_result.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/comprehensive_chain_test.txt' ]; then
    rm 'qa_results/20250605_200008/comprehensive_chain_test.txt'
    echo 'Deleted: qa_results/20250605_200008/comprehensive_chain_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/louisville_expert_test.txt' ]; then
    rm 'qa_results/20250605_200008/louisville_expert_test.txt'
    echo 'Deleted: qa_results/20250605_200008/louisville_expert_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/qa_summary.txt' ]; then
    rm 'qa_results/20250605_200008/qa_summary.txt'
    echo 'Deleted: qa_results/20250605_200008/qa_summary.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/enhanced_agent_test.txt' ]; then
    rm 'qa_results/20250605_200008/enhanced_agent_test.txt'
    echo 'Deleted: qa_results/20250605_200008/enhanced_agent_test.txt'
    ((deleted_count++))
fi
if [ -f 'qa_results/20250605_200008/accuracy_income_test.txt' ]; then
    rm 'qa_results/20250605_200008/accuracy_income_test.txt'
    echo 'Deleted: qa_results/20250605_200008/accuracy_income_test.txt'
    ((deleted_count++))
fi
if [ -f 'src/test/test_integration.py' ]; then
    rm 'src/test/test_integration.py'
    echo 'Deleted: src/test/test_integration.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/bridge.py' ]; then
    rm 'src/ai_framework/bridge.py'
    echo 'Deleted: src/ai_framework/bridge.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/framework.py' ]; then
    rm 'src/ai_framework/framework.py'
    echo 'Deleted: src/ai_framework/framework.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/__init__.py' ]; then
    rm 'src/ai_framework/__init__.py'
    echo 'Deleted: src/ai_framework/__init__.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/conductor.py' ]; then
    rm 'src/ai_framework/conductor.py'
    echo 'Deleted: src/ai_framework/conductor.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/core/message_bus.py' ]; then
    rm 'src/ai_framework/core/message_bus.py'
    echo 'Deleted: src/ai_framework/core/message_bus.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/core/intervention_manager.py' ]; then
    rm 'src/ai_framework/core/intervention_manager.py'
    echo 'Deleted: src/ai_framework/core/intervention_manager.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/core/specialist_handler.py' ]; then
    rm 'src/ai_framework/core/specialist_handler.py'
    echo 'Deleted: src/ai_framework/core/specialist_handler.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/core/__init__.py' ]; then
    rm 'src/ai_framework/core/__init__.py'
    echo 'Deleted: src/ai_framework/core/__init__.py'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/workflows/mirador_workflow.sh' ]; then
    rm 'src/ai_framework/workflows/mirador_workflow.sh'
    echo 'Deleted: src/ai_framework/workflows/mirador_workflow.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/utils/init.sh' ]; then
    rm 'src/ai_framework/utils/init.sh'
    echo 'Deleted: src/ai_framework/utils/init.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/utils/output_manager.sh' ]; then
    rm 'src/ai_framework/utils/output_manager.sh'
    echo 'Deleted: src/ai_framework/utils/output_manager.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/utils/logging.sh' ]; then
    rm 'src/ai_framework/utils/logging.sh'
    echo 'Deleted: src/ai_framework/utils/logging.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/utils/visualization.sh' ]; then
    rm 'src/ai_framework/utils/visualization.sh'
    echo 'Deleted: src/ai_framework/utils/visualization.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/file_reviewer.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/file_reviewer.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/file_reviewer.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/ux_designer.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/ux_designer.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/ux_designer.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/guitar_expert_precise.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/guitar_expert_precise.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/guitar_expert_precise.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/enhanced_agent.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/enhanced_agent.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/enhanced_agent.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/code_reviewer_fix.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/code_reviewer_fix.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/code_reviewer_fix.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/master_coder.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/master_coder.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/master_coder.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/fast_agent_focused.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/fast_agent_focused.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/fast_agent_focused.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/llama3.2_balanced.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/llama3.2_balanced.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/llama3.2_balanced.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/models/optimized/creative_entrepreneur.modelfile' ]; then
    rm 'src/ai_framework/models/optimized/creative_entrepreneur.modelfile'
    echo 'Deleted: src/ai_framework/models/optimized/creative_entrepreneur.modelfile'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/chains/run_chain.sh' ]; then
    rm 'src/ai_framework/chains/run_chain.sh'
    echo 'Deleted: src/ai_framework/chains/run_chain.sh'
    ((deleted_count++))
fi
if [ -f 'src/ai_framework/chains/role_chain.sh' ]; then
    rm 'src/ai_framework/chains/role_chain.sh'
    echo 'Deleted: src/ai_framework/chains/role_chain.sh'
    ((deleted_count++))
fi

echo "Total files deleted: $deleted_count"
echo "Backup saved at: $backup_dir"