Return-Path: <linux-can+bounces-7350-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFaBDZaC1mmwFwgAu9opvQ
	(envelope-from <linux-can+bounces-7350-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 18:30:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59C3BED84
	for <lists+linux-can@lfdr.de>; Wed, 08 Apr 2026 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FC7302012A
	for <lists+linux-can@lfdr.de>; Wed,  8 Apr 2026 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5CD3CF672;
	Wed,  8 Apr 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="StkD7K9d";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="75KnPYoF"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5E3D16E6;
	Wed,  8 Apr 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665748; cv=pass; b=l2ZbWo9OEFNfvf3csOV0u9c5fRTdS9ZPt4ibHz2CgjA6InhpBEYo+O9rIeDVI7VVWxOHUxwMG4kJXsKEAUF7Rpvvtmq/XHxph3ytJYN74+Dgz12fsKlp98B8/uLFbdcSu4FjMEt1tprTo1fImQ43Rlv6kjoST+F0BjPdEJ9ID0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665748; c=relaxed/simple;
	bh=rVFAJA0V5hQ0kfEXLdR4m0ViiPXuuxiolXRBJ4cpGNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH+J8qpc3uS4s1CpcxgLXLonQXPyBjkZ96RIY7NhCrO6mh/mhx4CidWcklrSBq/hcEa4bsWLsl4WasZhTAQJD8U6Lf2pu5QpMkEWw7oJm+YqpOyA9pgvUv2XXiDuPPrPCarWSGmWwMmDm3mOS/bNvNh6AcdSzMFf+JeXf8EWleY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=StkD7K9d; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=75KnPYoF; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1775665737; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LsRQ1MVra3q7cx+So/SsG8XW4BBpwZPAbYSxPTUJ9NfnSGN1QqQB3bi8Jlu+DfmLQC
    hVYib33kzq4rwq3xW/JzcZfK9ViP74LuZBIKNGjimJ2wXbTkB4Hb3/WEOD0Xy+g6xn8m
    S6tTI284JFrz5lK4EdKhpnm/glaEvhmC2JbAPfN1Ru/CyBSESqMwwK7D4Q9xAGmkN2Ul
    VwRwRZewjJ7gVK3o+RwHQA5tCoOQPOGp+fT1RYSNJz7Hz2+1V9iQpamv8zjSGNqRafZJ
    5oFZ5PPhtpzgTu2Jw8KABToPTVIEYvc+92EokV2Hw18MbHrl0FWMMbuu5d3+r1e0fz1q
    Vj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775665737;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HdGKxblKkNQXX0nQxA7xRoYj7XTASETxTsOgAYVW9/4=;
    b=NVHuHpNwHA/2+8KKXRyEgzzKjQYskTZyfUo4Y0yQAOHxoeqd+BzSkbfiwGZs4qT2IH
    shDujDbxaB4ruAuaiqROzYfET0XRbe09tmLOAS/h4a8nhvnq90H0/XHmQ9p9Hz+E4cfV
    OPn8+6y7ZxXkFazdZPWzrb1H3hzbcgKzuB14CSiE2Dh+ZwUFzCQf97OMfRDXNvYPShv5
    zMlwVkA64uG/8I0QAwvYXIJwty5IAjgF4rECqknu8GglBz+0Jx3tobFjYEfIBuq/uFW4
    JUUQ9a/oC3xfzf/12kTnhei4F4vbTM7D9ZX0kV87wzeX8Hq7D1rJDI0BN8FCi9KQEOCm
    ucHw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775665737;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HdGKxblKkNQXX0nQxA7xRoYj7XTASETxTsOgAYVW9/4=;
    b=StkD7K9dEROwqUg6Amo2LqnKcT1r1YPuveIaTGIpAfHOzaM7+ARlgvH4KSkTG/0ehK
    qNDctsZm17eCr8x8EdvOZ9Q0VDiYB/e0oDH8b77eXOBKi4q1u2rsgvwMSXp48d4Xffi3
    U14JRAZbgPm/+/0sJxIKdM+F3ERJ98C68nFAfCvGocNaoHYm9w2dYOPtr4PyFQPc+Vr4
    9EiVhfgndd1fhJHhuUV+T5c7kPN/0k6mxlsn6lMJZXFhNCTkhpDiIOzwOH4HSoDoiwrl
    SjhRuK44ypEZgv83Rgn4K/q1U+SWHOqQzvzbPb5to2mSNz3QKhcOvGO3PsgXvZNZAfoG
    QlMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775665737;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=HdGKxblKkNQXX0nQxA7xRoYj7XTASETxTsOgAYVW9/4=;
    b=75KnPYoFzefW6UJ9eAbu9jzPu4zGUAApkenynzarp1aPgcYi2nsWhzxMZZgj+GoO5T
    KZCCh3V2Y07UNtQtEtBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTRsLs5FrPm8xWJP2FLGj7g=="
Received: from [192.168.1.104]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d238GSuuAF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 8 Apr 2026 18:28:56 +0200 (CEST)
Message-ID: <c67d6642-8078-4144-8b21-f0e882ecd61a@hartkopp.net>
Date: Wed, 8 Apr 2026 18:28:47 +0200
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7350-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:dkim,hartkopp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bynar.io:email]
X-Rspamd-Queue-Id: AF59C3BED84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Sam,

many thanks for your investigation and for the provided fix.
Excellent work!

Btw. you also suggested a different solution with synchronize_rcu():

diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31e..5bb9a84f2471 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -431,6 +431,13 @@ static int raw_release(struct socket *sock)
      if (ro->count > 1)
          kfree(ro->filter);

+    /*
+     * Wait for any in-flight raw_rcv() calls to finish before freeing
+     * ro->uniq.  can_rx_unregister() scheduled deletion via call_rcu(),
+     * but RCU readers (raw_rcv in softirq) may still be active.
+     */
+    synchronize_rcu();
+
      ro->ifindex = 0;
      ro->bound = 0;
      ro->dev = NULL;


Can you tell why you preferred the destructor solution now?

And if I see it correctly the UAF problem might also show up with the
kfree(ro->filter) statement we can see at the beginning of the above patch.

So either free_percpu(ro->uniq) and kfree(ro->filter) should be handled 
after the finalized synchronize_rcu() process, right?

Many thanks and best regards,
Oliver


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


