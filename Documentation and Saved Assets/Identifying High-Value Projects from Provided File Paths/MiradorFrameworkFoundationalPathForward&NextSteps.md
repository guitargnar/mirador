# Mirador Framework: Foundational Path Forward & Next Steps

## 1. Introduction

This document outlines a foundational path forward for the Mirador Framework, based on a comprehensive review of all provided project files, including the core `framework.py`, `api.py`, `config.json`, persona `*.modelfile` definitions, domain-specific chain `*.json` configurations, and supporting documentation (`README.md`, `CLAUDE.md`, `chain_catalog.md`, and domain-specific `*.md` files).

The recommendations aim to build upon Mirador's significant strengths—its modularity, local-first design, sophisticated persona chaining, and extensive domain-specific configurations—while addressing opportunities for enhanced robustness, usability, and maintainability for your personal daily endeavors.

## 2. Key Strengths Observed

*   **Comprehensive Local-First Architecture:** The framework is impressively self-contained, running locally with Ollama and custom-weighted models, aligning perfectly with your privacy requirements.
*   **Sophisticated Persona System:** The use of detailed system prompts in `*.modelfile`s and the `config.json` to define specialized AI personas is a powerful approach.
*   **Extensive Domain-Specific Chains:** The numerous `*.json` files defining chains for Business, Content, Finance, Music, Productivity, and Cross-Domain tasks demonstrate a rich and well-thought-out application of the framework.
*   **Clear Orchestration Logic:** `framework.py` provides a solid foundation for sequential chain execution, session management, and basic logging.
*   **API Layer for Potential Extension:** `api.py` offers a Flask-based API, indicating foresight for potential (even if currently unused for external access) programmatic interaction or local GUIs.
*   **Webhook Integration:** The presence of `webhook_handler.py` and related test scripts/logs shows an advanced feature for event-driven notifications.
*   **Detailed Documentation:** The `README.md`, `CLAUDE.md`, and `chain_catalog.md` provide good insight into the project's structure and usage.

## 3. Core Principles for Evolution (Reiteration)

All suggestions are made with the following core principles, derived from your project goals, in mind:

*   **Privacy First:** Solutions must maintain the local-only nature of the project.
*   **Personal Use Focus:** Enhancements should benefit your daily personal endeavors, not prepare for public deployment.
*   **Maintainability & Reusability:** Changes should contribute to an "ironclad reusable state."
*   **Leverage Existing Strengths:** Build upon the current modular architecture and persona system.

## 4. Foundational Recommendations & Actionable Next Steps

Based on the review and synthesis, here are prioritized recommendations. These are designed to be implemented incrementally within your Claude Code terminal environment.

### Recommendation 1: Enhance Configuration Management & Versioning (High Impact, Low Effort)

**Rationale:** As your `config.json` and `*.modelfile` definitions grow and evolve, robust versioning and easier management become crucial for stability and experimentation.

**Actionable Steps (for you to implement in your Claude Code terminal):**

1.  **Implement Git Version Control (if not already strictly used for all relevant files):**
    *   **Context:** You mentioned this in our previous discussion, and it remains a top priority.
    *   **Action:** Ensure your entire Mirador project directory (including `ai_framework/`, `modelfiles/`, `domains/`, etc.) is a Git repository.
    *   **Command (if starting new or ensuring all is covered):**
        ```bash
        cd /path/to/your/mirador_project # Navigate to your main project root
        git init # If not already a repo
        git add . # Add all project files
        # Create/update .gitignore to exclude logs, __pycache__, venv, etc.
        echo "ai_framework/logs/" >> .gitignore
        echo "ai_framework/outputs/" >> .gitignore # If you don't want to version outputs
        echo "__pycache__/" >> .gitignore
        echo "*.pyc" >> .gitignore
        echo ".venv/" >> .gitignore # Or your virtual env name
        git commit -m "Initial or comprehensive commit of Mirador project files"
        ```
    *   **Ongoing:** Commit changes frequently with descriptive messages, especially after modifying `config.json`, `*.modelfile`s, or chain `*.json` files. Use tags for stable versions (e.g., `git tag v0.2-stable-config`).

2.  **Consider Splitting `config.json` for Modularity (Optional, Medium Effort):
    *   **Rationale:** Your `config.json` is becoming quite large with many personas. While manageable, splitting persona definitions from the main chain/webhook config could improve readability.
    *   **Suggestion:** You could have a `personas/` directory where each persona has its own JSON or a grouped JSON (e.g., `core_personas.json`, `creative_personas.json`). The main `config.json` would then reference these, or `framework.py` could be updated to load them.
    *   **Impact:** This is more of a long-term maintainability improvement. If the current `config.json` is working well for you, this can be deferred.

### Recommendation 2: Standardize and Validate Chain Definition JSONs (Medium Impact, Medium Effort)

**Rationale:** You have many domain-specific `*.json` files for chains. Standardizing their structure and adding a validation step can prevent errors and make them easier to manage and create.

**Actionable Steps:**

1.  **Define a JSON Schema for Chain Definitions:**
    *   **Action:** Create a `chain_schema.json` file that defines the expected structure for your domain chain JSON files (e.g., `business_builder.json`). This schema would specify required fields (`name`, `description`, `command` or `steps`, `personas`), types, and any constraints.
    *   **Example `chain_schema.json` snippet:**
        ```json
        {
          "$schema": "http://json-schema.org/draft-07/schema#",
          "title": "Mirador Chain Definition",
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "description": {"type": "string"},
            "command": {"type": "string"}, // For simple chains
            "steps": { // For multi-step cross-domain chains
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "name": {"type": "string"},
                  "domain": {"type": "string"},
                  "command": {"type": "string"},
                  "personas": {"type": "array", "items": {"type": "string"}},
                  "output_file": {"type": "string"}
                },
                "required": ["name", "command", "personas"]
              }
            },
            "personas": { // For simple chains
              "type": "array",
              "items": {"type": "string"}
            },
            "notes": {"type": "string"}
          },
          "oneOf": [
             { "required": ["name", "description", "command", "personas"] },
             { "required": ["name", "description", "steps"] }
          ]
        }
        ```

2.  **Add a Validation Utility or Step:**
    *   **Action:** Create a small Python script (e.g., `validate_chains.py`) that uses a library like `jsonschema` to validate all your `domains/**/*.json` files against `chain_schema.json`.
    *   **Python Snippet (`validate_chains.py`):**
        ```python
        import json
        import os
        from jsonschema import validate, exceptions
        
        def validate_chain_files(schema_path, domains_dir):
            try:
                with open(schema_path, 'r') as f_schema:
                    schema = json.load(f_schema)
            except FileNotFoundError:
                print(f"ERROR: Schema file not found at {schema_path}")
                return
            except json.JSONDecodeError:
                print(f"ERROR: Schema file {schema_path} is not valid JSON.")
                return

            print(f"Validating chain definitions in {domains_dir} against {schema_path}\n")
            has_errors = False
            for root, _, files in os.walk(domains_dir):
                for file in files:
                    if file.endswith(".json"):
                        file_path = os.path.join(root, file)
                        try:
                            with open(file_path, 'r') as f_chain:
                                chain_data = json.load(f_chain)
                            validate(instance=chain_data, schema=schema)
                            print(f"OK: {file_path}")
                        except FileNotFoundError:
                            print(f"ERROR: File not found {file_path}")
                            has_errors = True
                        except json.JSONDecodeError:
                            print(f"ERROR: {file_path} is not valid JSON.")
                            has_errors = True
                        except exceptions.ValidationError as e:
                            print(f"VALIDATION ERROR in {file_path}: {e.message} (Path: {list(e.path)})")
                            has_errors = True
                        except Exception as e:
                            print(f"UNEXPECTED ERROR validating {file_path}: {e}")
                            has_errors = True
            if has_errors:
                print("\nValidation finished with errors.")
            else:
                print("\nAll chain definitions validated successfully!")

        if __name__ == "__main__":
            # Assuming this script is in your project root, and domains are in ai_framework/domains
            # Adjust paths as necessary
            project_root = os.path.dirname(os.path.abspath(__file__))
            schema_file = os.path.join(project_root, "ai_framework", "chain_schema.json") 
            domains_folder = os.path.join(project_root, "ai_framework", "domains")
            validate_chain_files(schema_file, domains_folder)
        ```
    *   **Usage:** Run `python3 validate_chains.py` periodically or before committing changes to ensure your chain definitions are correct.
    *   **Note:** You'll need to install `jsonschema`: `pip3 install jsonschema`.

### Recommendation 3: Enhance `framework.py` for Robustness and Usability (High Impact, Medium Effort)

**Rationale:** While `framework.py` is solid, several enhancements can make it more robust for daily use and easier to debug.

**Actionable Steps:**

1.  **Improved Error Handling and Reporting in `run_persona` and `run_chain`:**
    *   **Context:** Currently, errors are logged and sometimes printed, but the chain might continue or return partial results. For personal use, more explicit error stopping or detailed in-terminal reporting can be helpful.
    *   **Suggestion:**
        *   In `run_persona`, if an Ollama call fails (e.g., connection error, model not found), ensure it clearly indicates this to the user if in interactive mode and perhaps offers a retry option or a way to skip and provide manual input.
        *   In `run_chain`, if a persona fails and `continue_on_error` is `False` (which should be the default for ensuring quality), the chain should stop, and a clear summary of where it stopped and why should be provided.

2.  **More Granular Control over Persona Parameters from CLI:**
    *   **Context:** The `persona_parameters` argument in `run_chain` is powerful but requires JSON input. A simpler CLI way to override common parameters (like `temperature`) for a specific run could be useful for experimentation.
    *   **Suggestion:** Consider adding CLI arguments like `--override-temp <persona_id>:<value>` or a more general `--override-param <persona_id>:<param_name>:<param_value>`.
    *   **Impact:** This adds complexity to CLI parsing but enhances flexibility for quick tests.

3.  **Interactive Input/Output Editing Enhancement:**
    *   **Context:** The current edit mechanism relies on the user manually editing the file and pressing Enter. This is functional but could be smoother.
    *   **Suggestion (Low hanging fruit):** After the user presses Enter, re-display a snippet of the (potentially) modified content from the file so they can confirm the changes were loaded correctly before proceeding.
    *   **Suggestion (More advanced):** For interactive sessions, instead of just file path, offer to open the output file in a default text editor (`os.system(f"open {output_path}")` on macOS, or `xdg-open` on Linux) and then wait. Or, allow pasting multi-line input directly in the terminal if an editor is not preferred.

4.  **Refined Logging:**
    *   **Context:** Logging to both stream and file is good. Consider structured logging (e.g., JSON logs) for easier machine parsing if you ever want to build analytics on top of logs, though for personal use, human-readable is often fine.
    *   **Suggestion:** Ensure that the `session_id` is a prominent part of every log message related to that session for easier filtering.

### Recommendation 4: Streamline Multi-Step (Cross-Domain) Chain Execution (Medium Impact, Medium Effort)

**Rationale:** Chains like `creator_financial_freedom.json` and `guitar_teacher_empire.json` define `steps`. The `framework.py` doesn't seem to have explicit logic to parse and execute these multi-step definitions directly; the `command` field in these JSONs seems to be a manual instruction or a simplified single call.

**Actionable Steps:**

1.  **Add Logic to `framework.py` to Natively Execute Multi-Step Chains:**
    *   **Action:** Modify `AIFramework.run_chain` (or create a new method like `run_meta_chain`) to detect if the provided chain definition (from a JSON file) contains a `steps` array.
    *   If `steps` exists:
        *   Iterate through each step.
        *   For each step, construct the necessary call to `run_chain` or `run_persona` based on the step's `command` (which might need parsing) or its defined `personas` and an initial prompt for that step.
        *   Crucially, implement a mechanism to pass the output of one step (e.g., content of `output_file`) as the primary input to the next step's prompt template.
    *   **Example modification in `framework.py` (conceptual):**
        ```python
        # In AIFramework class
        def run_meta_chain(self, chain_name_or_definition, initial_input_for_first_step, interactive=True):
            chain_def = None
            if isinstance(chain_name_or_definition, str):
                # Logic to load chain definition JSON by name from your domains folder
                # chain_def = self._load_chain_definition(chain_name_or_definition)
                pass # Placeholder for loading logic
            elif isinstance(chain_name_or_definition, dict):
                chain_def = chain_name_or_definition

            if not chain_def or "steps" not in chain_def:
                logger.error("Not a valid multi-step chain definition.")
                return {}

            logger.info(f"Running multi-step chain: {chain_def.get('name', 'Unnamed')}")
            step_outputs = {}
            current_step_input = initial_input_for_first_step

            for i, step in enumerate(chain_def["steps"]):
                step_name = step.get("name", f"step_{i+1}")
                logger.info(f"Running step: {step_name}")
                
                # Prepare input for this step - might be initial input or output from previous step
                # This requires careful templating in your step definitions
                # For example, the step's prompt_template in config.json for its personas
                # might need to accept {{previous_step_output}}
                
                # Simplified: Assume step["command"] is a full mirador command string that needs parsing
                # Or, better: step["chain_to_run"] and step["prompt_template_for_step"]
                # For now, let's assume we call run_chain for each sub-chain defined in the step
                # This part needs careful design based on how you want to define step inputs.

                # Example: if step has 'personas' and a way to formulate its specific prompt
                # step_prompt = f"Based on previous work ({current_step_input}), now {step['task_description']}"
                # step_output = self.run_chain(input_text=step_prompt, 
                #                              start_at=step["personas"][0],
                #                              end_at=step["personas"][-1],
                #                              interactive=interactive)
                # current_step_input = self._get_final_output_from_step_result(step_output) # Extract relevant text
                # step_outputs[step_name] = current_step_input
                
                # This is a placeholder for the actual execution logic for a step
                print(f"Placeholder for executing step: {step_name} with input derived from: {current_step_input[:100]}...")
                # Simulate output being generated and becoming input for the next step
                mock_output = f"Output from {step_name}"
                
                # Save step output to its defined file (if any)
                if "output_file" in step:
                    output_file_path = os.path.join(f"ai_framework/outputs/{self.session_id}", step["output_file"])
                    with open(output_file_path, "w") as f_out:
                        f_out.write(mock_output) # Replace mock_output with actual output
                    logger.info(f"Step '{step_name}' output saved to {output_file_path}")
                
                current_step_input = mock_output # Actual output from the step
                step_outputs[step_name] = current_step_input

            logger.info("Multi-step chain finished.")
            return step_outputs
        ```
    *   **Impact:** This would make your powerful cross-domain chains truly automated within the framework itself, rather than relying on manual execution of listed commands.

### Recommendation 5: Personal Knowledge Base Integration (Longer Term, High Impact)

**Rationale:** You mentioned this as a future direction. For personal use, having personas consult a local, curated set of your own notes, documents, or past outputs could be incredibly powerful.

**Actionable Steps (Conceptual Outline - this is a larger feature):**

1.  **Choose a Local Vector Store / Search Index:**
    *   Options: FAISS (CPU/GPU), ChromaDB (local), LanceDB. For simplicity and local use, ChromaDB or even SQLite with FTS5 could be starting points.
2.  **Create an Ingestion Pipeline:**
    *   A script to process your personal documents (Markdown, text files, PDFs).
    *   Chunk documents, generate embeddings (using a local Ollama model like Nomic Embed or SBert), and store them in the vector store.
3.  **Modify `rag_node` (or create a new `personal_rag_node`):**
    *   Before calling the LLM, this persona would take the user's query/current context.
    *   Generate an embedding for the query.
    *   Perform a similarity search against your local vector store to find relevant document chunks.
    *   Prepend these relevant chunks to the prompt for the LLM (e.g., the `rag_node`'s LLM).
    *   The LLM then synthesizes an answer based on both the original query and the retrieved personal context.

## 5. Summary of Foundational Path

1.  **Solidify Core:** Implement robust version control (Git) and consider `config.json` modularity. Standardize and validate chain definition JSONs.
2.  **Enhance Framework:** Improve `framework.py` error handling, CLI parameter flexibility, interactive editing, and logging.
3.  **Automate Complex Chains:** Natively support multi-step chain execution within `framework.py`.
4.  **Future-Proof with Knowledge:** Plan for (and optionally begin experimenting with) local RAG for personal knowledge base integration.

These steps, when implemented, will significantly enhance the robustness, usability, and power of your Mirador Framework for your personal daily endeavors, building on the already impressive foundation you've created.

I recommend starting with **Recommendation 1 (Git and Chain Validation)** as they provide immediate stability and maintainability benefits with relatively low effort. Then, move to **Recommendation 3 (Framework Enhancements)** and **Recommendation 4 (Multi-Step Chains)** as they directly improve the core functionality and automation capabilities.

