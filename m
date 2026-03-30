Return-Path: <linux-can+bounces-7300-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBylMP1wymnG8gUAu9opvQ
	(envelope-from <linux-can+bounces-7300-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 14:47:57 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 197E435B435
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A1EF30B8242
	for <lists+linux-can@lfdr.de>; Mon, 30 Mar 2026 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7E3D1CA5;
	Mon, 30 Mar 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXY0aouk"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC53D1CD2;
	Mon, 30 Mar 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874358; cv=none; b=rJaHedqXf+vWa+lgZHOWMwKmkeHInXzmny967SkTLgfvyMIMKP73OWKjyrWbvFpyrkFGb+dEcfTpitTfNEWooca21+Uhs3EhdjuHfy0fZ4MYqSm7c+IxR8Qcd9t7gAf4uAmlgk1br6kxXvj5SA6FK3YRuJffPdp1E9dNFiLbVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874358; c=relaxed/simple;
	bh=FZXYNhFoXA1WXvQf3jCo3+bbj9MBepKSUhsOMz/+rVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctK0QZciTzJZlP5M5yhAywZ2HsgRvI4d7zjHfH3HHWMLzXUeF+P4qVap1LdFGqnqSMOm+8PPEFgN5oFZmmxLyr/dcG2D5LYP90qaIjOaALLtHYn2brS6ab+tapn0A2PpnTci69gkA42nADWNHExq4kEZ78+6PCa6bBlB7jJBg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXY0aouk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43221C2BCB2;
	Mon, 30 Mar 2026 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774874358;
	bh=FZXYNhFoXA1WXvQf3jCo3+bbj9MBepKSUhsOMz/+rVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXY0aouk3Ks30hTM2PygVb2NQ2eQzdUP8KwIOeMXizogm5fnM/EG8Fj1oj9yAHBLk
	 GEcwwkBCJOABw7m5zB2gg2/bUFvqDl9DbDmBAFPZ0A9RjgOqrrOuETASYFF7W0J+/5
	 h8nV68R1wvVBbvI0mngxOKgmhh72IS9Sqov8KdpxDB6fqp2BSbPp0tQBBEcWOHRK2G
	 mku1QzMuvWqAtOgu9tHD0/t5D8D5JcccXwhvwuNrwVVq4TEJsDJ0OcAcUvX21R3h7H
	 W15zNBqA44dNp1hHCYgwcW8XJ50TVUIOuIoKwoHePePG5GTf3PI5MCxqxKpXhUcndU
	 QcehGSgndmKww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wenyuan Li <2063309626@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mailhol@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] can: mcp251x: add error handling for power enable in open and resume
Date: Mon, 30 Mar 2026 08:38:37 -0400
Message-ID: <20260330123842.756154-24-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330123842.756154-1-sashal@kernel.org>
References: <20260330123842.756154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[qq.com,pengutronix.de,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7300-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 197E435B435
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wenyuan Li <2063309626@qq.com>

[ Upstream commit 7a57354756c7df223abe2c33774235ad70cb4231 ]

Add missing error handling for mcp251x_power_enable() calls in both
mcp251x_open() and mcp251x_can_resume() functions.

In mcp251x_open(), if power enable fails, jump to error path to close
candev without attempting to disable power again.

In mcp251x_can_resume(), properly check return values of power enable calls
for both power and transceiver regulators. If any fails, return the error
code to the PM framework and log the failure.

This ensures the driver properly handles power control failures and
maintains correct device state.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
Link: https://patch.msgid.link/tencent_F3EFC5D7738AC548857B91657715E2D3AA06@qq.com
[mkl: fix patch description]
[mkl: mcp251x_can_resume(): replace goto by return]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a comprehensive analysis.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

### Step 1.1: Parse the Subject Line
Record: [Subsystem: can: mcp251x] [Action verb: add] [Summary: add error
handling for `mcp251x_power_enable()` return values in `mcp251x_open()`
and `mcp251x_can_resume()`]

### Step 1.2: Parse All Commit Message Tags
Record:
- **Signed-off-by:** Wenyuan Li <2063309626@qq.com> (author)
- **Link:** `https://patch.msgid.link/tencent_F3EFC5D7738AC548857B916577
  15E2D3AA06@qq.com`
- `[mkl: fix patch description]` — Marc Kleine-Budde (CAN subsystem
  maintainer) edited the description
- `[mkl: mcp251x_can_resume(): replace goto by return]` — maintainer
  restructured the resume error path
- **Signed-off-by:** Marc Kleine-Budde <mkl@pengutronix.de> (CAN
  subsystem maintainer)
- No Fixes: tag (expected for manual review candidates)
- No Reported-by: (code inspection find)
- No Tested-by:, Reviewed-by:, Acked-by:, Cc: stable

Notable pattern: CAN subsystem maintainer actively modified the patch,
indicating hands-on review and approval.

### Step 1.3: Analyze the Commit Body Text
Record: Bug description — `mcp251x_power_enable()` return values are
ignored in both `mcp251x_open()` and `mcp251x_can_resume()`. In
`open()`, failure to enable the transceiver regulator allows the driver
to proceed with IRQ/SPI setup on unpowered hardware. The error path at
`out_close` then calls `mcp251x_power_enable(transceiver, 0)`, which
attempts to disable a regulator that was never enabled (unbalanced
disable). In `resume()`, regulator failures are silently ignored and
success is returned to the PM framework, allowing restart work to
proceed on failed hardware. No stack trace or specific user report
referenced.

### Step 1.4: Detect Hidden Bug Fixes
Record: This is an explicit error-handling bug fix, not hidden. "Add
error handling" directly addresses missing return-value checks and
incorrect cleanup. The phrase "ensures the driver properly handles power
control failures and maintains correct device state" confirms it is
fixing incorrect behavior.

---

## PHASE 2: DIFF ANALYSIS — LINE BY LINE

### Step 2.1: Inventory the Changes
Record:
- **Files:** `drivers/net/can/spi/mcp251x.c` (single file)
- **Net change:** approximately +23/-5 lines
- **Functions modified:** `mcp251x_open()`, `mcp251x_can_resume()`
- **Scope classification:** single-file, two-function, surgical fix

### Step 2.2: Understand the Code Flow Change

**Hunk 1 — `mcp251x_open()`:**
- **Before:** `mcp251x_power_enable(priv->transceiver, 1)` — return
  value discarded. On failure, driver proceeds with IRQ request, SPI
  setup, etc. All error paths fall through `out_close` which calls
  `mcp251x_power_enable(priv->transceiver, 0)`.
- **After:** Return value checked; on failure, jumps to new
  `out_close_candev` label that skips the transceiver disable (correct —
  don't disable what was never enabled) and goes directly to
  `close_candev(net)` + mutex_unlock.

**Hunk 2 — `mcp251x_can_resume()`:**
- **Before:** Both `mcp251x_power_enable(priv->power, 1)` and
  `mcp251x_power_enable(priv->transceiver, 1)` return values discarded.
  PM framework always told success. `queue_work`, `force_quit = 0`,
  `enable_irq` all proceed unconditionally.
- **After:** Each call checked. On power failure, return error
  immediately. On transceiver failure, roll back power (disable it if it
  was just enabled), then return error. PM framework gets actual error
  code.

### Step 2.3: Identify the Bug Mechanism

Record: **Bug category:** Error-path / logic correctness / regulator
state imbalance.

**Concrete bugs verified:**

1. **Regulator framework WARN() trigger**: I verified in
   `drivers/regulator/core.c` at line 3179:

```3179:3181:drivers/regulator/core.c
        if (WARN(regulator->enable_count == 0,
                 "unbalanced disables for %s\n", rdev_get_name(rdev)))
                return -EIO;
```

If `regulator_enable()` fails in `mcp251x_open()`, the `enable_count`
stays at 0. Then the error path at `out_close` calls
`mcp251x_power_enable(priv->transceiver, 0)` → `regulator_disable()` →
hits `enable_count == 0` → **triggers WARN()**.

2. **Silent resume failure**: `mcp251x_can_resume()` returns 0 (success)
   to PM framework even when power enable fails. The driver then queues
   `restart_work`, clears `force_quit`, and re-enables IRQs — all
   operating under the assumption that hardware is powered.

3. **Scope limiter**: `mcp251x_power_enable()` returns 0 for
   `IS_ERR_OR_NULL(reg)` (verified at line 951), so the bug only
   manifests on systems with real regulator-backed `vdd`/`xceiver`
   supplies.

### Step 2.4: Assess the Fix Quality
Record: The fix is obviously correct — standard error checking and
rollback patterns matching the existing `mcp251x_can_probe()` style
(which already checks `mcp251x_power_enable(priv->power, 1)` at line
1394). The fix is minimal and surgical. Regression risk is extremely low
— only error paths are affected, and those paths were previously broken.
The CAN subsystem maintainer personally modified the patch.

---

## PHASE 3: GIT HISTORY INVESTIGATION

### Step 3.1: Blame the Changed Lines
Record: `git blame` confirms:
- Line 1228: unchecked `mcp251x_power_enable(priv->transceiver, 1)` in
  `open()` introduced by commit `1ddff7da0faecf` (Alexander Shiyan,
  2013-08-19, "can: mcp251x: Replace power callbacks with regulator
  API").
- Lines 1520-1523: unchecked enables in `resume()` from `1ddff7da0faecf`
  and `25b401c1816ae6` (Stefan Agner, 2015).
- `git describe --contains 1ddff7da0faecf` → `v3.12-rc1~132^2~209^2~2` —
  the buggy code has been present since kernel v3.12 (2013). This means
  **all active stable trees** contain the buggy code.

### Step 3.2: Follow the Fixes: Tag
Record: No Fixes: tag present. N/A.

### Step 3.3: Check File History for Related Changes
Record: `git log --oneline -20 -- drivers/net/can/spi/mcp251x.c` shows
related commits:
- `e728f444c913a`: "can: mcp251x: fix deadlock in error path of
  mcp251x_open" — this restructured the error path to use `release_irq`
  / deferred `free_irq()`. The candidate patch's new `out_close_candev`
  label is designed to fit this structure.
- `7dd9c26bd6cf6`: earlier deadlock fix for `mcp251x_open`
- `b1a09b63684ce`: "mcp251x_can_probe(): add missing unregister_candev()
  in error path" — another error-path fix in same file

No evidence this patch is part of a multi-patch series. It is
standalone.

### Step 3.4: Check the Author's Other Commits
Record: `git log --oneline --author='Wenyuan Li' -- drivers/net/can/`
shows:
- `de39b9320ab36`: "can: hi311x: hi3110_open(): add check for
  hi3110_power_enable() return value" — the identical class of fix
  applied to a sibling SPI CAN driver. This commit has already been
  backported to stable (confirmed by the `[Upstream commit ...]` marker
  and Sasha Levin's SOB in `git show`). This establishes a clear
  pattern: the author is systematically fixing unchecked power-enable
  returns across CAN SPI drivers, and the maintainer and stable tree are
  accepting them.

### Step 3.5: Check for Dependent/Prerequisite Commits
Record: The `mcp251x_open()` error path structure depends on commit
`e728f444c913a` (which introduced the `release_irq` pattern and the
current `out_close`/`out_free_irq` layout). This prerequisite is present
in the current tree.

For older stable trees (v5.15, v6.1, v6.6), I verified the `open()`
error path still has the older structure (direct `free_irq()` inside
`out_free_irq` without the deferred pattern). The resume-path changes
should apply cleanly to all trees. The open-path portion may need minor
context adaptation on trees without `e728f444c913a`.

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

### Step 4.1-4.4: Lore Search
Record: Lore.kernel.org is behind anti-bot protection and could not be
accessed. However:
- The CAN subsystem maintainer Marc Kleine-Budde actively edited and
  restructured the patch (documented in commit message), confirming
  hands-on review
- The sibling `hi311x` fix by the same author was accepted and
  backported to stable
- `git log --oneline --grep='mcp251x.*power'` returned no hits —
  confirming no prior fix for this specific issue exists

---

## PHASE 5: CODE SEMANTIC ANALYSIS

### Step 5.1: Key Functions
Record: `mcp251x_open()`, `mcp251x_can_resume()`,
`mcp251x_power_enable()`

### Step 5.2: Trace Callers
Record:
- `mcp251x_open()` is registered as `.ndo_open = mcp251x_open` in
  `mcp251x_netdev_ops` (line 1283). Called when user runs `ip link set
  canX up` — standard interface bring-up path.
- `mcp251x_can_resume()` is registered via
  `SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
  mcp251x_can_resume)` (line 1535). Called by PM framework on system
  resume.

### Step 5.3: Trace Callees
Record: `mcp251x_power_enable()` wraps
`regulator_enable()`/`regulator_disable()` (lines 949-958). Returns 0
for NULL/error regulators (limiting scope to real regulator setups).

### Step 5.4: Call Chain Reachability
Record: Both paths are reachable from standard operations:
- `open()`: userspace/admin brings up CAN interface
- `resume()`: PM framework resumes the SPI device after system suspend
Both are realistic, common operations on embedded systems using MCP251x
with regulator-managed power rails.

### Step 5.5: Similar Patterns
Record: The probe function (`mcp251x_can_probe()`) at line 1394 already
properly checks `mcp251x_power_enable(priv->power, 1)` with error
handling. The candidate patch aligns `open()` and `resume()` with this
existing correct pattern. The identical bug in sibling driver `hi311x`
was already fixed (`de39b9320ab36`).

---

## PHASE 6: STABLE TREE ANALYSIS

### Step 6.1: Does the Buggy Code Exist in Stable Trees?
Record: **Yes.** Verified with `git show
<tag>:drivers/net/can/spi/mcp251x.c | rg 'mcp251x_power_enable'`:
- **v5.15:** unchecked `mcp251x_power_enable(priv->transceiver, 1)` at
  line 1208 (open) and lines 1482-1484 (resume)
- **v6.1:** same at lines 1215, 1491-1493
- **v6.6:** same at lines 1215, 1491-1493

The buggy code was introduced in v3.12 (2013) and is present in **all
active stable trees**.

### Step 6.2: Backport Complications
Record:
- **Resume path:** Should apply cleanly to all stable trees — the code
  structure is essentially identical
- **Open path:** Requires minor adaptation on v5.15/v6.1/v6.6 because
  those trees have the older `mcp251x_open()` error structure (without
  the `release_irq`/deferred `free_irq` pattern from `e728f444c913a`).
  The `out_close_candev` label placement would need adjustment.
- Overall difficulty: **clean for resume; minor conflicts for open**

### Step 6.3: Related Fixes Already in Stable
Record: No existing fix for this specific issue found. `git log
--oneline --grep='mcp251x.*power'` returned no results.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

### Step 7.1: Subsystem Criticality
Record: CAN networking, SPI driver (`drivers/net/can/spi/mcp251x.c`).
Criticality: **IMPORTANT** for embedded/industrial/automotive CAN users.
The MCP2510/MCP2515/MCP25625 are among the most popular SPI CAN
controllers.

### Step 7.2: Subsystem Activity
Record: The file has 20+ recent commits. Active subsystem with ongoing
maintenance (deadlock fixes, probe fixes, etc.). Mature code with the
specific bug present since 2013.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

### Step 8.1: Affected Users
Record: **Driver-specific + config-specific.** Users of MCP251x CAN
controllers with regulator-backed `vdd` and/or `xceiver` supplies.
`mcp251x_power_enable()` returns 0 for `IS_ERR_OR_NULL(reg)`, so systems
without real regulators are unaffected. Typical use case:
embedded/industrial/automotive CAN systems.

### Step 8.2: Trigger Conditions
Record:
- **Open path:** Triggered when transceiver regulator fails to enable
  (hardware fault, supply issue, GPIO unavailability, deferred
  regulator)
- **Resume path:** Triggered when power/transceiver regulator fails
  during system resume (battery issues, regulator constraints)
- These are realistic on embedded systems. Not a constant trigger but a
  real-world scenario.

### Step 8.3: Failure Mode Severity
Record:
- **Kernel WARN() trigger** from regulator framework on the unbalanced
  disable path in `open()` — **MEDIUM** (kernel warning, noisy logs,
  stack trace output)
- **Silent PM resume failure** — PM framework believes success while
  hardware is unpowered — **MEDIUM-HIGH** (restart_work handler performs
  SPI operations on unpowered hardware, device non-functional after
  resume without any error indication)
- **Regulator state corruption** — enable_count imbalance can affect
  future operations — **MEDIUM**

Overall severity: **MEDIUM**

### Step 8.4: Risk-Benefit Ratio
Record:
- **Benefit:** Prevents kernel WARN(), prevents silent resume failures,
  maintains regulator state consistency, aligns with existing probe-path
  error handling. **Moderate-to-high benefit.**
- **Risk:** ~20 lines of standard error handling in one file, only
  affects failure paths that were previously broken, reviewed by
  subsystem maintainer. **Very low risk.**
- **Ratio:** Strongly favorable for backport.

---

## PHASE 9: FINAL SYNTHESIS

### Step 9.1: Compile the Evidence

**Evidence FOR backporting:**
- Fixes concrete kernel WARN() trigger (verified: regulator
  `enable_count == 0` → WARN in `drivers/regulator/core.c:3179`)
- Fixes silent PM resume failure (PM framework told success while
  hardware is unpowered)
- Fixes regulator state imbalance (unbalanced disable in error path)
- Small, surgical, single-file fix (~20 lines)
- Reviewed and actively modified by CAN subsystem maintainer Marc
  Kleine-Budde
- Sibling hi311x driver fix by same author already backported to stable
  (`de39b9320ab36`)
- Buggy code present in all stable trees since v3.12 (2013)
- Aligns with existing probe-path error handling pattern in same driver
- Standard error-handling patterns — obviously correct

**Evidence AGAINST backporting:**
- No user-reported crash or syzbot report (found by code inspection)
- Trigger requires regulator-enable failure (specific hardware
  conditions)
- Open-path portion may need minor context adaptation on older stable
  trees
- Severity is MEDIUM, not CRITICAL

**Unresolved:**
- Lore.kernel.org discussion not accessible (anti-bot protection)
- Exact applicability to stable trees older than v5.15 not verified

### Step 9.2: Stable Rules Checklist
1. **Obviously correct and tested?** YES — standard error handling,
   maintainer-reviewed and modified
2. **Fixes a real bug?** YES — verified WARN() trigger from regulator
   framework, silent PM resume failure
3. **Important issue?** YES — kernel warning, incorrect PM behavior,
   regulator state corruption (MEDIUM severity)
4. **Small and contained?** YES — ~20 lines in one file, two functions
5. **No new features or APIs?** YES — purely error handling
6. **Can apply to stable trees?** YES for resume path (clean); minor
   adaptation needed for open path on older trees

### Step 9.3: Exception Categories
Record: Not applicable. This is a standard bug fix, not a device ID,
quirk, DT update, build fix, or documentation fix.

### Step 9.4: Decision
The fix addresses verified, concrete bugs (regulator framework WARN
trigger, silent PM resume failure, regulator state corruption), is small
and obviously correct, was reviewed by the subsystem maintainer, and the
identical class of fix for the sibling driver was already backported to
stable. The risk-benefit ratio is strongly favorable. The buggy code has
been present since v3.12 and affects all active stable trees.

---

## Verification

- **[Phase 1]** Parsed all tags from provided commit message: Signed-
  off-by (author + maintainer), Link, maintainer edit notes. No
  Fixes/Reported-by/Cc stable.
- **[Phase 2]** Read current `mcp251x_open()` and `mcp251x_can_resume()`
  in `drivers/net/can/spi/mcp251x.c`; confirmed unchecked
  `mcp251x_power_enable()` calls at lines 1228, 1520-1523
- **[Phase 2]** Read `mcp251x_power_enable()` at lines 949-958;
  confirmed returns 0 for `IS_ERR_OR_NULL(reg)` — bug scope limited to
  real regulator setups
- **[Phase 2]** Verified regulator WARN trigger:
  `drivers/regulator/core.c` line 3179 — `WARN(regulator->enable_count
  == 0, "unbalanced disables for %s\n", ...)` — fires when `out_close`
  calls disable on never-enabled regulator
- **[Phase 2]** Read current error path in `open()` at lines 1260-1279:
  confirmed `out_close` calls `mcp251x_power_enable(priv->transceiver,
  0)` unconditionally
- **[Phase 3]** `git blame -L 1208,1290`: confirmed unchecked
  transceiver enable from `1ddff7da0faecf` (2013-08-19)
- **[Phase 3]** `git blame -L 1500,1560`: confirmed unchecked resume
  enables from `1ddff7da0faecf` and `25b401c1816ae6`
- **[Phase 3]** `git describe --contains 1ddff7da0faecf` →
  `v3.12-rc1~132^2~209^2~2` — buggy code introduced before v3.12
- **[Phase 3]** `git show --stat 1ddff7da0faecf`: confirmed this was the
  regulator API conversion that introduced `mcp251x_power_enable()`
  usage
- **[Phase 3]** `git log --oneline -20 --
  drivers/net/can/spi/mcp251x.c`: confirmed related deadlock fixes
  `e728f444c913a` and `7dd9c26bd6cf6`
- **[Phase 3]** `git log --oneline --author='Wenyuan Li' --
  drivers/net/can/`: found sibling fix `de39b9320ab36` (hi311x)
- **[Phase 3]** `git show de39b9320ab36`: confirmed identical class of
  fix, already backported to stable (has Upstream commit marker and
  Sasha Levin SOB)
- **[Phase 3]** `git log --oneline --grep='mcp251x.*power'`: no prior
  fix for this specific issue exists
- **[Phase 4]** Lore.kernel.org: blocked by anti-bot protection;
  maintainer edits in commit message confirm review
- **[Phase 5]** Verified `mcp251x_open` is `ndo_open` callback (line
  1283); `mcp251x_can_resume` registered via `SIMPLE_DEV_PM_OPS` (line
  1535)
- **[Phase 5]** Confirmed `mcp251x_can_probe()` at line 1394 already
  checks `mcp251x_power_enable(priv->power, 1)` — this fix aligns
  open/resume with probe
- **[Phase 6]** `git show v5.15:drivers/net/can/spi/mcp251x.c | rg
  mcp251x_power_enable`: confirmed unchecked calls exist in v5.15
- **[Phase 6]** `git show v6.1:drivers/net/can/spi/mcp251x.c | rg
  mcp251x_power_enable`: confirmed unchecked calls exist in v6.1
- **[Phase 6]** `git show v6.6:drivers/net/can/spi/mcp251x.c | rg
  mcp251x_power_enable`: confirmed unchecked calls exist in v6.6
- **[Phase 6]** Inspected v5.15 `mcp251x_open()` error path: confirmed
  older structure (direct `free_irq` in `out_free_irq`, no `release_irq`
  pattern) — open-path portion needs minor adaptation for older trees
- **[Phase 6]** Inspected v5.15 `mcp251x_can_resume()`: confirmed
  identical unchecked pattern — resume-path portion should apply cleanly
- **[Phase 8]** Failure mode: regulator WARN() on error path (MEDIUM),
  silent PM resume failure (MEDIUM-HIGH), overall MEDIUM severity
- **UNVERIFIED:** Full lore.kernel.org patch discussion and any explicit
  stable nominations by reviewers (anti-bot blocked). Applicability to
  stable trees older than v5.15.

**YES**

 drivers/net/can/spi/mcp251x.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f401..0d0190ae094a1 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PTR(ret));
+		goto out_close_candev;
+	}
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
+out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	if (release_irq)
@@ -1516,11 +1521,25 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore power: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore transceiver power: %pe\n", ERR_PTR(ret));
+			if (priv->after_suspend & AFTER_SUSPEND_POWER)
+				mcp251x_power_enable(priv->power, 0);
+			return ret;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
-- 
2.53.0


