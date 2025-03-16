import ast
import os
import re
from typing import List, Dict, Set

class CodeAnalyzer:
    def __init__(self):
        self.issues = []
        self.optimization_suggestions = []
        
    def analyze_file(self, filepath: str) -> None:
        """Analyze a single Python file for potential issues."""
        try:
            with open(filepath, 'r') as file:
                content = file.read()
                
            # Basic pattern checks
            self._check_resource_leaks(content, filepath)
            self._check_error_handling(content, filepath)
            self._check_thread_safety(content, filepath)
            self._check_performance_issues(content, filepath)
            
            # AST-based analysis
            try:
                tree = ast.parse(content)
                self._analyze_ast(tree, filepath)
            except SyntaxError as e:
                self.issues.append(f"Syntax error in {filepath}: {str(e)}")
                
        except Exception as e:
            self.issues.append(f"Failed to analyze {filepath}: {str(e)}")

    def _check_resource_leaks(self, content: str, filepath: str) -> None:
        """Check for potential resource leaks."""
        patterns = {
            r'socket\.(socket|create_connection)': 'Socket creation without context manager',
            r'open\([^)]+\)(?!\s*(?:with|as))': 'File opened without context manager',
            r'asyncio\.create_task\(': 'Unchecked task creation'
        }
        
        for pattern, issue in patterns.items():
            matches = re.finditer(pattern, content)
            for match in matches:
                self.issues.append(f"{filepath}: Potential resource leak - {issue} at line {content[:match.start()].count(chr(10)) + 1}")

    def _check_error_handling(self, content: str, filepath: str) -> None:
        """Check for proper error handling."""
        if 'except:' in content:  # Bare except
            self.issues.append(f"{filepath}: Bare except clause found - should specify exception types")
        
        if 'except Exception as e:' in content and 'logger' not in content:
            self.issues.append(f"{filepath}: Exception caught but might not be properly logged")

    def _check_thread_safety(self, content: str, filepath: str) -> None:
        """Check for thread safety issues."""
        if 'threading' in content or 'asyncio' in content:
            if 'self.' in content and 'Lock()' not in content:
                self.issues.append(f"{filepath}: Shared state without locks in threaded/async code")

    def _check_performance_issues(self, content: str, filepath: str) -> None:
        """Check for performance optimization opportunities."""
        patterns = {
            r'for\s+\w+\s+in\s+range\(len\(': 'Consider using enumerate() instead of range(len())',
            r'\.append\(.*\)\s+in\s+(?:while|for)': 'Consider list comprehension for better performance',
            r'print\([^)]*\)\s+in\s+(?:while|for)': 'Multiple print statements in loop - consider buffering output'
        }
        
        for pattern, suggestion in patterns.items():
            if re.search(pattern, content):
                self.optimization_suggestions.append(f"{filepath}: {suggestion}")

    def _analyze_ast(self, tree: ast.AST, filepath: str) -> None:
        """Perform AST-based analysis."""
        for node in ast.walk(tree):
            # Check for potentially problematic global variables
            if isinstance(node, ast.Global):
                self.issues.append(f"{filepath}: Use of global variables may cause issues in threaded environment")
            
            # Check for potentially infinite loops
            if isinstance(node, ast.While) and isinstance(node.test, ast.Constant) and node.test.value is True:
                self.issues.append(f"{filepath}: Potential infinite loop detected")

def analyze_codebase(root_dir: str) -> Dict:
    """Analyze entire codebase and return findings."""
    analyzer = CodeAnalyzer()
    results = {
        'issues': [],
        'optimization_suggestions': [],
        'files_analyzed': 0
    }
    
    for root, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.py'):
                filepath = os.path.join(root, file)
                analyzer.analyze_file(filepath)
                results['files_analyzed'] += 1
    
    results['issues'] = analyzer.issues
    results['optimization_suggestions'] = analyzer.optimization_suggestions
    
    return results

if __name__ == "__main__":
    print("Starting code analysis...")
    results = analyze_codebase('.')
    
    print("\n=== Analysis Results ===")
    print(f"\nFiles analyzed: {results['files_analyzed']}")
    
    print("\n=== Potential Issues ===")
    for issue in results['issues']:
        print(f"- {issue}")
    
    print("\n=== Optimization Suggestions ===")
    for suggestion in results['optimization_suggestions']:
        print(f"- {suggestion}")
