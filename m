Return-Path: <linux-can+bounces-7587-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKRQLiWBAWqebgEAu9opvQ
	(envelope-from <linux-can+bounces-7587-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 09:11:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3963D508EA4
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6613006787
	for <lists+linux-can@lfdr.de>; Mon, 11 May 2026 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9999351C06;
	Mon, 11 May 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="hmpWqyQu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bV+pe5aa"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6825F7A9;
	Mon, 11 May 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483488; cv=pass; b=D2N5/6q52v1l0MRCZENsVWqUsNbI6CgfWqBO1/0eDyg4IYUt2OLO5/7/YI0uEGTvcjr+GhLetEkv01cic7zukEjyoAWtJJTQEW8MQR+8oEuFVv8QJLbZfokVBPcXfwAWQAoO1zVYRp9PyFpIj96ChdFwnvdF4/mjWY17Z/8/nrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483488; c=relaxed/simple;
	bh=UImvta3a5NA4XoofG4vqCbMJsh4Tg0jBZtNojaa64po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuVt9Co5T6Z5f99RsegV4/5GKjEWgVGO4QdHU+/t8o++exvAwYadN685fj3zYSUNbSoS7ZcWLXQCrR2XNOOgq5wG7kO3pkhYeiRR1fMwFJ6ehjNDdDJKVj6ZwFO1PxbbvwliqGW6iSPJDZEsmlvo3fPI+hDpKK1jTfbNV95iYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=hmpWqyQu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bV+pe5aa; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1778483113; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SCdkKtx6lLJiFDw9JyWRAEimSTdoaju0a+ZyiQB1nZLgmsXlsW8cUJsSL3P/ZlKJp2
    fHd9Gw/WULyLp6LLt2bpevDYndOcNmGCRmEP5C341rHHIc/5RcLhEwzNtFdgFbhEZJeB
    8Buj3x061sExlow00RDpD1g3TSF2XDM+O6kGYAWkqTWpVYwYz1imntN0mtJdCi+9MgZj
    r4yypS2QFdCQtWYnr63jzQBY8I9eNtywrrG54y1S3KnlaIzxlZkE1p0B8sGjN1JgoecP
    oNx7yDwaAsTMgyT5v+dSOcXiWkPYEJgvOJi1pH5JclJpY18YmxnXaDKnhubrFZdSaggh
    r1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778483113;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fHZWmTdj+4PYEFLNzW/jlzuShU1U3HOxuWcewnugzcw=;
    b=JW03OiIIxwiOe2FK+OwFCgGrteY+R+R5mkKgD8dFS7uFGo20v1Cqwda9JB6cvP2nO6
    OHspWIAxcvkL/NMvvA4nczVZ7IJ5UWoRUjubuwA4kAO+IyWvxq2aBaMNQIbBkK3ysmN9
    iex4VmS05UOLPlV6teisrO4S1kzKQ37EaEyRrzUvwbwievDBAOflucUj4trlNtxb5r11
    bBymalp61R+lMbzL81hZ0pRHYTjeeJIV5k7KLND1ZbSBX9q67npQC5w3FDFMqoylTkXL
    IloKcMGP30za+JDKX3FO666dLDE0oj4phbFIg33dnnUmhJabMEF9dZdRuuaOX0nWKCA0
    wUSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778483113;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fHZWmTdj+4PYEFLNzW/jlzuShU1U3HOxuWcewnugzcw=;
    b=hmpWqyQut69u4iLacj5/T4NSbeiKI6lfa3l4g52ol5e8t6YWsWpqGvKtA+cevann1N
    V0ISYxyZiILMjiyKViSEpE/X8/vs9V0LrLuIbc9E2hq6XRQ2wyO8PXOVEF5fON+lZNyp
    +eTZlPJRT+GmOGkkj8rStJHi14RpNwZHG6IpHSzvsJuJNTRejJ4N5Re2IOud5ggkptfc
    zLo+aOQm3zPas+wHRGa5I5p7sAu8P+pFumCERhOwolTuzkNH5ozQ5NqJ6oFhjmXYJDkt
    /JfVHH6o/KcQzLSNAijlR9zG19OdY1U6Ra+GjWs0SjlEypNMbEup0B0A87RjdWJYlKKc
    1BZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778483113;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fHZWmTdj+4PYEFLNzW/jlzuShU1U3HOxuWcewnugzcw=;
    b=bV+pe5aaqJSpPTM+hFSfbm4YPBphrp10AS0CKvYyRd/99lzLnbWpQSJ3UOMC/E1YEc
    /AEVT26exXSX9qNzRdAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from [IPV6:2a00:6020:4a38:6800:3499:34c0:1f42:76da]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24B75Cmvx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 11 May 2026 09:05:12 +0200 (CEST)
Message-ID: <14d3ad71-ade2-4d2b-8a67-b0fda3eef2b7@hartkopp.net>
Date: Mon, 11 May 2026 09:05:07 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] can: isotp: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Robin van der Gracht
 <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260507-getsock_two_can-v1-2-3c2ae9edfadc@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3963D508EA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7587-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Action: no action



On 07.05.26 11:34, Breno Leitao wrote:
> Convert CAN ISO-TP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/can/isotp.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..1c33f09fbd338 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1500,7 +1500,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
>   }
>   
>   static int isotp_getsockopt(struct socket *sock, int level, int optname,
> -			    char __user *optval, int __user *optlen)
> +			    sockopt_t *opt)
>   {
>   	struct sock *sk = sock->sk;
>   	struct isotp_sock *so = isotp_sk(sk);
> @@ -1509,8 +1509,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>   
>   	if (level != SOL_CAN_ISOTP)
>   		return -EINVAL;
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> +	len = opt->optlen;
>   	if (len < 0)
>   		return -EINVAL;
>   
> @@ -1544,9 +1543,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
>   		return -ENOPROTOOPT;
>   	}
>   
> -	if (put_user(len, optlen))
> -		return -EFAULT;
> -	if (copy_to_user(optval, val, len))
> +	opt->optlen = len;
> +	if (copy_to_iter(val, len, &opt->iter_out) != len)
>   		return -EFAULT;
>   	return 0;
>   }
> @@ -1718,7 +1716,7 @@ static const struct proto_ops isotp_ops = {
>   	.listen = sock_no_listen,
>   	.shutdown = sock_no_shutdown,
>   	.setsockopt = isotp_setsockopt,
> -	.getsockopt = isotp_getsockopt,
> +	.getsockopt_iter = isotp_getsockopt,
>   	.sendmsg = isotp_sendmsg,
>   	.recvmsg = isotp_recvmsg,
>   	.mmap = sock_no_mmap,
> 

Same pattern as in net/can/raw.c that had slipped in via net-next last 
time ;-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Breno!

Best regards,
Oliver

