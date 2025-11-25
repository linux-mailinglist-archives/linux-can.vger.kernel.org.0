Return-Path: <linux-can+bounces-5657-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D4DC85370
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACE633469A4
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BB223DD0;
	Tue, 25 Nov 2025 13:40:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BB221DB6
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078031; cv=none; b=QMwoIO0eg9PE5Tz+U7jILlIK839zVWgKn91MINz+xPSZfXdpC74YjJsIClGBaBBmyBCym/wRLFutYeZnIQ4S6EujyqVphSGX7/0zpc1FI6Jv2y17DTs/vcLconkFHXb4g0g1o6lzqzyQ+99hrxTG2+uDpqCFeW3Q0GV72u249Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078031; c=relaxed/simple;
	bh=IdbgtGAjYU3GMjBOV7FRsCMLgU0iuStQQBW7ZA6OsPc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cTb7VzYC3TwGuLqIipbV9ODhz7YJBeuO77Fet9ZAIANZmv6MUCw6yE12vWlfzdZueZBatuqluRr/xPC79ltAp40qmBS4mPcIH04TRYRlnrxn0XqdMX3AATmVXiZ9LBdtb9hnWdKAAoCDnV0sob7mBEd13vFXYMrXmU0YI3CKMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5APDdxtv005881;
	Tue, 25 Nov 2025 22:39:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5APDdxGx005878
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Nov 2025 22:39:59 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
Date: Tue, 25 Nov 2025 22:39:59 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] can: j1939: make j1939_session_activate() fail if device is
 no longer registered
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is still reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

even after commit 93a27b5891b8 ("can: j1939: add missing calls in
NETDEV_UNREGISTER notification handler") was added. A debug printk() patch
found that j1939_session_activate() can succeed even after
j1939_cancel_active_session() from j1939_netdev_notify(NETDEV_UNREGISTER)
has completed.

Since j1939_cancel_active_session() is processed with the session list lock
held, checking ndev->reg_state in j1939_session_activate() with the session
list lock held can reliably close the race window.

Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Should we also make j1939_sk_queue_activate_next_locked() and
j1939_xtp_rx_rts_session_new() not to emit bogus warning message?
Is this error case rare enough to tolerate bogus warning message?

 net/can/j1939/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fbf5c8001c9d..613a911dda10 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1567,6 +1567,8 @@ int j1939_session_activate(struct j1939_session *session)
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
+	} else if (priv->ndev->reg_state != NETREG_REGISTERED) {
+		ret = -ENODEV;
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
 		list_add_tail(&session->active_session_list_entry,
-- 
2.47.3


