Return-Path: <linux-can+bounces-4430-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F0B4192D
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591681A86F1A
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06DD2F0C7C;
	Wed,  3 Sep 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzU509Gv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FBB2F0C7F;
	Wed,  3 Sep 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889527; cv=none; b=vF2ZYAqUBT/l8XCu4MEeiaGzqMqU5nQ+0wqQrLgsAfXa0+HHl9bYqGnv/NQI4u3S3yawk5QMU9fkBPURttHR91QGtd5kzaFPzl8KaTf4RXc8EPa55Po/K18GL07gDCb86KXao18k4RuU9fxMSZbLOulwaDsaJNUXVsj6C4IcUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889527; c=relaxed/simple;
	bh=N5vyjcsyY2EYRTViVRONes7S2dnBxSd+pnrbvocT+Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H93WGClUykwsepfaDkm08POB3nGGtccRSwjQq+22xiw010MANa67NoxJ+G2Q5/PXmovHlBe6nkZkqbGzCIhUqD5jgXqECUeOT/0qsA9KrC0VKCIsy32KSJQYyHU8RCaHJR+5tVdfn922tKCieX1ARi+rrlB2ZsH+PrKz7VxIOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzU509Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10938C4CEF0;
	Wed,  3 Sep 2025 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889527;
	bh=N5vyjcsyY2EYRTViVRONes7S2dnBxSd+pnrbvocT+Yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IzU509GvGcEDogvGK1+AVn3LK2PAoH0rTiG3yrpssO7rc5j6ceAar75c/g82Xlj7I
	 tvWB5ZSD+efOmn3A1cuoVxhHmbPmp/5VXwK3DsHtgXyQV7NwrmjmYDlVgHAho/IxuS
	 ZXpmy3dcrXn1mT/TKRma5/hWkXBxOYHzLPsdBMzGIcAc9GRlfbHYHHcln9rleWUaHQ
	 8QYQwTcdunGo5Rakg4SDMCZIepdJqsBNo+3M8QerkyNdIkPjP8lqXzYxHHrNzjOf6J
	 qlRAW1RC9ou470TZtT0OWW8eEQfjPihWuMFbyIE6r8cS+FA9NM/yP2QXkuU8z16Yhy
	 B6se7GxNYTZGQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:04 +0900
Subject: [PATCH 05/21] can: netlink: add can_validate_tdc()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-5-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4290; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=N5vyjcsyY2EYRTViVRONes7S2dnBxSd+pnrbvocT+Yo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GOtrzyQe9dwpPdHS14AjxO5nnuKWw6FyVyav1+LX+
 fdY85JTRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIm0TGb4Z/yzpOqHo+RnrRnT
 k8/G/2Z8JCci+q3bpezg+5qMLtGgfYwM7a2fm/46W0oFK4adfMkTMeWyY+WDsxt8pu4wFb1UHH+
 RAwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Factorise the TDC validation out of can_validate() and move it in the
new can_validate_tdc() function. This is a preparation patch for the
introduction of CAN XL because this TDC validation will be reused
later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

RFC 1 -> RFC 2:

  - fix bug on tdc flags mutual exclusivity:
      'if (tdc_auto == tdc_manual)' -> 'if (tdc_auto && tdc_manual)'
---
 drivers/net/can/dev/netlink.c | 80 +++++++++++++++++++++++++------------------
 include/linux/can/bittiming.h |  4 +++
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index bc91df8d75ac41381fefea895d7e490a965d3f7b..1367ebe5db8fd6fcac49d3a1f59d44b61847128f 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -56,6 +56,49 @@ static int can_validate_bittiming(struct nlattr *data[],
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
@@ -74,42 +117,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
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
index 4d5f7794194ab13641c7854c2d66625c4e942f6c..71f839c3f0325b2a496a4bc447044a4853541338 100644
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
2.49.1


