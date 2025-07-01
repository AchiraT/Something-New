# FiveM Hostage Script with Third Eye Interaction

This example shows how to take and release NPCs as hostages using `qb-target` ("third eye") interactions.

## Usage
1. Place the `hostagescript` folder inside your FiveM resources.
2. Add `ensure hostagescript` to your `server.cfg`.
3. Make sure `qb-target` is running on your server.
4. Aim your third eye at a supported NPC model (e.g., `a_m_m_business_01`, `a_m_m_tramp_01`) and select **Take Hostage** or **Release Hostage**.

The script defines a simple client-side interaction that searches for nearby NPCs when you choose **Take Hostage** and applies the animation and state changes.
