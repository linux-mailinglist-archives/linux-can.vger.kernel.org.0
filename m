Return-Path: <linux-can+bounces-7954-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8i/zKK5CRmpLNAsAu9opvQ
	(envelope-from <linux-can+bounces-7954-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 12:51:26 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F66F637A
	for <lists+linux-can@lfdr.de>; Thu, 02 Jul 2026 12:51:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=i-love.sakura.ne.jp (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7954-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7954-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1993336560E
	for <lists+linux-can@lfdr.de>; Thu,  2 Jul 2026 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F5048125D;
	Thu,  2 Jul 2026 10:09:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7A481FB6
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 10:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986955; cv=none; b=Rb6ovx8IjASpgj1/uP4++XLOV1BbQYf7jYxtfIbSOftRoRhNTOSROQGGdh1mNXbgGV+sly9yexhfs0AvCvYS6YDY127byZag9piJ+jyi1z2zBVJuATjf+/+dJ9shRwwT2lhIqtq8tz1h/DM6ZjbU99OALcohH2aO64WfoqAm5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986955; c=relaxed/simple;
	bh=GmMUTv/x1Nb6ObJWaUZNnmKTnO2YZHma0L40U6la3EQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ma8E+IviXv/2tTQOWi9n5d/UyqWrppqdl2dJHPX95KlufkDUJBZaKNeqBTFod3YHXxixuUJFJuYG80If1r4gJKvR25m3Jq2i2+R2kDTH0Q2w2uDLFQAKsFL2S9KUYKyNZGQcqsLWHQjdG9rhd3TPM2f/3oNc8PLlkEwkZbcO+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 662A8fhI066697;
	Thu, 2 Jul 2026 19:08:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 662A8eLx066693
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Jul 2026 19:08:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e45a86fb-114b-46fe-84a0-e57f3b5d4375@I-love.SAKURA.ne.jp>
Date: Thu, 2 Jul 2026 19:08:40 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 (repost)] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[i-love.sakura.ne.jp : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7954-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-can@vger.kernel.org,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,I-love.SAKURA.ne.jp:mid,I-love.SAKURA.ne.jp:from_mime,i-love.sakura.ne.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 125F66F637A

Ping?

On 2026/05/29 10:31, Tetsuo Handa wrote:
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
> ---
> I'm waiting for your response. If you don't like this approach, please let me know.
> 
>  net/can/j1939/bus.c        | 2 ++
>  net/can/j1939/j1939-priv.h | 3 +++
>  net/can/j1939/main.c       | 8 ++++----
>  net/can/j1939/transport.c  | 2 ++
>  4 files changed, 11 insertions(+), 4 deletions(-)


