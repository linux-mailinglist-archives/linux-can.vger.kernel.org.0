Return-Path: <linux-can+bounces-3119-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496F2A64F06
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BA17238A
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D123A566;
	Mon, 17 Mar 2025 12:36:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86C238D32;
	Mon, 17 Mar 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214998; cv=none; b=ZulFDYSZvVXxkV+Ew/uJS3s53L2cWP7kU+aa8cddPuy5rOFJu12kg0bnaDgBcXAwuQbMWnCnwH1upl5SDDjyHXM6YCBV2WO8lTC4a79XBdCQBEMcW33ULRNaJ9KxEQ69wuhz/j4HBtHp2F8h7NfBRX267zKqWauxgD4Y8G26la8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214998; c=relaxed/simple;
	bh=EgtAe31rU6EZ+Q8IPVD7kFBC1h3C26sTl48yIObSk58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9Z3XYO+U4gA9PQzQCqwGCTUp/dUJ/mfKpVUdenjGR+VFfs2aPe0Cmm0b3M+FCLueowlKOccA8fYMGmf2YblrTJX6I8VvMpy4iWM2AmuiNrSbTE7nOXqdQaLXcKlryNDZqn9E5zaftXCBRTh56XRV7jLBEYdeg5qEZT2Led15kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: SEv4VgHyTQ6wsA1xAcLkBg==
X-CSE-MsgGUID: YrRJvmPTSoSyH3ccC30VnQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A0470400262C;
	Mon, 17 Mar 2025 21:36:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 00/16] Add support for RZ/G3E CANFD
Date: Mon, 17 Mar 2025 12:35:54 +0000
Message-ID: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
and RZ/G2L, but differs in some hardware parameters:
 * No external clock, but instead has ram clock.
 * Support up to 6 channels.
 * 20 interrupts.

This patch series depend upon [1]
[1] https://lore.kernel.org/all/20250220094516.126598-1-biju.das.jz@bp.renesas.com/

v4->v5:
 * Collected tag from Geert.
 * The rules for R-Car Gen3/4 could be kept together, reducing the number
   of lines. Similar change for rzg2l-canfd aswell.
 * Keeping interrupts and resets together allows to keep a clear
   separation between RZ/G2L and RZ/G3E, at the expense of only
   a single line.
 * Retained the tags for binding patches as it is trivial changes.
 * Dropped the unused macro RCANFD_GAFLCFG_GETRNC.
 * Updated macro RCANFD_GERFL_ERR by using gpriv->channels_mask and
   dropped unused macro RCANFD_GERFL_EEF0_7.
 * Replaced RNC mask in RCANFD_GAFLCFG_SETRNC macro by using
   info->num_supported_rules variable.
 * Updated the macro RCANFD_GAFLCFG by using info->rnc_field_width
   variable.
 * Updated shift value in RCANFD_GAFLCFG_SETRNC macro by using a formula
   (32 - (n % rnc_per_reg + 1) * field_width).
 * Replaced the variable name shared_can_reg->shared_can_regs.
 * Improved commit description for patch{#11,#12}by replacing has->have.
 * Dropped RCANFD_EEF_MASK and RCANFD_RNC_MASK as it is taken
   care by gpriv->channels_mask and info->num_supported_rules.
 * Dropped RCANFD_FIRST_RNC_SH and RCANFD_SECOND_RNC_SH by using a
   formula (32 - (n % rnc_per_reg + 1) * rnc_field_width.
 * Improved commit description by "All SoCs supports extenal clock"->
   "All existing SoCs support an external clock".
 * Updated error description in probe as "cannot get enabled ram clock"
 * Updated r9a09g047_hw_info table.
v3->v4:
 * Added Rb tag from Rob for patch#2.
 * Added prefix RCANFD_* to enum rcar_canfd_reg_offset_id.
 * Added prefix RCANFD_* to enum rcar_canfd_mask_id.
 * Added prefix RCANFD_* to enum rcar_canfd_shift_id.
v2->v3:
 * Collected tags.
 * Dropped reg_gen4() and is_gen4() by adding mask_table, shift_table,
   regs, ch_interface_mode and shared_can_reg variables to
   struct rcar_canfd_hw_info.
v1->v2:
 * Split the series with fixes patch separately.
 * Added patch for Simplify rcar_canfd_probe() using
   of_get_available_child_by_name() as dependency patch hit on can-next.
 * Added Rb tag from Vincent Mailhol.
 * Dropped redundant comment from commit description for patch#3.


Biju Das (16):
  dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
  can: rcar_canfd: Use of_get_available_child_by_name()
  can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
  can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
  can: rcar_canfd: Add num_supported_rules variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add rnc_field_width variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Simplify RCANFD_GAFLCFG_SETRNC macro
  can: rcar_canfd: Add ch_interface_mode variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add shared_can_regs variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add register mapping table to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Add mask table to struct rcar_canfd_hw_info
  can: rcar_canfd: Add shift table to struct rcar_canfd_hw_info
  can: rcar_canfd: Add only_internal_clks variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Enhance multi_channel_irqs handling
  can: rcar_canfd: Add RZ/G3E support

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 171 +++++++++----
 drivers/net/can/rcar/rcar_canfd.c             | 238 ++++++++++++++----
 2 files changed, 314 insertions(+), 95 deletions(-)

-- 
2.43.0


