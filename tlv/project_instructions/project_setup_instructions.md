# Instructions for Setting up a Project for Conversion

> ## Setup Status — SERV (target module: `rtl/serv_bufreg.v`) — COMPLETE
>
> User decision: run tests **in the Docker container only**.
>
> Done:
> - **Analysis** — captured in `project_specific_instructions.md`: no libraries,
>   no generated CSRs, no tri-states, no latches; flip-flop based on `posedge
>   i_clk`. `serv_bufreg.v` is a single module. Params: `W` (1 or 4), `MDU`,
>   `B=W-1`. `i_en` is a functional clock enable. Verilator waiver matches
>   `serv_bufreg.v` unused signals **by line number** — see below.
> - **Environment** — base image already has SandPiper, Verilator, Yosys.
>   Added `tlv/env/Dockerfile.project` (installs FuseSoC 2.4.6, SERV's test tool)
>   and wired it into `tlv/env/docker-compose.yml` (`claude-base` →
>   `claude-conversion`/`serv-conversion:latest`).
> - **Conversion pipeline** — `tlv/serv_bufreg.tlv` is the initial verbatim `\SV`
>   copy. `sandpiper-saas` (+ strip of the `//_\` header lines) regenerates
>   `tlv/verilog/serv_bufreg.v` and `serv_bufreg_gen.v`. `rtl/serv_bufreg.v` and
>   `rtl/serv_bufreg_gen.v` are symlinks into `tlv/verilog/`; `serv.core` lists
>   the gen file just before the module (shared macro ordering).
> - **Regression** — `tlv/regress/regress.sh`: lint W=1, lint W=4, and a
>   `hello_uart` servant sim. **All three PASS** against the symlinked RTL
>   (~10 s warm, 1–2 min cold). Golden for FEV: `tlv/serv_bufreg_golden.v`.
> - `tlv/.gitignore` excludes `regress/work/` and `env/.env`.
>
> Not done / caveats:
> - `docker compose build` could not be run to verify the images — this agent
>   runs *inside* the already-provisioned container (no docker CLI). The
>   FuseSoC install in `Dockerfile.project` matches the working in-container
>   version (2.4.6), so risk is low; verify on a host with Docker.
> - The waiver is line-number based. Real TL-Verilog refactoring will shift lines
>   and require updating `data/verilator_waiver.vlt` (documented in
>   `project_specific_instructions.md`).

These instructions provide guidance for setting up a Verilog Git project for conversion to TL-Verilog using the process defined in this file's original repository. They are to be followed by an LLM agent interactively with the user, using, for example, Claude Code or Github Copilot in VSCode.

TODO: Break these up into tasks and automate the tasks.
TODO: Introduce task-specific instructions in addition to generic ones (supported by get_task.py, but test it).


## Overview

Every Verilog project is different. To prepare for conversion, you must:

- determine what Verilog will be converted
- identify challenges and our approach to dealing with them
- identify library paths that will be needed for Yosys commands to successfully read the new Verilog code
- customize a Dockerfile to build the necessary environment to regress changes using the project's established methods
- put in place the conversion process's automation for regressing refactoring changes
- provide succinct project-specific agent instructions to augment the standard conversion instructions

You'll use this file (`tlv/project_instructions/project_setup_instructions.md`) to keep track of your remaining work. As you complete tasks (like this one), mark them complete; delete things that are no longer relevant; as you identify work to be done, add the details. If your efforts are put on hold and picked up later, this file will be the starting point for continued work.

You'll produce in `<PROJECT_ROOT>/tlv/`:

- `env/docker-compose.yml`: a Docker environment for the conversion, including the project's environment for regression testing.
- `project_instructions/project_specific_instructions.md`: concise project-specific instructions for conversion agents
- `regress/regress.sh` (or similar): (if requested) a script for conversion agents to run to regress changes using the project's environment


## Prerequisits

This flow was developed on a Ubuntu system and may need modifications for other platforms.

Docker and Docker Compose must be installed.

The user must let know whether they want you to get the project's tests working on the local machine, in the Docker container only, or not at all. If the user has not made this clear, ASK AND STOP IMMEDIATELY.

You should have access to a `<PROJECT-ROOT>` directory (likely, but not necessarily the root directory of a clone of a fork of the Verilog project's Git repository). It should have already been set up to contain:

- tlv/               # A directory added to the project for converting to TL-Verilog
  - env/               # Provides the sandboxed environment(s) for carrying out the conversion
    - Dockerfile         # Read-only, baseline Dockerfile for code conversion
    - docker-compose.yml # Project-specific environment, seeded to use Dockerfile, to be extended as needed
    - etc.
  - instructions/    # Instructions for setting up the project for conversion
    - project_setup_instructions.md   # Starting instructions to setup the project for conversion
  - regress/         # Collateral for regressing the project against conversion code changes


## Task: Analyze Verilog Code

Analyze the project's Verilog code, especially its libraries and their use. The following considerations may add difficulty to the conversion effort. Any issues and special project-specific instructions resulting from these (and other observations) can be captured in `project_specific_instructions.md`.

### Include Paths

The conversion agents will need to be informed of include/library paths that will be needed in the Yosys commands to read the Verilog. If any are needed, create a `## Preparation` section with this information.

### Generated Code

Some projects use code generators to generate Verilog code. CSRs are a common example. Such code should be generated prior to the conversion, so the challenge should be for you to generate it appropriately. You may need to inform the conversion agents about include/library paths for these or of configuration settings and mechanisms to select alternate versions of generated code.

### Parameterization

Identify project-level configurations. These might be tick-defines, or Verilog parameters commonly passed to modules. Each module converted will be tested by conversion agents with chosen parameters. You're guidance can help these agents choose appropriate parameter values to test. Provide guidance on legal parameter values.

## One Module Per File

The conversion process assumes that each file defines a single module. It may define submodules only instantiated by its own top-level module. But, it must not define multiple modules instantiated externally. If any files define such multiple modules, report these as problematic. They should be excluded from conversion unless the issue is addressed.

### Latch-based Design

The conversion instructions assume the logic is flip-flop-based, triggered by the rising edge of the clock. The agents performing the code conversion will address specific cases for each module, but you may make general observations, especially from the nature of the libraries, about the use of latch-based logic and make a brief note about it (only if you observe something noteworthy).

### Clock Gating/Enabling

Clock gating logic can be difficult to convert. TL-Verilog logic infers flip-flops and does not have direct control over the application of clock to them. TL-Verilog supports fine-grained clock gating or enables using "when conditions", e.g., `?$valid`. This can be used to create clock gating or clock enabling that matches the original, but it may result in awkward code, especially for course grained clock gating.

There is a distinction between functional and non-functional clock gating/enabling. In functional gating/enabling the gating is functionally required. In non-functional clock gating, the gating condition is functionally a DONT-CARE. If we know the gating to be non-functional, we have more flexibility in the conversion.

Only if appropriate, add brief notes about the project's clock gating/enabling methodology and any available mechanisms for configuring clock gating/enabling.

### No Tri-States

This process does not support conversion of tri-states. Note any general methodology around tri-states.


## Task: Installation

Based on the user's wishes, you may need to install the project environment on the local and/or Docker environment.

### Research

Find the project's installation instructions in the available documenation, such as a `README.md` or any other relevant documentation referenced by the readme or in `docs`, etc. Look for installation scripts, such as `init`, `install.sh`, etc. and instructions for basic testing.

### Local Environment

If the user wants the project environment established on the local machine (ask if unsure) and the local machine is compatible, create a TODO checklist here (in `tlv/project_instructions/project_setup_instructions.md`) for yourself with details based on your research and complete the items in that list to get the environment fully working, or report on blocking issues or shortcomings.

### Docker Environment Setup

The conversion process uses a Docker environment created with Docker Compose.

- Read `tlv/env/Dockerfile` and `tlv/env/docker-compose.yml` to understand the base environment.
- Build and test the current Docker environment.

If the user wants project regressions to be run during the conversion process (ask if unsure), refine the TODO list below for yourself here for establishing the environment and automating a regression test.

- Create `tlv/env/Dockerfile.project`, providing a project-specific environment layer as required by the project.
- Modify `tlv/env/docker-compose.yml` to add `Dockerfile.project`.


## Task: Regression

The conversion process achieves correctness using FEV. But it will break the verification environment, which connects to signals in the Verilog model. Conversion results in a mapping of original to updated signal names that can be used to resurrect the test bench and other verification collateral that connects to the Verilog after the conversion is complete.

Testing along the way can keep the transformation incremental and avoid a monolithic effort that could be intractable. 90% coverage would be plenty to maintain general stability, and full regression testing can be completed after conversion.

If desired by the user, you'll develop an automated flow for regressing the project's verification environment. First, investigate the project's verification collateral and how it connects to the Verilog model. Identify all collateral that must be updated as the Verilog changes, and document this in `project_specific_instructions.md`. Determine how to best verify the integrity of this collateral. This probably involves building one or more configurations of the Verilog. If Verification collateral attaches to the model dynamically, simulation or other steps may be called for to test collateral. Testing should strike a balance between keeping testing light-weight and achieving good coverage.

Define the commands that should be run by the conversion agents to test the verification environment(s). Provide a script to reduce this to a single command for the agents, `tlv/regress/regress.sh` for example. Be sure the command produces minimal output when successful and only key information when unsuccessful. Full logs can be captured in files. This helps to minimize the amount of log data cluttering the context window. Document in `project_specific_instructions.md` the strategy, command, what the command does, and any tips for debugging.

The conversion will result in new Verilog files in different directories (under `tlv/`). The project must be updated to override the original Verilog files with these, if present. The conversion can, perhaps, link to the converted files from `tlv/verilog/`, and this path can be added to all Verilog search paths (with priority). Determine the right solution, and provide instruction under `## Preparation` in `project_specific_instructions.md` that conversion agents will follow when preparing a Verilog module file for conversion, such as creating a link to the generated Verilog file.

## Task: Review and Refine

Once you have worked through all issues, review this document and your work again. Fix any oversights. Proper setup and a streamlined process is crutial to the success of the conversion effort, so your work on this deserved thorough review, testing, and optimization.

The resulting `project_specific_instructions.md` should ideally be less than a page and, in the simplest case, could be as minimal as: "No issue. No libraries are used. No dynamic verification will be done."
