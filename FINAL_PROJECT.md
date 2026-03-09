# 🚗 Final Project: RC Car with Live Camera

**Version**: 2.0
**Date**: 2026-03-09
**Author**: JeroweTan + GitHub Copilot
**Status**: Planning Phase

---

## Executive Summary

Build a Rust-powered, rear-wheel-drive RC car with live camera feed. This project has **two paths** — choose based on your confidence level and ambition:

| Path            | Difficulty | Time        | Budget  | Control                      | Camera              |
| --------------- | ---------- | ----------- | ------- | ---------------------------- | ------------------- |
| 🟢 **Easy**     | ⭐⭐       | 4-6 weeks   | $55-105 | IR Remote                    | Raspberry Pi stream |
| 🔴 **Advanced** | ⭐⭐⭐⭐⭐ | 12-14 weeks | $80-150 | Phone App (WiFi + Gyroscope) | ESP32-CAM onboard   |

**Both paths share the same foundation:** Rust embedded programming, brushed DC motor, servo steering, rear differential, USB-C rechargeable battery, LEGO Technic chassis.

**Why this project?**

- Learn Rust embedded programming with real hardware
- Understand systems programming (motors, sensors, I/O)
- Build something tangible and fun
- Foundation for future upgrades (GPS, autonomy, AI)

---

## Problem Statement

**Current Situation**: Learning Rust through book exercises (guessing game, hello world) — need a real-world project to apply systems programming knowledge.

**Proposed Solution**: Build an RC car that combines hardware engineering with Rust embedded programming. Two difficulty paths available.

**Expected Outcome**: A working RC car with live camera feed, programmed in Rust.

---

## Choose Your Path

### 🟢 Path A: Easy — IR Remote RC Car

```
Brain:        Arduino Nano / STM32
Control:      IR Remote (physical remote)
Camera:       Raspberry Pi + USB Camera (separate system)
Motor:        Simple brushed DC motor
Steering:     Single servo (simple tie rod)
Transmission: Single speed (direct drive)
Power:        Li-Po 3.7V + TP4056 USB-C charging
Chassis:      LEGO Technic

Skills Learned:
├─ Embedded Rust basics (GPIO, PWM)
├─ Motor/servo control
├─ IR signal decoding
├─ Basic hardware integration
└─ Difficulty: ⭐⭐ (Beginner-friendly)
```

### 🔴 Path B: Advanced — WiFi RC Car

```
Brain:        ESP32-S3-CAM (camera + WiFi + Rust)
Control:      Phone App (WiFi + Gyroscope steering)
Camera:       ESP32-CAM onboard MJPEG stream
Motor:        WPL 370 Brushed Motor (0.2 HP)
Steering:     MG90S Metal Gear Servo (Ackermann)
Transmission: 2-Speed LEGO Gearbox (Low/High via SG90 servo)
Power:        2x 18650 Li-ion (7.4V) + 2S USB-C BMS
Chassis:      LEGO Technic (any car body)

Skills Learned:
├─ Everything from Easy Path PLUS:
├─ Async Rust (concurrent video + control)
├─ WiFi networking (UDP for low latency)
├─ Phone app development (Slint UI framework)
├─ State machine design (Neutral/Forward/Reverse/Shifting)
├─ Digital clutch logic (prevent gear grinding)
├─ Distributed systems (Phone ↔ ESP32)
└─ Difficulty: ⭐⭐⭐⭐⭐ (Expert-level)
```

---

# ═══════════════════════════════════════

# 🟢 PATH A: EASY — IR REMOTE RC CAR

# ═══════════════════════════════════════

---

## Easy Path: Project Specifications

### Drivetrain

| Spec             | Detail                                                |
| ---------------- | ----------------------------------------------------- |
| **Drive Type**   | Rear-Wheel Drive (RWD)                                |
| **Motor**        | Brushed DC Motor                                      |
| **Differential** | Rear differential (distributes torque to rear wheels) |
| **Steering**     | Front servo (left/right)                              |
| **Transmission** | Single speed (direct drive)                           |

### Controls

| Spec            | Detail                               |
| --------------- | ------------------------------------ |
| **Remote Type** | IR (Infrared) Remote Control         |
| **Receiver**    | IR Receiver Module                   |
| **Directions**  | Forward, Backward, Left, Right, Stop |
| **Protocol**    | Standard IR (NEC/RC5)                |

### Power

| Spec                | Detail                         |
| ------------------- | ------------------------------ |
| **Battery Type**    | Li-Po or Li-Ion (rechargeable) |
| **Charging**        | USB Type-C                     |
| **Voltage**         | 3.7V - 7.4V (1S-2S)            |
| **Charging Module** | TP4056 USB-C module            |

### Camera

| Spec              | Detail                                    |
| ----------------- | ----------------------------------------- |
| **Camera Type**   | USB or WiFi camera module                 |
| **Feed**          | Live video stream                         |
| **Mounting**      | Front-facing on chassis                   |
| **Stream Method** | WiFi to phone/computer (via Raspberry Pi) |

---

## Easy Path: Architecture Diagram

```
┌─────────────────────────────────────────┐
│            IR Remote Control            │
│   [Forward] [Backward] [Left] [Right]  │
└──────────────────┬──────────────────────┘
                   │ (IR signal)
┌──────────────────▼──────────────────────┐
│           IR Receiver Module            │
└──────────────────┬──────────────────────┘
                   │ (digital signal)
┌──────────────────▼──────────────────────┐
│     Microcontroller (Arduino/STM32)     │
│         Running Rust Code 🦀            │
│                                         │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │ Motor Logic │  │ Steering Logic  │   │
│  └──────┬──────┘  └───────┬─────────┘   │
└─────────┼─────────────────┼─────────────┘
          │                 │
┌─────────▼──────┐  ┌──────▼──────────┐
│  Motor Driver  │  │  Servo Motor    │
│  (L298N/DRV)   │  │  (Front Wheels) │
└─────────┬──────┘  └────────────────┘
          │
┌─────────▼──────────────────────────┐
│  Brushed DC Motor                  │
│  → Rear Differential              │
│  → Rear Wheels (RWD)              │
└────────────────────────────────────┘

┌────────────────────────────────────┐
│  Camera Module (Separate System)   │
│  Raspberry Pi + USB Camera         │
│  → WiFi Stream to Phone/PC        │
└────────────────────────────────────┘

┌────────────────────────────────────┐
│  Battery (Li-Po, USB-C Charging)   │
│  Powers: Motor, Servo, MCU, Camera │
└────────────────────────────────────┘
```

---

## Easy Path: Hardware Shopping List

### Core Components

| #   | Component                       | Purpose                          | Est. Cost | Source                       |
| --- | ------------------------------- | -------------------------------- | --------- | ---------------------------- |
| 1   | Brushed DC Motor (3V-6V)        | Drive rear wheels                | $3-5      | AliExpress/Amazon            |
| 2   | Motor Driver (L298N or DRV8833) | Control motor speed/direction    | $2-3      | AliExpress/Amazon            |
| 3   | Servo Motor (SG90 or MG90S)     | Front wheel steering             | $3-5      | AliExpress/Amazon            |
| 4   | IR Receiver Module (VS1838B)    | Receive remote signals           | $2-3      | AliExpress/Amazon            |
| 5   | IR Remote Control               | Send commands to car             | $2-3      | AliExpress/Amazon            |
| 6   | Rear Differential (gear set)    | Distribute torque to rear wheels | $5-10     | AliExpress/Amazon/Hobby shop |
| 7   | Li-Po Battery (3.7V 1200mAh+)   | Power supply                     | $5-10     | AliExpress/Amazon            |
| 8   | TP4056 USB-C Charging Module    | Charge battery via USB-C         | $2-3      | AliExpress/Amazon            |

### Microcontroller (Brain)

| #   | Component                      | Purpose                       | Est. Cost | Source            |
| --- | ------------------------------ | ----------------------------- | --------- | ----------------- |
| 9   | Arduino Nano / STM32 Blue Pill | Run Rust code, control motors | $3-10     | AliExpress/Amazon |

### Camera System (Optional Phase 2)

| #   | Component           | Purpose                | Est. Cost | Source            |
| --- | ------------------- | ---------------------- | --------- | ----------------- |
| 10  | Raspberry Pi Zero W | Camera streaming brain | $15-25    | Amazon/Pi Shop    |
| 11  | USB Camera Module   | Live video feed        | $10-20    | AliExpress/Amazon |

### Chassis & Structural

| #   | Component                            | Purpose        | Est. Cost | Source                |
| --- | ------------------------------------ | -------------- | --------- | --------------------- |
| 12  | Chassis (3D printed or LEGO Technic) | Car body/frame | $5-15     | 3D print / LEGO store |
| 13  | Wheels (4x, matching motor shaft)    | Movement       | $3-5      | AliExpress/Amazon     |
| 14  | Wires, connectors, screws            | Assembly       | $3-5      | AliExpress/Amazon     |

### Budget Summary

| Phase                | Components                                 | Est. Cost   |
| -------------------- | ------------------------------------------ | ----------- |
| **Phase 1: Driving** | Motor, driver, servo, IR, battery, chassis | **$30-60**  |
| **Phase 2: Camera**  | Raspberry Pi + camera                      | **$25-45**  |
| **Total**            | Everything                                 | **$55-105** |

---

## Easy Path: Chassis Options

| Option              | Pros                              | Cons                  | Cost   |
| ------------------- | --------------------------------- | --------------------- | ------ |
| **3D Printed**      | Custom design, lightweight, cheap | Need printer access   | $5-15  |
| **LEGO Technic**    | Easy assembly, modular, sturdy    | Limited customization | $15-30 |
| **Pre-made RC Kit** | Ready to use, all parts fit       | Less learning         | $20-40 |

**Recommended**: 3D printed (cheapest, most customizable) or LEGO Technic (easiest, modular)

---

## Easy Path: Software Architecture

### Motor Control (Rust Embedded)

```rust
// Direction control enum
enum Direction {
    Forward,
    Backward,
    Left,
    Right,
    Stop,
}

// RC Car struct
struct RCCar {
    motor_speed: u16,
    steering_angle: u16,
    is_running: bool,
}

impl RCCar {
    fn new() -> Self {
        RCCar {
            motor_speed: 0,
            steering_angle: 90, // Center (straight)
            is_running: false,
        }
    }

    fn move_forward(&mut self, speed: u16) {
        self.motor_speed = speed;
        self.is_running = true;
        // PWM signal to motor driver
    }

    fn move_backward(&mut self, speed: u16) {
        self.motor_speed = speed;
        self.is_running = true;
        // Reverse PWM signal to motor driver
    }

    fn turn_left(&mut self) {
        self.steering_angle = 45; // Turn servo left
        // Servo pulse signal
    }

    fn turn_right(&mut self) {
        self.steering_angle = 135; // Turn servo right
        // Servo pulse signal
    }

    fn stop(&mut self) {
        self.motor_speed = 0;
        self.steering_angle = 90; // Center wheels
        self.is_running = false;
    }
}

// Main loop
fn main() {
    let mut car = RCCar::new();

    loop {
        match read_ir_command() {
            Direction::Forward => car.move_forward(200),
            Direction::Backward => car.move_backward(150),
            Direction::Left => car.turn_left(),
            Direction::Right => car.turn_right(),
            Direction::Stop => car.stop(),
        }
    }
}
```

### Camera Streaming (Python on Raspberry Pi)

```python
# Simple MJPEG stream for live camera feed
import cv2
from flask import Flask, Response

app = Flask(__name__)
camera = cv2.VideoCapture(0)

def generate_frames():
    while True:
        success, frame = camera.read()
        if not success:
            break
        ret, buffer = cv2.imencode('.jpg', frame)
        frame_bytes = buffer.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')

@app.route('/video')
def video_feed():
    return Response(generate_frames(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')

# Access live feed at: http://<raspberry-pi-ip>:5000/video
app.run(host='0.0.0.0', port=5000)
```

---

## Easy Path: Wiring Diagram

### Motor Driver (L298N) Connections

```
Arduino/STM32          L298N Motor Driver
├─ Pin 5 (PWM)  ────→  ENA (Motor Speed)
├─ Pin 6         ────→  IN1 (Forward)
├─ Pin 7         ────→  IN2 (Backward)
├─ GND           ────→  GND
└─ 5V            ────→  +5V

L298N                  DC Motor
├─ OUT1          ────→  Motor Terminal 1
└─ OUT2          ────→  Motor Terminal 2

Battery
├─ + (Positive)  ────→  L298N 12V Input
└─ - (Negative)  ────→  L298N GND
```

### Servo Connections

```
Arduino/STM32          Servo Motor
├─ Pin 9 (PWM)  ────→  Signal (Orange/White wire)
├─ 5V            ────→  Power (Red wire)
└─ GND           ────→  Ground (Brown/Black wire)
```

### IR Receiver Connections

```
Arduino/STM32          IR Receiver (VS1838B)
├─ Pin 11        ────→  Signal (Data pin)
├─ 5V            ────→  VCC
└─ GND           ────→  GND
```

---

## Easy Path: Project Phases & Timeline

### Phase 1: Learn Rust Fundamentals (Current — 2-3 weeks)

```
Status: IN PROGRESS ✅

Tasks:
├─ ✅ Variables, mutability, shadowing
├─ ✅ Enums, generics, pattern matching
├─ ✅ Traits and trait imports
├─ ✅ Expressions vs statements
├─ ✅ I/O, buffering, flush
├─ ✅ Error handling (Result, match)
├─ 🔄 Guessing game project (finishing)
├─ ⏳ Ownership and borrowing
├─ ⏳ Structs and impl blocks
├─ ⏳ Option<T> type
└─ ⏳ Modules and crate organization
```

### Phase 2: Learn Embedded Rust (2-3 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Get Arduino/STM32 microcontroller
├─ ⏳ Set up embedded Rust toolchain
├─ ⏳ Blinky LED (Hello World of embedded)
├─ ⏳ GPIO control (digital pins)
├─ ⏳ PWM basics (motor speed control)
├─ ⏳ Timer and interrupt handling
└─ ⏳ Serial communication (UART)
```

### Phase 3: Build RC Car — Driving (2-3 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Order components (shopping list above)
├─ ⏳ Build/print chassis
├─ ⏳ Wire motor + motor driver
├─ ⏳ Wire servo for steering
├─ ⏳ Wire IR receiver
├─ ⏳ Write Rust motor control code
├─ ⏳ Write Rust servo control code
├─ ⏳ Write Rust IR decoder code
├─ ⏳ Integrate: IR → Motor + Servo
├─ ⏳ Test forward/backward/left/right
├─ ⏳ Wire battery + USB-C charging
└─ ⏳ Full driving test
```

### Phase 4: Add Live Camera (1-2 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Set up Raspberry Pi Zero W
├─ ⏳ Connect USB camera
├─ ⏳ Write Python streaming server
├─ ⏳ Mount camera on chassis
├─ ⏳ Test live feed on phone/computer
└─ ⏳ Final integration test
```

### Phase 5: Polish & Future Upgrades (Ongoing)

```
Status: FUTURE

Possible Upgrades:
├─ ⏳ Speed control (variable speed via PWM)
├─ ⏳ Battery level indicator
├─ ⏳ Distance sensor (obstacle avoidance)
├─ ⏳ GPS module (location tracking)
├─ ⏳ Phone app controller (replace IR remote)
├─ ⏳ Autonomous driving (AI/ML)
├─ ⏳ Multi-gear simulation (fake transmission 😂)
└─ ⏳ Real manual transmission (THE DREAM 👑)
```

---

## Easy Path: Risk Assessment

| Risk                           | Probability | Impact | Mitigation                                   |
| ------------------------------ | ----------- | ------ | -------------------------------------------- |
| Motor doesn't spin             | Medium      | High   | Test motor separately before assembly        |
| IR signal weak/blocked         | Low         | Medium | Use strong IR LED, clear line of sight       |
| Battery drains too fast        | Medium      | Medium | Use efficient motor, bigger battery          |
| Camera lag/latency             | Medium      | Low    | Optimize stream resolution, use WiFi 5GHz    |
| Rust embedded toolchain issues | Medium      | High   | Use well-documented boards (STM32, Arduino)  |
| Chassis breaks on impact       | Low         | Medium | Design with reinforcements, test durability  |
| Budget overrun                 | Low         | Low    | Buy from AliExpress (cheaper), order in bulk |

---

## Easy Path: Technology Stack

| Layer                | Technology              | Purpose                            |
| -------------------- | ----------------------- | ---------------------------------- |
| **Motor Control**    | Rust (embedded)         | Control motors, servo, IR decoding |
| **Microcontroller**  | Arduino Nano / STM32    | Hardware brain                     |
| **Camera Streaming** | Python + OpenCV + Flask | Live video feed                    |
| **Camera Hardware**  | Raspberry Pi Zero W     | Camera processing                  |
| **Communication**    | IR (NEC protocol)       | Remote to car                      |
| **Power**            | Li-Po + TP4056 USB-C    | Rechargeable battery               |
| **Chassis**          | 3D Print / LEGO Technic | Car body                           |

---

## Easy Path: Rust Concepts Applied

| Concept              | Where Used                                       |
| -------------------- | ------------------------------------------------ |
| **Enums**            | Direction (Forward, Backward, Left, Right, Stop) |
| **Structs**          | RCCar (motor_speed, steering_angle, is_running)  |
| **impl blocks**      | Methods on RCCar (move_forward, turn_left, stop) |
| **Pattern matching** | match on IR commands                             |
| **Traits**           | Embedded HAL traits (OutputPin, PwmPin)          |
| **Error handling**   | Result for hardware operations                   |
| **Loops**            | Main control loop                                |
| **Ownership**        | Managing hardware resources                      |
| **Modules**          | Organizing motor, servo, IR code                 |

---

## Easy Path: Success Criteria

- [ ] Car moves forward when pressing forward button
- [ ] Car moves backward when pressing backward button
- [ ] Car turns left when pressing left button
- [ ] Car turns right when pressing right button
- [ ] Car stops when releasing buttons
- [ ] Rear differential distributes torque properly
- [ ] Battery charges via USB-C
- [ ] Live camera feed viewable on phone/computer
- [ ] Rust code controls all motor/servo operations
- [ ] Total cost under $105

---

## References & Resources

### Rust Embedded

- [The Embedded Rust Book](https://docs.rust-embedded.org/book/)
- [awesome-embedded-rust](https://github.com/rust-embedded/awesome-embedded-rust)
- [stm32f4xx-hal crate](https://crates.io/crates/stm32f4xx-hal)

### Hardware

- [L298N Motor Driver Tutorial](https://lastminuteengineers.com/l298n-dc-stepper-driver-arduino-tutorial/)
- [Servo Motor Basics](https://www.arduino.cc/en/Tutorial/Knob)
- [IR Receiver Tutorial](https://www.arduino.cc/en/Tutorial/IRrecvDemo)

### Camera

- [Raspberry Pi Camera Guide](https://www.raspberrypi.org/documentation/accessories/camera.html)
- [OpenCV Python Tutorial](https://docs.opencv.org/master/d6/d00/tutorial_py_root.html)
- [Flask Video Streaming](https://blog.miguelgrinberg.com/post/video-streaming-with-flask)

---

## Notes

- This project serves as the culmination of learning Rust programming
- Start with Rust fundamentals (Phase 1), then progress to embedded (Phase 2)
- Build the car incrementally — test each component before integration
- Document everything in KNOWLEDGE_MEMORY.md as you learn
- Have fun! This is a learning project, not a production vehicle 🚗🦀

---

# ═══════════════════════════════════════

# 🔴 PATH B: ADVANCED — WiFi RC CAR

# ═══════════════════════════════════════

## Advanced RC Car Overview

**Concept**: A 1:20 scale LEGO Technic RC car with 2-speed transmission, WiFi phone control with gyroscope steering, live onboard camera, and drift capability. All powered by Rust. Body can be any car design you want!

**Why this project?**

- Distributed logic: Phone + ESP32 coordinating over WiFi
- State management: Rust enums for Neutral/Forward/Reverse/Shifting
- Concurrency: Async Rust for video streaming + motor control simultaneously
- Hardware/Software integration: Digital clutch prevents gear grinding
- Cool factor: USB-C charging port at the rear like exhaust pipe pit stop! 🏎️

---

## Hardware Bill of Materials (BOM)

### Brain & Communication

| #   | Component                | Purpose                                        | Est. Cost  | Source            |
| --- | ------------------------ | ---------------------------------------------- | ---------- | ----------------- |
| 1   | **ESP32-S3-CAM (N8R8)**  | WiFi hotspot + MJPEG video + Rust control loop | $10-15     | AliExpress/Amazon |
| 1b  | **FPC Cable (Optional)** | Extend camera 20-40cm from ESP32 board         | $0.50-1.50 | AliExpress        |

### Drivetrain

| #   | Component                 | Purpose                                    | Est. Cost | Source            |
| --- | ------------------------- | ------------------------------------------ | --------- | ----------------- |
| 2   | **WPL 370 Brushed Motor** | Main drive motor (0.2 HP, fits 1:20 frame) | $5-8      | AliExpress/Amazon |
| 3   | **DRV8833 Dual H-Bridge** | Motor driver (Forward/Reverse PWM control) | $2-3      | AliExpress/Amazon |
| 4   | **MG90S Micro Servo**     | Steering servo (metal gears for Ackermann) | $3-5      | AliExpress/Amazon |
| 5   | **SG90 Micro Servo**      | Gear shifter (pushes LEGO Driving Ring)    | $2-3      | AliExpress/Amazon |

### Power System

| #   | Component                              | Purpose                                | Est. Cost | Source            |
| --- | -------------------------------------- | -------------------------------------- | --------- | ----------------- |
| 6   | **2x 18650 Li-ion Cells (7.4V)**       | High-discharge battery for drifting    | $8-12     | AliExpress/Amazon |
| 7   | **2S USB-C BMS Module**                | USB-C charging + cell protection       | $3-5      | AliExpress/Amazon |
| 8   | **Mini Buck Converter (7.4V→5V)**      | Step-down to power ESP32 + servos      | $2-3      | AliExpress/Amazon |
| 9   | **Toggle Switch or Soft Power Button** | Turn car on/off or cut power instantly | $1-2      | AliExpress/Amazon |

### Chassis & Structural

| #   | Component                           | Purpose                              | Est. Cost | Source               |
| --- | ----------------------------------- | ------------------------------------ | --------- | -------------------- |
| 10  | **LEGO Technic Beams & Connectors** | 1:20 scale RC car frame              | $15-30    | LEGO Store/BrickLink |
| 11  | **LEGO 18947 Driving Ring**         | Gear shifting mechanism              | $2-5      | BrickLink            |
| 12  | **LEGO 18948 16-Tooth Gear**        | Gearbox gearing                      | $1-3      | BrickLink            |
| 13  | **LEGO 6641 Changeover Catch**      | Shifter fork (engaged by SG90 servo) | $1-2      | BrickLink            |
| 14  | **LEGO 62821b Differential**        | Rear differential for cornering      | $3-5      | BrickLink            |
| 15  | **LEGO Wheels (4x)**                | Movement                             | $3-5      | BrickLink            |
| 16  | **Wires, connectors, screws**       | Assembly                             | $3-5      | AliExpress/Amazon    |

### Tools & Assembly Accessories

> These are the tools and accessories you need to **wire, solder, and assemble** everything together.
> Most are one-time purchases — you'll reuse them for future projects.

#### Essential Tools (One-Time Purchase)

| #   | Tool                                   | Purpose                                           | Est. Cost | Source            |
| --- | -------------------------------------- | ------------------------------------------------- | --------- | ----------------- |
| T1  | **Soldering Iron (60W, temp control)** | Solder wires to motor terminals, BMS, buck conv.  | $15-25    | AliExpress/Amazon |
| T2  | **Solder Wire (60/40 or lead-free)**   | Filler metal for solder joints                    | $3-5      | AliExpress/Amazon |
| T3  | **Wire Stripper / Cutter**             | Strip insulation, cut wires to length             | $5-8      | AliExpress/Amazon |
| T4  | **Multimeter (basic digital)**         | Test voltage, check continuity, debug connections | $10-15    | AliExpress/Amazon |
| T5  | **Helping Hands / Third Hand**         | Holds parts steady while soldering                | $8-12     | AliExpress/Amazon |

#### Assembly Accessories (Consumables)

| #   | Accessory                               | Purpose                                           | Est. Cost | Source            |
| --- | --------------------------------------- | ------------------------------------------------- | --------- | ----------------- |
| A1  | **Breadboard (half-size)**              | Prototype circuits before soldering permanently   | $2-3      | AliExpress/Amazon |
| A2  | **Dupont Jumper Wires (M-M, M-F, F-F)** | Connect ESP32 pins to breadboard/components       | $3-5      | AliExpress/Amazon |
| A3  | **Silicone Wire (22-26 AWG, colors)**   | Flexible, heat-resistant wiring for permanent use | $5-8      | AliExpress/Amazon |
| A4  | **Heat Shrink Tubing (assorted)**       | Insulate solder joints, prevent shorts            | $3-5      | AliExpress/Amazon |
| A5  | **Zip Ties (assorted sizes)**           | Mount ESP32, bundle wires, secure components      | $2-3      | AliExpress/Amazon |
| A6  | **Electrical Tape**                     | Quick insulation, temporary fixes                 | $2-3      | AliExpress/Amazon |
| A7  | **USB-C Cable**                         | Program ESP32 + charge batteries                  | $3-5      | AliExpress/Amazon |
| A8  | **Header Pins (male + female)**         | Plug into ESP32 without soldering to board        | $2-3      | AliExpress/Amazon |
| A9  | **JST-PH 2.0mm Connectors (pairs)**     | Make motor/battery connections detachable/modular | $3-5      | AliExpress/Amazon |
| A10 | **Hot Glue Gun + Sticks**               | Reinforce joints, secure loose wires              | $5-8      | AliExpress/Amazon |

#### Optional (Nice to Have)

| #   | Tool                                 | Purpose                           | Est. Cost | Source            |
| --- | ------------------------------------ | --------------------------------- | --------- | ----------------- |
| O1  | **Crimping Tool**                    | Make custom JST/Dupont connectors | $10-15    | AliExpress/Amazon |
| O2  | **Desoldering Pump (solder sucker)** | Fix soldering mistakes            | $3-5      | AliExpress/Amazon |
| O3  | **Flux Pen**                         | Cleaner solder joints             | $3-5      | AliExpress/Amazon |
| O4  | **Wire Labels / Markers**            | Label which wire goes where       | $2-3      | AliExpress/Amazon |

#### What Connects to What (Method Guide)

```
Connection                          Method              Difficulty
────────────────────────────────────────────────────────────────────
ESP32 → DRV8833 (signal wires)     Dupont jumpers       Easy (no solder)
ESP32 → Servo signal pins          Dupont jumpers       Easy (no solder)
DRV8833 → WPL 370 motor            Solder + heat shrink Medium
Battery → BMS module               Solder + heat shrink Medium
BMS → Buck converter               Solder or screw term Medium
Buck converter → 5V rail           Solder + silicone    Medium
All GND connections                 Common ground bus    Easy (breadboard)
Motor ↔ Gearbox coupling           Adapter sleeve       Easy (mechanical)
```

### Budget Summary

| Phase                      | Components                              | Est. Cost      |
| -------------------------- | --------------------------------------- | -------------- |
| **Phase 1: Drivetrain**    | Motor, driver, servos, battery, chassis | **$50-82**     |
| **Phase 2: Camera + WiFi** | ESP32-S3-CAM (built-in!)                | **$10-15**     |
| **Phase 3: Phone App**     | Software only (Slint framework)         | **$0 (free!)** |
| **Tools (one-time)**       | Soldering iron, multimeter, etc.        | **$40-65**     |
| **Accessories**            | Wires, breadboard, zip ties, etc.       | **$30-50**     |
| **RC Parts Total**         | Car components only                     | **$60-97**     |
| **Grand Total**            | Everything (first-time builder)         | **$130-212**   |

> **Note:** If you already own a soldering iron and multimeter, subtract ~$25-40.
> Tools are reusable for all future electronics projects.

---

## Architecture Diagram

```
┌─────────────────────────────────────────────┐
│          PHONE APP (Codebase 2)             │
│          Built with Rust + Slint            │
│                                             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │Live Video│  │Gyroscope │  │ Throttle │  │
│  │ MJPEG    │  │ Steering │  │ Slider   │  │
│  │ Stream   │  │ -45°~+45°│  │ -100~100 │  │
│  └──────────┘  └──────────┘  └──────────┘  │
│                                             │
│  ┌──────────┐  ┌──────────┐                 │
│  │ Gear "L" │  │ Gear "H" │                 │
│  │ (Torque) │  │ (Speed)  │                 │
│  └──────────┘  └──────────┘                 │
└──────────────────┬──────────────────────────┘
                   │ WiFi (UDP, near-zero latency)
                   │ SSID: RC_CAR_WIFI
┌──────────────────▼──────────────────────────┐
│       ESP32-S3-CAM (Codebase 1)             │
│       Running Rust Firmware 🦀               │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  WiFi Access Point (192.168.71.1)     │  │
│  │  ├─ UDP Socket: Control data          │  │
│  │  └─ HTTP Socket: MJPEG video stream   │  │
│  └───────────────────────────────────────┘  │
│                                             │
│  ┌─────────────┐  ┌───────────────────┐     │
│  │ Motor Task  │  │ Camera Task       │     │
│  │ (async)     │  │ (async)           │     │
│  │             │  │                   │     │
│  │ Throttle    │  │ Capture frames    │     │
│  │ Steering    │  │ MJPEG encode      │     │
│  │ Shifting    │  │ Stream over HTTP  │     │
│  └──────┬──────┘  └───────────────────┘     │
└─────────┼───────────────────────────────────┘
          │
    ┌─────┴──────────────────────────────┐
    │                                    │
┌───▼────────┐  ┌───────────┐  ┌────────▼───┐
│ DRV8833    │  │ MG90S     │  │ SG90       │
│ Motor      │  │ Steering  │  │ Gear       │
│ Driver     │  │ Servo     │  │ Shifter    │
└───┬────────┘  └─────┬─────┘  └────┬───────┘
    │                 │              │
┌───▼──────┐   ┌──────▼─────┐  ┌────▼───────────────┐
│ WPL 370  │   │ Front      │  │ LEGO Gearbox       │
│ Motor    │   │ Wheels     │  │ ├─ Driving Ring     │
│ (0.2 HP) │   │ (Ackermann)│  │ ├─ Low Gear (Torq) │
└───┬──────┘   └────────────┘  │ └─ High Gear (Spd) │
    │                          └────┬────────────────┘
┌───▼──────────────────┐           │
│ LEGO Differential    │◄──────────┘
│ ├─ Left Rear Wheel   │
│ └─ Right Rear Wheel  │
└──────────────────────┘

┌──────────────────────────────────┐
│  Power System                    │
│  2x 18650 (7.4V)                │
│  ├─ Buck Converter → 5V → ESP32 │
│  ├─ Direct → DRV8833 → Motor    │
│  └─ USB-C BMS for charging      │
│     (mounted at rear = pit stop!)│
└──────────────────────────────────┘
```

---

## Camera Positioning & FPC Cable Guide

### Option A: Fixed Camera (Default ✅ Easiest)

**If you DON'T have an FPC connector:**

- Camera is soldered directly to ESP32-S3-CAM
- Mount entire module on **rotating 3D-printed bracket**
- Allows tilt/pan by servos for motorized positioning
- Cost: $1-3 (bracket material)

### Option B: Extended Camera (Recommended for Positioning 🎯)

**If your ESP32-S3-CAM HAS an FPC connector:**

**FPC Cable Specifications:**

```
Pin Configuration:  24-pin (for OV2640)
Pitch:              0.5mm
Connector Type:     Same as onboard camera
Recommended Length: 20-30cm
Cost:               $0.50-1.50 per cable
```

**Available Lengths on AliExpress:**
| Length | Use Case | Part Number Search |
| ------ | ------------------------------------- | --------------------------- |
| 10cm | Minimal spacing (tight fit) | FPC 24pin 0.5mm 10cm |
| 15cm | Moderate spacing | FPC 24pin 0.5mm 15cm |
| 20cm | Good camera positioning ⭐ BEST | FPC 24pin 0.5mm 20cm |
| 30cm | Maximum flexibility | FPC 24pin 0.5mm 30cm |
| 40cm | Premium positioning (for large build) | FPC 24pin 0.5mm 40cm (rare) |

**How to Order:**

1. Search AliExpress: `"FPC flat cable 24 pin 0.5mm"`
2. Filter: **24-pin**, **0.5mm pitch**, **20-30cm length**
3. Price: ~$0.50-1.50 each (free shipping)
4. Delivery: 1-3 weeks from China

**Positioning Strategies with FPC Cable:**

```
Strategy 1: Forward-Facing
ESP32          FPC Cable (20cm)        Camera Module
┌────┐         ────────────────────────┬────┐
│Rear│                                 │FWD │  ← Sees track ahead
└────┘                                 └────┘

Strategy 2: Elevated (45° down)
                    ┌─ Camera (angled)
                    │  ↓45°
ESP32 ──FPC──┌──┘   → Sees car + ground

Strategy 3: Motorized Pan/Tilt
ESP32 ──FPC──[SG90 Servo Bracket]──Camera
               ↑
           Can rotate camera 360° (if servo added!)
```

### How to Check If Your Board Has FPC Port

**On the ESP32-S3-CAM (back side):**

```
Look for:
  ┌─────────────────────────────┐
  │ ESP32-S3-CAM (back view)    │
  │                             │
  │ _____ (ribbon cable slot)   │  ← FPC Connector?
  │                             │
  │ If present: You can use FPC │
  │ If absent: Use fixed mount  │
  └─────────────────────────────┘
```

### Recommendation for Your Build

✅ **Get the 20cm FPC cable** — Gives flexibility to:

- Position camera where you want on chassis
- Keep electronics separate (cleaner wiring)
- Experiment with angles during testing
- Cost: Only $0.50-1.50!

---

### The 2-Speed Gearbox

```
How it works:

LEGO Driving Ring (18947):
├─ Slides LEFT → Engages Low Gear (Torque)
├─ Slides RIGHT → Engages High Gear (Speed)
└─ Moved by SG90 servo via Changeover Catch (6641)

Physical Layout:
                SG90 Servo
                    │
            Changeover Catch (6641)
                    │
    ┌───────────────┼───────────────┐
    │               │               │
  LOW GEAR    Driving Ring     HIGH GEAR
  (16-tooth)    (18947)       (larger ratio)
    │               │               │
    └───────────────┼───────────────┘
                    │
              To Differential
              (LEGO 62821b)
                    │
            ┌───────┼───────┐
            │               │
        Left Wheel     Right Wheel
```

### Digital Clutch Logic (Rust)

```rust
// Prevents gear grinding by cutting motor power during shift

enum GearState {
    Neutral,
    Low,      // Torque gear (starting, drifts)
    High,     // Speed gear (straightaways)
    Shifting, // Transitioning (motor OFF!)
}

struct Transmission {
    current_gear: GearState,
    shifter_servo: SG90,
    motor: WPL370,
}

impl Transmission {
    async fn shift_to(&mut self, target: GearState) {
        // Step 1: Cut motor power (DIGITAL CLUTCH)
        self.motor.set_pwm(0);
        self.current_gear = GearState::Shifting;

        // Step 2: Wait 50ms for motor to stop
        delay_ms(50).await;

        // Step 3: Move shifter servo to target position
        match target {
            GearState::Low => self.shifter_servo.set_angle(45),   // Push left
            GearState::High => self.shifter_servo.set_angle(135), // Push right
            _ => {}
        }

        // Step 4: Wait 100ms for gear to engage
        delay_ms(100).await;

        // Step 5: Resume motor power
        self.current_gear = target;
        // Motor speed restored by throttle task
    }
}
```

---

## Software Architecture (2 Codebases)

### Codebase 1: The Car Firmware (Rust on ESP32)

```rust
// Main entry point for ESP32-S3-CAM
use esp_idf_hal::prelude::*;
use embassy_executor::Spawner;

// Car state management with Rust enums
enum CarState {
    Idle,
    Forward(u8),    // speed 0-100
    Reverse(u8),    // speed 0-100
    Shifting,       // motor disabled during gear change
}

enum Gear {
    Low,            // Torque gear (drifting, starting)
    High,           // Speed gear (straightaways)
}

struct RCCar {
    state: CarState,
    gear: Gear,
    steering_angle: i8,  // -45 to +45 degrees
}

impl RCCar {
    fn new() -> Self {
        RCCar {
            state: CarState::Idle,
            gear: Gear::Low,
            steering_angle: 0,
        }
    }

    fn set_throttle(&mut self, value: i8) {
        // value: -100 (full reverse) to +100 (full forward)
        match value {
            v if v > 0 => {
                self.state = CarState::Forward(v as u8);
                // Activate Forward pin on DRV8833
                // Set PWM duty cycle
            }
            v if v < 0 => {
                self.state = CarState::Reverse((-v) as u8);
                // Activate Reverse pin on DRV8833
                // Set PWM duty cycle
            }
            _ => {
                self.state = CarState::Idle;
                // Set PWM to 0
            }
        }
    }

    fn set_steering(&mut self, angle: i8) {
        // angle: -45 (full left) to +45 (full right)
        self.steering_angle = angle;
        let servo_angle = 90 + angle as i16;  // Map to 45-135 range
        // Send PWM to MG90S servo
    }
}

// Async tasks running concurrently
#[embassy_executor::main]
async fn main(spawner: Spawner) {
    // Initialize hardware
    let mut car = RCCar::new();

    // Task 1: WiFi Access Point
    spawner.spawn(wifi_task()).unwrap();

    // Task 2: UDP control listener
    spawner.spawn(control_task()).unwrap();

    // Task 3: Camera MJPEG streaming
    spawner.spawn(camera_task()).unwrap();

    // Task 4: Main control loop
    loop {
        // Read UDP packets from phone
        // Update car state (throttle, steering, gear)
        // Send PWM signals to hardware
    }
}
```

### Codebase 2: The Phone App (Rust + Slint)

```rust
// Phone controller app using Slint UI framework
use slint::*;

slint::slint! {
    export component CarController inherits Window {
        // Live video feed from ESP32-CAM
        video_frame: Image;

        // Gyroscope steering indicator
        steering_angle: float;

        // Throttle slider
        throttle_value: float;

        // Gear buttons
        callback shift_low();
        callback shift_high();
    }
}

fn main() {
    let app = CarController::new().unwrap();

    // Connect to car's WiFi: SSID "RC_CAR_WIFI"
    // IP: 192.168.71.1

    // Read phone gyroscope → steering angle
    // Map tilt angle (-45° to +45°) to steering

    // Smart throttle slider
    // -100 (full reverse) to +100 (full forward)

    // Gear buttons: "L" and "H"
    // Triggers shift sequence on ESP32

    // Live video: MJPEG stream from ESP32-CAM
    // Display in app window

    app.run().unwrap();
}
```

---

## Wiring Diagram

### ESP32-S3-CAM Pin Connections

```
ESP32-S3-CAM              Component
├─ GPIO 1 (PWM)   ────→  DRV8833 IN1 (Motor Forward)
├─ GPIO 2 (PWM)   ────→  DRV8833 IN2 (Motor Reverse)
├─ GPIO 3 (PWM)   ────→  MG90S Signal (Steering Servo)
├─ GPIO 4 (PWM)   ────→  SG90 Signal (Gear Shifter Servo)
├─ 5V              ────→  From Buck Converter (5V rail)
├─ GND             ────→  Common Ground
└─ Camera          ────→  Built-in OV2640 (onboard!)

DRV8833 Motor Driver:
├─ IN1             ←────  ESP32 GPIO 1
├─ IN2             ←────  ESP32 GPIO 2
├─ OUT1            ────→  WPL 370 Motor Terminal 1
├─ OUT2            ────→  WPL 370 Motor Terminal 2
├─ VCC             ←────  Battery 7.4V (direct from 18650s)
└─ GND             ────→  Common Ground

MG90S Steering Servo:
├─ Signal (Orange) ←────  ESP32 GPIO 3
├─ VCC (Red)       ←────  5V from Buck Converter
└─ GND (Brown)     ────→  Common Ground

SG90 Shifter Servo:
├─ Signal (Orange) ←────  ESP32 GPIO 4
├─ VCC (Red)       ←────  5V from Buck Converter
└─ GND (Brown)     ────→  Common Ground

Power System:
2x 18650 (7.4V)
├─ Through Toggle Switch ────→  2S BMS (main power control)
├─ Through 2S BMS  ────→  USB-C Port (charging)
├─ Direct (from BMS)  ────→  DRV8833 VCC (motor power)
└─ Through Buck Converter ────→  5V Rail (ESP32 + Servos)

(Place toggle switch BEFORE battery to BMS
to physically cut all power quickly)
```

---

## Project Phases & Timeline

### Phase 1: Rust Fundamentals (Shared with Easy Path — 2-3 weeks)

```
Status: IN PROGRESS ✅

Tasks:
├─ ✅ Variables, mutability, shadowing
├─ ✅ Enums, generics, pattern matching
├─ ✅ Traits and trait imports
├─ ✅ Expressions vs statements
├─ ✅ I/O, buffering, flush
├─ ✅ Error handling (Result, match)
├─ 🔄 Guessing game project (finishing)
├─ ⏳ Ownership and borrowing
├─ ⏳ Structs and impl blocks
├─ ⏳ Option<T> type
├─ ⏳ Modules and crate organization
├─ ⏳ Async/await basics (ADVANCED PATH ONLY)
└─ ⏳ Networking concepts (ADVANCED PATH ONLY)
```

### Phase 2: ESP32 + Embedded Rust (3-4 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Get ESP32-S3-CAM module
├─ ⏳ Set up esp-idf-hal toolchain for Rust
├─ ⏳ Blinky LED (Hello World of embedded)
├─ ⏳ GPIO control (digital pins)
├─ ⏳ PWM basics (motor speed control)
├─ ⏳ WiFi Access Point setup
├─ ⏳ UDP socket communication
├─ ⏳ Camera capture basics
└─ ⏳ MJPEG streaming test
```

### Phase 3: Build RC Car — Drivetrain (2-3 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Order all components (BOM above)
├─ ⏳ Build LEGO Technic chassis (1:20 scale frame)
├─ ⏳ Build LEGO gearbox (Driving Ring + gears)
├─ ⏳ Install LEGO differential
├─ ⏳ Mount WPL 370 motor
├─ ⏳ Wire DRV8833 motor driver
├─ ⏳ Mount MG90S steering servo (Ackermann linkage)
├─ ⏳ Mount SG90 shifter servo (gear mechanism)
├─ ⏳ Write Rust motor control code
├─ ⏳ Write Rust servo control code
├─ ⏳ Implement digital clutch logic
├─ ⏳ Test forward/backward/left/right
├─ ⏳ Test gear shifting (Low ↔ High)
└─ ⏳ Wire battery + USB-C BMS charging
```

### Phase 4: WiFi Control + Camera (2-3 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Set up WiFi Access Point on ESP32
├─ ⏳ Implement UDP control listener
├─ ⏳ Map UDP packets to car commands
├─ ⏳ Test WiFi control with laptop/phone browser first
├─ ⏳ Set up MJPEG camera streaming task
├─ ⏳ Implement async concurrent tasks (video + control)
├─ ⏳ Optimize latency (target: <50ms)
└─ ⏳ Test camera + driving simultaneously
```

### Phase 5: Phone App (2-3 weeks)

```
Status: NOT STARTED

Tasks:
├─ ⏳ Learn Slint UI framework basics
├─ ⏳ Build app layout (video + controls)
├─ ⏳ Implement gyroscope → steering angle mapping
├─ ⏳ Implement throttle slider (-100 to +100)
├─ ⏳ Add gear shift buttons (L / H)
├─ ⏳ Connect to ESP32 WiFi (SSID: RC_CAR_WIFI)
├─ ⏳ Display live MJPEG video feed
├─ ⏳ Send UDP control packets
├─ ⏳ Test full integration
└─ ⏳ Optimize responsiveness
```

### Phase 6: Polish & Drifting! (1-2 weeks)

```
Status: FUTURE

Tasks:
├─ ⏳ Fine-tune motor response curves
├─ ⏳ Optimize gear shift timing
├─ ⏳ Tune Ackermann steering angles
├─ ⏳ Test drifting (Low gear + sharp steering)
├─ ⏳ Build mini race track
├─ ⏳ Add lap timing system
├─ ⏳ Mount USB-C port at rear (pit stop exhaust!)
└─ ⏳ Film demo video!
```

---

## Risk Assessment

| Risk                        | Probability | Impact | Mitigation                                   |
| --------------------------- | ----------- | ------ | -------------------------------------------- |
| ESP32 toolchain setup fails | Medium      | High   | Use well-documented esp-idf-hal, ask Copilot |
| LEGO gear mechanism jams    | Medium      | High   | Test gearbox separately, adjust spacing      |
| WiFi latency too high       | Medium      | Medium | Use UDP (not TCP), optimize packet size      |
| Camera + control conflicts  | Medium      | High   | Async Rust tasks, proper task prioritization |
| Slint app crashes           | Low         | Medium | Test incrementally, Copilot helps debug      |
| Gear grinding (timing)      | Medium      | High   | Digital clutch logic (50ms motor cutoff)     |
| Battery overheating         | Low         | High   | BMS module protects cells, use rated cells   |
| Budget overrun              | Low         | Low    | Most parts under $10 each                    |
| Async Rust complexity       | High        | Medium | Learn incrementally, Copilot guides          |
| Phone gyroscope inaccurate  | Low         | Medium | Calibration routine, deadzone filtering      |

---

## Technology Stack

| Layer               | Technology                 | Purpose                               |
| ------------------- | -------------------------- | ------------------------------------- |
| **Motor Control**   | Rust (esp-idf-hal)         | PWM, GPIO, motor/servo control        |
| **Microcontroller** | ESP32-S3-CAM               | WiFi + Camera + Control (all-in-one!) |
| **Networking**      | UDP over WiFi              | Low-latency control data              |
| **Camera**          | OV2640 (onboard ESP32-CAM) | MJPEG streaming over HTTP             |
| **Phone App**       | Rust + Slint               | Cross-platform UI with gyroscope      |
| **Async Runtime**   | Embassy / esp-idf async    | Concurrent video + control tasks      |
| **Motor Driver**    | DRV8833                    | Dual H-Bridge for forward/reverse     |
| **Power**           | 2x 18650 + 2S BMS + Buck   | 7.4V motor, 5V logic, USB-C charge    |
| **Chassis**         | LEGO Technic               | 1:20 scale RC car frame               |
| **Gearbox**         | LEGO Driving Ring + Gears  | 2-speed mechanical transmission       |

---

## Rust Concepts Applied

| Concept              | Where Used                                                        |
| -------------------- | ----------------------------------------------------------------- |
| **Enums**            | CarState (Idle, Forward, Reverse, Shifting), Gear (Low, High)     |
| **Structs**          | RCCar (state, gear, steering_angle), Transmission                 |
| **impl blocks**      | Methods: set_throttle(), set_steering(), shift_to()               |
| **Pattern matching** | match on CarState, Gear, UDP commands                             |
| **Traits**           | Embedded HAL traits (OutputPin, PwmPin), Write trait              |
| **Error handling**   | Result for WiFi, camera, hardware operations                      |
| **Async/Await**      | Concurrent video streaming + motor control                        |
| **Ownership**        | Managing hardware resources (single-owner peripherals)            |
| **Modules**          | Separate: motor.rs, servo.rs, wifi.rs, camera.rs, transmission.rs |
| **Generics**         | Reusable servo controller for MG90S and SG90                      |
| **Closures**         | UDP packet handlers, callback functions                           |
| **Lifetimes**        | Hardware references with proper lifetime management               |

---

## Success Criteria

- [ ] ESP32 creates WiFi hotspot (SSID: RC_CAR_WIFI)
- [ ] Phone connects to ESP32 WiFi
- [ ] Live camera feed visible on phone app
- [ ] Gyroscope steering works (tilt phone → car turns)
- [ ] Throttle slider controls speed and direction
- [ ] Car moves forward/backward/left/right smoothly
- [ ] Gear shifting works (Low ↔ High via buttons)
- [ ] Digital clutch prevents gear grinding
- [ ] Rear differential distributes torque in turns
- [ ] Ackermann steering geometry functional
- [ ] Battery charges via USB-C
- [ ] Drifting possible in Low gear + sharp steering
- [ ] Total latency under 50ms (control responsive)
- [ ] Total cost under $150

---

## References & Resources

### ESP32 + Rust

- [esp-idf-hal (Rust on ESP32)](https://github.com/esp-rs/esp-idf-hal)
- [The esp-rs book](https://esp-rs.github.io/book/)
- [Embassy async framework](https://embassy.dev/)
- [ESP32-CAM pinout guide](https://randomnerdtutorials.com/esp32-cam-ai-thinker-pinout/)

### Slint UI Framework

- [Slint official docs](https://slint.dev/)
- [Slint Rust examples](https://github.com/slint-ui/slint)
- [Slint on mobile](https://slint.dev/blog/slint-on-mobile)

### LEGO Mechanical Parts

- [BrickLink (buy individual LEGO parts)](https://www.bricklink.com/)
- [LEGO 18947 Driving Ring](https://www.bricklink.com/v2/catalog/catalogitem.page?P=18947)
- [LEGO 62821b Differential](https://www.bricklink.com/v2/catalog/catalogitem.page?P=62821b)

### Hardware

- [DRV8833 datasheet](https://www.ti.com/product/DRV8833)
- [WPL 370 motor specs](https://www.aliexpress.com/w/wholesale-wpl-370-motor.html)
- [18650 battery guide](https://www.18650batterystore.com/)

---

# ═══════════════════════════════════════

# 📊 PATH COMPARISON SUMMARY

# ═══════════════════════════════════════

## Side-by-Side Comparison

| Feature          | 🟢 Easy Path           | 🔴 Advanced                  |
| ---------------- | ---------------------- | ---------------------------- |
| **Brain**        | Arduino Nano / STM32   | ESP32-S3-CAM                 |
| **Control**      | IR Remote (physical)   | Phone App (WiFi + Gyroscope) |
| **Camera**       | Raspberry Pi + USB Cam | ESP32 onboard OV2640         |
| **Motor**        | Generic DC motor       | WPL 370 (0.2 HP)             |
| **Steering**     | SG90 (simple tie rod)  | MG90S (Ackermann linkage)    |
| **Transmission** | Single speed           | 2-speed LEGO gearbox         |
| **Power**        | Li-Po 3.7V + TP4056    | 2x 18650 7.4V + 2S BMS       |
| **Networking**   | IR (line of sight)     | WiFi UDP (through walls!)    |
| **App**          | None                   | Rust + Slint phone app       |
| **Async**        | No                     | Yes (video + control)        |
| **Budget**       | $55-105                | $60-150                      |
| **Timeline**     | 4-6 weeks              | 12-14 weeks                  |
| **Difficulty**   | ⭐⭐                   | ⭐⭐⭐⭐⭐                   |

## Recommended Approach

```
Best Strategy: PROGRESSIVE BUILD

Step 1: Start with Easy Path basics
├─ Learn embedded Rust (GPIO, PWM)
├─ Get motor + servo working
├─ Build confidence with hardware
└─ Time: 4-6 weeks

Step 2: Upgrade to Advanced RC Car
├─ Replace Arduino with ESP32-S3-CAM
├─ Add WiFi control + camera
├─ Build LEGO gearbox
├─ Create phone app
└─ Time: 6-8 additional weeks

Total: 10-14 weeks for FULL RC CAR!
(But you have a working car after week 4-6!)
```

## The Journey

```
Week 1-3:   Learn Rust fundamentals ✅ (You're here!)
Week 4-6:   Easy Path RC car (WORKING CAR! 🎉)
Week 7-9:   Upgrade to ESP32 + WiFi
Week 10-11: Add LEGO gearbox + camera
Week 12-13: Build phone app
Week 14:    FULL RC CAR COMPLETE! 🏎️🔥
```

---

## Notes

- This project serves as the culmination of learning Rust programming
- Two paths available: Easy (IR remote) and Advanced (WiFi + phone app)
- Start with Rust fundamentals, then progress to embedded systems
- Build incrementally — test each component before integration
- Document everything in KNOWLEDGE_MEMORY.md as you learn
- Progressive build: Easy Path first → Upgrade to Advanced → Maximum learning!
- Have fun! This is a learning project, not a production vehicle 🚗🦀

---

_Last Updated: 2026-03-09_
