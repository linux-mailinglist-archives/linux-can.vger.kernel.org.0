Return-Path: <linux-can+bounces-2919-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 833DAA3ED76
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 08:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FBF19C2E00
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321781FFC4C;
	Fri, 21 Feb 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdCo/KrS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7961FF7B4;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123680; cv=none; b=sfXyG8gOndPNrRjOt7LRtnbWjp3E4978L/Oaa09ElYwmkdwaT4SjV2xTSjcQwQ5E6j/GPc39Vfx+wUk7IstxilnGcMlzCGh5kpBlSyEqc7Bu6btV0p16iRNKgtugkvs78IeDlEEq/To76KJ7N/Uyk3fcoFRKRAE+/dcVrjmSqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123680; c=relaxed/simple;
	bh=6jSgqIeR0c/xLJD5vzRfWmph7ikgHRiGHWzqjbobJj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fiDkjdqZIh+1u8mC7bB5C928C0oj7rGrU/3r6XK4vgqRP5m7rLfsUcM9rp1GoRjZejSE/phCuJBQzpJR4OITAD4ZMNk1Iv0M5hps+8VbX3wdOvsW1x8FOhDSiAOPuezW5CeHENXm0hwQoJM7VxDYeheIAClCLKAlSgCgUWo7ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdCo/KrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 627CCC4CEEE;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740123679;
	bh=6jSgqIeR0c/xLJD5vzRfWmph7ikgHRiGHWzqjbobJj8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AdCo/KrSd8m0YzM6OiLc2zfbZPj8+j1QzOqb6SzR0w+LtLIb4o/jKxXtM4IL38HiM
	 KZV9m67HHs/qICmcoxcKUZ5eLePbwfWPx6iur4F+I6fhaqdf+19ip+Y88rtudoQuPT
	 pbNfUwul5J6pVlzh57NCM5Ut0uYKOTQI66p9vxaF97vAGV8YjpLzL+sd2ipdFl0/E+
	 r0yPAxx3UN3kIVjcB4D8PVT4jKvLfO26nNGwmB9iIa0mgYaV8nnKY+68r/3m+LcVCp
	 WPpbEjBdPZ0RgoAGvczPetbijxYsk8zbYcT6fLzO8YEZ6ogK/8Zyl3ArR4KcNNep+A
	 3q4R6SFe2ASVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA4DC021AA;
	Fri, 21 Feb 2025 07:41:19 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v3 0/2] can: flexcan: add transceiver capabilities
Date: Fri, 21 Feb 2025 08:40:03 +0100
Message-Id: <20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMtuGcC/4XNsQ6CMBSF4Vchna25tyKlTr6HcWjLrTRBIC1pM
 IR3tzAZBx3/M3xnYZGCp8guxcICJR/90Oc4HQpmW90/iPsmNxMgShSguOtotrrnumn4FHQfLfl
 EgVs9Ri6tc6oEsEpULBNjIOfnnb/dc7c+TkN47W8Jt3WDzyAQf8MJOXBbaWNkjdKAu3aeTEshH
 O3wZJudxIcn4I8nsqdrVBIcYl1WX966rm9se3khGwEAAA==
X-Change-ID: 20241209-flexcan-add-transceiver-caps-7cff9400c926
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740123678; l=1632;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=6jSgqIeR0c/xLJD5vzRfWmph7ikgHRiGHWzqjbobJj8=;
 b=qzOLZ9cXPue92g9sUo39JYmSXkvp/5FgZFy5Bg7sW9iFjdTL/jxrICP0c9+q6ELMqGf/NRiN/
 Arkr4WgzQ13DhEhAcn1wLfwyxXewGGr2uB1vNwBBrSbGbyzR/1xJHud
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY. Add
the capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Have xceiver-supply or phys properties in bindings
- Switch do dev_err_probe in flexcan_probe when checking error of call
  devm_phy_optional_get
- Link to v2: https://lore.kernel.org/r/20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com

Changes in v2:
- Rename variable xceiver to transceiver in struct flexcan_priv and in
  flexcan_probe
- Set priv->can.bitrate_max if transceiver is found
- Fix commit messages which claim that transceivers are not supported
- Do not print error on EPROBE_DEFER after calling devm_phy_optional_get in
  flexcan_probe
- Link to v1: https://lore.kernel.org/r/20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: can: fsl,flexcan: add transceiver capabilities
      can: flexcan: add transceiver capabilities

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   | 15 ++++++++++++
 drivers/net/can/flexcan/flexcan-core.c             | 27 +++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h                  |  1 +
 3 files changed, 37 insertions(+), 6 deletions(-)
---
base-commit: 6a24171b9625471abfc90c7b28c4b45bee64b3a4
change-id: 20241209-flexcan-add-transceiver-caps-7cff9400c926

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



