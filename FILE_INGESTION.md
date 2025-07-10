# Mirador File Ingestion System

## How File Processing Works

### 1. **Direct File Analysis** (RAG Chain)
The RAG chain uses Command-R 35B model optimized for retrieval-augmented generation:

```bash
# Supports multiple file types
./bin/mirador_rag_chain.sh [type] "your query" /path/to/file

# Types: document, code, research, report, comparison
```

### 2. **Supported File Types**
- **Documents**: PDF, TXT, MD, DOC, DOCX
- **Code**: PY, JS, TS, GO, RUST, JAVA, C, CPP
- **Data**: JSON, CSV, XML, YAML
- **Web**: HTML, saved web pages

### 3. **Processing Pipeline**

```
File → Text Extraction → Chunking → Context Injection → Model Analysis → Structured Output
```

### 4. **Advanced Features**

#### Multi-file Comparison
```bash
# Compare two documents
./bin/mirador_rag_chain.sh comparison "What are the key differences?" file1.pdf file2.pdf
```

#### Code Analysis
```bash
# Deep code review
./bin/mirador_rag_chain.sh code "Security audit" /src/app.py
```

#### Research Synthesis
```bash
# Extract insights from papers
./bin/mirador_rag_chain.sh research "Summarize findings" paper.pdf
```

### 5. **Context Window Management**
- Command-R: 128K token context window
- Automatic chunking for large files
- Maintains document structure awareness

### 6. **Output Structure**
Each analysis creates:
- `document_summary.md` - Key points
- `detailed_analysis.md` - Full analysis
- `extracted_data.json` - Structured data
- `action_items.md` - Next steps

## Examples

### Financial Document Analysis
```bash
./bin/mirador_rag_chain.sh document "Extract all expenses and categorize" bank_statement.pdf
```

### Codebase Understanding
```bash
./bin/mirador_rag_chain.sh code "Map the architecture and dependencies" /project/src/
```

### Contract Review
```bash
./bin/mirador_rag_chain.sh document "Identify key terms and potential issues" contract.pdf
```

## Future Capabilities
- OCR for images
- Audio transcription
- Video frame analysis
- Real-time document monitoring