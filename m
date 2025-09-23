Return-Path: <linux-can+bounces-4838-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5CB94705
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915EA161B16
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4030F923;
	Tue, 23 Sep 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qND9BNll"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39B30F920;
	Tue, 23 Sep 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606053; cv=none; b=ZZpxkr8XLg70boVKAiDaFESdWL6OGUkLU4te7V8yLKYxUUIw7kZFVnmqwzSP19dfPjpbrXiD+zBFcZc+PXbWTtAGhPsQ9q6ZILbSCtc1WunAM9oumGqwHn/9zeLmOfh59XYx5fMRM0sEARemy5h7Y2+SPHcTE+lrL6j/P/OURj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606053; c=relaxed/simple;
	bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNLZlVCh1eprNDNBdH1Lx337EytbPzRpKeEEoYDEX3/nB5CCYr3RbqQ7094T3FaeZrz8QNfaBSC+uXJXgDdu/SdCt10rkH8n/iQSz+UI8eMghpg4EmkQ/LdPgmBAn5c+s2KFbz28vuWrGCMOqTUpOXmii8Xc0Xw1Q33FBOADXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qND9BNll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFA2C113CF;
	Tue, 23 Sep 2025 05:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606053;
	bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qND9BNll6+lABgVv3l3n183eD5kmlls5LNTkwp3ByvQr6k5qs7CoKz/5PzEM/Kfha
	 ZqwzkVIK+67YBHUWbIVNrQSjzoSElUlyv6s3cVZXEFOsW7lNbUUQDIyHT6MMxEPSYY
	 9lv7Q1nUKwAaZh1TXzzTObxp+shi4Ys/93wXS0gBgnCWbZvyBZbkkP2nlVwaxLksKa
	 8cAAuF2IuV7Ctb35FqT9n5hYgE3f+mxqWfUVtgInqhqbsOjt8au1zibiO+fPS0/VHf
	 mB8EMRqkWCTTSJjs8XcDceR+i1RyeIFYkmBzAb371YoCxFMMRD6IS9eOoIXXS1gmmi
	 4xeqCZilj7NXw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:39 +0900
Subject: [PATCH v3 04/20] can: netlink: refactor can_validate_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-4-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=YbwnjxfMye/PzcS1THZ1QtGxRafIoeUGUPEkh1iC8L0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjDbtjvt+d87tYoVnqe8qZU7Mkth+cLnAqqCWXZMuM
 Hn3njyzsqOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBEnKUZGW6+Y93184S/RDSL
 yxzu0w8kSo1mZ876enPP2eMBnFqiigkM/8v2y7wLktDLuskrGB0xs8rgvX6Ims8d4aeLb93dsFE
 1jhUA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Whenever can_validate_bittiming() is called, it is always preceded by
some boilerplate code which was copy pasted all over the place. Move
that repeated code directly inside can_validate_bittiming().

Finally, the mempcy() is not needed: the nla attributes are four bytes
aligned which is just enough for struct can_bittiming. Add a
static_assert() to document that the alignment is correct and just use
the pointer returned by nla_data() as-is.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v2 -> v3:

  - add a static_assert() to prove that the alignment is correct.
---
 drivers/net/can/dev/netlink.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 248f607e3864ffbda6f0b8daf4e2484179cf9cd5..13555253e789ec6ca9c8c30571c990ad6bfde770 100644
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
2.49.1


