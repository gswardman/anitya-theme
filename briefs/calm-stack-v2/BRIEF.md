# Brief: Calm Stack page v2 (buy now, no reservation)

Branch: `shop/calm-stack-v2` (already created from main at `d975685`).
Read `GIT-RULES.md` first. Nothing on this branch reaches customers until Geordie OKs the preview.

## Why

Meta traffic reaches the page (about $3 per landing page view) but almost nobody adds to cart. The $10 reservation confuses people about what they pay and when it ships. ODF now ships stock, so the page moves to direct purchase at full price. Agency call, 24 Nov 2026.

## What to build

The page in `briefs/calm-stack-v2/mockup-clean.dc.html`, as a new section and a new product template:

- `sections/anitya-calm-stack-v2.liquid`
- `templates/product.calm-stack-v2.json` (one section, type `anitya-calm-stack-v2`)

Do not edit or delete the current Calm Stack sections or templates. The product keeps using the current template until Geordie switches it in the admin. That switch is the go-live, and switching back is the rollback.

`mockup-desktop.pdf` and `mockup-phone.pdf` show how it should look. `mockup-with-change-tags.dc.html` has blue tags explaining each change; the tags are notes for review, not page content.

The mockup files are Design Component HTML. Take the markup and inline styles. Ignore `<x-dc>`, `<helmet>`, `{{tagDisplay}}`, `<sc-for>` and the `data-dc-script` block. Rebuild the weather icons and the 21 bars of the app mock-up in Liquid or plain HTML, using the values in that script block.

Images: `ASSET:<file>` in the mockup means `{{ '<file>' | asset_url }}`. The six ODF renders are already in `assets/` (`calm-stack-saffron-1/2/3.png`, `calm-stack-magnesium-1/2/3.png`). Use `image_tag` or add `width`, `height`, `loading` and `alt`. The founder video: reuse the YouTube embed and `video_id` setting from `sections/anitya-calm-stack-v3.liquid` instead of the mockup's thumbnail link.

Leave the mockup's site header out of the section. The theme already renders the store header and footer around the page. Keep the section's own policy-links footer (render `shop.policies`, as v3 does) and the Powered by Finn lines.

## Copy

Use the mockup's copy word for word. Do not add, reword or "improve" any line. Claims rules: the only product claims are "supports mood" (saffron) and "melatonin-free" (magnesium), with the FDA disclaimer. If anything in the build seems to need new wording, stop and list it in STATE.md for Geordie.

Prices come from Shopify, not hard-coded: render each tier's price from its variant (`variant.price | money_without_trailing_zeros`). The per-morning prices ($1.15, 98¢, 66¢), the "save" amounts and the Black Friday lines can stay as section settings or text.

## The buy path (tracking: do not break this)

- Same product, same URL `/products/calm-stack`, same three variants: First Light `67884288639367`, The Practice `67884288672135`, The Season `67884288704903`. The Practice is selected by default.
- Use `{% form 'product', product %}` with the selected variant id. **Do not send `selling_plan`.** No hidden selling_plan input, no selling_plan in the Cart API call. This is the whole switch from deposit to full price.
- Keep the current checkout steps: on submit, POST `/cart/add.js` with `{ items: [{ id, quantity: 1 }] }`, then go to `/checkout`. Copy v3's submit handler minus the selling plan. Keep a plain form submit as the fallback if JS fails.
- Button text follows the selected tier: "Add The Practice to cart · $118" (name and price from the variant).
- Sticky add-to-cart bar on phones only (hidden above 860px), shown once the hero button scrolls out of view. Reuse v3's IntersectionObserver and safe-area code. Its button runs the same submit as the hero button.
- Do not touch `layout/theme.liquid`, `snippets/ga4.liquid`, `config/settings_data.json`, any app embed, or any pixel. Do not add fbq, gtag or any other tracking call.
- Any link to the app (app.anityalabs.com) gets `?ref=store-calm-stack-<placement>` so the utm script from commit d975685 picks it up.

## Email form (app section)

"Not ready to buy? Start with the app. It's free." Use `{% form 'customer' %}` with `contact[email]`, a hidden `contact[tags]` of `calm-stack-app-lead`, and `contact[accepts_marketing]` true. Show a success line after submit: "Thanks. Check your email for the app link." Do not wire any email sending; Geordie sets up the email in Shopify.

## Done means

1. `shopify theme check` passes on the new files (install `@shopify/cli` with npm if missing; if it can't run here, say so in STATE.md).
2. The page renders the same as the mockup PDFs at 1280 px and 390 px. Check it locally as far as possible without a store.
3. One commit per logical step on `shop/calm-stack-v2`, pushed. Nothing merged to main.
4. `STATE.md` at the repo root: branch, what was built, anything that needs Geordie, and the go-live steps below.

## Go-live steps (for Geordie, not the agent)

1. Online Store > Themes > Add theme > Connect from GitHub > branch `shop/calm-stack-v2`. Preview `/products/calm-stack?view=calm-stack-v2`.
2. OK: squash-merge to main. Nothing changes for customers yet, because the product still uses the old template.
3. Products > The Calm Stack > Theme template > `calm-stack-v2`. Save. That is the go-live.
4. Same minute: end the pre-order in PreProduct for this product and remove the `pre-order` tag, so the app stops adding its deposit plan or button text.
5. Test with a real card: add to cart, reach checkout, confirm full price and no deposit line. Check Meta Events Manager > Test events for ViewContent, AddToCart and InitiateCheckout.
6. Rollback at any point: switch the template back (step 3). Full rollback: publish theme `backup-live-2026-11-24 (pre-order, before Calm Stack v2)`.
7. Tell Diksha it is live.
