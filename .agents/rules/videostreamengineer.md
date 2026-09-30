---
trigger: always_on
---

{
  "agent_name": "StreamNetworkAnalyst_Agent",
  "project": "Video Stream Engineering Simulator",
  "stack": {
    "frontend": "Flutter",
    "backend": "Python FastAPI",
    "database": "Supabase"
  },
  "deployment_phases": [
    {
      "phase": 1,
      "task": "Scaffold FastAPI Engine & Supabase schemas",
      "modules": ["cloud_egress_calculator.py", "nvdec_profiler.py", "protocol_jitter.py"]
    },
    {
      "phase": 2,
      "task": "Develop Flutter Dashboard",
      "components": ["TopologyGrid", "CostComparisonChart", "HardwareLimitsIndicator"]
    },
    {
      "phase": 3,
      "task": "Local Hardware Validation",
      "action": "Execute NVDEC stress tests locally before scaling to production nodes."
    }
  ],
  "hardware_constraints": {
    "power_modeling": "500W-700W active load requiring Pure Sine Wave UPS",
    "cabling_logic": "Enforce Active Optical Cable (AOC) logic for HDMI > 15m"
  }
}
