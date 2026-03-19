Return-Path: <linux-can+bounces-7151-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMljGeT6u2mzqwIAu9opvQ
	(envelope-from <linux-can+bounces-7151-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:32:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F0D2CC098
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 14:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8870A3028A1A
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290D1459F6;
	Thu, 19 Mar 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="g/KsOXhF";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UYPCdI7K"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B3BED10;
	Thu, 19 Mar 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773927132; cv=pass; b=tA7Wfcaj6GUmz8Y3YE9CFifDFye6ttuOnuhGMnu8kdBDwuc3KJG8RnDZ5TZ7qEl3vmS9bC1EeMX+PNX+uaZ//1mBH+GLBX4/uc1kCcV/ue9UZglP884KOpYO2gFZNDORse7ssE+bJM1c8okUoHf5Bz8R26XJiZSOSBZoPkkqCLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773927132; c=relaxed/simple;
	bh=cJ635i5fm7+9T1qVfaUkixI7IjsOSQDDmfmCY/pNI+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/J0CNA7rFYYaBjispROKSKwSJhBsUTnOPS69H5VwMJieYkb1rbTWWTdzz0ONhchIFWdVzfFDEftX0mX1irPovztf17KRbex0LIJqDAGjwkdedxAjoHk7hUVyLDphDMp9jhv9usAbHooXwVng/jAaaqjFKqRiKAnRrKdkE2GrzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=g/KsOXhF; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UYPCdI7K; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773926040; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rzSuGllwe3v9JEw8Lzo/jwphVDqAN7nAS2AmQf++PkKd/A8LoPZz8k7PRKh2AwDl6g
    GvCDHbkgJ5YDVxRxrmgbntjxaN+AQ6jkm5A7XkbDNYnBtGbAHrsiAxw+2alTTy2qzwuC
    lI8sC5P9FFr1Dtb1MV7YCaCNPoFn6/SnHNXw4o+3fsJUr23Y5S/vynANKekYbrp09Xpt
    bWwIDOmNyoYvNKhNsyYaHoVqN/pt3iyKF0HknBc48C/hjomJu82eNj0Siv8fvk3Bu55g
    QT+3gKymzre2aO8g0tu1ZOiYtvDoFwgU8ni8g/ri32ox08K7L2gbSfBwjMiIG0mCecqq
    L0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773926040;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qBjyZ7tBlwA5Rs8H7gLo2wC9H1zvpReUog1xQNRuiD4=;
    b=apoF1jf3VaNKPWf83PJwxnsi8iDqbrcJlc+drWERtNyAg1q1Sgo1niWPqU1BZca3MI
    hKllx1EkfTxn7QKZbxoV85iXjQ5bB5Xxk/7MU/Tkh7yMzeP0IDH0ANGamxqGJrZU/q72
    GDOZlaG8/Vb8klV9Cs+04CYFJSqGBqli0VkfynigrY1IvpWEr9UU/3t8yoSWZcIA1NW4
    tzfaEcwkJMvhnVFeWVYgcMaW/hjpPbZyiCqqKZRKPOA4kAywPf6mXC5+MfUK27QlrzB0
    BIh0TJCeClQwD7lxjrCpN6PyGEfEF7KXiQHSK5SlpqMDQEQ6VTODYU5pw1KMhteFS/3o
    ghRw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773926040;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qBjyZ7tBlwA5Rs8H7gLo2wC9H1zvpReUog1xQNRuiD4=;
    b=g/KsOXhFTURhHdBODO6I2djP9srUJOZOknKxXqPn27TIKTpK70f1CN8mm+LjmVoYrp
    iGXC7KaH33yWioCqq1NaeijDZVd+e3089Y80LRzrcgjZC3pfn/Kz7S6HYuu0kavOgewi
    ed7FLyXmlwYhHoxEvIj+YMdge+UjxeINZw5/ytH7sz6ggXObGM9b4Hv9KBeJ+Nl9/ZFd
    4nBJlNLhq7o91/78WGGU8TUhbAQx0aEx0uGxenTSdmBFkWyVH33Aoel0BuUsdS//4hP8
    vC3RnQ7ntEYqkeRYlloaMFjARdKuzQQR15tNMSZODB7gBg9G8GfMSx5NabAfFwsdxOKB
    5yug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773926040;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qBjyZ7tBlwA5Rs8H7gLo2wC9H1zvpReUog1xQNRuiD4=;
    b=UYPCdI7Kw85rfWM0cO4AUVHB4Sf8ueeCkT3xizlAPP9Op21C7b4rHPR4nxxKtksjEm
    LZ/OIfDUc++dgyXIXcDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from [IPV6:2a00:6020:4a38:6800:217d:dfe3:b063:ecb0]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22JDE0s2N
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Mar 2026 14:14:00 +0100 (CET)
Message-ID: <c6bb76ce-0f3c-4775-beaf-174e281f991f@hartkopp.net>
Date: Thu, 19 Mar 2026 14:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, Ali Norouzi <ali.norouzi@keysight.com>,
 linux-can@vger.kernel.org
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260318165120.17560-2-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7151-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid,keysight.com:email]
X-Rspamd-Queue-Id: 60F0D2CC098
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hallo Marc,

the AI bot correctly remarked that the Fixes tag points to the wrong 
commit I took from Alis original patch.

Indeed it has to be

Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu 
size")

Can you correct that while applying the patch or should I resend it?

Best regards,
Oliver


On 18.03.26 17:51, Oliver Hartkopp wrote:
> isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
> to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
> wait_event_interruptible() and then calls kfree(so->tx.buf).
> 
> If a signal interrupts the wait_event_interruptible() inside close()
> while tx.state is ISOTP_SENDING, the loop exits early and release
> proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
> while sendmsg may still be reading so->tx.buf for the final CAN frame
> in isotp_fill_dataframe().
> 
> The so->tx.buf can be allocated once when the standard tx.buf length needs
> to be extended. Move the kfree() of this potentially extended tx.buf to
> sk_destruct time when either isotp_sendmsg() and isotp_release() are done.
> 
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Cc: stable@vger.kernel.org
> Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
> Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/isotp.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index da3b72e7afcc..2770f43f4951 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1246,16 +1246,10 @@ static int isotp_release(struct socket *sock)
>   	hrtimer_cancel(&so->rxtimer);
>   
>   	so->ifindex = 0;
>   	so->bound = 0;
>   
> -	if (so->rx.buf != so->rx.sbuf)
> -		kfree(so->rx.buf);
> -
> -	if (so->tx.buf != so->tx.sbuf)
> -		kfree(so->tx.buf);
> -
>   	sock_orphan(sk);
>   	sock->sk = NULL;
>   
>   	release_sock(sk);
>   	sock_prot_inuse_add(net, sk->sk_prot, -1);
> @@ -1620,10 +1614,25 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
>   	isotp_busy_notifier = NULL;
>   	spin_unlock(&isotp_notifier_lock);
>   	return NOTIFY_DONE;
>   }
>   
> +static void isotp_sock_destruct(struct sock *sk)
> +{
> +	struct isotp_sock *so = isotp_sk(sk);
> +
> +	/* do the standard CAN sock destruct work */
> +	can_sock_destruct(sk);
> +
> +	/* free potential extended PDU buffers */
> +	if (so->rx.buf != so->rx.sbuf)
> +		kfree(so->rx.buf);
> +
> +	if (so->tx.buf != so->tx.sbuf)
> +		kfree(so->tx.buf);
> +}
> +
>   static int isotp_init(struct sock *sk)
>   {
>   	struct isotp_sock *so = isotp_sk(sk);
>   
>   	so->ifindex = 0;
> @@ -1664,10 +1673,13 @@ static int isotp_init(struct sock *sk)
>   
>   	spin_lock(&isotp_notifier_lock);
>   	list_add_tail(&so->notifier, &isotp_notifier_list);
>   	spin_unlock(&isotp_notifier_lock);
>   
> +	/* re-assign default can_sock_destruct() reference */
> +	sk->sk_destruct = isotp_sock_destruct;
> +
>   	return 0;
>   }
>   
>   static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
>   {


