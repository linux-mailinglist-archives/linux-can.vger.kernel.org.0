Return-Path: <linux-can+bounces-6123-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8964D19ED3
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9A83013EF5
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1682392B82;
	Tue, 13 Jan 2026 15:29:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312C38E5ED;
	Tue, 13 Jan 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318154; cv=none; b=eXLu3olW7mzvIWu+e0hMHPayp47SoBeW/JhShYl0cLoSSm4QHxs48dCGhYaL9hLo0LfSbLL3jWGEoqgM7YqUfLkdeFmwwz99x03kcp0p1GoY9Nuf7Gh3bqtPMbtf7Utlmq6mVv0UBSTgN2IpZL3zloOX+10eQHeCoCRyi2EXlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318154; c=relaxed/simple;
	bh=b1wdIDzj/ZREMokgMe0lxHicW4GxQ/8swVGaT5TWrP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRyj677Pf/nRW7jafPoguxC4auGM2NnZmM8DZ7Lvu9Sqty/WGlDgLgSrxHvrD8wLSYT+4GM7U3pKAiPk+1bsnXyfuUV3MHzNbwKp3QUDBLxZw2ezEeQmbteN/U3uB5yMurz8cLPQ2GbFrl92LSxbhjUj08pqAaQX2NfJmYhv/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60DFSoZ8097424;
	Wed, 14 Jan 2026 00:28:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60DFSoLR097421
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Jan 2026 00:28:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
Date: Wed, 14 Jan 2026 00:28:47 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] can: j1939: deactivate session upon receiving the second rts
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
 <aWZXX_FWwXu-ejEk@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aWZXX_FWwXu-ejEk@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
called only when the timer is enabled, we need to call
j1939_session_deactivate_activate_next() if we cancelled the timer.
Otherwise, refcount for j1939_session leaks, which will later appear as

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2.

problem.

Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
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
2.47.3


