# STATE

Updated: 27 Nov 2026, evening

## Current branch

`main` only. Feature branch `shop/saffron-first` merged and deleted (local + remote). No stashes, no stale remotes.

## What is live

Saffron-first offer on anityalabs.com/products/calm-stack (URL unchanged for Meta ads). Built from brief `01-Projects/TestVentures/ecom/04-Reference/Prompts/Saffron-First-Offer-Build-2026-11-27.md`.

### Product rename

Shopify product title changed from "The Calm Stack" to **"Morning Saffron"** (27 Nov). Handle stays `calm-stack`, URL stays `/products/calm-stack`.

### Variant IDs (for ODF mapping)

| Variant | ID | Price | SKU |
|---|---|---|---|
| Morning Saffron 1 jar | 68335831417223 | $39 | TBC |
| Buy 2 get 1 free | 68335831449991 | $78 | TBC |
| Evening Magnesium add-on | 68335831482759 | $25 | TBC |

Old variants (First Light $69, The Practice $118, The Season $159) still exist in Shopify but are not shown on the page.

### Theme files changed

- `sections/anitya-calm-stack-v2.liquid`: full rewrite for saffron-first. Variant lookup by ID, addon checkbox, dynamic total.
- `templates/product.calm-stack-v2.json`: 2 tiers + addon settings wired to variant IDs above.
- `templates/index.json`: homepage BF bar and shelf block updated for Morning Saffron.
- `sections/anitya-home.liquid`: schema defaults updated.

### Copy changes (27 Nov evening)

- Founder paragraph: "The Calm Stack gives them an anchor: one jar for dawn, one for dusk" changed to "Morning Saffron is the anchor: one capsule each morning".
- Reviews disclaimer: "not reviews of the Calm Stack" changed to "not reviews of Morning Saffron".

### Commits

- `1bc79ac`: saffron-first offer merged to main (product page + homepage + template JSON).
- Theme code edits for copy rename (pending push).

## Still to do

1. **SKUs** — set in Shopify admin and update the table above.
2. **ODF mapping** — confirm new variant IDs with Michael after Thanksgiving.
3. **Menu link** — rename "Calm Stack" to "Morning Saffron" in Shopify admin > Online Store > Navigation > main-menu.
4. **Addon channel visibility** — the Evening Magnesium add-on variant is currently visible on all sales channels (Online Store, Facebook & Instagram, Shop). Shopify does not support per-variant channel hiding in the admin UI. Options:
   - Hide via the Facebook & Instagram channel app catalogue settings
   - Use the Shopify Admin API to unpublish the variant from specific channels
   - Move the addon to a separate Shopify product published only to Online Store
5. **Product description** — still references old stack copy ("Two jars, one calm routine", "Why the second jar"). Needs rewriting for saffron-first.
6. **Push pending copy edits** to main (founder paragraph + reviews disclaimer).
