Return-Path: <linux-can+bounces-5561-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED2C787A8
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1674F2D503
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E609345CA0;
	Fri, 21 Nov 2025 10:19:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4213451BF;
	Fri, 21 Nov 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763720375; cv=none; b=aMx29UzTA7B9tap315KGnz9pyx6x6sGLyqv8tQQzCBeKKMvBQbEOy6+3m4sSwZBLCztbDtU02EUwGiCKpFxr95p35h0lYHXlSus+BRqyYjSWO9wcz6trPdn2L+6FXv4rbwK7KG39TBFm/oeJYsZRrkIL1NclZZPbAqnOGNf2834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763720375; c=relaxed/simple;
	bh=i99edoSX1y5+h7zBwznQ6HlJ8b5Uyuq8wtQ/TD3YCU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8QYTwbbaec82vVnVApUcDrwo7T8VKmBmWHZSYqvmnungZvAcboOH5qC8tohxpi1KV/UH2itur9c4qpk1QzAC/oATqaj68T8aXlwNRt2VU4wWRvlb+msEgjWMhDhMzgcFDcih0XlLCHU4xFHWt+LpDAW6jAr2c4DAVB5PyupQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5ALAJP8V033301;
	Fri, 21 Nov 2025 19:19:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5ALAJPOB033297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Nov 2025 19:19:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c95f5436-3e7e-43b8-820b-e380f059b9f8@I-love.SAKURA.ne.jp>
Date: Fri, 21 Nov 2025 19:19:24 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can/j1939] unregister_netdevice: waiting for vcan0 to become
 free. Usage count = 2
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
 <aSArkb7-JNW-BjrG@pengutronix.de>
 <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
 <aSA4JMyFNdliTpli@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aSA4JMyFNdliTpli@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/11/21 19:00, Oleksij Rempel wrote:
>> Do we want to update
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?id=5ac798f79b48065b0284216c7a0057271185a882
>> in order to also try tracing refcount for j1939_session ?
> 
> Ack.
> 

I see.

By the way, I am thinking

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 88e7160d4248..f12679446990 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -477,16 +477,22 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		struct net_device *ndev;
 
 		ndev = dev_get_by_index(net, addr->can_ifindex);
 		if (!ndev) {
 			ret = -ENODEV;
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
 			ret = -ENODEV;
 			goto out_release_sock;
 		}
 
 		if (!(ndev->flags & IFF_UP)) {

as an alternative approach for
https://lkml.kernel.org/r/9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp
because I consider that getting a new refcount on net_device should be avoided
when NETDEV_UNREGISTER event has already started.

Maybe we can do similar thing for j1939_session in order to avoid getting a new
refcount on j1939_priv when NETDEV_UNREGISTER event has already started.

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fbf5c8001c9d..b22568fecba5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1492,6 +1492,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	struct j1939_session *session;
 	struct j1939_sk_buff_cb *skcb;
 
+	if (priv->ndev->reg_state != NETREG_REGISTERED)
+		return NULL;
 	session = kzalloc(sizeof(*session), gfp_any());
 	if (!session)
 		return NULL;



