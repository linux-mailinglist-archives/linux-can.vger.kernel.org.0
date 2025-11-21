Return-Path: <linux-can+bounces-5558-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9837C782B2
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0121334549B
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F193242D6;
	Fri, 21 Nov 2025 09:33:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495D2E0917;
	Fri, 21 Nov 2025 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717599; cv=none; b=mVyUh4ibfqfELuJ1srXDXgoMEPOe7PZglxLBCrxl232LxTKkoy8GAne0D0FrVPMPaoYtI/KisAwSvlx8O/bKPX8rQRmjeRCsJq+vOFdKY8S+99Bgm7E3hDtYe4Gda8ToXLS67VQu/eENPIyrNlyeP6GFY7NvojtVytTh3+bFxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717599; c=relaxed/simple;
	bh=vGKQkkuuwDoqk0Ib3IZAIvL6Iua7SbpQo0wMFE8rYbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRUIDLZ4MYCV4YtRfFjjoTir82Tc7rOXP7qDVz3B4hNvPzgtjSi8Fduw6HsINFO3uDy34e3NAWyM5mdC1fmJrbdrWQdlZdXh5F4GsaRNrqkNTno7yVIN8ZKG2MxRQ8G9uGO8TP/lbCYniVEO7FFaVRRFEwY2SdLeSPR8a9dxzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AL9X2JI020186;
	Fri, 21 Nov 2025 18:33:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AL9X2PY020180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Nov 2025 18:33:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
Date: Fri, 21 Nov 2025 18:33:02 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aSArkb7-JNW-BjrG@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

On 2025/11/21 18:06, Oleksij Rempel wrote:
> Hm, looks like we have a race where new session is created in
> j1939_xtp_rx_rts(), just at the moment where we call
> j1939_can_rx_unregister().
> 
> Haw about following change:
> 
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -214,6 +214,7 @@ static void __j1939_rx_release(struct kref *kref)
>                                                rx_kref);
>  
>         j1939_can_rx_unregister(priv);
> +       j1939_cancel_active_session(priv, NULL);
>         j1939_ecu_unmap_all(priv);
>         j1939_priv_set(priv->ndev, NULL);
>         mutex_unlock(&j1939_netdev_lock);
> 

Well, j1939_cancel_active_session(priv, NULL) is already called from
j1939_netdev_notify(NETDEV_UNREGISTER). Unless a session is recreated
after NETDEV_UNREGISTER event was handled, I can't imagine such race.

We can see that there are three j1939_session_new() calls but only
two j1939_session_destroy() calls. There might be a refcount leak on
j1939_session which prevents j1939_priv from dropping final refcount.

  Call trace for vcan0@ffff888031c9c000 +2 at
       j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
       j1939_tp_send+0x338/0x8c0 net/can/j1939/transport.c:2018

  Call trace for vcan0@ffff888031c9c000 +1 at
       j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
       j1939_session_fresh_new net/can/j1939/transport.c:1543 [inline]
       j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1628 [inline]
       j1939_xtp_rx_rts+0xd16/0x18b0 net/can/j1939/transport.c:1749

  Call trace for vcan0@ffff888031c9c000 -2 at
       j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
       j1939_session_destroy net/can/j1939/transport.c:285 [inline]
       __j1939_session_release net/can/j1939/transport.c:294 [inline]
       kref_put include/linux/kref.h:65 [inline]

Do we want to update
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?id=5ac798f79b48065b0284216c7a0057271185a882
in order to also try tracing refcount for j1939_session ?


