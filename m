Return-Path: <linux-can+bounces-2717-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509BFA26320
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 19:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A36161502
	for <lists+linux-can@lfdr.de>; Mon,  3 Feb 2025 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD02199236;
	Mon,  3 Feb 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZnXAcjP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441115530C;
	Mon,  3 Feb 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608937; cv=none; b=ofaR0wfVEQ09Ds/ZMGkUKWeo0wozGIRN+fibF5bN2Sdb9brVHQmVh1zDpWYke0lkM22mWxJs+3EzvAnVy/MLJbVo3SJBMdBHDfKQXpMN2mKCr26GmPveBjV/JQRM3xDIIS0V1nSQhcl2juZ8lvLlBeoR8pbT2nN46t1Tol+SrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608937; c=relaxed/simple;
	bh=cQdwqEISItC6zM0J7AR1idcKaygDDDljuSsFKU7b5IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcKFfFTTJiROIeEy8epomgVdhcIQtlAakDNQ5vpUgQIaJpQ3XyfBjvU9VC0z+r1knsi19aAb1pMFc1riFjdKHeZtFYKOThiyRJCR8MKBytwrjoYpd1c1lW4HQRF0tkL9ZgaHLJFkrgR6bfaPyxK7nZl0LWngcCv1oqOPtSn8aZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZnXAcjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E93AC4CED2;
	Mon,  3 Feb 2025 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738608936;
	bh=cQdwqEISItC6zM0J7AR1idcKaygDDDljuSsFKU7b5IE=;
	h=From:To:Cc:Subject:Date:From;
	b=AZnXAcjPL0qQtwpJhc9Ml5VpiNfyzHKIxktRVr1iD1OYS+KnpQ5zRn8nzNlLoNFWf
	 lVlYO4CYmWqOynyyR/V7WL3hioXW7UePo6HTzeoK539XsM0+snBEl9EGkzUlNsbFKP
	 zdwFs5v0bFxj4VQhEFfgv4xKfwWv8lOu/XiRMXfEMA2WS/9aB9UhGZJ4och0iTfcHi
	 a9pheLf014oopykBTBMsKHNng/La7toyBzRgVgyikOblzH6UG9hXLu6aw1IF9I9A85
	 YTKnNw3ZiHXVvE36hEJIi1pWGsrJPGRXijtoSSb2dPakndYKnHRnOdsAfO7V2wUrqo
	 Y1ZAYVN57WVFA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states" property presence check
Date: Mon,  3 Feb 2025 12:54:21 -0600
Message-ID: <20250203185421.3383805-2-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't matter whether "mux-states" is not present or there is some
other issue parsing it causing an error. Drop the presence check and
rework the error handling to ignore anything other than deferred probe.

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Now a warning in v6.14-rc1, so please apply for 6.14.

v2:
 - Use brackets on else clause
---
 drivers/phy/phy-can-transceiver.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index ee4ce4249698..2bec70615449 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -103,6 +103,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct phy *phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
 	int err;
 
@@ -113,13 +114,11 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
-	if (of_property_read_bool(dev->of_node, "mux-states")) {
-		struct mux_state *mux_state;
-
-		mux_state = devm_mux_state_get(dev, NULL);
-		if (IS_ERR(mux_state))
-			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
-					     "failed to get mux\n");
+	mux_state = devm_mux_state_get(dev, NULL);
+	if (IS_ERR(mux_state)) {
+		if (PTR_ERR(mux_state) == -EPROBE_DEFER)
+			return PTR_ERR(mux_state);
+	} else {
 		can_transceiver_phy->mux_state = mux_state;
 	}
 
-- 
2.47.2


