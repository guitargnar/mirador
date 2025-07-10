#!/bin/bash
# Test script for RAG chain functionality

echo "🧪 Testing Mirador RAG Chain"
echo "=========================="
echo ""

# Test 1: Document analysis without file
echo "Test 1: Document analysis query (no file)"
./bin/mirador_rag_chain.sh document "What are the key components of an effective AI strategy?"
echo ""
echo "Press Enter to continue..."
read

# Test 2: Code analysis with sample
echo "Test 2: Code analysis with sample file"
echo "Creating sample code file..."
cat > /tmp/sample_code.py << 'EOF'
import torch
import torch.nn as nn

class TransformerModel(nn.Module):
    def __init__(self, vocab_size, d_model=512, nhead=8, num_layers=6):
        super().__init__()
        self.embedding = nn.Embedding(vocab_size, d_model)
        self.pos_encoding = PositionalEncoding(d_model)
        self.transformer = nn.Transformer(d_model, nhead, num_layers)
        self.fc_out = nn.Linear(d_model, vocab_size)
        
    def forward(self, src, tgt):
        src = self.embedding(src) * math.sqrt(self.d_model)
        src = self.pos_encoding(src)
        tgt = self.embedding(tgt) * math.sqrt(self.d_model)
        tgt = self.pos_encoding(tgt)
        output = self.transformer(src, tgt)
        return self.fc_out(output)

class PositionalEncoding(nn.Module):
    def __init__(self, d_model, max_len=5000):
        super().__init__()
        pe = torch.zeros(max_len, d_model)
        position = torch.arange(0, max_len).unsqueeze(1)
        div_term = torch.exp(torch.arange(0, d_model, 2) * -(math.log(10000.0) / d_model))
        pe[:, 0::2] = torch.sin(position * div_term)
        pe[:, 1::2] = torch.cos(position * div_term)
        self.register_buffer('pe', pe)
        
    def forward(self, x):
        return x + self.pe[:x.size(0)]
EOF

./bin/mirador_rag_chain.sh code "Explain the architecture and identify potential improvements" /tmp/sample_code.py
echo ""
echo "Press Enter to continue..."
read

# Test 3: Research analysis
echo "Test 3: Research paper analysis (simulated)"
./bin/mirador_rag_chain.sh research "What are the main contributions and limitations of this research?"
echo ""

echo "✅ RAG Chain tests complete!"
echo ""
echo "Check the outputs directory for detailed analysis reports."