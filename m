Return-Path: <linux-can+bounces-8265-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QJZhJeKYUGrZ2AIAu9opvQ
	(envelope-from <linux-can+bounces-8265-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 09:01:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAFD737E3A
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 09:01:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0002 header.b=QaZPih9s;
	dkim=pass header.d=hartkopp.net header.s=strato-dkim-0003 header.b=BPR8dLNb;
	dmarc=pass (policy=reject) header.from=hartkopp.net;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8265-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8265-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F779300E151
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 07:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61697271443;
	Fri, 10 Jul 2026 07:00:50 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310263B6364
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 07:00:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666849; cv=pass; b=tpoNJ+/UoG8N3DAY4dJsViN226g++1FsPOf+198nmeg65HHfO0jJfLO7vykmX7tUPVRX9c+lBR2Nv64+3Vbf7th5t8pnm/vaMUWZzntPFlijCM1sElwnxSmaNO69RrtKlQDxAdN3VBS16iRyF2lgOockIDDD+yutO4DjGvHy97A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666849; c=relaxed/simple;
	bh=uEQzjm/roGkDpedhS8LNaUbm0fxgeQJgOjsZ4G0h3Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1uWOeJ5CUB+thVmcjnRa0w7w6kUMfgto51mszrtRrwMhCYb7ZwZoDPFxEj0gRrw5K5qNniMXpg7b1RtLlmvhF+5gGqU1kEv/GnDPKxDcVwUg02TLYaMr884m9e3+DepIZ0J5nHf4eouZ87JzZsTrEc2ZGZHg1woCT5/Z6hcYl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QaZPih9s; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BPR8dLNb; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal: i=1; a=rsa-sha256; t=1783666824; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P4jNWZ3e23VcIvDtyPgic6DTg79a/k2S+9AUqyuHZkJZv2dRnqL824hurcmCFspQlz
    7WFDIS9rnN07n9D7LRIHlz1OHEOpKJ+YEUTB+9Q9tpU2DrRgmCMIt9EKWDqPG8g2ltQY
    odCpWD7sMAAmUKBL+Lhgj9F85HHRNaeHyhfCY6GoGKxCt1LDOwV5zAWx0KNDCjY4QcPm
    Igb89DH0Olxcyv4YAXhfLfrJ9/F5deYe3k/HG2vxiCDDiEWKIDO4O2ck1s0ac0V6k6vX
    +7nJhIwjehycOJPZhWece3wYI0UVwCs/IQUHMO2Zypa8nzmH6Lz6iv0g4+Jm151Flg8e
    1MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=KgopI+MZ35kJpuoWug8Yk7MbF0p/v5MEixa4x3+1pEaQv7ILeXgufbe33XVGWLirj1
    nICIH+iaVosSoA/6llAnxm8E95/+vq3N4s2g8Ihn5EPrVSwr7oNHZMFFCFjA6dU8gCL2
    hbMFQD1DFUakM9FT07M31fBEVuOC+/RnPF3FTBQesThovBRjUtp188B3JIQlYbHV15iX
    akI7B9+DITOldxcsJFw/lU4CSQZZGIsFHwoLKfYKQRSWhllU6lWUpnTrrd5vG5chZLGL
    kyvfFEIMqgmQaCKTCkD2/o7K3m+IxKs2cVMckjIUo5ZqO0u6S9R4nfpO+CeBXIPJi10F
    IMhQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=QaZPih9sMrvejGP+V1klkklI3z0nVGjsCSo36ylli5A2yOXMKErJTY+2Jt7NV1/xOA
    edrPpj42B69g27oQz2L0gfulYEEGCnd5dekJUtn0bnvmTXRBGEqZksaOkt1XM+Tg5/8M
    MmI5AQEyzO5JIHA/UVrzVn0DvtorRJKK1BZUgZw5M395MkU9DIGacPv9y7eQtQn7oRQX
    YztPPKK2dbawaFXyAZdfhVqBpkKm0JFdc2IgnIIj2R9viWiDy+rqjq0EJPQCsdo/Y3Gq
    wtEC8htS3VgfNLzo12ZnfvY1GRs3ib1rufH4wCSva72vSLigsqVdscoAuv8iVe4KaCDP
    sadQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783666824;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=czu3yM1Jla68x0oZHD55EKdQktA5LFwkug6sw/72vxo=;
    b=BPR8dLNbn9VSuW1SClKhUYJaYJqbwf0/kRYwqmSYp3GNaoCk619BGToGfAZOBXO3R0
    dk4FTTFQQkED9uXmz+Dw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.236]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26A70O523
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 10 Jul 2026 09:00:24 +0200 (CEST)
Message-ID: <06ac5d34-e4bf-40e8-8d2c-2b361846cb74@hartkopp.net>
Date: Fri, 10 Jul 2026 09:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Nico Yip <zdi-disclosures@trendmicro.com>, linux-can@vger.kernel.org
References: <20260707094716.63578-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260707094716.63578-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8265-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:zdi-disclosures@trendmicro.com,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BAFD737E3A

Hi Marc,

do you consider to upstream this patch together with the BCM patch set?

I know sashiko-bot had again some "Pre-existing issue" remarked on this 
patch. But this simple fix should probably go into upstream, before the 
next "AI Pre-existing issue"-party starts with isotp.c and sashiko-bot ;-)

Best regards,
Oliver

On 07.07.26 11:47, Oliver Hartkopp wrote:
> isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
> and clears so->bound without waiting for a grace period. isotp_release()
> uses so->bound to decide whether it needs to call synchronize_rcu()
> before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
> skips that synchronize_rcu() and can cancel the timer while an
> in-flight isotp_rcv() is still executing and about to re-arm it via
> isotp_send_fc(), leading to a use-after-free timer callback on the
> freed socket.
> 
> sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
> therefore make isotp_release() always call synchronize_rcu() before
> cancelling the timers, regardless of so->bound. This still closes the
> original race (isotp_notify() clearing so->bound without waiting for
> in-flight isotp_rcv() callers before isotp_release() cancels the RX
> timer) without adding any RCU wait to the netdevice notifier path.
> 
> Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
> Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.kernel.org/
> Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/isotp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297..d30937345bcd 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1235,15 +1235,22 @@ static int isotp_release(struct socket *sock)
>   
>   				can_rx_unregister(net, dev, so->txid,
>   						  SINGLE_MASK(so->txid),
>   						  isotp_rcv_echo, sk);
>   				dev_put(dev);
> -				synchronize_rcu();
>   			}
>   		}
>   	}
>   
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>   	hrtimer_cancel(&so->txfrtimer);
>   	hrtimer_cancel(&so->txtimer);
>   	hrtimer_cancel(&so->rxtimer);
>   
>   	so->ifindex = 0;


