Return-Path: <linux-can+bounces-5044-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BCBA5EA8
	for <lists+linux-can@lfdr.de>; Sat, 27 Sep 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F007B160C
	for <lists+linux-can@lfdr.de>; Sat, 27 Sep 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C02DF14A;
	Sat, 27 Sep 2025 12:12:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA42882D0
	for <linux-can@vger.kernel.org>; Sat, 27 Sep 2025 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975125; cv=none; b=pp9YAVkBSzmhDqOlPo2mXaA+xVHFYX7bRLnV2LZLmDpttSTlh7sRUNDSPB8ZhxwaaFruQTxm5R6kOxamaWFo65mAGePJzI0Nd5U5oXUA0ZP0UeTNIzoFNF5qYbfplZStHY9lb/zvCpjRP7N+3IlRaZTGg34CDcYLyGYYReQV65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975125; c=relaxed/simple;
	bh=2/pCkzHzoBBgmrbX2QEEb/ya8THCztM0q/sHLRJGybA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UU3fnUox+cVVVMX6/3utrQ4naAN/Ll0ICuyxZ7nGAmfukNTs691WFlvaHup7nrMo0q57ge8b5OXflZ1oGbIAaaf+LtqAztmcniZZpbUVtIZ4sbn+6L5Z72yF8zVN9eHd3CZFEmnHkAwVeZrTY6ziyhzcZUPr5l42fwSxo19uHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58RCBUFV069064;
	Sat, 27 Sep 2025 21:11:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58RCBJNA069002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Sep 2025 21:11:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
Date: Sat, 27 Sep 2025 21:11:16 +0900
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
Subject: [PATCH] can: j1939: add missing calls in NETDEV_UNREGISTER
 notification handler
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

Currently NETDEV_UNREGISTER event handler is not calling
j1939_cancel_active_session() and j1939_sk_queue_drop_all().
This will result in these calls being skipped when j1939_sk_release() is
called. And I guess that the reason syzbot is still reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

is caused by lack of these calls.

Calling j1939_cancel_active_session(priv, sk) from j1939_sk_release() can
be covered by calling j1939_cancel_active_session(priv, NULL) from
j1939_netdev_notify().

Calling j1939_sk_queue_drop_all() from j1939_sk_release() can be covered
by calling j1939_sk_netdev_event_netdown() from j1939_netdev_notify().

Therefore, we can reuse j1939_cancel_active_session(priv, NULL) and
j1939_sk_netdev_event_netdown(priv) for NETDEV_UNREGISTER event handler.

Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I couldn't tell whether NETDEV_UNREGISTER event handler should also call
j1939_ecu_unmap_all(), for there seems to be no corresponding call in
j1939_sk_release()...

 net/can/j1939/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 3706a872ecaf..a93af55df5fd 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -378,6 +378,8 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		j1939_ecu_unmap_all(priv);
 		break;
 	case NETDEV_UNREGISTER:
+		j1939_cancel_active_session(priv, NULL);
+		j1939_sk_netdev_event_netdown(priv);
 		j1939_sk_netdev_event_unregister(priv);
 		break;
 	}
-- 
2.47.3


