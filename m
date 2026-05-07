Return-Path: <linux-can+bounces-7552-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPv+EJh2/Gm3QQAAu9opvQ
	(envelope-from <linux-can+bounces-7552-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 13:25:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CCC4E76CD
	for <lists+linux-can@lfdr.de>; Thu, 07 May 2026 13:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9DC13031CD1
	for <lists+linux-can@lfdr.de>; Thu,  7 May 2026 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128537D13E;
	Thu,  7 May 2026 11:23:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0873B7B7D
	for <linux-can@vger.kernel.org>; Thu,  7 May 2026 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153011; cv=none; b=OPtqdjNo4+lE/wMPpK3LoDAEZ/RzMmGS+XEQiJubK4gpyGrXkFvkrMmvcyiQBCF51eOJE9q1K4P4/55XLic9ev7FgF/Z2Ctx/6oQIk2VReeQsy5V+hexFMTC7ozw1nvZSgoIw+qTbrdJC/ei64mFrrYlGyEAvtCGqE4b6NlUrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153011; c=relaxed/simple;
	bh=b5QGLrdMcXO/r/dp1/Y+Gcb8f+3BvNPmsAVZJ++CwT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU6ZPdICUV5gnG7r5htGTGjDoascC89qKKHvjcxXIoNXZbeSjBWvmU4AXQRlik/AOekrON1+tqTMHnBLP4Rq+usiWdCM9snInV/nB8ujDvJe7BdpPc2YDcLsFfs5YIuaLuHpXCiqbHgRMYoWUqLtqqUq5wB4oJcJ3aXyrS96OXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp9-0002vl-S6; Thu, 07 May 2026 13:23:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wKwp9-000ufg-02;
	Thu, 07 May 2026 13:23:23 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2D9AF530408;
	Thu, 07 May 2026 11:23:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/6] can: j1939: fix wrong RX timeout for CTS hold messages
Date: Thu,  7 May 2026 10:22:25 +0200
Message-ID: <20260507112321.439968-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507112321.439968-1-mkl@pengutronix.de>
References: <20260507112321.439968-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 87CCC4E76CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,pengutronix.de,gmx.net];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	TAGGED_FROM(0.00)[bounces-7552-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alexander Hölzl <alexander.hoelzl@gmx.net>

In J1939 segmented transport, a CTS message with data byte 2 set to zero is
interpreted as a hold message. This instructs the transmitter of the
segmented message to hold the connection open but to delay sending.

According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after
which an held open session is invalidated is 1050 ms, not 550 as
implemented currently. The 550 ms are problematic if a device uses hold
messages and assumes it can wait for more than 550 ms before it has to
resend the hold message.

Fix the RX timeout by changing the T4 timeout from 550 ms to 1050.

Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260421153152.87772-3-alexander.hoelzl@gmx.net
[mkl: rewrap long lines in patch description, use imperative mood in last section]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..7ad56b5f17b9 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1479,7 +1479,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		}
 	} else {
 		/* CTS(0) */
-		j1939_tp_set_rxtimeout(session, 550);
+		j1939_tp_set_rxtimeout(session, 1050);
 	}
 	return;
 
-- 
2.53.0


