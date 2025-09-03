Return-Path: <linux-can+bounces-4431-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22687B4192E
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF805625F5
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383B2F1FD9;
	Wed,  3 Sep 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEFzK+Wn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA272F0666;
	Wed,  3 Sep 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889529; cv=none; b=IxfhW2hyy1LN5yKv7FFMCcsqiwpR4+W1fS8SFyTBXbYbNmX81Md+w+sFvaXXdnUWJJZrPFabUGvTj1ENbbekrbJERY3/SS3903AXP3SF+jlMM+Wv/S5fN7xi5Fz5XPFYc+SteJHl/A0xVW/oy9qC31elTuc5bpqrQWAhRa4k5O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889529; c=relaxed/simple;
	bh=/7yR2bTbG3z9BRBOnVH5Wh2v8KTbTEoUXWedJ/vhrOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkF3+jkdfajBmRPU7mpivcscUQ3Uvn+rbfw8DFMQRmIwMnDvESjTnvx/GnAokNIjQmEIsP7wpxmNEHp6/VLO+LuTa2McSxIF8Jyr53miQBRkLyS/jM/zx7z2VeKUbLTjD6HRfPx92+5mCpYpXgHSVj+MXNUvaiH3+1YQqUHbWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEFzK+Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A109CC4CEF1;
	Wed,  3 Sep 2025 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889528;
	bh=/7yR2bTbG3z9BRBOnVH5Wh2v8KTbTEoUXWedJ/vhrOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YEFzK+WnwBmtyszVKep9X+ShE0tP5PGHLaF814y32RJ2NbJB21P4VoKN1wNGVWhI3
	 6tqrIYXTNs7O65wF+CeUQwTyAjvp2UfqinCDV0lPwp+hy5nVW45QqSHRjg8vLvJ4mA
	 wFu0je3JJvDrecopHhf/16tLXZLGR7xGPBgPYbw2GXDBY8pY8FhM6dGT4OQRgwp80n
	 y7eR501wpbD3SNMdkzU/La0xQqzMJdpInIBe6HIhG71tTZmF+cpxloIxJYuflEJYFX
	 XNShuZk0lecg8A4nzK4IIDwlBSAT5x7wkKmHzmvdt5yGJnafl0OjEuNebfvuP+grb5
	 3I1PbZXwUcxzg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:05 +0900
Subject: [PATCH 06/21] can: netlink: add can_validate_databittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-6-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=/7yR2bTbG3z9BRBOnVH5Wh2v8KTbTEoUXWedJ/vhrOo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GBs3r69/cOLfOo5Orxbr3WcY3r8+pvpYpuDaFqkJ8
 RPO9PMs6ihlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRj+aMDJO/Pfww7aK+5vS6
 S12WJ2ewpBbqXs+etIp3Mdc5qb9uFn8ZGbp2r4+Yu9Gy+W3szoCd93pSNpusqDU+7pi27jzvQp3
 Np1kA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Factorise the databittiming validation out of can_validate() and move
it in the new add can_validate_databittiming() function. This is a
preparation patch for the introduction of CAN XL as this databittiming
validation will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 60 ++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 1367ebe5db8fd6fcac49d3a1f59d44b61847128f..f7b12057bc9c6c286aa0c4341d565a497254296d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -99,10 +99,48 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 	return 0;
 }
 
+static int can_validate_databittiming(struct nlattr *data[],
+				      struct netlink_ext_ack *extack,
+				      int ifla_can_data_bittiming, u32 flags)
+{
+	struct nlattr *data_tdc;
+	u32 tdc_flags;
+	bool is_on;
+	int err;
+
+	if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
+		data_tdc = data[IFLA_CAN_TDC];
+		tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
+		is_on = flags & CAN_CTRLMODE_FD;
+	} else {
+		WARN_ON(1); /* Place holder for CAN XL */
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
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	bool is_can_fd = false;
+	u32 flags = 0;
 	int err;
 
 	/* Make sure that valid CAN FD configurations always consist of
@@ -118,29 +156,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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


