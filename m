Return-Path: <linux-can+bounces-4867-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813DB94A46
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF6188DE7A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78447311C10;
	Tue, 23 Sep 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCCYvsbw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E5311C07;
	Tue, 23 Sep 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610795; cv=none; b=J4uh2IIWsE2IHo5S6xOlPvWx+lw/OPlt2EcPeeInUFxWqQ3KbvUrfKGeuaPPFv6cqLvVkRVfMcF/HN8rFsWiBMUS+e3PQgatmqzW2dN02/IN/ZG2pkCt6TRwoor2trXouhE3BL2FzqweLSXFfk69AcFmBVvjYnz4NYTSUq9U7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610795; c=relaxed/simple;
	bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXLcN8pGP+Kw65vuC4L427jUNA1OHOIiFXHmLt03mIyOq6JX5iRJBmXbrd1G14lNdKzIGNtu2p+k+hJXH+5rmV8mMx+zFhEj75TlT0zapkK5DCNKYRtW0VcWl46Y5ryLXN6I+FUeSSA5z6DeJdhwLpIYjhl11VLAWymjHw/VBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCCYvsbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED789C116B1;
	Tue, 23 Sep 2025 06:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610795;
	bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bCCYvsbwmjsjFaSEOHGLCvJ9mOUGpH6tBWHVA5ayMRjwf0Sd727LgMgMRU4yM2uE3
	 /xz+B8VDcj17MKtRxRiIpk+TWifx/laTmwoP+A/IKnEnz9EpOau2Dj8S9eLKhD1Fxt
	 yLo5X+V3gddVP9IaWBGC47LxxyFQrmJ1DTXLR5RCsk2fOqRkvItva0erMPeQuo8To4
	 /1r+pJyqm/NVSRyMJ3V+MLDE2jUh8SPyU8HSXmu90thP4l7FABFlDX/0iY7+5rZacq
	 2HGGYDS/15sma/144u/YKdkpZ6Tco1bnG9McP1KLVHoxPGZ3iOCwWCrM3Ef6X8ub+W
	 FDjE57E1gNCNA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:31 +0900
Subject: [PATCH v4 06/20] can: netlink: add can_validate_databittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-6-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=nzN3dLaayJQUQNyfjfJG0vwlCtwEhYpqAcFOwwLzEmM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXI3ZSg8YZzeocX2paX4gLiq/pEPNrkaaRcF229WG3
 cyVPV87SlkYxLgYZMUUWZaVc3IrdBR6hx36awkzh5UJZAgDF6cATESOgeF/ulV3W8X65Cf8XZqy
 pS9Pbqy+xtT2UJjlar3CNu9vmWfsGRlubj/qspDfV/LlKtV7/vzHRc+2/0v6bS569P/3kC/BEZc
 YAQ==
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


