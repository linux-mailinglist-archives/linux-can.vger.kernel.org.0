Return-Path: <linux-can+bounces-2516-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3EB9FF0B3
	for <lists+linux-can@lfdr.de>; Tue, 31 Dec 2024 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA383A28A1
	for <lists+linux-can@lfdr.de>; Tue, 31 Dec 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A319D89B;
	Tue, 31 Dec 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF4GFi8M"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52E19D06E;
	Tue, 31 Dec 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735662786; cv=none; b=XREbq7Q/ogocL+ecjlW3nRCz94WCqkA/i4BOWIicpLuBWt6nK4CkS9Q29sXzJyBw6lFACumH5zow+iI3q8/UW+7Q5+97+f8JbZMW5tHvzy2ByVVNe3QX+W/XYEqYP19PkN6o1Iu0IwOgKZDW6c7bteUojJkNhZGBW/7y5xEHVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735662786; c=relaxed/simple;
	bh=o0hR1NQpAKxq1IPLzu/NabrShb8lQvp0/ggSu0lB1TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H91xW0kJnWGSAxGbqOGMCyLIug/6E22Pfm0e/HF9cyjbZ3zciQd8EBILO6XvHevUL9+5h2ZWqNH0/bf1qumOz6bMNpvcQ74cmF9vKdr84cWZ4HU+eiGkN9K4YMOJ/Ad+gbPhELVeeBUCI93eC0LKbL/5EBFZYe+OlHv7GPHA9z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF4GFi8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F9C4CED2;
	Tue, 31 Dec 2024 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735662785;
	bh=o0hR1NQpAKxq1IPLzu/NabrShb8lQvp0/ggSu0lB1TI=;
	h=From:To:Cc:Subject:Date:From;
	b=vF4GFi8MEqFfJLpX2HzNUWDu+14/yG7FzKeh8K5QCsLWWsasnxLJiVXclVn6qH7pf
	 9g+ZLbueFzFCgtVRj7dTYBexZON/iUhU9ubhs1GuU+YXZPXQN0lgVI+F3EyIURz4fy
	 /aIfC1lRR61vA6QpqYAVry1lvoP9EnbQ+t0y3lNOtnYvyoIzqhcpN5VVHT95oQNM8Z
	 uWBDpbI7HNeOA0Kyh7JVUuUmqS/BIuI0FUTVE/ZmmEsh/dDkbfos4bLyq++kvA67Ov
	 1nZo37f2FBLTlxR86wSMojkWYJXPWTsO8IikTUiFJa9Y3Io/parmdLAGyLf2kWRmBB
	 eLM68YriNvduw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: can-transceiver: Drop unnecessary "mux-states" property presence check
Date: Tue, 31 Dec 2024 10:32:51 -0600
Message-ID: <20241231163251.244167-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/phy/phy-can-transceiver.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index ee4ce4249698..ed8ba30eb038 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -103,6 +103,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct phy *phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct mux_state *mux_state;
 	u32 max_bitrate = 0;
 	int err;
 
@@ -113,15 +114,12 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
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
+	} else
 		can_transceiver_phy->mux_state = mux_state;
-	}
 
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
-- 
2.45.2


