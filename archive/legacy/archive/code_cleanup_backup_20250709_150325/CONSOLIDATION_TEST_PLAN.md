# Consolidation Test Plan

## Overview
This document outlines the testing strategy to ensure the consolidation process maintains system integrity.

## Pre-Consolidation Tests

### 1. Current System Health Check
```bash
# Test current mirador functionality
./mirador-smart-v2 "Test query to ensure system works"

# Check all critical scripts are executable
find . -name "*.sh" -type f -exec test -x {} \; -print | wc -l

# Verify model availability
ollama list | grep -E "(matthew_context|universal_strategy|creative_catalyst)" | wc -l
```

### 2. Backup Verification
```bash
# Verify backups are complete
ls -la ~/mirador_consolidation_backup_20250709/
tar -tzf ~/mirador_consolidation_backup_20250709/mirador_project_backup.tar.gz | wc -l
tar -tzf ~/mirador_consolidation_backup_20250709/ai_framework_git_backup.tar.gz | wc -l
```

## During Consolidation Tests

### 1. File Comparison Tests
```bash
# Test for file differences before deletion
diff /Users/matthewscott/ai_framework_git/robust_chain_runner.sh ./robust_chain_runner.sh
diff /Users/matthewscott/ai_framework_git/README.md ./README.md
```

### 2. Import Validation
```bash
# After importing unique files, verify they work
python3 ollama_model_extractor.py --help
python3 enhanced_model_analyzer.py --help
```

## Post-Consolidation Tests

### 1. Core Functionality Tests
```bash
# Test all major entry points
./mirador-smart-v2 "What should I focus on today?"
./mirador_universal_runner_v2.sh life_optimization "Test query" quick
./mirador-ez chain "Test" matthew_context_provider_v5_complete universal_strategy_architect
```

### 2. Model Chain Tests
```bash
# Test each universal chain type
for chain in life_optimization business_acceleration creative_breakthrough relationship_harmony technical_mastery strategic_synthesis; do
    echo "Testing $chain..."
    ./mirador_universal_runner_v2.sh $chain "Brief test" quick
done
```

### 3. Integration Tests
```bash
# Test context manager
python3 context_manager.py stats

# Test constraint validator
echo "Work 8 hours, exercise 1 hour, spend time with family" | python3 constraint_validator.py validate -

# Test memory system
python3 ai_memory/init_db.py
```

### 4. Performance Benchmarks
```bash
# Measure response times
time ./mirador-smart-v2 "Quick performance test"

# Check model loading times
time echo "test" | ollama run matthew_context_provider_v5_complete
```

## Rollback Plan

### If Issues Detected:
1. **Immediate Rollback**:
   ```bash
   git checkout main
   git branch -D feature/portfolio-consolidation
   ```

2. **Restore from Backup**:
   ```bash
   cd ~/Projects/mirador
   rm -rf *
   tar -xzf ~/mirador_consolidation_backup_20250709/mirador_project_backup.tar.gz
   ```

3. **Restore ai_framework_git**:
   ```bash
   cd ~
   tar -xzf ~/mirador_consolidation_backup_20250709/ai_framework_git_backup.tar.gz
   ```

## Success Criteria

✅ All test commands execute without errors
✅ Response times remain under 60 seconds
✅ All 80+ models remain accessible
✅ No data loss detected
✅ Unique tools successfully integrated
✅ Documentation remains accessible

## Test Log
Document results here:

- [ ] Pre-consolidation health check: 
- [ ] Backup verification: 
- [ ] File comparison tests: 
- [ ] Core functionality tests: 
- [ ] Model chain tests: 
- [ ] Integration tests: 
- [ ] Performance benchmarks: 

## Sign-off
Consolidation approved when all tests pass: _______________