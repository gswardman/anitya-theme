# STATE

Updated: 27 Nov 2026

## Current branch

`shop/saffron-first` (from main at `1ef8322`). Not merged. Waiting on Geordie to create Shopify variants and set the addon variant ID before merging to main.

## What was built

Saffron-first offer: Morning Saffron leads, Evening Magnesium is an optional add-on checkbox. All changes from the brief `01-Projects/TestVentures/ecom/04-Reference/Prompts/Saffron-First-Offer-Build-2026-11-27.md`.

### Files changed

- `sections/anitya-calm-stack-v2.liquid`: full rewrite for the saffron-first offer.
- `templates/product.calm-stack-v2.json`: 2 tiers (1 jar $39, buy 2 get 1 free $78) instead of 3. Addon variant ID blank until set.
- `templates/index.json`: homepage BF bar text and Calm Stack shelf block updated.
- `sections/anitya-home.liquid`: schema defaults and preset updated for the new offer.

### Product page changes

- **Top bar:** "Free US shipping · Ships within one business day · No subscription" (was Black Friday).
- **Hero:** saffron jar only (magnesium jar removed). Kicker: "MORNING SAFFRON · USHA". H1: "One capsule of saffron each morning." Body: "88.5 mg saffron extract, one ingredient. Supports mood.*"
- **App box** added to hero: six weather icons + "Track your vibe as you take it..." text.
- **Buy box:** 2 tiers: "Morning Saffron, 1 jar" at $39 (variant 0) and "Buy 2, get 1 free" at $78 (variant 1, default, tagged "SAVE $39 · ONE JAR FREE").
- **Add-on checkbox:** "Add the Evening Magnesium jar · +$25". Conditional on `addon_variant_id` being set. When checked, the magnesium variant is added as a second cart item.
- **Button:** "Add to cart · $[total]" with dynamic total (tier + addon). Same on the phone sticky bar.
- **Who it's for closing:** removed "two capsules in the evening".
- **What each jar does:** saffron leads, magnesium labelled "Add the evening jar (optional)".
- **App section:** "every order" instead of "every stack".
- **About the price:** "65¢ a morning for one jar. 43¢ with buy 2, get 1 free." Refund line: "jar" not "jars".
- **Day 1:** "One capsule of Morning Saffron. Add Evening Magnesium if you chose it."
- **Guarantee:** "Same guarantee on every order."
- **FAQ:** "Do both jars last the same time?" → "How long does a jar last?" with new answer.
- **Bottom CTA:** "Buy 2, get 1 free: three jars of Morning Saffron, $78."
- **Who made this:** untouched.
- **Removed:** all Black Friday, Practice, Season, First Light, stack-centric copy. No "No code" line.

### Homepage changes

- BF bar: "Buy 2 jars of Morning Saffron, get 1 free".
- Shelf block: button "Shop Morning Saffron", copy updated.

### Buy path

- `{% form 'product', product %}` with two radios (variants 0 and 1). Variant 1 (buy 2 get 1 free) selected by default.
- Optional add-on checkbox. When checked, the JS adds both the saffron variant and the magnesium variant to the cart.
- On submit: POST `/cart/clear.js`, then POST `/cart/add.js` with `{ items: [{saffron}, {magnesium if checked}] }`, then go to `/checkout`.
- Phone bar: same submit logic.
- Closing button always adds the default tier (buy 2 get 1 free), no addon.

## Needs Geordie before merge

1. **Create Shopify variants.** The Calm Stack product needs two new variants:
   - Variant 0: "Morning Saffron, 1 jar" at $39
   - Variant 1: "Buy 2, get 1 free" at $78
   The old variants (First Light $69, The Practice $118, The Season $159) stay in Shopify but won't appear on the page.

2. **Create the Evening Magnesium add-on product** (or variant) in Shopify at $25 (compare at $35). Note the variant ID.

3. **Set the addon variant ID.** In the theme editor (or in `templates/product.calm-stack-v2.json`), set `addon_variant_id` to the magnesium variant ID. Until this is set, the add-on checkbox won't appear.

4. **Backup the live theme** in Shopify admin: Themes > Actions > Duplicate. Name it `backup-live-2026-11-27 (before saffron-first)`.

5. **Preview** the branch in a draft theme: Themes > Add theme > Connect from GitHub > branch `shop/saffron-first`. Check at 390px on a phone.

6. **Merge to main** after preview is OK: squash merge, then the live theme updates in about 30 seconds.

7. **Report the new variant IDs and SKUs** to the vault STATE.md for ODF mapping.

## Checks

- `shopify theme check`: 0 offenses in changed files (one `UnusedAssign` was fixed). 29 warnings are all in older files, same as before.
- No "Black Friday", "Practice", "Season", "First Light", stack price, "$10 today", or "free extra jar" left on the product page or homepage.
- Pixel: no tracking changes. The existing ViewContent, AddToCart, and InitiateCheckout pixels fire as before (they are app embeds, not in the section).

## Go-live steps

1. Create the Shopify variants and the magnesium add-on product (above).
2. Set the addon variant ID in the template JSON.
3. Backup the live theme.
4. Connect the branch as a draft theme and preview at 390px.
5. If OK, squash-merge to main.
6. Products > The Calm Stack > Theme template: confirm it's `calm-stack-v2`.
7. Test: add each option to cart, with and without the magnesium add-on. Verify totals ($39, $78, $64, $103).
8. Check Meta Events Manager for AddToCart firing.
9. Write the variant IDs and SKUs to the vault.
