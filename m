Return-Path: <linux-can+bounces-4604-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60ADB50DAB
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DE2544B40
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5226307AFB;
	Wed, 10 Sep 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv/T0o5B"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFF3043DD;
	Wed, 10 Sep 2025 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484294; cv=none; b=fQrOCWN6OHE2WMf8GNkO7h//PnZUg9T6YdTdfq0XTsxPTa81azfESTmmETP2y78M4r092Z/4ftdq8WvpLgwwL0L/xwTLlHmUH3UWs56GoJyjjCCHdWu7Qt2uZDlLMktAGNDuSgyCvVS3cnMEdoTttrKUJ/xM/pJj32/ZqCKPDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484294; c=relaxed/simple;
	bh=IucMtAsp191cVbemQachgp1r++hfkZZJA/oHBo4slr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2VtDD3hnv7VurJJ3FD6LgUuzDUex55N33ce4SRekxF0sP8NV7eVbFS4Ks2i46CuYxRiPMZlFDssxXTlVlr7j5Z6XihhXtYIujSt7cRE/CdYmDbCoY73Q0dTA1v9eYP16v4TBfsPpvUDIr37/JBwezK0Js1RFVwzI5Rh0BfMoDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv/T0o5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA44C4CEF0;
	Wed, 10 Sep 2025 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484294;
	bh=IucMtAsp191cVbemQachgp1r++hfkZZJA/oHBo4slr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wv/T0o5B0mnbbKNI9ebms5bPAXFwo+xtud0KLijQrHzSFcTav3/RFT4VOv0sqf+Ut
	 ywu7KbqjdV9t00M5GF9mgQBeQxClqxn4H7esLGvykHkDzzS6HaXoqz61UONZo6rIna
	 6U6tMG6pqLhj48vBetWUuVDznQHYTtcYVuIU+bLIMdgteWMR+MMYAktIqrwJBqHQeJ
	 AR2Jx6p4tqlNikRUWYkt2aLNEBGq7WjF7aJAdwtA1lv8gXb+F3PsV1KUlaSGZqvSAc
	 Iar5uy+Gi8XnO6BKlifzj7hk8ibDTt8XOQWEcZJGzr5UJyHKiNzbtMxK4XBfGngXLG
	 02Yon40noT20A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:30 +0900
Subject: [PATCH v2 05/20] can: netlink: add can_validate_tdc()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-5-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=IucMtAsp191cVbemQachgp1r++hfkZZJA/oHBo4slr8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRS4b3Vmr8inw2aelduK+xy7cnq9rrn/7z42rU7aGb
 vm9iteWsaOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBELrIwMqycKj+zjOOZ39Yq
 zqjq+HP7bBZf3HaGWaf+VWRl7223WTqMDA27tCy++m+WcAlneMXU8T/5xCnrNzfXllhLrrZr/Pv
 wIDcA
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
 drivers/net/can/dev/netlink.c | 82 +++++++++++++++++++++++++------------------
 include/linux/can/bittiming.h |  4 +++
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index bc91df8d75ac41381fefea895d7e490a965d3f7b..24ad34ad7cc9ae75b6f28d53fb4d8030710d2507 100644
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
@@ -66,7 +109,7 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	 * - nominal/arbitration bittiming
 	 * - data bittiming
 	 * - control mode with CAN_CTRLMODE_FD set
-	 * - TDC parameters are coherent (details below)
+	 * - TDC parameters are coherent (details in can_validate_tdc())
 	 */
 
 	if (!data)
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


