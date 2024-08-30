Return-Path: <linux-can+bounces-1276-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA29966B6F
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5A728144B
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AD1C1ABE;
	Fri, 30 Aug 2024 21:44:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2A178387
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725054260; cv=none; b=n11zPSe0/NXVFA/9bpqzXnhMt4nbMcCX2H1RWl8Fj1OVEtqyw6kDzAFQqqr0qak6giHnnVGygvXc61xnEp2rDmCQ+5xPnH6QZCTMv7kGoMCq4sJrP8Xhq8oCUhfXPsZKkbzT+w81dhTCyMRqGTo8w68KWMPFeAWkoalZzpr/0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725054260; c=relaxed/simple;
	bh=HUHyCOIdf6ZB7tbORbDJ6oBGmpBGX/vvQvS6NPC/Xa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqVynZsNOHFaQu78sglnw5YXOspjxisZBm+Zj6E+LVbA83m7Ns5VWcG4Ku0zP0x8kXW7V6SErZ1q6wjZRB3prAjHYyZX8VVLmTaqI0+M95YpH/pV8ih1MIJ6BG42oBPOc8UBUQZwLxiY76jX2eCuALZ8n9r5bVX5p0J/iJx66Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pj-0002gR-7s
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:15 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sk9Pi-004FNO-30
	for linux-can@vger.kernel.org; Fri, 30 Aug 2024 23:44:14 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id BEE6032E47A
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 21:44:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 10D3332E452;
	Fri, 30 Aug 2024 21:44:12 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 153ecc30;
	Fri, 30 Aug 2024 21:44:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/6] can: j1939: use correct function name in comment
Date: Fri, 30 Aug 2024 23:34:36 +0200
Message-ID: <20240830214406.1605786-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830214406.1605786-1-mkl@pengutronix.de>
References: <20240830214406.1605786-1-mkl@pengutronix.de>
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

From: Zhang Changzhong <zhangchangzhong@huawei.com>

The function j1939_cancel_all_active_sessions() was renamed to
j1939_cancel_active_session() but name in comment wasn't updated.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Link: https://patch.msgid.link/1724935703-44621-1-git-send-email-zhangchangzhong@huawei.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..319f47df3330 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1179,10 +1179,10 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		break;
 	case -ENETDOWN:
 		/* In this case we should get a netdev_event(), all active
-		 * sessions will be cleared by
-		 * j1939_cancel_all_active_sessions(). So handle this as an
-		 * error, but let j1939_cancel_all_active_sessions() do the
-		 * cleanup including propagation of the error to user space.
+		 * sessions will be cleared by j1939_cancel_active_session().
+		 * So handle this as an error, but let
+		 * j1939_cancel_active_session() do the cleanup including
+		 * propagation of the error to user space.
 		 */
 		break;
 	case -EOVERFLOW:
-- 
2.45.2



