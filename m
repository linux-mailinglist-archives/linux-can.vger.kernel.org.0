Return-Path: <linux-can+bounces-3155-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68999A6747C
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 14:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C8216EAC6
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C771BC2A;
	Tue, 18 Mar 2025 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E7u9oOay";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qKMdKOEN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEB2E62C
	for <linux-can@vger.kernel.org>; Tue, 18 Mar 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303095; cv=pass; b=ewVtT/ueovLzelS/nGSmKX9u5E2+dfJNG/Flw2lk4JxFsVkyFa3HmHGZnkSt9rmiN9EOSJyZ6Ti/N8rAIJw0bf1l56TqcXNEbj8/cSxRGmhVrWbGvXvbN63phtq2YgAexNnKxb//ESzZvM9Tf1HSWl8FZdfBUzJoe/ypaLkwtH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303095; c=relaxed/simple;
	bh=Mr5XHmetng3u8jfDQy94XS0MgTZSwXBjSx2SJsaXXiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4tzTlwfbsyUHKzPnpW84YfvMGJ1Syow4U/SSgomBnnqWu4PHefgffsWbP8j8UOe7iSn8vf4+V2JFrao0ylmI01tllcKQG7Fq1L/g6xhBMMfqzfLPoBr4yJRwHn0yIx/Lr6Z6mu8Wc6FSnG245CTKuCGYX5KzhzwRLrbuIHbsIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E7u9oOay; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qKMdKOEN; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1742302897; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=swJWFPpG5DJq5C5M83avbIaym9zOi31X7+MSKZpv+mfjlZf+bEHvka2Qg8y5LEVH5p
    Dwm0/ZRbIcFYGu9dbmhNtqJ12hqd7O0Sfb1xMkUrDD/+2vRIpoxe/En/G87kdVt5JxfU
    Wx2el5zMoKax5nSU7nhAUXhkQmeAtMexgxaPWaaw5AYpqFFemEJaQ4cuojan3G7SHzlp
    vSIY2/fTNcdRzNJKIhOE3FYCdTimw3T2zP4FYkhSgaLfRcmxBZgYzfA+2tprfXQit8hl
    eglytDJjk7or8a1URgP9/GuhDAvQyH8kuiah4GeC82m4/77jA4TH6cyKdvMiFKNBMLxb
    EpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742302897;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ljmsm+7GYJcolyYWOIgEhHTLYMJkS+Ima0+yE6EL1Hg=;
    b=T7/xhW+Khp1IlYLI7LAMMTxc/W0UrbTfFSn4KgX59WJToCDrTVqnPfLiMq8XddxdcT
    7SaJidPWqnFbpcD4Xg1PCu6wgkCvxC+sT/w3l3yUU8tFPOrpMmWYuUsxIsHiHgdQIWta
    SflBKqhF8d2aRupOPn3v22fk6ik8b+c6gVvJOvnVLO4oKmy4ActhxotrctZGV/5VBU7z
    DA+IrHI5u+QoV/MQIRnOr9MXNeJkw/yJO7ed+dyZ0xFgPss0CpmdoPcQgCoRrKtQ+cQG
    90ELmcF2TQwYVXwMAKG8inVJFuJ6pfZsCq31PbZjt0HdQu7HRtqrqaJH07e+5bgkRrfy
    j8tg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742302897;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ljmsm+7GYJcolyYWOIgEhHTLYMJkS+Ima0+yE6EL1Hg=;
    b=E7u9oOayQRc3pG4HbDdpVllP5g79sYBY8Ad0fHCC65vAPfV2indacvf23AifpojF/f
    xs9IbHqSJQK0urcFzJxNUQ/cdAe81rDRvFY7aZLVz2zK5KyKA6KILJIxmEJJIRsFIAtG
    XGUpBMtVaBqGInZsiYqtxlY0En+wfbaGgBmAVfDWINTcN558RDrldXSs9J0VgM/nKuhs
    SZNw1AqJBkl6jNM5N4vHJDV7mJxYVj3vvF8KTgau9yzaQe9/cAtJe45bvK9Bw9gHGaZ+
    76O21kHLtEdACaWsrhuvqvFtWgtiOAHjmOeOFN43N2qX83KblxkIREIKPNTkYR9j+hRc
    tmug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742302897;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ljmsm+7GYJcolyYWOIgEhHTLYMJkS+Ima0+yE6EL1Hg=;
    b=qKMdKOENO+iLaZ9Fd1ebvmW3yRlygPf2Hl47pe4AS4CwIX/qQmP548OdL+US1X25dI
    t4o/PkDigYhttffTLsCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512ID1b8Xt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 18 Mar 2025 14:01:37 +0100 (CET)
Message-ID: <c28e12e3-5f1f-4e96-b8f4-20afd1b210d9@hartkopp.net>
Date: Tue, 18 Mar 2025 14:01:31 +0100
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
 <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>
 <Z9f16MYRF_vlkkVY@dcaratti.users.ipa.redhat.com>
 <fdcebcb4-f1d4-4fc8-82cf-62e1213538c0@hartkopp.net>
 <Z9hErDHczAhqds_Q@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <Z9hErDHczAhqds_Q@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17.03.25 16:50, Davide Caratti wrote:
> hi Oliver,
> 
> On Mon, Mar 17, 2025 at 11:21:25AM +0100, Oliver Hartkopp wrote:
> 
>>>> But don't we need to take care on every place where sock_put() is called
>>>> where sock_prot_inuse_add() has to decrease the counter?
>>>
>>> only the last call to sock_put() needs sock_prot_inuse_add(..., -1):
>>
>> Right.
> 
> well, it does not even need to be the very last caller. Just +1 for each
> socket created, -1 for each socket released. /proc/net/protocols counts the
> number of active sockets for each protocol, so it's ok not to account for
> dead / already-orphaned ones that are just waiting for being freed in some
> later RCU callback - like it happens   See below:
> 
> [...]
>   
>>>> af_can.c:               sock_put(sk);
>>>
>>> 491 static void can_rx_delete_receiver(struct rcu_head *rp)
>>> 492 {
>>> 493         struct receiver *rcv = container_of(rp, struct receiver, rcu);
>>> 494         struct sock *sk = rcv->sk;
>>> 495
>>> 496         kmem_cache_free(rcv_cache, rcv);
>>> 497         if (sk)
>>> 498                 sock_put(sk);
>>> 499 }
>>>
>>> this one comes from can_rx_unregister(), and it's called in RCU callback - so
>>> we can't tell if it happens before or after sock_put() in ->release().
>>> So we probably need something smarter in case we are not sure that ->release()
>>> is called at least once for each socket.
>>
>> The can_rx_delete_receiver() might be called if the (e.g. USB) CAN interface
>> is removed in the network notifier. So this is no gracefully socket
>> termination from user space.
>> I think the need to decrease the prot-in-use counter here too.
> 
> AFAIU sock_put() in can_rx_delete_receiver() is always balanced with
> sock_hold() here:
> 
> 564         /* schedule the receiver item for deletion */
> 565         if (rcv) {
> 566                 if (rcv->sk)
> 567                         sock_hold(rcv->sk);
> 568                 call_rcu(&rcv->rcu, can_rx_delete_receiver);
> 569         }
> 
> and we have can_rx_unregister() also in ->release(). So, I think it's OK not to
> do sock_prot_inuse_add(..., -1) inside the RCU callback and just decrement the
> after socket is orphaned. For similar reason, I think that
> 
> 252 static void __j1939_session_drop(struct j1939_session *session)
> 253 {
> 254         if (!session->transmission)
> 255                 return;
> 256
> 257         j1939_sock_pending_del(session->sk);
> 258         sock_put(session->sk);
> 259 }
> 
> does not need to touch 'in_use' counter, because it couples with this:
> 
> 2025         /* skb is recounted in j1939_session_new() */
> 2026         sock_hold(skb->sk);
> 2027         session->sk = skb->sk;
> 
> for a socket (namely skb->sk) that's already created.
> 
> [...]
> 
>>> this is  '->release()' of each protocol, that I aimed to cover in the
>>> patch...
>>>
>> ACK
>>
>>>> j1939/socket.c: sock_put(sk);
> 
> bottom line, I think we only need one sock_prot_inuse_add(..., -1)
> in the above file. WDYT?

Makes sense.

@Marc: Can you please finally review the fix?

Thanks,
Oliver


