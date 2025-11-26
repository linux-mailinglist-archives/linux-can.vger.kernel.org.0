Return-Path: <linux-can+bounces-5737-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D94B2C8AC3C
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70E32359462
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487CD33BBD9;
	Wed, 26 Nov 2025 15:57:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE733B96F
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172647; cv=none; b=YIEM9l7MJvpCDlhBdCRLel++3iqDEKx9NF6/gKUM3qraklJ8qD6L0t0aX5Ikk/GHl+wq+fKdEETAVXas7BpbETlD308g+G4MlDxXoZBxTgr/1jJ6uNBhuok3a2qGAT7qVlwBmmOf2KCQmd6SMmLTnpuq1B0MU/9ZTVIbohupzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172647; c=relaxed/simple;
	bh=xFWfkHgFb28bnu42jZiLmC2R53gw1402qhqAUblmCvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfQ6q6qKp1eRfAnx5rM1AllRwINAV7jB2YGcte6jZrP0Rt42mCwoEwRxNuuTWOET96BVdlXuNAp1iHpWe8vNbTBpyEd5XgEpSW/lCF6ahTyRDhneDOE+xpb8VjK4KoncfTi3zItT9rA+Fuq6z2cCF3irr6vRqckXDRbELpzYmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-000656-MJ; Wed, 26 Nov 2025 16:57:18 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOHtO-002dLr-0o;
	Wed, 26 Nov 2025 16:57:18 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 017D84A8E38;
	Wed, 26 Nov 2025 15:57:18 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 8/8] net/sched: em_canid: fix uninit-value in em_canid_match
Date: Wed, 26 Nov 2025 16:41:18 +0100
Message-ID: <20251126155713.217105-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126155713.217105-1-mkl@pengutronix.de>
References: <20251126155713.217105-1-mkl@pengutronix.de>
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

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Use pskb_may_pull() to ensure a complete CAN frame is present in the
linear data buffer before reading the CAN ID. A simple skb->len check
is insufficient because it only verifies the total data length but does
not guarantee the data is present in skb->data (it could be in
fragments).

pskb_may_pull() both validates the length and pulls fragmented data
into the linear buffer if necessary, making it safe to directly
access skb->data.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Link: https://patch.msgid.link/20251126085718.50808-1-ssranevjti@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..2d27f91d8441 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (!pskb_may_pull(skb, CAN_MTU))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.51.0


