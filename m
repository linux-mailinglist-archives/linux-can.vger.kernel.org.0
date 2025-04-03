Return-Path: <linux-can+bounces-3361-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE7A7AA0B
	for <lists+linux-can@lfdr.de>; Thu,  3 Apr 2025 21:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA923B6AC7
	for <lists+linux-can@lfdr.de>; Thu,  3 Apr 2025 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAD2571D4;
	Thu,  3 Apr 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpWl2Wzy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC9253F17;
	Thu,  3 Apr 2025 19:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706974; cv=none; b=fH6mdbzemcyhwe00Y1cnyCBbKL7wC/lUAbX+cH1a5ZwgzRJlLWhy1D7vOaiQC671+wP6rlcRVAneh6cnltRj0tF7i2MGCZvF0Wu92aPPk798PJQ37/13sb4N05fdhozzCPVksrfbg+V129w5vpr4Y+PVQvUw5itfGGE1ClCy5Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706974; c=relaxed/simple;
	bh=orAlzYqfbkqjUnifq9+bENHRT8oQwBXPv8MWjX8Jfk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWNC0XFOHSInRjBXetWa+3AkWFucrg0cvmgfmSBOqxSsTu+E/tGF1cXfzZCh+ckZekGycfPH4KN2/4sYnVtvaJ6I6mhn3spBJMfGXwLq3K/+5dE/Fmk8gy6Q4Mi/htl1vtpX119eTBsnBjbPcHSKD+I6pS+BlW2jryPnWnXwCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpWl2Wzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC0C4CEEC;
	Thu,  3 Apr 2025 19:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706973;
	bh=orAlzYqfbkqjUnifq9+bENHRT8oQwBXPv8MWjX8Jfk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpWl2WzybbDy+aNnNTu+wd4UBoauFIwPjq11rdFY+HUvYp1DK1OO/A2F36jnPe83k
	 6+/vfIbzqCARO4lM+c1GxkWFRiMrqVWovgN/CqVnBpeWh58jCSkarYysWo1Ca6dTFM
	 rFBisyVNU9HsJOAMRhnnZd9fXMkNUawoxPzZKUNfLX2rMVN3gLpl/ydFtW84ZBUwDg
	 u2yChmKcB/GS5Dsuk2qeDYVe6Yz3xCZ5lfohwR5EgERqcUHNjMlj1H0DkWf74HoTPi
	 z5di29d7DJ6k9YdiglEonzgah62jidQIdICIJuaZ+IwnGIaBHuGjRw/+NYy3N1351j
	 qUUqf9tYis3Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mailhol.vincent@wanadoo.fr,
	haibo.chen@nxp.com,
	frank.li@nxp.com,
	u.kleine-koenig@baylibre.com,
	dimitri.fedrau@liebherr.com,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 18/54] can: flexcan: add NXP S32G2/S32G3 SoC support
Date: Thu,  3 Apr 2025 15:01:33 -0400
Message-Id: <20250403190209.2675485-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

[ Upstream commit 8503a4b1a24d32e95f3a233062e8f1dc0b2052bd ]

Add device type data for S32G2/S32G3 SoC.

FlexCAN module from S32G2/S32G3 is similar with i.MX SoCs, but interrupt
management is different.

On S32G2/S32G3 SoC, there are separate interrupts for state change, bus
errors, Mailboxes 0-7 and Mailboxes 8-127 respectively.
In order to handle this FlexCAN hardware particularity, first reuse the
'FLEXCAN_QUIRK_NR_IRQ_3' quirk provided by mcf5441x's irq handling
support. Secondly, use the newly introduced
'FLEXCAN_QUIRK_SECONDARY_MB_IRQ' quirk which handles the case where two
separate mailbox ranges are controlled by independent hardware interrupt
lines.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Link: https://patch.msgid.link/20250113120704.522307-4-ciprianmarian.costea@oss.nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan/flexcan-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 1a94586cbd11e..fca290afb5329 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -386,6 +386,16 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
+static const struct flexcan_devtype_data nxp_s32g2_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_SUPPORT_ECC | FLEXCAN_QUIRK_NR_IRQ_3 |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SECONDARY_MB_IRQ,
+};
+
 static const struct can_bittiming_const flexcan_bittiming_const = {
 	.name = DRV_NAME,
 	.tseg1_min = 4,
@@ -2055,6 +2065,7 @@ static const struct of_device_id flexcan_of_match[] = {
 	{ .compatible = "fsl,vf610-flexcan", .data = &fsl_vf610_devtype_data, },
 	{ .compatible = "fsl,ls1021ar2-flexcan", .data = &fsl_ls1021a_r2_devtype_data, },
 	{ .compatible = "fsl,lx2160ar1-flexcan", .data = &fsl_lx2160a_r1_devtype_data, },
+	{ .compatible = "nxp,s32g2-flexcan", .data = &nxp_s32g2_devtype_data, },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, flexcan_of_match);
-- 
2.39.5


