Return-Path: <linux-can+bounces-4866-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7541B94A40
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8632A5A2B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290B8311943;
	Tue, 23 Sep 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCRWJ6VE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E263115BC;
	Tue, 23 Sep 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610794; cv=none; b=e5eGWgOZ7MKLR6hpqdvd1b9zGhcxIB6IfTs9/+o+F+tT3kjNYDBQb0vI4vV6xOrtR2pvssMp4m91ZV6SUUFc9Aqyuscgb5+n13t7xVVTyRd1KF1Apb61bIzK1qWtNRTuVTHPqry27W1MSGbKfAGNWEQigbwMwiYqbTzMgz8P4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610794; c=relaxed/simple;
	bh=v3v+O363rC+dn52ot3vqRu7qNq/YGiBUd4dacgQWkrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISBQvOfXjGrTuFOPK2ynYiccqObM/9b/ZRZQC0q0WYnJkMovXpg8OrmaVuauYw/bVDn3lsYhAH+VKIP04PFQAVOs+Gt8lZEMCwk9NaltQfYG6vV4jAFPwOhcUAk/M/a1l0RodZkQ7kVZerF+WkNPWk+fQspqdaNb9pfUxmCKGYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCRWJ6VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6000CC19422;
	Tue, 23 Sep 2025 06:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610793;
	bh=v3v+O363rC+dn52ot3vqRu7qNq/YGiBUd4dacgQWkrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kCRWJ6VEZNUcOneXDI0jY92DSzrKgVrjpopohYpDql5LIaVkk+NKKh4m6A8+mD4L+
	 HHW5YHkNbka5Ccj2C1fRk8bC+5LkSVm1xAwxCxCtvOuPURIrzsyTdzkGT7uRLO/XPO
	 O8CZj5tkbA8UCcfuO2emo1eCPoLOYg+RFxUdP0+4voAtEySMtIRid3EHbYaJSzf7qv
	 wqkCDA+UXqLGjsJiCasdOeipvP9cwohnIxRW9kkxGy42Tv2gz4H5qZjjaZ/97NC0U5
	 HXAIdGkJ6P3YpeOmQUuMgftjteBs51pP5BbILZvLfrzLXLP8+x5w5xYF07iwrbRWa+
	 lQu7q5hp2aq4g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:30 +0900
Subject: [PATCH v4 05/20] can: netlink: add can_validate_tdc()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-5-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4624; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=v3v+O363rC+dn52ot3vqRu7qNq/YGiBUd4dacgQWkrQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXA0fXfzKo7iT48aLR1n5FZs+PRec2v6U8YN575TmZ
 XPzXERUO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzE7isjw6zt5zQjrl88Mdty
 45nPsfLMh7d3xEvl7s2Je8/cwnVy9RyGP3weYgt0J5df6rxaZ7jKe8Nx8//HOL7k1m7g4QjKWb5
 iCx8A
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Factorise the TDC validation out of can_validate() and move it in the
new can_validate_tdc() function. This is a preparation patch for the
introduction of CAN XL because this TDC validation will be reused
later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

RFC -> v1:

  - fix bug on tdc flags mutual exclusivity:
      'if (tdc_auto == tdc_manual)' -> 'if (tdc_auto && tdc_manual)'
---
 drivers/net/can/dev/netlink.c | 82 +++++++++++++++++++++++++------------------
 include/linux/can/bittiming.h |  4 +++
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 13555253e789ec6ca9c8c30571c990ad6bfde770..25c08adee9ade22a5dabdd3dec1b5eb1ee16a78e 100644
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


