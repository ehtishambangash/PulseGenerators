# ECE 323 Midterm Project - Spring 2025
## Pulse Generators using Timer, Keypad, LCD, Motor and LPC1114

---

## Objectives

1. **Learning Outcome Assessment**: Assess the ability to design, implement, and validate an embedded system using:
   - GPIO (General Purpose Input/Output)
   - Interrupts
   - Timers
   - Memory
   - Subroutines
   - ARM microprocessor LPC1114 using ARM assembly language

2. **Course Outcomes**: Assess course outcomes 6, 7, 8, 9 listed in the course syllabus

3. **Pulse Generation**: Generate one to four pulses using timer control and keypad

4. **Servo Motor Control**: Design an embedded system for angle control of a servo motor

---

## Project Description

Design and develop motor driving PWM waves using:
- **Interrupt method** (Level 1 and 2)
- **Built-in PWM mode** (Level 2)
- **Measure wave period and duty cycle** (Level 3)

---

## Design Specifications

### Level 1: Minimum Requirements (60%)

Develop and implement a pulse generator that can drive a servo motor in a range from 0 to 180 degrees.

#### Requirements:

a. **PWM Generation**:
   - Generate a PWM pulse with duty cycle using a 32-bit timer
   - Use two matching registers
   - Implement using time interrupt method (similar to Level 2 of Lab 6)
   - Save the entered angle value (in clock clicks) in memory locations

b. **Servo Motor Control**:
   - Control servo motor angle from 0 to 180 degrees
   - PWM pulse period: **20 ms** (fixed for Match Register 1)
   - **0 degrees**: 0.5 ms positive pulse width
   - **180 degrees**: 2.5 ms positive pulse width
   - Input: Enter angle via keypad (up to 3 digits), end with **#**
   - System converts angle to clock ticks automatically

c. **Memory Recall**:
   - Press button **D** to recall value from memory location to a register
   - Display the memory content of the location
   - Show the register value on LCD

---

### Level 2: Advanced Requirements (80%)

Drive the motor using **two channels** with PWM pulses at two different angles via keypad (end with **#**).

#### Requirements:

a. **Dual Channel Operation**:
   - Use built-in PWM mode (do NOT use interrupt method)
   - Motor runs to the programmed angle for **1 second**
   - Motor returns to **0 degrees**, stays for **1 second**
   - Motor returns to the angle again
   - Process repeats continuously

b. **Control Commands**:
   - Press **\*** to stop the motor
   - Press **A** to start the motor again

c. **Memory Management**:
   - Store pulse width values in memory locations
   - Verify stored values
   - Recall values when needed

---

### Level 3: Full Implementation (100%)

Design and implement a pulse measurement method and display the measured pulse width on the LCD.

#### Requirements:

a. **Real-time Measurement**:
   - Code must be integrated with Level 2
   - Measure pulse width while motors are running
   - Display measured values on LCD in real-time

---

## Implementation Notes

### Important Information

1. **Driver File**: Use `LPC11xx.inc` driver from the D2L project folder
   - This driver includes ALL timers
   - Lab 6 driver only enables one 32-bit timer

2. **Output Pin Selection**:
   - Select your own output pins for all levels
   - **Keep your output pin selections confidential**

3. **Subroutines**: Use subroutines for various functions

4. **Reliability**: Circuit must work reliably and accurately

5. **Restart Penalty**: Using reset button or re-downloading code during checkout: **-5% deduction**

---

## Implementation Hints

### Getting Started (Suggested Approach)

#### Step 1: Level 0 - Integration
1. Start with Lab 7 code, save as new project "Midterm"
2. Add Level 2 code from Lab 6 to Lab 7
3. Edit code so that:
   - Keypad entry and LCD display work
   - Pulse generation via GPIO works
   - Lab 7 and Level 2 of Lab 6 run together

#### Step 2: Level 1 - Single Channel PWM
1. Fix MR1 for 20 ms period
2. Convert entered angle to timer ticks for MR0
3. Test pulse generation

#### Step 3: Level 2- - Dual Parameters
1. Modify code to accept two pulse width entries
2. Pass pulse widths to MR0 and MR1
3. Verify generated pulse widths match entered values

#### Step 4: Level 2 - Complete Implementation
1. Save pulse width contents to memory locations
2. Verify stored values
3. Implement recall functionality
4. Test repeatability

### Detailed Development Steps

**Step One**: Based on Level 2 of Lab 6
- In main, set two pulse parameters for registers (R0 and R1)
- Call Level 2 code of Lab 6
- Pass R0 and R1 parameters to MR0 and MR1
- Check GPIO pin for correct pulse generation

**Step Two**: Dual Timer Setup
- Copy level2.s to level2x.s
- Rename all Timer 0 variables to Timer 1
- Select and configure another GPIO pin
- Pass R0 and R1 to MR0 and MR1 of Timer 1
- Verify two pulses at two GPIO pins

**Step Three**: Keypad and LCD Integration
- Add keypad and LCD code from Lab 7
- Call LCD_init and Keypad_init
- Add circulation loop in main with State = 0

**When 'A' is pressed**:
- If State = 0, call function to display "Enter T0:"
- Disable keypad interrupt
- Reconfigure LCD data pins as output
- Display prompt string
- Reconfigure pins as input
- Enable interrupt
- Set R0, R1, R2, R3 = 0
- Set State = 1

**When number is pressed (State = 1)**:
- Display the number on LCD
- Update R0 using: `R0 = R0 * 10 + entered_number - 0x30`

**Step 4**: Button B Processing
- Similar process for 'B' button to enter T1 into R1
- Use different states to track stages

**Step 5**: Hash (#) Key Processing
- When '#' pressed, call level2 function
- Pass R0 and R1 to MR0 and MR1 of Timer 1
- Pulses are generated
- Ensure repeatability for Level 1 completion

**Step 6**: Channel Selection
- Add channel selection for Channel 1 or Channel 2
- Pass R0 and R1 to level2x for second channel
- Verify Level 2 completion and repeatability

---

## Additional Suggestions

### Code Organization

1. **Start with Lab 6 Level 2 code**:
   - Use LPC11xx.inc that includes Timer 0 and Timer 1 definitions
   - Lab 7 driver is missing Timer 1 definitions

2. **Use ALIGN directive**:
   - Place at end of function calls
   - Allows code longer than 256 lines (>1024 memory locations)

3. **State Machine**:
   - Use a register for state machine control
   - States: 0, 1, 2, 3, 4... represent system status
   - Makes program control easier

4. **Function Calls**:
   - Use **BL** (Branch with Link) for functions in another .s file
   - This allows return address to be passed to link register

---

## Grading Criteria

### Level Breakdown

| Level | Percentage | Description |
|-------|-----------|-------------|
| Level 1 | 60% | Single channel PWM with memory storage |
| Level 2 | 80% | Dual channel PWM with continuous operation |
| Level 3 | 100% | Real-time pulse measurement and display |

### Bonus Points

**Early Checkout Bonus**: +5% of final grade
- Must check out on **Wednesday** (one-time check only for all levels)

### Minimum Passing Grade

- Complete Level 1 meeting all design specifications
- Acceptable answers to questions about code and hardware

---

## Checkout Requirements

### Deadline

**Must check out with Dr. Zheng by 4:00 PM on March 27, 2025**

### During Checkout

The system must demonstrate:
1. **Performance**: All described design specifications working
2. **Reliability**: Repetitive and reliable operation
3. **Documentation**: Clean wiring that can be easily tracked for debug
4. **Knowledge**: Ability to answer hardware and software questions about your design

### Important Notes

- Any hints given to a student during checkout will be shared publicly with all students
- Checkout is **one-time only**
- Any reset/restart during checkout: **-5% deduction**

---

## Submission Requirements

### Code Submission

**Immediate Upload After Checkout**:
- Upload zipped code immediately after checkout
- Upload to D2L
- Include all project files

### Report Submission

**Due Date**: April 4, 2025 (or earlier)

**File Naming**: `ECE323_[LastName]_Midterm_report.doc`
- Example: `ECE323_Smith_Midterm_report.doc`

**Report Contents** (follow format on D2L):
1. **Functional Flow Chart**:
   - Use MS Visio or similar tool
   - Show complete program flow

2. **Schematic**:
   - Use Altium, EASY EDA, or similar tool
   - Show complete circuit diagram

3. **Design Description**:
   - Explain design choices
   - Document implementation details

---

## Academic Integrity

### Policy

This project is treated as a **take-home examination**. All work must be completed **independently**.

### Restrictions

❌ **NOT ALLOWED**:
- Discussion of implementation details among students
- Sharing any work
- Plagiarizing code or design
- Copying from other students

✅ **ALLOWED**:
- Questions to instructor/TA about:
  - Project instructions
  - General approaches from previous labs
  - Algorithms for keypad operation and LCD

### Requirements

- You must be able to answer questions about your hardware and software design
- You must understand your circuit and code
- Any help/hints given to one student will be shared publicly with all students
- TA/instructor will NOT help with specific problems or issues

### Consequences

Violations of academic integrity will result in:
- **F grade** in the class
- University discipline action
- Possible disqualification from ECE major

### University Policy

The university and department academic integrity policies will be strictly enforced for this project.

---

## Repository Structure

```
PulseGenerators/
├── LEVEL1/          # Level 1 implementation (60%)
│   ├── main.s
│   ├── TIMER32_0_IRQHandler.s
│   ├── PIOINT0_IRQHandler.s
│   ├── LCD_*.s
│   ├── Keypad_init.s
│   └── ...
├── LEVEL 2/         # Level 2 implementation (80%)
│   ├── main.s
│   ├── TIMER32_0_IRQHandler.s
│   ├── TIMER32_1_IRQHandler.s
│   ├── PIOINT0_IRQHandler.s
│   └── ...
└── LEVEL3/          # Level 3 implementation (100%)
    ├── main.s
    ├── MR0_input.s
    ├── MR1_input.s
    └── ...
```

---

## Technical Specifications

### Servo Motor Control

- **Operating Range**: 0° to 180°
- **PWM Period**: 20 ms (fixed)
- **Pulse Width Range**:
  - 0°: 0.5 ms (500 μs)
  - 90°: 1.5 ms (1500 μs)
  - 180°: 2.5 ms (2500 μs)

### Keypad Interface

- **Input**: 4x4 matrix keypad
- **Number Entry**: 0-9 (up to 3 digits for angle)
- **Special Keys**:
  - **#**: Confirm entry
  - **\***: Stop operation (Level 2+)
  - **A**: Start operation (Level 2+)
  - **D**: Recall memory value (Level 1+)

### LCD Display

- **Function**: Display angle values, status, and measurements
- **Format**: Show entered values, memory contents, register values

### Microcontroller

- **Model**: LPC1114 (ARM Cortex-M0)
- **Language**: ARM Assembly
- **Timers**: 32-bit Timer 0 and Timer 1

---

## Questions or Issues?

Contact the course instructor or TA with questions about:
- Project instructions clarification
- General lab approaches
- Keypad and LCD algorithms

**Remember**: This is a take-home examination. Work independently and maintain academic integrity.

---

## License

This is an academic project for ECE 323. All rights reserved.
