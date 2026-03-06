# 🚗 Final Project: RC Car with Live Camera

**Version**: 1.0
**Date**: 2026-03-06
**Author**: JeroweTan + GitHub Copilot
**Status**: Planning Phase

---

## Executive Summary

Build a budget-friendly, rear-wheel-drive RC car with live camera feed, controlled via IR remote. The car uses a simple brushed DC motor, servo steering, rear differential, and USB-C rechargeable battery. The long-term goal is to program the car's brain using **Rust** (embedded systems), making this both a hardware and software learning project.

**Why this project?**

- Learn Rust embedded programming with real hardware
- Understand systems programming (motors, sensors, I/O)
- Build something tangible and fun
- Foundation for future upgrades (GPS, autonomy, AI)

---

## Problem Statement

**Current Situation**: Learning Rust through book exercises (guessing game, hello world) — need a real-world project to apply systems programming knowledge.

**Proposed Solution**: Build a simple RC car that combines hardware engineering with Rust embedded programming.

**Expected Outcome**: A working RC car with live camera feed, controlled via IR remote, programmed in Rust.

---

## Project Specifications

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

## Architecture Diagram

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

## Hardware Shopping List

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

## Chassis Options

| Option              | Pros                              | Cons                  | Cost   |
| ------------------- | --------------------------------- | --------------------- | ------ |
| **3D Printed**      | Custom design, lightweight, cheap | Need printer access   | $5-15  |
| **LEGO Technic**    | Easy assembly, modular, sturdy    | Limited customization | $15-30 |
| **Pre-made RC Kit** | Ready to use, all parts fit       | Less learning         | $20-40 |

**Recommended**: 3D printed (cheapest, most customizable) or LEGO Technic (easiest, modular)

---

## Software Architecture

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

## Wiring Diagram

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

## Project Phases & Timeline

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

## Risk Assessment

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

## Technology Stack

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

## Rust Concepts Applied in This Project

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

## Success Criteria

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

_Last Updated: 2026-03-06_
