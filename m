Return-Path: <linux-can+bounces-5005-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79DCB9F1E7
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761B04E4A93
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB107301494;
	Thu, 25 Sep 2025 12:14:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BC2FE59B
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802444; cv=none; b=HpV+gQXIi8jHtDrXFiX/3ZwzOPGQyAYIXIYIp6kdDPkyeOprDYjaFiulhD9C6EcKgPMhgmqSlnuzZp4jjZ8Oqi9GTsRo4K+ZR0+IwMAEx2sJ0Y3t55CtUAcebmL8bD7l/N7QKgq2/AaMCJsqfs6r+XmTzn8zWu0VHy6g9gLCurA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802444; c=relaxed/simple;
	bh=+1yQOwxQd/GNYq3gvYPG1yvFAgCAbDlUc60igkoTr1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dos1Ixb/0Gwyy9Q+ucGeICFaLcNvHPVKe8OdennV5t5FS2nVY5++daXOIOKHBAr4l0nS91gIsl+5T1aM4ups1OKHIcF7ShBMijpTL9KlvMDdvFLVH7hUXHeNxlHmbeFFxKmDJfnjBg6PfsUGS3vV6wfWDrlXsE+FCVaACng5re4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-0000Yb-QO; Thu, 25 Sep 2025 14:13:38 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-000Pww-16;
	Thu, 25 Sep 2025 14:13:37 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1D05147998E;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 34/48] can: netlink: add can_validate_databittiming()
Date: Thu, 25 Sep 2025 14:08:11 +0200
Message-ID: <20250925121332.848157-35-mkl@pengutronix.de>
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

Factorise the databittiming validation out of can_validate() and move
it in the new add can_validate_databittiming() function. Also move
can_validate()'s comment because it is specific to CAN FD. This is a
preparation patch for the introduction of CAN XL as this databittiming
validation will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-6-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 64 ++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 25c08adee9ad..549a2247d847 100644
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
2.51.0


