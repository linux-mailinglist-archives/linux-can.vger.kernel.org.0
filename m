Return-Path: <linux-can+bounces-2826-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2221DA39990
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97408165786
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40D23717F;
	Tue, 18 Feb 2025 10:50:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0313D51E;
	Tue, 18 Feb 2025 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739875819; cv=none; b=cOVgI/jppG7gRLMqVh5dziUPGN4b6wFA7P5agfjP2O8galh2wFZhcJ6NKYZReLxG3C+JrutEEBBAvMudni8yZ+eNC6DtB6uJcUQKBNJlMchX+fwK8/VIGjp7bBMLv12htiVpHMhvl5E4L2WdKNrzFSMVS/jTLHFDyzE5oICdk9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739875819; c=relaxed/simple;
	bh=cukJ0YpKR1kt8Y9Av4A4pHlmztUO8OZigwY0OI8Yu8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQUqro1eYwLZz2+eiFkY+2NKOmT6UgPmFOQvhev3zq/kYg5gXYr1cw9qpuNPDdYX9LEsptAa0NXcRq3iA+msK9JnLTn6S/AkLp3VTfm5szH6WB9sTRok2YQEyatVSDD/Ve+oMQQ4eUleVfi/aX9MrG6LBhUf9Eq5ew9VfKbCo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ydLRkTBhR9mxWRn+7xkR4w==
X-CSE-MsgGUID: HGdy3ZEoRriNBJMOUoAl7Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 18 Feb 2025 19:50:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.208])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD4B042A5EA4;
	Tue, 18 Feb 2025 19:50:09 +0900 (JST)
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
Subject: [PATCH 00/11] Add support for RZ/G3E CANFD
Date: Tue, 18 Feb 2025 10:49:50 +0000
Message-ID: <20250218105007.66358-1-biju.das.jz@bp.renesas.com>
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

Biju Das (11):
  clk: renesas: r9a09g047: Add CANFD clock/reset
  dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern properties
    for R-Car V4M
  dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
  can: rcar_canfd: Fix page entries in the AFL list
  can: rcar_canfd: Add gen4_type variable to struct rcar_canfd_hw_info
  can: rcar_canfd: Add only_internal_clks variable to struct
    rcar_canfd_hw_info
  can: rcar_canfd: Enhance multi_channel_irqs handling
  can: rcar_canfd: Add RZ/G3E support
  arm64: dts: renesas: r9a09g047: Add CANFD node
  arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 182 +++++++++++++-----
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  62 ++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  45 +++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  15 ++
 drivers/clk/renesas/r9a09g047-cpg.c           |  10 +
 drivers/net/can/rcar/rcar_canfd.c             |  46 +++--
 6 files changed, 305 insertions(+), 55 deletions(-)

-- 
2.43.0


