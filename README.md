# Peptide Library Check


## Installation

**[⬇️ Click here to install in Cauldron](http://localhost:50060/install?repo=https%3A%2F%2Fgithub.com%2Fnoatgnu%2Fpeptide-library-check-plugin)** _(requires Cauldron to be running)_

> **Repository**: `https://github.com/noatgnu/peptide-library-check-plugin`

**Manual installation:**

1. Open Cauldron
2. Go to **Plugins** → **Install from Repository**
3. Paste: `https://github.com/noatgnu/peptide-library-check-plugin`
4. Click **Install**

**ID**: `peptide-library-check`  
**Version**: 1.0.0  
**Category**: utilities  
**Author**: Cauldron Team

## Description

Check if peptides from experimental data are present in a FASTA library by generating tryptic peptides with configurable miss cleavages

## Runtime

- **Environments**: `python`

- **Entrypoint**: `library_check_peptide.py`

## Inputs

| Name | Label | Type | Required | Default | Visibility |
|------|-------|------|----------|---------|------------|
| `file_path` | Input Peptide File | file | Yes | - | Always visible |
| `peptide_column` | Peptide Sequence Column | column | Yes | - | Always visible |
| `fasta_file` | FASTA Library File | file | Yes | - | Always visible |
| `miss_cleavage` | Missed Cleavages | number (min: 0, max: 5) | No | 2 | Always visible |
| `min_length` | Minimum Peptide Length | number (min: 1, max: 50) | No | 5 | Always visible |

### Input Details

#### Input Peptide File (`file_path`)

Tab-separated or CSV file containing experimental peptide data


#### Peptide Sequence Column (`peptide_column`)

Column containing peptide sequences to check


#### FASTA Library File (`fasta_file`)

FASTA file containing protein sequences to generate tryptic peptide library


#### Missed Cleavages (`miss_cleavage`)

Maximum number of missed cleavages to consider when generating tryptic peptides


#### Minimum Peptide Length (`min_length`)

Minimum length of peptides to include in the library


## Outputs

| Name | File | Type | Format | Description |
|------|------|------|--------|-------------|
| `peptide_in_library.txt` | `peptide_in_library.txt` | data |  | Tab-separated file with a "Found" column indicating whether each peptide was found in the FASTA library |

## Requirements

- **Python Version**: >=3.10

### Python Dependencies (External File)

Dependencies are defined in: `requirements.txt`

- `pandas>=2.0.0`
- `click>=8.0.0`

> **Note**: When you create a custom environment for this plugin, these dependencies will be automatically installed.

## Usage

### Via UI

1. Navigate to **utilities** → **Peptide Library Check**
2. Fill in the required inputs
3. Click **Run Analysis**

### Via Plugin System

```typescript
const jobId = await pluginService.executePlugin('peptide-library-check', {
  // Add parameters here
});
```
