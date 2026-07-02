Return-Path: <linux-can+bounces-7957-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vj3XAC9vRmocVAsAu9opvQ
	(envelope-from <linux-can+bounces-7957-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:01:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886BE6F8A51
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 16:01:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7957-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7957-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2819530584AC
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D1496919;
	Thu,  2 Jul 2026 13:56:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5B54A2E01
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 13:56:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000563; cv=none; b=TbQQ6mAVZsCicXfVydF8bu1Aw8JIc1NFRVTNC3ppubEG9Qudm8bByO9e45sQunOoN9jwp5A3MOyXRLxY4wOVHrlrZ8MyqRUokgzWk41fU6cQAtbDiSwlZh5evpUrnTcTZGXSNdd4i1Sx+MZjb442/ymDgSluYYz1L+pA9WrfqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000563; c=relaxed/simple;
	bh=T3uuF/8A51Bmk9D48setsl9wX+g7FZ8fCWHxRhZEuBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUeyH0Zfuhv53zARzErfW+I+eZ/fLrx8RQ+7SEc0lHGlVqtgBYP27CgFgGTi00k6X3mmPVeG6Esr7UjiUICb/McGo/7fjA3w6P5RlRRzf/m8FotJ2NfVZWfPZS+kF80KNZeZlS2suGIXVmf5/EQR8B0piZ7YrNC0Ly7mn54EPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ADE9320262F;
	Thu, 02 Jul 2026 15:55:58 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wfHtW-005kqn-21;
	Thu, 02 Jul 2026 15:55:58 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wfHtW-0000000DQBM-2Cbn;
	Thu, 02 Jul 2026 15:55:58 +0200
Date: Thu, 2 Jul 2026 15:55:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 (repost)] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Message-ID: <akZt7t2aLfnf1Yk6@pengutronix.de>
References: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-7957-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:penguin-kernel@i-love.sakura.ne.jp,m:linux-can@vger.kernel.org,m:robin@protonic.nl,m:kernel@pengutronix.de,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[i-love.sakura.ne.jp:query timed out];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i-love.sakura.ne.jp:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:mid,pengutronix.de:email,pengutronix.de:url,pengutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 886BE6F8A51

On Fri, May 29, 2026 at 10:31:22AM +0900, Tetsuo Handa wrote:
> syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem. A debug printk() patch in linux-next-20260508 identified that
> there is dev_hold()/dev_put() imbalance in j1939_priv management.
> 
>   Call trace for vcan0[26] +4 at
>      __dev_hold include/linux/netdevice.h:4470 [inline]
>      netdev_hold include/linux/netdevice.h:4513 [inline]
>      dev_hold include/linux/netdevice.h:4536 [inline]
>      j1939_priv_create net/can/j1939/main.c:140 [inline]
>      j1939_netdev_start+0x36b/0xc10 net/can/j1939/main.c:268
>      j1939_sk_bind+0x853/0xb30 net/can/j1939/socket.c:506
>      __sys_bind_socket net/socket.c:1948 [inline]
>      __sys_bind+0x2e9/0x410 net/socket.c:1979
> 
>   Call trace for vcan0[28] -3 at
>      __dev_put include/linux/netdevice.h:4456 [inline]
>      netdev_put include/linux/netdevice.h:4523 [inline]
>      dev_put include/linux/netdevice.h:4548 [inline]
>      __j1939_priv_release net/can/j1939/main.c:166 [inline]
>      kref_put include/linux/kref.h:65 [inline]
>      j1939_priv_put+0x128/0x270 net/can/j1939/main.c:172
>      j1939_sk_sock_destruct+0x52/0x90 net/can/j1939/socket.c:388
>      __sk_destruct+0x8d/0x9d0 net/core/sock.c:2352
>      rcu_do_batch kernel/rcu/tree.c:2617 [inline]
>      rcu_core kernel/rcu/tree.c:2869 [inline]
>      rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2957
>      smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>      kthread+0x388/0x470 kernel/kthread.c:436
>      ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> This refcount leak in j1939_priv might be caused by a refcount leak in
> j1939_{session,ecu} because j1939_{session,ecu} holds a ref on j1939_priv.
> For further investigation using upstream kernels, enable netdevice_tracker
> in j1939_{priv,session,ecu} management.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

