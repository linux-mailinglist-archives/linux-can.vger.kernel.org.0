Return-Path: <linux-can+bounces-4429-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E7B4192B
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E135E718E
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3622F0697;
	Wed,  3 Sep 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvTUQB+5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45682F0666;
	Wed,  3 Sep 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889525; cv=none; b=ngIEwj24FwkvKZhb+/mKzzuT/GnQ99j6BEWnMMETmfWg2QyP4Gs27Y6t8st9Ob9q7vM2V8dlbkbtMAV6l4uWIYs5ZmTEAC/NifY53aw5SpuL7WvvKUWlX5ev8BTkwMswhfLQXpDcf5SavTMdWr1o1rf4QiCThlvAl+2UYcAePPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889525; c=relaxed/simple;
	bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sx9y7eURhYn7PzqLuu+SDRC4CCT8YYqRMaIXrGBbs3wrJDNOSyWtKDjzDlAEPsy2Fz7r0y5SSZQkOL+MZGY6pQzdtaZ6uTaMOzRvQGRiKGzza/6LAgKZf9v0A8h3ZSP+Ui0vMrY5hO1amCQrHMJo/3z260MXPk+9g2nPUjX6Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvTUQB+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ED3C4CEF0;
	Wed,  3 Sep 2025 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889525;
	bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tvTUQB+54zhquXA4tHKGJXDEovF0GG4Ve9Sn+L2DGRC4G+wYw7WGgysPTuMsHEn6F
	 acdWj2doEBD75UfcL/m2XTbJag8SvYAy+qsP1flvU6/j+7L2GMxA1a1Hg4PIoo/uWs
	 kpJIS2caFxV94gsAAsTUJQ7eocRXmB/rRNdniUmBTBJL/77nZHMdpumXN9GCL51HSG
	 IkcdrC/eklnDXuMwkS1qTtvjFiat9N/5tGyVX0JUrQ5QO04jR2AxMxAxD83KmA66Mn
	 chkPYgq1S8JKk/8WVlhdz/tkCEn+yaDIEnDbpfEO/k43wKUyCaldEvAbyjyY97hl51
	 5653z4mgZhGtw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:03 +0900
Subject: [PATCH 04/21] can: netlink: refactor can_validate_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-4-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GGtenn/7afrkhXLSRltvZ3yvuP79iPXppMyHfwMa6
 0+s/CGV0FHKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAisncZ/opp5ZVzOIcU/cx7
 /jhKmb+ss9Jy47LnZucna74yLQw+s4iRYSevsOBq7eK43Y0Wm996cBW1huy9cVrz/LrdzK6KBUq
 LuQA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Whenever can_validate_bittiming() is called, it is always preceded by
some boilerplate code which was copy pasted all over the place. Move
that repeated code directly inside can_validate_bittiming().

Finally, the mempcy() is not needed. Just use the pointer returned by
nla_data() as-is.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d9f6ab3efb9767409c318b714f19df8a30e51137..bc91df8d75ac41381fefea895d7e490a965d3f7b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -36,13 +36,20 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
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
+	bt = nla_data(data[ifla_can_bittiming]);
+
 	/* sample point is in one-tenth of a percent */
 	if (bt->sample_point >= 1000) {
 		NL_SET_ERR_MSG(extack, "sample point must be between 0 and 100%");
-
 		return -EINVAL;
 	}
 
@@ -105,14 +112,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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
@@ -124,14 +126,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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


