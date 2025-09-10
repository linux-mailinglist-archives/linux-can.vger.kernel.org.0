Return-Path: <linux-can+bounces-4613-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F1B50DC2
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AF545FE7
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65BF30C35C;
	Wed, 10 Sep 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THdbLEwU"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E07B30AD0F;
	Wed, 10 Sep 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484308; cv=none; b=GGROYQwgHexWbJZ6N2YaOALEnZ1uxNXD7Ijz0SzK5gfnEkcEGryYUZglxAevAVBm6shpjjZtevQoS9v8pyDiQ5dcAFzeaRlMkDClRRpsfayv6Ioc7FslymmAvSe0sDFS1yi2dsizEYaqDLKWfqac+y9/hORVmd+WiybpYfw7s1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484308; c=relaxed/simple;
	bh=70CWolPIlOgPwhAb0qjq4AkLhlgahxoMh2KXdI+DFHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EiYDzU013Oz9/tXaCcHMA8m2EtRNP2nAlZDkvncg8AduGbxRhWELZZX+0OyGbT/jZdA/Oiq3jrzXlOD6kfBzrJQJMOOnE82lNAPT3avNoPlOtxsXCO5/cYUjbeJPjutwlot5gd7+RS7tpPm1HQZ1Y2BbieDxq+9d6NOTwGXU9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THdbLEwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA27C4CEF9;
	Wed, 10 Sep 2025 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484308;
	bh=70CWolPIlOgPwhAb0qjq4AkLhlgahxoMh2KXdI+DFHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=THdbLEwUJ/8fUO30vzEifpRmmZLPQhdDM57sl927F1B0/U983rQTWgerpaC8fTS2t
	 tEXmZ4Hze6opDsBVTzayvlS0nGP0zDIEYIaH5339AaFEUIO0gmjzxUOZpxChR2h2n9
	 31IdHc4Sy0MVJ5mMVoJUboEytGuygayK8kQgQq2FIHeXvRqUxjOzQvoogfE6F+e1yh
	 5w3VD0Nt7YBukN+XcY0b4C4munXt9J9UJIb8662BAYtzIitkBABtpG+lQs9XtC2qJj
	 2I1UlNJa4FvSz83syPRx3+MNOnABz2sZASzkaJJuB/wsqYrOHetljcuuD2W27xbdVH
	 YbOm+XNyQvrBg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:39 +0900
Subject: [PATCH v2 14/20] can: netlink: add can_bittiming_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-14-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=70CWolPIlOgPwhAb0qjq4AkLhlgahxoMh2KXdI+DFHM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRV5NzttnIXh4W3bzMqH9EyKM/vXZ9zUcXee4ji8l9
 yBb0NWFHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYSPJOR4ffrnrb9q0ryju76
 +k+9I3flXBn5kN5043z9etNJfbxnLBkZ7ho5p/mwPP/pH3Nzqsr00/cZ0oPeuj7bOuHy9V++956
 6swMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bittiming_fill_info() to factorise the logic when filling the
bittiming information for Classical CAN and CAN FD. This function will
be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index c30920761d25871ac2e73a56a54333c521b4f9d8..e2f26898b83be8df8d2c4d0cd64b505f3c4a9b7d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -559,6 +559,14 @@ static size_t can_get_size(const struct net_device *dev)
 	return size;
 }
 
+static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
+				   struct can_bittiming *bittiming)
+{
+	return bittiming->bitrate != CAN_BITRATE_UNSET &&
+		bittiming->bitrate != CAN_BITRATE_UNKNOWN &&
+		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -641,10 +649,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
 
-	if ((priv->bittiming.bitrate != CAN_BITRATE_UNSET &&
-	     priv->bittiming.bitrate != CAN_BITRATE_UNKNOWN &&
-	     nla_put(skb, IFLA_CAN_BITTIMING,
-		     sizeof(priv->bittiming), &priv->bittiming)) ||
+	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
+				    &priv->bittiming) ||
 
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
@@ -659,9 +665,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-	    (priv->fd.data_bittiming.bitrate &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
-		     sizeof(priv->fd.data_bittiming), &priv->fd.data_bittiming)) ||
+	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
+				    &priv->fd.data_bittiming) ||
 
 	    (priv->fd.data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,

-- 
2.49.1


