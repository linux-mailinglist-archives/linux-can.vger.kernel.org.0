Return-Path: <linux-can+bounces-7355-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIihG3St1mncHAgAu9opvQ
	(envelope-from <linux-can+bounces-7355-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 21:33:08 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8E3C32BB
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 21:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF545300B458
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CB362128;
	Wed,  8 Apr 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YqrupV+/";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ymx+VrWD"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C159284896;
	Wed,  8 Apr 2026 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676752; cv=pass; b=GLxtLiao41qswy4TcFTAhBCy7G2PkpaiKcM6ggEB3CgqsqTDGfCqc+LiUjskNBqjSSm6aIwwxlG31CL2iHqw38P+QszZyUdxTxXq3chfXyp2kv+ybp5jaQW+zekZJlp1UfABmtbxBSmFm4hzh/Okg4caI2g9zKxuhQXDTXyXh9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676752; c=relaxed/simple;
	bh=WdoR318b/ybLUuyQ2kB9JIh2VE05fzztMVB8ZSje288=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH5DXCBV+26vY6wUMaXTBtH/IOVK7RVjc6dWZCrSw7J6maU1I5XL0lAjT5YIiG+VyGlQ4sbFYsy+C3DllrRf1XjsiQuxIHm4I0QiJ4zZ7l5usTzLAWRgpz4u3kaLRfoKAyeHMYcWwKTqAF8qB2EIHfQ02DoNQgWkbZLUzs7k/zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YqrupV+/; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ymx+VrWD; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775676741; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gf34llHU7Gz1mOoChs7Y2QwC6V9PP8p+WvsacJ7QPISfgos3cNwyQfs46ubRuqvhjf
    8RounGrxPXVGPUkur674QKGmaIZfMRBHAuMKXwMRxLEz0L3DRYppnCmt53dA+vxct+YG
    IWMLHl9wE8zhfL4CZ5z9/SfZ2uRHpPbx0lLtTwhIRGkX9mcsMf+sbLLpf46JD87gseIR
    X24KJHzXaDCIZZ/jcEz/6/ARwyCO8audn2pCzGMu31bcnAklo5CHBlwNRgWoHspUWw8b
    8pcOPbv4rf5L64GqXq1lLWKzu6wNR6EOkex6KZRWddyBMfnDWzC6RG1sUABiUwhrRMvX
    Reog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775676741;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8pLjPYHSB6MTjexDQzesLub21qZ6LA0lo8HYGJgYBB8=;
    b=qQJDi+OIjxVTd43KVaGbfsRRnC7Hm6RjoLdRMLt7OpE/KVbQxi9+lE/0LxD8pLdYQ1
    1DIoX2OyfWvWfscY8uoYh65YMDe9xnhe7fbNE3eKkoQSzlEUUdo4m9eqh9k4cC+0oyE5
    yGFvEbt3iiuHOVxU1M7crjoCKH15Da3oq9HkzfIjFiY70rtO2nvRoRGpicMVeBy7Y1Z6
    eWSI8nRX2ribb47DKmE+jAiiPGe/hT6sBiMuhdv8GqDeD52IKgrRK6rN7JCwd7wehCLi
    OTCZ/9s0oXB/SV+lnK/N2Uv3ezISEOwluq4iGPhmLyFlJY18gi6vskxWh/k7kWs0CHrc
    BaFw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775676741;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8pLjPYHSB6MTjexDQzesLub21qZ6LA0lo8HYGJgYBB8=;
    b=YqrupV+/bU0opDE5C7zFOKxkcQ3iI1TwEMkLDT0YWgak2jM6Pl8lVwddiCwIpvvJTw
    AFnyAyVGPWoI/uPmeMpFFim5zYE7M16o/IQ+Fjp0cPkNNOGuj+8vNslwXNSJDQJaZ5vY
    knw8mQPCxA5KYmrf/VFbgGzuV4lzM36FcIhLu08VZnkO6Mec7+ON467fAAStw3yu86Y5
    GzUKCHUziYJP3bRXiAuTEfy0lcz3jcaYcW+XJyKh9kuk5IhYmhfOp2D9P6J0VLx0EFlR
    Dz/F+/vR6dCEw+sayHI1M3mevbnVK5cuzUSO9tldJAeFkR+bS3BzaUWvXaJgpN556ss4
    tJFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775676741;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8pLjPYHSB6MTjexDQzesLub21qZ6LA0lo8HYGJgYBB8=;
    b=Ymx+VrWDO4tb1i+lb2QXkgYSq5oD7XIAkPcr/PrcpR9hKW9aVYUsIuR6PHApqUI87u
    94LC1wuzcrVhRVPyhDAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d238JWLuX7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Apr 2026 21:32:21 +0200 (CEST)
Message-ID: <4fe2b2fd-e3f3-445f-9e06-411bfd9dd906@hartkopp.net>
Date: Wed, 8 Apr 2026 21:32:20 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: raw: fix ro->uniq use-after-free in raw_rcv()
To: Sam P <sam@bynar.io>, netdev@vger.kernel.org
Cc: mkl@pengutronix.de, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
References: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <26ec626d-cae7-4418-9782-7198864d070c@bynar.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7355-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bynar.io:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34B8E3C32BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 08.04.26 16:30, Sam P wrote:
> raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
> but receiver deletion is deferred with call_rcu(). This leaves a window
> where raw_rcv() may still be running in an RCU read-side critical section
> after raw_release() frees ro->uniq, leading to a use-after-free of the
> percpu uniq storage.
> 
> Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
> socket destructor. can_rx_unregister() takes an extra reference to the
> socket and only drops it from the RCU callback, so freeing uniq from
> sk_destruct ensures the percpu area is not released until the relevant
> callbacks have drained.
> 
> Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame 
> for overlapping CAN filters")
> Cc: stable@vger.kernel.org # v4.1+
> Assisted-by: Bynario AI
> Signed-off-by: Samuel Page <sam@bynar.io>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> 
> ---
>   net/can/raw.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/raw.c b/net/can/raw.c
> index eee244ffc31e..f042c4316890 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -361,6 +361,14 @@ static int raw_notifier(struct notifier_block *nb, 
> unsigned long msg,
>       return NOTIFY_DONE;
>   }
> 
> +static void raw_sock_destruct(struct sock *sk)
> +{
> +    struct raw_sock *ro = raw_sk(sk);
> +
> +    free_percpu(ro->uniq);
> +    can_sock_destruct(sk);
> +}
> +
>   static int raw_init(struct sock *sk)
>   {
>       struct raw_sock *ro = raw_sk(sk);
> @@ -387,6 +395,8 @@ static int raw_init(struct sock *sk)
>       if (unlikely(!ro->uniq))
>           return -ENOMEM;
> 
> +    sk->sk_destruct = raw_sock_destruct;
> +
>       /* set notifier */
>       spin_lock(&raw_notifier_lock);
>       list_add_tail(&ro->notifier, &raw_notifier_list);
> @@ -436,7 +446,6 @@ static int raw_release(struct socket *sock)
>       ro->bound = 0;
>       ro->dev = NULL;
>       ro->count = 0;
> -    free_percpu(ro->uniq);
> 
>       sock_orphan(sk);
>       sock->sk = NULL;


