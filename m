Return-Path: <linux-can+bounces-5240-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58959BF2180
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BCE04F9CE8
	for <lists+linux-can@lfdr.de>; Mon, 20 Oct 2025 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943BE26A08C;
	Mon, 20 Oct 2025 15:25:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE96264A97
	for <linux-can@vger.kernel.org>; Mon, 20 Oct 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973928; cv=none; b=J70LzhEGNrKOCOhu4JnJ92ZpHfjI79cIg4F0gjJmfkl5mdsteeGpxsnRR7TQ3pNBAxVGYuvb8nqTxJyRGRht+P7ky7l97rBAk4BKR5BTWOa2SFLcKPESOO8KAOpz6lz3nnbKRAUG2Eb70Gy+iP///smaVpjep1V0Vh6fw3HN8XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973928; c=relaxed/simple;
	bh=1Nc+4T6K74qt1+p9936kzRAIcPBKq/tDZ9neB8aX0s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R441eI9Kf5cY9F6/987H8mJu+FjVHMeZZzbQ6KlRb6RxUqq2ZRcpjOe4ZIU0L0RbYjtJ7am/7kDTH3dvehHdBeVEGiPnhedNzPDegUeDOOyMNveyNyTkGYwThO00TDokoK21pbIrwWQILfH//uQJM8Pbat1k/o5JefDk59BTIoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlC-0005Ah-D7; Mon, 20 Oct 2025 17:25:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vArlB-004ZUN-1i;
	Mon, 20 Oct 2025 17:25:21 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4661248B59C;
	Mon, 20 Oct 2025 15:25:21 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@vger.kernel.org,
	Andrei Lalaev <andrey.lalaev@gmail.com>
Subject: [PATCH net 4/4] can: netlink: can_changelink(): allow disabling of automatic restart
Date: Mon, 20 Oct 2025 17:22:25 +0200
Message-ID: <20251020152516.1590553-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020152516.1590553-1-mkl@pengutronix.de>
References: <20251020152516.1590553-1-mkl@pengutronix.de>
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

Since the commit c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL
pointer deref of struct can_priv::do_set_mode"), the automatic restart
delay can only be set for devices that implement the restart handler struct
can_priv::do_set_mode. As it makes no sense to configure a automatic
restart for devices that doesn't support it.

However, since systemd commit 13ce5d4632e3 ("network/can: properly handle
CAN.RestartSec=0") [1], systemd-networkd correctly handles a restart delay
of "0" (i.e. the restart is disabled). Which means that a disabled restart
is always configured in the kernel.

On systems with both changes active this causes that CAN interfaces that
don't implement a restart handler cannot be brought up by systemd-networkd.

Solve this problem by allowing a delay of "0" to be configured, even if the
device does not implement a restart handler.

[1] https://github.com/systemd/systemd/commit/13ce5d4632e395521e6205c954493c7fc1c4c6e0

Cc: stable@vger.kernel.org
Cc: Andrei Lalaev <andrey.lalaev@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20251020-certain-arrogant-vole-of-sunshine-141841-mkl@pengutronix.de
Fixes: c1f3f9797c1f ("can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode")
Link: https://patch.msgid.link/20251020-netlink-fix-restart-v1-1-3f53c7f8520b@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 0591406b6f32..6f83b87d54fc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -452,7 +452,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -461,7 +463,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
-- 
2.51.0


