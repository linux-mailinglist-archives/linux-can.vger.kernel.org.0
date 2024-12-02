Return-Path: <linux-can+bounces-2310-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800599DFCA8
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C7D281CE2
	for <lists+linux-can@lfdr.de>; Mon,  2 Dec 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7461FBE99;
	Mon,  2 Dec 2024 09:00:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286C1FAC30
	for <linux-can@vger.kernel.org>; Mon,  2 Dec 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130057; cv=none; b=gmb/YHQcB16SDpzUgd23IN0e95/SEEizjk29zieRamGy1RjdRn7KJ6M+ZD/IRFVlrXB02D//JGg1D7Kg7G1lY00o8edRSTgPzPLOQolbAeV+wRlT0UPPYZLSy/OoxiIpCtd/n+rFPrRKTfjL1SAsxoMZtREF2GEh8WrDOB2HNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130057; c=relaxed/simple;
	bh=h8cCRu1JLjpWd3QOPsuwi9HGbd5UzGSlJPlOIXjshk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONSZZGV3t1Tv9LdwDgn4wZpfWoDEXtwJ2z28Po5AJqdFFMvfZVFTSonl1JUPKiqnohlPhH+KFK5iEWV0eSM70k3umpRcEZcHhDY6vnUgEawkQFeyZOaydNAZtn8+OkLSHC3uN8bhlcyg0ueYGU4wmiB6lptMEMZTdMqljmxyCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IW-0007jT-DA
	for linux-can@vger.kernel.org; Mon, 02 Dec 2024 10:00:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI2IS-001Gch-3C
	for linux-can@vger.kernel.org;
	Mon, 02 Dec 2024 10:00:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6F4A638339D
	for <linux-can@vger.kernel.org>; Mon, 02 Dec 2024 09:00:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3C527383344;
	Mon, 02 Dec 2024 09:00:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6478a1cf;
	Mon, 2 Dec 2024 09:00:44 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 15/15] can: j1939: j1939_session_new(): fix skb reference counting
Date: Mon,  2 Dec 2024 09:55:49 +0100
Message-ID: <20241202090040.1110280-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202090040.1110280-1-mkl@pengutronix.de>
References: <20241202090040.1110280-1-mkl@pengutronix.de>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

Since j1939_session_skb_queue() does an extra skb_get() for each new
skb, do the same for the initial one in j1939_session_new() to avoid
refcount underflow.

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20241105094823.2403806-1-dmantipov@yandex.ru
[mkl: clean up commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..95f7a7e65a73 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
+	skb_queue_tail(&session->skb_queue, skb_get(skb));
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
-- 
2.45.2



