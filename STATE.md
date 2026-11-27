# STATE

Updated: 27 Nov 2026, evening

## Session log

**27 Nov 2026** — Saffron-first offer live (1 jar $39, buy 2 get 1 free $78, magnesium add-on $25). Pre-order wording gone, "Add to cart" fixed, old v1/v3 sections deleted, old pre-order theme backup deleted. Decision: no email to Michael yet; any weekend orders on the new SKUs get sorted with ODF support on Monday. Next: Tuesday 1 Dec, review ad numbers after Black Friday, then decide on budget.

## Current branch

`main` only. Feature branch `shop/saffron-first` merged and deleted (local + remote). No stashes, no stale remotes.

## What is live

Saffron-first offer on anityalabs.com/products/calm-stack (URL unchanged for Meta ads). Built from brief `01-Projects/TestVentures/ecom/04-Reference/Prompts/Saffron-First-Offer-Build-2026-11-27.md`.

### Product rename

Shopify product title changed from "The Calm Stack" to **"Morning Saffron"** (27 Nov). Handle stays `calm-stack`, URL stays `/products/calm-stack`.

### Variant IDs (for ODF mapping)

| Variant | ID | Price | SKU |
|---|---|---|---|
| Morning Saffron 1 jar | 68335831417223 | $39 | 57227-127 |
| Buy 2 get 1 free | 68335831449991 | $78 | 57227-127-3 |
| Evening Magnesium add-on | 68335831482759 | $25 | 57226-824 |

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
- `cb312eb`: copy rename — founder paragraph + reviews disclaimer say "Morning Saffron" instead of "The Calm Stack". STATE.md rewritten.
- `0871386`: locale ATC text "Pre-order" → "Add to cart"; homepage shelf alt text updated.
- `66e0a46`: deleted dead v1/v3 sections and templates (2,006 lines removed).

### Theme backups

27 Nov: deleted theme backup `backup-live-2026-11-24 pre-order`; kept `Copy of anitya-theme/main` as rollback until ~4 Dec.

### Leftovers sweep (27 Nov)

- **PreProduct app embed**: `config/settings_data.json` line 151, already `"disabled": true`. Not loading.
- **`locales/en.default.json` line 109**: ~~"Pre-order"~~ → "Add to cart". Fixed in `0871386`.
- **Dead sections and templates**: `anitya-calm-stack.liquid` (v1), `anitya-calm-stack-v3.liquid`, `product.calm-stack.json`, `product.calm-stack-v3.json` — all deleted in `66e0a46`.
- **Homepage alt text**: ~~"The Calm Stack: saffron and magnesium jars"~~ → "Morning Saffron and Evening Magnesium jars". Fixed in `0871386`.
- Schema labels at line 486-487 still say "Black Friday bar" / "Show Black Friday bar" (theme editor only, not customer-visible).
- **Addon cart isolation**: the product page JS always clears the cart and adds the saffron tier first, so the addon can never reach the cart alone from the storefront. Risk is on FB/IG and Shop channels if the variant is published there (see addon channel visibility below).

## Still to do

1. **ODF SKU mapping** — confirm new variant IDs and SKUs (57227-127, 57227-127-3, 57226-824) with Michael after Thanksgiving, before first real order ships.
2. **Addon channel visibility** — hide the Evening Magnesium add-on variant from FB/IG and Shop before any of those channels go on. Shopify does not support per-variant channel hiding in the admin UI. Options:
   - Hide via the Facebook & Instagram channel app catalogue settings
   - Use the Shopify Admin API to unpublish the variant from specific channels
   - Move the addon to a separate Shopify product published only to Online Store
3. **Uninstall PreProduct app** — Geordie, in Shopify admin. App embed is already disabled but the app is still installed.
4. **Delete theme backup** — remove "Copy of anitya-theme/main" around 4 Dec if no rollback needed.
