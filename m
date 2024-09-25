Return-Path: <linux-can+bounces-1560-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF4398598A
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406A21C20F6F
	for <lists+linux-can@lfdr.de>; Wed, 25 Sep 2024 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B71A38E9;
	Wed, 25 Sep 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfTQHoM4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2661A38DD;
	Wed, 25 Sep 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264365; cv=none; b=FQtROc8Yt5WCPmscB6VA/p4PhWy+ZzPV8sWjMiv7MyqogIaQBBZjBPwT5u75NHJ9yQIlSlRCIyOtVGgjZ6hs181m9KOnndhJSxx9Udwq8033osmsHhr4ott+z0DMUUN/UL9f28apsnlXMq/o4HjL19arzn5eQIdITWgUZd40q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264365; c=relaxed/simple;
	bh=kRWR6qYrxWbNzYcGxDDO/mF6H7avlIAs8xLSBm1IsR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiC4vuS5bL0i0w4NxuDL8Ho9llZlxXyQRojJ2SHzXxolBvSGE9ZnuZfbusT8sv+IuMMz1pBYoKdI71+NozIDcAXApYXO+Ev6E5rO8DgXdZbNE6KX4BjSPSjCIdoh+xpatX21FmQz2z3ryMd5OEZT7a/UV/q9/IDpvBjU58uz5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfTQHoM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E0AC4CEC7;
	Wed, 25 Sep 2024 11:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264365;
	bh=kRWR6qYrxWbNzYcGxDDO/mF6H7avlIAs8xLSBm1IsR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfTQHoM4j0jIvPmaP9MGA1PjF6Vi8FAYwc2LTlQYEcNpXUMrBIOmZ6wO6oMIJFutL
	 gG0CDtBS5IhMzUoOV3/uBkWYlnlJgXUdwvIieu4rWxLCTvUE0KO0u/zWdeYflW3ypc
	 1kk7t4Mqg5PHPJ7aeu5TLp3QzZYOZWWRA+ovRKqV7jVtyT7O0S+wrS7EA0v+Q7hqFy
	 Aw7o01q26WkEoiDx+KoBWR05MVnJZ+uK2qv9xnWz/SzVA6vzHAGy/gpm6frSnt9obJ
	 GN8HUKNUtOMZrYIv1QuqlRZAPUFBLu5giZS88uPKlgyBh+qehjQs3yTMrzWs9OV7aU
	 7f8JHlvKbV6Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.jayat@mobile-devices.fr,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 068/244] can: netlink: avoid call to do_set_data_bittiming callback with stale can_priv::ctrlmode
Date: Wed, 25 Sep 2024 07:24:49 -0400
Message-ID: <20240925113641.1297102-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Stefan Mätje <stefan.maetje@esd.eu>

[ Upstream commit 2423cc20087ae9a7b7af575aa62304ef67cad7b6 ]

This patch moves the evaluation of data[IFLA_CAN_CTRLMODE] in function
can_changelink in front of the evaluation of data[IFLA_CAN_BITTIMING].

This avoids a call to do_set_data_bittiming providing a stale
can_priv::ctrlmode with a CAN_CTRLMODE_FD flag not matching the
requested state when switching between a CAN Classic and CAN-FD bitrate.

In the same manner the evaluation of data[IFLA_CAN_CTRLMODE] in function
can_validate is also moved in front of the evaluation of
data[IFLA_CAN_BITTIMING].

This is a preparation for patches where the nominal and data bittiming
may have interdependencies on the driver side depending on the
CAN_CTRLMODE_FD flag state.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://patch.msgid.link/20240808164224.213522-1-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/netlink.c | 102 +++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index dfdc039d92a6c..01aacdcda2606 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -65,15 +65,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
@@ -114,6 +105,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
+
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
 			return -EOPNOTSUPP;
@@ -195,48 +195,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->bittiming_const && !priv->do_set_bittiming &&
-		    !priv->bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt,
-					priv->bittiming_const,
-					priv->bitrate_const,
-					priv->bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   bt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memcpy(&priv->bittiming, &bt, sizeof(bt));
-
-		if (priv->do_set_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->do_set_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 		u32 ctrlstatic;
@@ -284,6 +242,48 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->bittiming_const && !priv->do_set_bittiming &&
+		    !priv->bitrate_const)
+			return -EOPNOTSUPP;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_get_bittiming(dev, &bt,
+					priv->bittiming_const,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt,
+					extack);
+		if (err)
+			return err;
+
+		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
+					   bt.bitrate, priv->bitrate_max);
+			return -EINVAL;
+		}
+
+		memcpy(&priv->bittiming, &bt, sizeof(bt));
+
+		if (priv->do_set_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
 	if (data[IFLA_CAN_RESTART_MS]) {
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
-- 
2.43.0


