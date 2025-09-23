Return-Path: <linux-can+bounces-4840-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF9B94711
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BED07A6FD4
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294B30FC2B;
	Tue, 23 Sep 2025 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmKtQQNH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5F30FC29;
	Tue, 23 Sep 2025 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606057; cv=none; b=TXciRNyWWYqjo7L2qo7xpvRxFQYYaLRcBzEYSYLJudRkZCX9tSpFgY1evjSyHhFyWTw0URY3KT+CLeYU92F1Ut1oJbhE/8ZYz7fH2bLcYU5/XMKTtEP1Iq41tDQPXoSYMT7p5hl/UV1uMvnzS2quKkSoC2POLbL54VyMihMi53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606057; c=relaxed/simple;
	bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLn2CVcSeP9heii42op1io60FQAmUJQZwPyAAdiNorfd4K9J1bWhLso/v2Xl43ZeYQTnaPxirqlZ3xIxvttFe3aPyoyR1CTbtGjsCOZTiE5Z9Btqls1aGoPXv4gAj6XBJN47m79q4ZIRC17/Qdav6BJww1eLmlAFyXbtecwLtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmKtQQNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333CAC113CF;
	Tue, 23 Sep 2025 05:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606056;
	bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WmKtQQNHH2q+X6XReURbnoQ9LwnToMRv9NExyG6S8hIJtL/MDlUqF26iwqxHAaB4l
	 6/9XHB9GY7uOIuUYVQliz1Kx106pwTAymfTw0w6wIJZPxXdwnEtyor2qjukm5fRJgC
	 C4ThXX8nl6AHW9s2fr+UADLKTIgIRvdJk1y094QoHPAlF1EFMIs90+gEma00RuxgKZ
	 Y3lxYJHCcdR6JKNGGyAjZXdtVZbcptQZzGZ4exRfIFUdRMhhmE19zK+PKbpoHhoyiY
	 hL5Z7L2CoZgE9DQd3syUHHpTgiWPczXRXsztmnINqgkGViMQeNjpusI0bdfcBb/2a7
	 RvxZ25mQv7klA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:41 +0900
Subject: [PATCH v3 06/20] can: netlink: add can_validate_databittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-6-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjLazq0dwBiZkBrxm61CP26w6NT3i9RGPFVc/vA92s
 +hb8nNFRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkcOsjwT3O3idf2DM1AnsUL
 v2jK1XQyWAf47NuUbchZdJf9iKJDGMNfwbce7Ir3/uWK3mo3cA/cu66v4eW1MMfjK6M/CEvZ3Dr
 JDAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Factorise the databittiming validation out of can_validate() and move
it in the new add can_validate_databittiming() function. Also move
can_validate()'s comment because it is specific to CAN FD. This is a
preparation patch for the introduction of CAN XL as this databittiming
validation will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - Move can_validate()'s comment block to
    can_validate_databittiming(). Consequently, the next patch

      can: netlink: remove comment in can_validate()

    is removed.

  - Change WARN_ON(1) into return -EOPNOTSUPP to suppress a gcc
    warning.
    Link: https://lore.kernel.org/linux-can/202509050259.NjPdQyAD-lkp@intel.com/
---
 drivers/net/can/dev/netlink.c | 64 +++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 25c08adee9ade22a5dabdd3dec1b5eb1ee16a78e..549a2247d847dd26c8cb8c76ecb609256f549eb2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -100,10 +100,13 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	return 0;
 }
 
-static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
+static int can_validate_databittiming(struct nlattr *data[],
+				      struct netlink_ext_ack *extack,
+				      int ifla_can_data_bittiming, u32 flags)
 {
-	bool is_can_fd = false;
+	struct nlattr *data_tdc;
+	u32 tdc_flags;
+	bool is_on;
 	int err;
 
 	/* Make sure that valid CAN FD configurations always consist of
@@ -113,35 +116,56 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	 * - TDC parameters are coherent (details in can_validate_tdc())
 	 */
 
+	if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
+		data_tdc = data[IFLA_CAN_TDC];
+		tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
+		is_on = flags & CAN_CTRLMODE_FD;
+	} else {
+		return -EOPNOTSUPP; /* Place holder for CAN XL */
+	}
+
+	if (is_on) {
+		if (!data[IFLA_CAN_BITTIMING] || !data[ifla_can_data_bittiming])
+			return -EOPNOTSUPP;
+	}
+
+	if (data[ifla_can_data_bittiming] || data_tdc) {
+		if (!is_on)
+			return -EOPNOTSUPP;
+	}
+
+	err = can_validate_bittiming(data, extack, ifla_can_data_bittiming);
+	if (err)
+		return err;
+
+	err = can_validate_tdc(data_tdc, extack, tdc_flags);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int can_validate(struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	u32 flags = 0;
+	int err;
+
 	if (!data)
 		return 0;
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
-		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
-
-		err = can_validate_tdc(data[IFLA_CAN_TDC], extack,
-				       cm->flags & CAN_CTRLMODE_FD_TDC_MASK);
-		if (err)
-			return err;
+		flags = cm->flags & cm->mask;
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
 	if (err)
 		return err;
 
-	if (is_can_fd) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
-			return -EOPNOTSUPP;
-	}
-
-	if (data[IFLA_CAN_DATA_BITTIMING] || data[IFLA_CAN_TDC]) {
-		if (!is_can_fd)
-			return -EOPNOTSUPP;
-	}
-
-	err = can_validate_bittiming(data, extack, IFLA_CAN_DATA_BITTIMING);
+	err = can_validate_databittiming(data, extack,
+					 IFLA_CAN_DATA_BITTIMING, flags);
 	if (err)
 		return err;
 

-- 
2.49.1


