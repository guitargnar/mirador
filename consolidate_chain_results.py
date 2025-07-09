#!/usr/bin/env python3
"""
Chain Results Consolidation Script
==================================

Consolidates all chain_results directories into a searchable archive
with metadata indexing for easy retrieval.
"""

import os
import json
import shutil
import sqlite3
from datetime import datetime
from pathlib import Path
import hashlib

class ChainResultsConsolidator:
    def __init__(self, archive_dir="chain_results_archive"):
        self.archive_dir = Path(archive_dir)
        self.archive_dir.mkdir(exist_ok=True)
        self.db_path = self.archive_dir / "chain_index.db"
        self.init_database()
        
    def init_database(self):
        """Initialize SQLite database for indexing chain results"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS chain_executions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                execution_id TEXT UNIQUE,
                timestamp TEXT,
                chain_type TEXT,
                prompt TEXT,
                models_used TEXT,
                output_format TEXT,
                summary TEXT,
                file_path TEXT,
                hash TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        cursor.execute('''
            CREATE INDEX IF NOT EXISTS idx_chain_type ON chain_executions(chain_type)
        ''')
        
        cursor.execute('''
            CREATE INDEX IF NOT EXISTS idx_timestamp ON chain_executions(timestamp)
        ''')
        
        conn.commit()
        conn.close()
        
    def calculate_hash(self, file_path):
        """Calculate MD5 hash of file to detect duplicates"""
        hash_md5 = hashlib.md5()
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
        
    def extract_metadata(self, chain_dir):
        """Extract metadata from chain execution directory"""
        metadata = {
            "execution_id": chain_dir.name,
            "timestamp": chain_dir.name.split('_')[-1] if '_' in chain_dir.name else "",
            "chain_type": "unknown",
            "prompt": "",
            "models_used": [],
            "output_format": "detailed",
            "summary": ""
        }
        
        # Try to read prompt
        prompt_file = chain_dir / "prompt.txt"
        if prompt_file.exists():
            metadata["prompt"] = prompt_file.read_text().strip()
            
        # Try to read summary
        summary_file = chain_dir / "summary.md"
        if summary_file.exists():
            metadata["summary"] = summary_file.read_text()[:500]  # First 500 chars
            
        # Detect chain type from content
        for file in chain_dir.glob("*"):
            if "life_optimization" in str(file):
                metadata["chain_type"] = "life_optimization"
            elif "business_acceleration" in str(file):
                metadata["chain_type"] = "business_acceleration"
            elif "creative_breakthrough" in str(file):
                metadata["chain_type"] = "creative_breakthrough"
            elif "relationship_harmony" in str(file):
                metadata["chain_type"] = "relationship_harmony"
            elif "technical_mastery" in str(file):
                metadata["chain_type"] = "technical_mastery"
            elif "strategic_synthesis" in str(file):
                metadata["chain_type"] = "strategic_synthesis"
                
        # Extract models used
        step_files = sorted(chain_dir.glob("step_*.md"))
        for step_file in step_files:
            content = step_file.read_text()
            if "Model:" in content:
                model_line = [line for line in content.split('\n') if "Model:" in line]
                if model_line:
                    model_name = model_line[0].split("Model:")[-1].strip()
                    metadata["models_used"].append(model_name)
                    
        return metadata
        
    def consolidate_directory(self, source_dir):
        """Consolidate a single chain results directory"""
        source_path = Path(source_dir)
        if not source_path.exists() or not source_path.is_dir():
            return False
            
        # Create archive subdirectory based on date
        date_str = datetime.now().strftime("%Y%m")
        archive_subdir = self.archive_dir / date_str
        archive_subdir.mkdir(exist_ok=True)
        
        # Extract metadata
        metadata = self.extract_metadata(source_path)
        
        # Copy directory to archive
        dest_path = archive_subdir / source_path.name
        if dest_path.exists():
            print(f"Skipping duplicate: {source_path.name}")
            return False
            
        try:
            shutil.copytree(source_path, dest_path)
        except Exception as e:
            print(f"⚠️  Error copying {source_path.name}: {e}")
            return False
        
        # Store in database
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        try:
            cursor.execute('''
                INSERT INTO chain_executions 
                (execution_id, timestamp, chain_type, prompt, models_used, 
                 output_format, summary, file_path)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            ''', (
                metadata["execution_id"],
                metadata["timestamp"],
                metadata["chain_type"],
                metadata["prompt"],
                json.dumps(metadata["models_used"]),
                metadata["output_format"],
                metadata["summary"],
                str(dest_path.relative_to(self.archive_dir))
            ))
            conn.commit()
            print(f"✓ Archived: {source_path.name}")
            return True
        except sqlite3.IntegrityError:
            print(f"Already archived: {source_path.name}")
            return False
        finally:
            conn.close()
            
    def consolidate_all(self):
        """Consolidate all chain results from home directory and outputs"""
        consolidated_count = 0
        
        # Find all chain_results directories in home
        home_dir = Path.home()
        chain_dirs = list(home_dir.glob("chain_results_*"))
        
        # Add outputs directories from current project
        outputs_dir = Path("outputs")
        if outputs_dir.exists():
            chain_dirs.extend(outputs_dir.glob("*"))
            
        print(f"Found {len(chain_dirs)} chain result directories to consolidate")
        
        for chain_dir in chain_dirs:
            if self.consolidate_directory(chain_dir):
                consolidated_count += 1
                
        print(f"\nConsolidation complete: {consolidated_count} directories archived")
        return consolidated_count
        
    def search(self, query=None, chain_type=None, start_date=None, end_date=None):
        """Search archived chain results"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        sql = "SELECT * FROM chain_executions WHERE 1=1"
        params = []
        
        if query:
            sql += " AND (prompt LIKE ? OR summary LIKE ?)"
            params.extend([f"%{query}%", f"%{query}%"])
            
        if chain_type:
            sql += " AND chain_type = ?"
            params.append(chain_type)
            
        if start_date:
            sql += " AND timestamp >= ?"
            params.append(start_date)
            
        if end_date:
            sql += " AND timestamp <= ?"
            params.append(end_date)
            
        sql += " ORDER BY timestamp DESC"
        
        cursor.execute(sql, params)
        results = cursor.fetchall()
        conn.close()
        
        return results
        
    def generate_report(self):
        """Generate a summary report of all archived chains"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Get statistics
        cursor.execute("SELECT COUNT(*) FROM chain_executions")
        total_count = cursor.fetchone()[0]
        
        cursor.execute("""
            SELECT chain_type, COUNT(*) as count 
            FROM chain_executions 
            GROUP BY chain_type 
            ORDER BY count DESC
        """)
        type_stats = cursor.fetchall()
        
        cursor.execute("""
            SELECT DATE(timestamp) as date, COUNT(*) as count 
            FROM chain_executions 
            WHERE timestamp != ''
            GROUP BY date 
            ORDER BY date DESC 
            LIMIT 30
        """)
        daily_stats = cursor.fetchall()
        
        conn.close()
        
        report = f"""# Chain Results Archive Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Summary
- Total Executions: {total_count}
- Archive Location: {self.archive_dir}
- Database: {self.db_path}

## Chain Type Distribution
"""
        for chain_type, count in type_stats:
            report += f"- {chain_type}: {count} executions\n"
            
        report += "\n## Recent Activity (Last 30 Days)\n"
        for date, count in daily_stats:
            report += f"- {date}: {count} executions\n"
            
        report_path = self.archive_dir / "ARCHIVE_REPORT.md"
        report_path.write_text(report)
        print(f"\nReport generated: {report_path}")
        
        return report

if __name__ == "__main__":
    consolidator = ChainResultsConsolidator()
    
    print("Starting chain results consolidation...")
    consolidator.consolidate_all()
    
    print("\nGenerating archive report...")
    consolidator.generate_report()
    
    print("\nExample searches:")
    print("- Recent life optimization chains:")
    results = consolidator.search(chain_type="life_optimization")
    for r in results[:3]:
        print(f"  {r[1]} - {r[3][:50]}...")