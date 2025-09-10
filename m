Return-Path: <linux-can+bounces-4605-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C67B50DB4
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA555189A35F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47153081D7;
	Wed, 10 Sep 2025 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luqcw3Ht"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC170307ADE;
	Wed, 10 Sep 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484296; cv=none; b=HzOaJFdbPQIDURMWNbURj+CRHg8KAuklGU19M54mm100VJqZ2Uol1dEKRoDJp9OPsXirGcNPQNUJKTHzFE6G8zAFKK+ClUbWVC9u+0e5WzHMXcEGzZ644Brt55jEy6/nneXolk+FU5bg9Q2yeqzNK0E2/OJiri3WgJGOJn1ldzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484296; c=relaxed/simple;
	bh=tDjzbxh+AWGwXpeAyyMu0TEaae8leCI3cry2J8B33fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7hbP0MGKUiFI5gyKLbM3ZzXBQKUCa81i3zfFDI5h9RT2CAH5yx5cAPXgP1mUwOPtvLOPwmQSwLlWjnplWBqxd7NPPZtKDSQTFwQdpsXNwm+hg0ZARz4fQ/lH2pvcA2uMbPk+ekk0LaXAx+TVXZ2tAlTzWPb2+1WZMLXmZTu0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luqcw3Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E42C4CEF9;
	Wed, 10 Sep 2025 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484295;
	bh=tDjzbxh+AWGwXpeAyyMu0TEaae8leCI3cry2J8B33fI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=luqcw3HtcUafoxvdyX79Gk9WxcXsd/eBosUSro3xJ7tCfGw938rww4Vapvbyr+VvQ
	 UHIet7jLWrZ7KIBACYlexFmRxNI+fTxLkWco3y1fqCOsgit0wOtom0/Y02kPR6NOOr
	 4UeqnpUpEgpJBnXgJHsfY023IasNJunZoNmMJLyoOBwi4C2sDTS/rnXMktfe54GVfV
	 Ces88x+IMIO22wanW/vfz0WJoZh3tOMoy5m+EyfbBk0NPHnByIy29s76JyffZeCiqS
	 xj7uQ0p7tahBVxoBORnh12emiLg1ehEVCfWPy2yAcPsC1RHuEPSX5I7Ta3k4nclcaG
	 nZPzLazGeLggQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:31 +0900
Subject: [PATCH v2 06/20] can: netlink: add can_validate_databittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-6-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3586; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=tDjzbxh+AWGwXpeAyyMu0TEaae8leCI3cry2J8B33fI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRa7VVB2LMTWNMeLhVLOcpWpgpH914frSLUdXH1p90
 L0nartaRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIlcPMnwP31+07MnXaebtn1d
 3m91MjOEt5Gx9+An5o6iJl4RfzPGjQz/lCIZa9gaH1UmnI40ndT6RzsoRYPr/K0230ZxvY6MBh0
 2AA==
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
index 24ad34ad7cc9ae75b6f28d53fb4d8030710d2507..274eaab10796b601d565c32f6315727a578970bb 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -99,10 +99,13 @@ static int can_validate_tdc(struct nlattr *data_tdc,
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
@@ -112,35 +115,56 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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


