Return-Path: <linux-can+bounces-3104-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A2A635A3
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 13:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633AE3A5617
	for <lists+linux-can@lfdr.de>; Sun, 16 Mar 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2094D20328;
	Sun, 16 Mar 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F/ZFI4uf";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3CNpwFji"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7070DDF49
	for <linux-can@vger.kernel.org>; Sun, 16 Mar 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742128618; cv=pass; b=HSvhJM2FyVyNpZ2ncUclYTRUmN53DkufujEEOZkXgFP+Jyk/In99U+G4EJOgaTn3lZuZeB41nV8YvBoKmRLWVmD7Fc0tjlI28xDwMiOv5KcKWALTBY8Xk2Kze8wLfjB/NK0JPRAiQViedkb/pFQO3NDVuZMZLvrYB9BswGK+oD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742128618; c=relaxed/simple;
	bh=VSatf4B02bC/lgVO5XIF+gvB2FdE5rrx82yvm0T6LOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tV5ILWKbfShNr4QZYhJiJ60ehOr/+MDNsASTxWEWIDnJUnr1fP3aqL6F5vbhatoAtgY1wD0FWTP9gffwPVIaQIrBsDBEGzgZF3t9NLEF1gOgf2srh2iTBWGNBDAWniOJzf6MztoDAXctTF4lp3oapArwZb6NyXm7O163dehNngg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F/ZFI4uf; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3CNpwFji; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1742128606; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oKxcK99WcqLM6N2+yNIrF+qsIlU8NZaa8l6ZdfgAlVOAgPuiZz6vfwy1EhXE6cYXwf
    MJWe8RzaBo1CsGoTBq2ic+VDAViQLS1QG29ovurWZiSH0XuL5kNh1dkk4ZjM0vifvxxe
    jdn3lULPOnXEC08W2Ygp9NZwa83YjXFsR5X9AMQlkBmPdcZu+RQMaME3AqgKCsCz0seZ
    6RNuLlSp2y9HQb8MlO7jsXysC6wAoIEkaOTbsvEk7B8TFJA9sxMYo/5oSM2Vlw4W/s23
    WC2BL6KZVqWfobYfBQDcOs4lCkZmhlEk0CkNPj5hxmTRqhoZ3mrfy21cKogt5wSSmUub
    aDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742128606;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vWhvwgY66fG5U0ozks15ENsbxtV97oDMpWYfdv93ypc=;
    b=qf0RRafOBYtBD+NJmUptL7pUcMvZ3WAGk0MOWuxFalQ+6i4TnrMYBH5+CpV2eDjEr5
    6RMejRwz58Cs3zdNaehLFtc+ktIcuwXQ+9ywpsxqxhSlPWrbNVEZ9wbibi3yN4VvmLox
    vg2H7vt3n98RjPGAlDaupt1fNDB5rgcBZ3x1Y/SMzSfVk9tKEQExX5G1I6AObsstPOzI
    AGvStevH7bTNBMTMcz/JBOJ83BKOnqhVVvUJEOgUOkr46RDHg6b/UQdcqlnaUjcMiW8/
    Sz0SBHBzZ2gNgYtE4s0tD5i9m6ath3zaa8o2JBB7F249JMfAUwXKPDodRIqKD+FaEHdl
    o/QA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742128606;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vWhvwgY66fG5U0ozks15ENsbxtV97oDMpWYfdv93ypc=;
    b=F/ZFI4uf4iVuAXO+0zpCpwotQctcI5pG4AcdSSZBVxY71xW26kDFH5jEggBzr27JbD
    xBO5ptDze6xOf0h2u7ufcPYmiyX+QhUJVMvs3YxdRvJaV/PeB5u0mvTugKDITllnpUkc
    yhaC7bdXZfTjRE+wKG46QZe6gkLo/fwAbtBrDStaqJStTUGLv5ikfIwBGwFPrTGeG+/I
    j3LHY1auDCWrsCyVC3BqS6I5Pn01Xg88E7gKMS9wq1o9Vshawotnn0ckM7qHKjaQpAZ9
    LbyUUpPufOFzNUCsF2CHN164D2Ukjpnk1WuOqO/jEiRAKcJo/ZvNeBtr/Cd6DIPdENTn
    DwoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742128606;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=vWhvwgY66fG5U0ozks15ENsbxtV97oDMpWYfdv93ypc=;
    b=3CNpwFjiK6lpopTWvzLBHbAnFY5H29sc6rzslxZgDa9herbV+ghJepMyUGpvcn+nM0
    HDgt7LpBUQFxw2ssMJBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512GCakvxy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Mar 2025 13:36:46 +0100 (CET)
Message-ID: <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>
Date: Sun, 16 Mar 2025 13:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
To: Davide Caratti <dcaratti@redhat.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Davide,

thanks for your patch!

~/linux/net/can$ git grep sock_put .
af_can.c:               sock_put(sk);
af_can.c:               sock_put(sk);
bcm.c:  sock_put(sk);
isotp.c:        sock_put(sk);
j1939/socket.c: sock_put(sk);
j1939/transport.c:      sock_put(session->sk);
raw.c:  sock_put(sk);

But don't we need to take care on every place where sock_put() is called 
where sock_prot_inuse_add() has to decrease the counter?

Best regards,
Oliver

On 14.03.25 12:39, Davide Caratti wrote:
> The third column in the output of the following command:
> 
>   # grep CAN /proc/net/protocols
> 
> is systematically '0': use sock_prot_inuse_add() to account for the number
> of sockets for each protocol on top of AF_CAN family.
> 
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>   net/can/af_can.c | 2 ++
>   net/can/bcm.c    | 1 +
>   net/can/isotp.c  | 1 +
>   net/can/raw.c    | 5 ++++-
>   4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 01f3fbb3b67d..7b191dbe3693 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -172,6 +172,8 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
>   		sock_orphan(sk);
>   		sock_put(sk);
>   		sock->sk = NULL;
> +	} else {
> +		sock_prot_inuse_add(net, sk->sk_prot, 1);
>   	}
>   
>    errout:
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 217049fa496e..6dc041e054ba 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1625,6 +1625,7 @@ static int bcm_release(struct socket *sock)
>   	sock->sk = NULL;
>   
>   	release_sock(sk);
> +	sock_prot_inuse_add(net, sk->sk_prot, -1);
>   	sock_put(sk);
>   
>   	return 0;
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 16046931542a..789583c62f98 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1239,6 +1239,7 @@ static int isotp_release(struct socket *sock)
>   	sock->sk = NULL;
>   
>   	release_sock(sk);
> +	sock_prot_inuse_add(net, sk->sk_prot, -1);
>   	sock_put(sk);
>   
>   	return 0;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 9b1d5f036f57..020f21430b1d 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -397,11 +397,13 @@ static int raw_release(struct socket *sock)
>   {
>   	struct sock *sk = sock->sk;
>   	struct raw_sock *ro;
> +	struct net *net;
>   
>   	if (!sk)
>   		return 0;
>   
>   	ro = raw_sk(sk);
> +	net = sock_net(sk);
>   
>   	spin_lock(&raw_notifier_lock);
>   	while (raw_busy_notifier == ro) {
> @@ -421,7 +423,7 @@ static int raw_release(struct socket *sock)
>   			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
>   			netdev_put(ro->dev, &ro->dev_tracker);
>   		} else {
> -			raw_disable_allfilters(sock_net(sk), NULL, sk);
> +			raw_disable_allfilters(net, NULL, sk);
>   		}
>   	}
>   
> @@ -440,6 +442,7 @@ static int raw_release(struct socket *sock)
>   	release_sock(sk);
>   	rtnl_unlock();
>   
> +	sock_prot_inuse_add(net, sk->sk_prot, -1);
>   	sock_put(sk);
>   
>   	return 0;


