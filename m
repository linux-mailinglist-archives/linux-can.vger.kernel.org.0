Return-Path: <linux-can+bounces-5008-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C318CB9F1E1
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E789C32636C
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2637630149E;
	Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E22FE595
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802445; cv=none; b=U9xd24Lh7bC8pNaix3lTdhaHdrlzi2Ru4hKKk7oomHXOJ3+dKKSRc+w68+7D1v6L5XLfKaTqdNsvva4xUpVV3HCQ3+OTJtXD5n+sT0UfEY/7EFbg3fcdEUBnoPLs6rq7VgJikwHcDrbcJcYPOgKdr7iI9sRJGz5cmbi0hWbgQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802445; c=relaxed/simple;
	bh=TFmehwCjjPT1uv+G/Y+wI/HAxAG1kdYiXPRU/g+zkz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITrtX9/N3frXD3gDWn3nVb8zGzre7MiN9++ogB2psA+Xtn8GMqRrQMFgmlIYG8Bk9lmhdmp720eRB7TqzDh2I/DiOEvbN+acCfmDf/8hjqkZFSXdwdXBST7yMq6j5xGPYQzkbZCMuBaa0rumws7/N6/rdnOzaWO6GWWtFYAA7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000YV-RG; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pwr-0q;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE4FA47998C;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 32/48] can: netlink: refactor can_validate_bittiming()
Date: Thu, 25 Sep 2025 14:08:09 +0200
Message-ID: <20250925121332.848157-33-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

Whenever can_validate_bittiming() is called, it is always preceded by
some boilerplate code which was copy pasted all over the place. Move
that repeated code directly inside can_validate_bittiming().

Finally, the mempcy() is not needed: the nla attributes are four bytes
aligned which is just enough for struct can_bittiming. Add a
static_assert() to document that the alignment is correct and just use
the pointer returned by nla_data() as-is.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-4-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 36 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 248f607e3864..13555253e789 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -36,13 +36,21 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
-static int can_validate_bittiming(const struct can_bittiming *bt,
-				  struct netlink_ext_ack *extack)
+static int can_validate_bittiming(struct nlattr *data[],
+				  struct netlink_ext_ack *extack,
+				  int ifla_can_bittiming)
 {
+	struct can_bittiming *bt;
+
+	if (!data[ifla_can_bittiming])
+		return 0;
+
+	static_assert(__alignof__(*bt) <= NLA_ALIGNTO);
+	bt = nla_data(data[ifla_can_bittiming]);
+
 	/* sample point is in one-tenth of a percent */
 	if (bt->sample_point >= 1000) {
 		NL_SET_ERR_MSG(extack, "sample point must be between 0 and 100%");
-
 		return -EINVAL;
 	}
 
@@ -105,14 +113,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
+	if (err)
+		return err;
 
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
@@ -124,14 +127,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_DATA_BITTIMING);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.51.0


