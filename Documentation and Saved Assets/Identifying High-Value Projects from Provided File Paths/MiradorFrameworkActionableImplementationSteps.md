# Mirador Framework: Actionable Implementation Steps

This document provides concrete, copy-pasteable action steps to implement selected high-impact suggestions for your Mirador Framework. These steps are designed for your Claude Code (local terminal) environment and align with the project's private, local-only nature.

## Selected Suggestions for Implementation:

1.  **Version Control with Git:** Implement Git for versioning your Mirador project files, especially `config.json` and `*.modelfile`.
2.  **Golden-File Testing:** Set up a basic structure for golden-file tests to ensure chain output consistency.
3.  **Automated Output Logging (CSV):** Create a simple CSV logger to track persona outputs and user ratings for trend analysis.

---

## Action Step 1: Implement Version Control with Git

This will help you track changes, experiment safely, and roll back if needed.

**Assumptions:**
*   You have Git installed on your MacBook M3.
*   Your Mirador project files (Python scripts, `config.json`, `modelfiles/` directory, etc.) are in a main project directory (e.g., `~/mirador_project/`).

**Instructions:**

1.  **Navigate to your Mirador project directory:**
    ```bash
    cd ~/mirador_project  # Replace with your actual project path
    ```

2.  **Initialize a Git repository:**
    ```bash
    git init
    ```

3.  **Create a `.gitignore` file:** This file tells Git which files or directories to ignore (e.g., Python virtual environments, `__pycache__`, large output directories if you don't want to version them).
    Create a file named `.gitignore` in your project root (`~/mirador_project/`) with the following content (adjust as needed):
    ```gitignore
    # Python
    __pycache__/
    *.py[cod]
    *$py.class
    
    # Virtual environment (if you use one, e.g., venv, .venv)
    venv/
    .venv/
    env/
    .env
    
    # Ollama models (these are managed by Ollama, not versioned with project code)
    # You might have a local ollama models directory if you symlink, otherwise not needed here
    
    # Mirador session outputs (can get very large, consider if you want to version these)
    # If your output directory is, for example, `ai_framework/outputs/`
    # ai_framework/outputs/
    
    # IDE / Editor specific files
    .vscode/
    .idea/
    *.swp
    *.swo
    ```

4.  **Add your project files to Git staging:**
    ```bash
    git add .
    ```

5.  **Make your initial commit:**
    ```bash
    git commit -m "Initial commit of Mirador Framework project"
    ```

6.  **(Recommended) Create Git tags for significant versions of your configurations:** After making important changes to `config.json` or your modelfiles and committing them, you can tag that commit.
    For example, after a stable configuration:
    ```bash
    git tag v1.0_stable_config
    ```
    You can list tags with `git tag` and checkout a tag with `git checkout tags/<tag_name>`.

**Ongoing Use:**
*   After making changes to your files: `git add .` then `git commit -m "Your descriptive commit message"`
*   To see changes: `git status`, `git diff`
*   To view history: `git log`

---

## Action Step 2: Basic Golden-File Testing Structure

This provides a way to check if your chains produce consistent (or expected) outputs for specific inputs.

**Assumptions:**
*   Your Mirador framework can be invoked via a Python script or command line.
*   You have a main script, e.g., `framework.py` in `~/mirador_project/ai_framework/` as suggested by `CLAUDE.md`.

**Instructions:**

1.  **Create a `tests/` directory in your project root:**
    ```bash
    cd ~/mirador_project # Or your project root
    mkdir tests
    cd tests
    ```

2.  **Create a subdirectory for golden files:**
    ```bash
    mkdir golden_files
    ```

3.  **Create your first golden input and output:**
    *   **Input:** Create a file, e.g., `tests/golden_files/test01_master_coder_prompt.txt`, with a simple prompt you want to test, for example:
        ```txt
        Create a Python function to calculate the square of a number.
        ```
    *   **Expected Output (Golden File):** Manually run your Mirador chain (e.g., just the `master_coder` persona) with this prompt. Save the key parts of the output you expect to remain consistent into a file, e.g., `tests/golden_files/test01_master_coder_expected.txt`. This might not be the *entire* output, but rather specific code structures or phrases.
        Example `test01_master_coder_expected.txt` (simplified):
        ```python
        def square(number):
            return number * number
        ```

4.  **Create a simple test script (e.g., `tests/run_tests.py`):**
    This script will run the prompt and compare its output to the golden file.
    ```python
    # ~/mirador_project/tests/run_tests.py
    import subprocess
    import os
    
    def run_mirador_chain(prompt_text, persona_chain_args):
        """ 
        This function needs to be adapted to how you actually run a Mirador chain.
        It should return the relevant output string from the persona.
        Example: Invoking your framework.py script.
        """
        # Example: Assuming your framework.py is in ../ai_framework/
        # and takes a prompt and perhaps persona arguments.
        # This is a placeholder and needs to be customized!
        project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
        framework_script = os.path.join(project_root, "ai_framework", "framework.py")
        
        # Construct the command based on how your Mirador CLI works
        # This example assumes you can specify a single persona or a short chain
        # and that the output goes to stdout.
        # You might need to parse a file if output is saved to a session directory.
        command = [
            "python3", 
            framework_script, 
            "--prompt", prompt_text
        ] + persona_chain_args # e.g., ["--start", "master_coder", "--end", "master_coder", "--non-interactive"]
        
        try:
            print(f"Running command: {" ".join(command)}")
            result = subprocess.run(command, capture_output=True, text=True, check=True, cwd=project_root)
            # This is a simplification. You will likely need to parse the actual output 
            # from Mirador's session files or structured output if it's not just stdout.
            # For now, let's assume the relevant part is in stdout.
            return result.stdout.strip()
        except subprocess.CalledProcessError as e:
            print(f"Error running Mirador: {e}")
            print(f"Stderr: {e.stderr}")
            return None
        except FileNotFoundError:
            print(f"Error: framework.py not found at {framework_script}. Adjust path.")
            return None
    
    def compare_outputs(actual_output, expected_output_path):
        with open(expected_output_path, "r") as f:
            expected = f.read().strip()
        
        # Simple exact match for demonstration. 
        # You might want partial match, regex, or key phrase checking.
        # For LLM outputs, exact matches are rare. Consider checking for key elements.
        # For this example, we'll check if expected is a substring of actual.
        if expected in actual_output:
            print(f"PASS: Output matches {expected_output_path}")
            return True
        else:
            print(f"FAIL: Output does not match {expected_output_path}")
            print("--- EXPECTED (content from golden file) ---")
            print(expected)
            print("--- ACTUAL (from Mirador run) ---")
            print(actual_output)
            print("----------------------------------------")
            return False
    
    if __name__ == "__main__":
        print("Running Mirador Golden File Tests...")
        
        # Test Case 1: Master Coder basic prompt
        prompt_file_1 = "golden_files/test01_master_coder_prompt.txt"
        expected_output_file_1 = "golden_files/test01_master_coder_expected.txt"
        # Define how to run just the master_coder persona or a chain that includes it.
        # These args depend on your Mirador CLI. Example:
        master_coder_args = ["--start", "master_coder", "--end", "master_coder", "--non-interactive"]
        # If your Mirador framework has a config for a chain named "master_coder_only_chain":
        # master_coder_args = ["--chain", "master_coder_only_chain", "--non-interactive"]
        
        with open(prompt_file_1, "r") as f:
            prompt1_text = f.read().strip()
        
        actual_output_1 = run_mirador_chain(prompt1_text, master_coder_args)
        
        if actual_output_1:
            compare_outputs(actual_output_1, expected_output_file_1)
        else:
            print(f"FAIL: Could not get output for {prompt_file_1}")
        
        # Add more test cases here...
        print("\nTests finished.")
    ```

5.  **Run your test script:**
    ```bash
    cd ~/mirador_project/tests # Or your project root/tests
    python3 run_tests.py
    ```
    You will need to **heavily customize** the `run_mirador_chain` function in `run_tests.py` to correctly invoke your Mirador framework and retrieve the specific persona output you want to test.

**Important Considerations for Golden File Tests with LLMs:**
*   LLM outputs are often non-deterministic. Exact matches are rare.
*   Focus on testing for the presence of key phrases, structural elements, or specific information rather than byte-for-byte equality.
*   You might need to parse the output (e.g., if it's JSON or Markdown) to extract the relevant parts for comparison.
*   Start with very simple, stable prompts and personas.

---

## Action Step 3: Automated Output Logging (CSV)

This creates a simple CSV log to track chain executions, sentiment scores (if you implement them), and your manual ratings.

**Instructions:**

1.  **Decide on your CSV log file location and name:** e.g., `~/mirador_project/mirador_log.csv`

2.  **Modify your Mirador framework's main execution script (e.g., `framework.py`) to append to this CSV.**

    Add a function to log data and call it after each persona completes or at the end of a chain.

    ```python
    # Example additions to your main Mirador script (e.g., ai_framework/framework.py)
    import csv
    import os
    from datetime import datetime
    
    LOG_FILE_PATH = os.path.expanduser("~/mirador_project/mirador_log.csv") # Adjust path
    LOG_HEADER = ["timestamp", "chain_name", "persona_id", "prompt_snippet", "output_snippet", "user_rating", "sentiment_score", "notes"]
    
    def initialize_log_file():
        if not os.path.exists(LOG_FILE_PATH):
            with open(LOG_FILE_PATH, "w", newline="") as f:
                writer = csv.writer(f)
                writer.writerow(LOG_HEADER)
    
    def log_mirador_run(chain_name, persona_id, prompt, output, user_rating="N/A", sentiment_score="N/A", notes=""):
        initialize_log_file() # Ensure header exists
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        prompt_snippet = (prompt[:75] + '...') if len(prompt) > 75 else prompt # Log a snippet
        output_snippet = (output[:75] + '...') if len(output) > 75 else output # Log a snippet
        
        with open(LOG_FILE_PATH, "a", newline="") as f:
            writer = csv.writer(f)
            writer.writerow([
                timestamp, 
                chain_name, 
                persona_id, 
                prompt_snippet, 
                output_snippet, 
                user_rating, 
                sentiment_score, 
                notes
            ])
    
    # --- In your main chain execution loop --- 
    # After a persona generates its output:
    # ... existing code to get persona_output ...
    
    # Example call (you'll need to get these variables from your context):
    # current_chain_name = "my_analysis_chain" # Get this from your config or runtime
    # current_persona_id = persona.id # Get the current persona's ID
    # input_to_persona = "..." # The input text for this persona
    # output_from_persona = "..." # The output text from this persona
    
    # At the point where you ask the user "y/n" to continue, you can also ask for a rating:
    # user_choice = input(f"Output from {current_persona_id}. Continue chain? (y/n/rate): ")
    # user_rating_value = "N/A"
    # if user_choice.lower() == 'rate':
    #     user_rating_value = input("Rate this output (1-5, or notes): ")
    #     # Then log, and ask again y/n to continue
    
    # log_mirador_run(
    #     chain_name=current_chain_name, 
    #     persona_id=current_persona_id, 
    #     prompt=input_to_persona,
    #     output=output_from_persona,
    #     user_rating=user_rating_value # Collect this from user if desired
    #     # sentiment_score=get_sentiment(output_from_persona) # If you implement sentiment analysis
    # )
    ```

3.  **Integrate the `log_mirador_run` call into your framework.**
    *   You'll need to decide where it makes the most sense: after each persona, or at the end of a full chain run.
    *   You'll need to pass the relevant data (chain name, persona ID, prompt, output) to the logging function.
    *   To get `user_rating`, you could extend your existing `y/n` prompt to also allow providing a quick rating or note.

4.  **(Optional) Implement Sentiment Scoring:**
    If you want to automate `sentiment_score` (as suggested by ChatGPT):
    *   Install a library: `pip3 install vaderSentiment` (VADER is good for general text)
    *   Add a function to get sentiment:
        ```python
        # In the same file or a utils.py
        from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
        
        analyzer = SentimentIntensityAnalyzer()
        
        def get_sentiment(text):
            vs = analyzer.polarity_scores(text)
            return vs['compound'] # Returns a float between -1 (most negative) and +1 (most positive)
        ```
    *   Call `get_sentiment(output_from_persona)` and pass it to `log_mirador_run`.

**Using the Log:**
*   You can open `mirador_log.csv` with any spreadsheet program (Excel, Google Sheets, Numbers, LibreOffice Calc) to view, sort, and analyze trends in your Mirador outputs and persona performance.

---

These steps provide a starting point. You will likely need to adapt the Python snippets to fit the exact structure and workflow of your existing Mirador Framework scripts. Remember to commit these changes to Git as you implement them!

