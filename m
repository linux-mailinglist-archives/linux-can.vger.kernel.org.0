Return-Path: <linux-can+bounces-6140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2AD1E435
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 251693074033
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AF395267;
	Wed, 14 Jan 2026 10:55:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB6396D0D
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388132; cv=none; b=Bt//Jtid/+4gw6N4Kbjt8hFF1dNKQn9W62pMu0JgSDDLaVAv0SoHkeJ74ReIpoUyROEFFNz/hzHVywCjpjnr3UOT2GqEEai/wAyUzogALK0o36jcrD5nahYMn3FgGOVzJ1ArO+OQJKIKXPyxvo4Uc8307gzXDFn25xpe421izGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388132; c=relaxed/simple;
	bh=N3Pqqp8dF2+QpK86L3qSSsrFm0cAtWFa+zhTYIkq+kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXDgRtyIBMojHi3JLMCR2gYq2DyDTKJl+bkU+R/8xZm1orArEHhAZC0hkNZgZYzOIlLkSNvZw7a664od7EZhq/rV1oOk6BzDs9ry7ujIcbgVqu0vMhfcSwovEatdvpqJZ0FwSIIuKI0CCJfSe1+NBMZVOINHS//Blg7IGs1nw38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-0006p6-8S; Wed, 14 Jan 2026 11:52:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vfyU4-000Zf2-1i;
	Wed, 14 Jan 2026 11:52:15 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 96CA24CCB6B;
	Wed, 14 Jan 2026 10:52:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/4] net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts
Date: Wed, 14 Jan 2026 11:45:03 +0100
Message-ID: <20260114105212.1034554-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114105212.1034554-1-mkl@pengutronix.de>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
called only when the timer is enabled, we need to call
j1939_session_deactivate_activate_next() if we cancelled the timer.
Otherwise, refcount for j1939_session leaks, which will later appear as

| unregister_netdevice: waiting for vcan0 to become free. Usage count = 2.

problem.

Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Link: https://patch.msgid.link/b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 613a911dda10..8656ab388c83 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1695,8 +1695,16 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-		if (session->transmission)
+		if (session->transmission) {
 			j1939_session_deactivate_activate_next(session);
+		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
+			/* Force deactivation for the receiver.
+			 * If we rely on the timer starting in j1939_session_cancel,
+			 * a second RTS call here will cancel that timer and fail
+			 * to restart it because the state is already WAITING_ABORT.
+			 */
+			j1939_session_deactivate_activate_next(session);
+		}
 
 		return -EBUSY;
 	}
-- 
2.51.0


