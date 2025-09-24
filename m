Return-Path: <linux-can+bounces-4970-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C7B9A344
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 16:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067A519C39D0
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 14:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FAF14B953;
	Wed, 24 Sep 2025 14:17:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6EB74040
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723434; cv=none; b=N557VZfGO3uJlE1gy6rKmvjszG8RXvdffSHhlbPsnzucfjT2zbZ1sZhNxzmnamdZidd6gCaNliZgAmxy/BZLLQ11KdLqXISauPRXzrngvyxFmrrF6dSf7GMHxqdZ02BSlSzkvj2e1GHxGEJQ29+6YwGrwFKX4uLXfESFjCi9DrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723434; c=relaxed/simple;
	bh=T2UgRRdejrt+oPG4CbKMHKVf8wwaWzBlQwjVM74l26w=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=niShH17AHCdayY9tEW0U6oi+sK61+8Y/5ufn35t+bonZMgi5LDyyIi5twlWrBuC7nhwSijOCPO9KNABlnurMeeovyia2wg6mMcX4txPABuI0lzJZMdSR5TEBY2b/Fg1Xw97Ppss9LTw7q4+eCidEsctL+rZbeCy9GELLUGN/fKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58OEGlNx011179;
	Wed, 24 Sep 2025 23:16:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58OEGl39011160
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Sep 2025 23:16:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp>
Date: Wed, 24 Sep 2025 23:16:46 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: [PATCH] can: j1939: close theoretical race window in
 j1939_sk_netdev_event_unregister()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

There is a theoretical race window in j1939_sk_netdev_event_unregister()
where two j1939_sk_bind() calls jump in between read_unlock_bh() and
lock_sock().

The assumption jsk->priv == priv can fail if the first j1939_sk_bind()
call once made jsk->priv == NULL due to failed j1939_local_ecu_get() call
and the second call again made jsk->priv != NULL due to successful
j1939_local_ecu_get() call.

Close this race by also checking jsk->priv == priv.

Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Do we want to make j1939_sk_bind() transactional (i.e. don't make any changes
when it fails) after j1939_sk_bind() once succeeded, for the J1939_SOCK_BOUND
state being cleared might be an unexpected behavior?
Or, programs will just close() or exit() if re-bind() request failed?

 net/can/j1939/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 88e7160d4248..0a377ad75038 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1313,7 +1313,7 @@ void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
 	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		/* Skip if j1939_jsk_add() is not called on this socket. */
-		if (!(jsk->state & J1939_SOCK_BOUND))
+		if (!(jsk->state & J1939_SOCK_BOUND) || jsk->priv != priv)
 			continue;
 		sk = &jsk->sk;
 		sock_hold(sk);
@@ -1323,7 +1323,7 @@ void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
 		 * j1939_jsk_del() with socket's lock held.
 		 */
 		lock_sock(sk);
-		if (jsk->state & J1939_SOCK_BOUND) {
+		if ((jsk->state & J1939_SOCK_BOUND) && jsk->priv == priv) {
 			/* Neither j1939_sk_bind() nor j1939_sk_release() called j1939_jsk_del().
 			 * Make this socket no longer bound, by pretending as if j1939_sk_bind()
 			 * dropped old references but did not get new references.
-- 
2.47.3


