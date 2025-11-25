Return-Path: <linux-can+bounces-5658-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ED8C85394
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 14:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A87D4E9A4C
	for <lists+linux-can@lfdr.de>; Tue, 25 Nov 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37D221DB6;
	Tue, 25 Nov 2025 13:43:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DF221F24
	for <linux-can@vger.kernel.org>; Tue, 25 Nov 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078208; cv=none; b=efbXHtOjlHg6u/uqmDnGDT3JyU8+5I7kB5c+uOFxlIlN1gpuW6ywRoYTRPalbEiZojcLY6mYN9jIRJ8Eq2yMRdeM1CuwFBVcguqKZlrXOsUjY3gZZZWJo5zaGk0I+Zggz8xSG2isuUvbVdycnYw/81K6HnESvBNxaf6hngNchsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078208; c=relaxed/simple;
	bh=BeEt2LljxgKFZOqL1WwyvSivfdOArBIUVFd0NSWEVgs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZIKdpXPa5mXOW7BFT75NpOoaSU0XtUd6y8MomLtnsQnn1Yodr7z+Z9oQrnY4W2jdOZ9rJ0/S+ze6VUZ3v4tR0dR/T2eBxpnprWaqWdNwq42UpssFZbcUQwi8SA3VH3cjzjV5pkE1jbHriLOblfezYZ6Ec9F1yT1rnKd+yeUj9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5APDhCKb006622;
	Tue, 25 Nov 2025 22:43:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5APDhCwt006619
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Nov 2025 22:43:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5732921e-247e-4957-a364-da74bd7031d7@I-love.SAKURA.ne.jp>
Date: Tue, 25 Nov 2025 22:43:12 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] can: j1939: make j1939_sk_bind() fail if device is no
 longer registered
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

There is a theoretical race window in j1939_sk_netdev_event_unregister()
where two j1939_sk_bind() calls jump in between read_unlock_bh() and
lock_sock().

The assumption jsk->priv == priv can fail if the first j1939_sk_bind()
call once made jsk->priv == NULL due to failed j1939_local_ecu_get() call
and the second j1939_sk_bind() call again made jsk->priv != NULL due to
successful j1939_local_ecu_get() call.

Since the socket lock is held by both j1939_sk_netdev_event_unregister()
and j1939_sk_bind(), checking ndev->reg_state with the socket lock held can
reliably make the second j1939_sk_bind() call fail (and close this race
window).

Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/can/j1939/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 88e7160d4248..e3ba2e9fc0e9 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -482,6 +482,12 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out_release_sock;
 		}
 
+		if (ndev->reg_state != NETREG_REGISTERED) {
+			dev_put(ndev);
+			ret = -ENODEV;
+			goto out_release_sock;
+		}
+
 		can_ml = can_get_ml_priv(ndev);
 		if (!can_ml) {
 			dev_put(ndev);
-- 
2.47.3



