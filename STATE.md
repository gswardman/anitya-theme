# STATE

Updated: 24 Nov 2026

## Current branch

`shop/calm-stack-v2` (from main at `d975685`). Not merged. Nothing here reaches customers until Geordie OKs the preview.

Preview link: none yet. Geordie connects a draft theme to this branch (go-live step 1), then opens `/products/calm-stack?view=calm-stack-v2`.

## What was built

- `sections/anitya-calm-stack-v2.liquid`: the page in `briefs/calm-stack-v2/mockup-clean.dc.html`. Copy is taken from the mockup word for word. All CSS sits under `.an-cs2`.
- `templates/product.calm-stack-v2.json`: one section, type `anitya-calm-stack-v2`, with three tier blocks (detail line, Black Friday line, italic line, price per morning, phone bar detail).
- The current Calm Stack sections and templates are untouched. So are `layout/theme.liquid`, `snippets/ga4.liquid`, `config/settings_data.json`, app embeds and pixels. No tracking calls were added.

Buy path:

- `{% form 'product', product %}` with three radios (the variants in order). The second variant, The Practice, is selected by default.
- No `selling_plan` anywhere: no hidden input, nothing in the Cart API call.
- On submit: POST `/cart/clear.js`, then POST `/cart/add.js` with `{ items: [{ id, quantity: 1 }] }`, then go to `/checkout`. This is v3's handler minus the selling plan. If JS is off or the add fails, the form posts the plain way to `/cart/add`.
- Tier names and prices come from the variants (`money_without_trailing_zeros`). The hero button, the "You pay ... today" line and the phone bar follow the selected tier.
- Phone add-to-cart bar: below 860px only, shown once the hero button has scrolled up out of view (IntersectionObserver, safe-area padding). Its button runs the same submit as the hero button.

Email form: `{% form 'customer' %}` with `contact[email]`, hidden `contact[tags]` = `calm-stack-app-lead`, `contact[accepts_marketing]` = true. After submit it shows "Thanks. Check your email for the app link." No email sending is wired.

Founder video: the YouTube embed and `video_id` setting from v3.

Footer of the section: FDA line, hello@anityalabs.com, `shop.policies` links, Powered by Finn lines.

### Change from Geordie during the build (24 Nov): no store menu

- The section hides the theme's whole header group on this template (`.shopify-section-group-header-group{display:none !important}` in the section's own style block). That covers the store header and any announcement bar inside the header group. The rule only exists on pages that use the v2 section. `layout/theme.liquid` and the header section were not edited.
- The page starts with a plain centred logo row (heart mark and "Anitya Labs", not a link, no nav, no cart icon), then the amber Black Friday bar from the mockup.
- The theme footer is left alone.
- Links off the page: the policy links, the hello@anityalabs.com mail link and the YouTube video. The mockup has no link to app.anityalabs.com, so none was added.

## Checks

- `shopify theme check` (CLI 3, run with npx): 0 offenses in the two new files. The 27 warnings it reports are all in older files, not touched here. The Google Fonts links in the new section carry a `theme-check-disable RemoteAsset` comment; they are loaded the same way as in v3.
- Rendered locally (Liquid replaced with sample values, Dawn's `base.css` loaded around it) and screenshotted at 1280px and 390px against the two mockup PDFs. Desktop height 7894px against the mockup's 7896px. Sections, spacing and copy match.
- Buy path tested in a headless browser with the cart endpoints stubbed: the add call carries only `id` and `quantity`, then the browser goes to `/checkout`.
- Not tested: a real store. The `form` tags, real prices, the customer form and the checkout need the preview theme.

## Differences from the mockup

- No site header (brief), replaced by the centred logo row (Geordie's change).
- Founder video is the YouTube embed, not the thumbnail link (brief).
- The phone bar is fixed to the bottom of the screen and hidden until the hero button has scrolled out of view. In the mockup it is always there. When showing, it covers the last lines of the theme footer on phones.
- The serif font could not be fetched from Google in the test browser, so line breaks in headings were compared with a local copy of Fraunces. Check headings on the preview.

## Needs Geordie

1. **Closing button.** The mockup's closing lines name The Practice ("The Practice, 2 stacks and a free Evening Magnesium jar, $118..."). There is no wording for the other two tiers, so the closing button always adds The Practice, whatever is selected in the hero. If it should follow the selected tier, it needs a line each for First Light and The Season.
2. **Phone bar wording for the other tiers.** The mockup only gives "The Practice · 2 stacks + a free jar · $118". For the others the bar uses words already on the tiles: "First Light · 1 stack · $69" and "The Season · 3 stacks + free jar · $159". Editable per tier in the theme editor.
3. **Cart is cleared before the add.** Kept from v3 so checkout holds one Calm Stack line only. Say if it should go.
4. **Announcement bar.** The header group in this repo holds only the header. If the "reserve for $10" bar comes from an app embed or sits outside the header group, the hide rule will not catch it. Check on the preview.
5. **Black Friday copy is fixed text** (bar, kicker, dark box, tier lines, closing line, FAQ shipping dates). It needs an edit after 24 Dec. The Thanksgiving shipping answer dates sooner.
6. **Email form.** Set up the Shopify email for the tag `calm-stack-app-lead`. Shopify may show its captcha page after submit.
7. **Daily log.** GIT-RULES asks for a line in the daily log; it is not in this repo, so it was not written.

## Go-live steps (for Geordie)

1. Online Store > Themes > Add theme > Connect from GitHub > branch `shop/calm-stack-v2`. Preview `/products/calm-stack?view=calm-stack-v2`.
2. OK: squash-merge to main. Nothing changes for customers yet, because the product still uses the old template.
3. Products > The Calm Stack > Theme template > `calm-stack-v2`. Save. That is the go-live.
4. Same minute: end the pre-order in PreProduct for this product and remove the `pre-order` tag, so the app stops adding its deposit plan or button text.
5. Test with a real card: add to cart, reach checkout, confirm full price and no deposit line. Check Meta Events Manager > Test events for ViewContent, AddToCart and InitiateCheckout.
6. Rollback at any point: switch the template back (step 3). Full rollback: publish theme `backup-live-2026-11-24 (pre-order, before Calm Stack v2)`.
7. Tell Diksha it is live.
