Return-Path: <linux-can+bounces-4917-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C370B98CAE
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7042E1FBF
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA644284B4E;
	Wed, 24 Sep 2025 08:21:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB252820BF
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702104; cv=none; b=iHSjJ4g5owgNJ9MkyDrU/Idm5Bqg5fICYRODO+2L9okZJA9pv/761HT+NnZujlxrTpGkYgJLDP1gMkgVzZl7eTPNM+8wL1oFzsmSV5TinF6ibErjX+PXIQEARRWPbTq3SY3tXyLqXNOTOQHNUL7Xu9zUF8xAj4SvXljsPxFVSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702104; c=relaxed/simple;
	bh=9wXVXM5CbsvZTKk/q914b/XH6oNxY5+kix4Gv+qO5AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5No6osqI/CVp6Qtfm3PmEbBFlyKeG6uLdYEZ3FEZGWQoPpwtv/YCujXVVTukE7vObc0sq8u4Kqttt82xH8r30hHj+uU1FRY8s88juxqnNc4go1RFWstPzPqMos0+XEYtnDws7ZwjMurUIK9BI5xM/mNoKps7eWoIKZqTDAw/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001EA-AJ; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dva-1v;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 313984788A6;
	Wed, 24 Sep 2025 08:21:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 33/48] can: netlink: add can_validate_tdc()
Date: Wed, 24 Sep 2025 10:06:50 +0200
Message-ID: <20250924082104.595459-34-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

Factorise the TDC validation out of can_validate() and move it in the
new can_validate_tdc() function. This is a preparation patch for the
introduction of CAN XL because this TDC validation will be reused
later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-5-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 82 ++++++++++++++++++++---------------
 include/linux/can/bittiming.h |  4 ++
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 13555253e789..25c08adee9ad 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -57,6 +57,49 @@ static int can_validate_bittiming(struct nlattr *data[],
 	return 0;
 }
 
+static int can_validate_tdc(struct nlattr *data_tdc,
+			    struct netlink_ext_ack *extack, u32 tdc_flags)
+{
+	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
+	bool tdc_auto = tdc_flags & CAN_CTRLMODE_TDC_AUTO_MASK;
+	int err;
+
+	/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
+	if (tdc_auto && tdc_manual)
+		return -EOPNOTSUPP;
+
+	/* If one of the CAN_CTRLMODE_TDC_* flag is set then TDC
+	 * must be set and vice-versa
+	 */
+	if ((tdc_auto || tdc_manual) != !!data_tdc)
+		return -EOPNOTSUPP;
+
+	/* If providing TDC parameters, at least TDCO is needed. TDCV
+	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
+	 */
+	if (data_tdc) {
+		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
+
+		err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
+				       data_tdc, can_tdc_policy, extack);
+		if (err)
+			return err;
+
+		if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
+			if (tdc_auto)
+				return -EOPNOTSUPP;
+		} else {
+			if (tdc_manual)
+				return -EOPNOTSUPP;
+		}
+
+		if (!tb_tdc[IFLA_CAN_TDC_TDCO])
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -67,7 +110,7 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	 * - nominal/arbitration bittiming
 	 * - data bittiming
 	 * - control mode with CAN_CTRLMODE_FD set
-	 * - TDC parameters are coherent (details below)
+	 * - TDC parameters are coherent (details in can_validate_tdc())
 	 */
 
 	if (!data)
@@ -75,42 +118,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
 
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
-			return -EOPNOTSUPP;
-		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
-		 * TDC must be set and vice-versa
-		 */
-		if (!!tdc_flags != !!data[IFLA_CAN_TDC])
-			return -EOPNOTSUPP;
-		/* If providing TDC parameters, at least TDCO is
-		 * needed. TDCV is needed if and only if
-		 * CAN_CTRLMODE_TDC_MANUAL is set
-		 */
-		if (data[IFLA_CAN_TDC]) {
-			struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
-
-			err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
-					       data[IFLA_CAN_TDC],
-					       can_tdc_policy, extack);
-			if (err)
-				return err;
-
-			if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
-				if (tdc_flags & CAN_CTRLMODE_TDC_AUTO)
-					return -EOPNOTSUPP;
-			} else {
-				if (tdc_flags & CAN_CTRLMODE_TDC_MANUAL)
-					return -EOPNOTSUPP;
-			}
-
-			if (!tb_tdc[IFLA_CAN_TDC_TDCO])
-				return -EOPNOTSUPP;
-		}
+		err = can_validate_tdc(data[IFLA_CAN_TDC], extack,
+				       cm->flags & CAN_CTRLMODE_FD_TDC_MASK);
+		if (err)
+			return err;
 	}
 
 	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 4d5f7794194a..71f839c3f032 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -16,6 +16,10 @@
 
 #define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
+#define CAN_CTRLMODE_TDC_AUTO_MASK				\
+	(CAN_CTRLMODE_TDC_AUTO)
+#define CAN_CTRLMODE_TDC_MANUAL_MASK				\
+	(CAN_CTRLMODE_TDC_MANUAL)
 
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
-- 
2.51.0


