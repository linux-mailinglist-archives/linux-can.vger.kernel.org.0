Return-Path: <linux-can+bounces-4338-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73BB32F02
	for <lists+linux-can@lfdr.de>; Sun, 24 Aug 2025 12:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12311896292
	for <lists+linux-can@lfdr.de>; Sun, 24 Aug 2025 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75E92701CC;
	Sun, 24 Aug 2025 10:30:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80F26A0EB;
	Sun, 24 Aug 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756031427; cv=none; b=j37yJzf53v/3uUCY65zUbBwsWK3zERNc+ikjHc4JVgmOa1zbjgQRj1+ikShJi7i+UXgyGKdWOvWmn6AveHY93N1jHB67sUd0ewN7SxGLcFiblP5EGn7RgpAkjcYfIUvB6boiEEtwhEOWu4J9wdEK2I6Gu3ftfDQpZxcAh6g/Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756031427; c=relaxed/simple;
	bh=RPGLOX14M7J3ohT6Th8+aDR7CR3/MFsU+QZNJFomAm4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BNEDix8KbDAYKTquelzh5pZ1T8AmUNF4Dg/Y9V329yrPmsQ3O4DQ6ZmSH41Pahks7kiVYMDuDug42ZuepMan7WXiLhtpkKO7UdF7h3MwjulnBy9lpnMGx51Yz/1xwFUVBnjLgGYuIAl3BQAj13pxvdn/WV5kBX52tngd/2bQyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57OAUBOG051735;
	Sun, 24 Aug 2025 19:30:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57OAUBnQ051730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 24 Aug 2025 19:30:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
Date: Sun, 24 Aug 2025 19:30:09 +0900
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
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp

Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
callback") expects that a call to j1939_priv_put() can be unconditionally
delayed until j1939_sk_sock_destruct() is called. But a refcount leak will
happen when j1939_sk_bind() is called again after j1939_local_ecu_get()
 from previous j1939_sk_bind() call returned an error. We need to call
j1939_priv_put() before j1939_sk_bind() returns an error.

Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
The change made by commit 25fe97cb7620 might be relevant to my result

  As far as I tested, the only way that can drop the refcount to 1 is to
  call j1939_sk_release() (which involves sock_put()) on all j1939 sockets

in https://lkml.kernel.org/r/bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp .

 net/can/j1939/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 3d8b588822f9..493f49bfaf5d 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -521,6 +521,9 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	ret = j1939_local_ecu_get(priv, jsk->addr.src_name, jsk->addr.sa);
 	if (ret) {
 		j1939_netdev_stop(priv);
+		jsk->priv = NULL;
+		synchronize_rcu();
+		j1939_priv_put(priv);
 		goto out_release_sock;
 	}
 
-- 
2.51.0


