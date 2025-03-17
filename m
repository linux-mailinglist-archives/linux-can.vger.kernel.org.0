Return-Path: <linux-can+bounces-3117-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B5A649EA
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 11:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0BD188D55A
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15F2376F4;
	Mon, 17 Mar 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Yj6Bdk26";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="lG2YHRZn"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2137233D8C
	for <linux-can@vger.kernel.org>; Mon, 17 Mar 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207077; cv=pass; b=YiIHx2KDJIqu8bpth7MNeRfqH1aPgES9Of8VCeV3pYwLm8qsJvV9At+BtcaA0kb8NxH0AolRGq3TUO7gSmOn1z00jVs4ty5Frkr2/nLsPbkFM3F0cWE0XwYl1aZCRbmydi5HWNkq/7pc9MVKroj8FEFFqdvZYODeUdTLte8AfSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207077; c=relaxed/simple;
	bh=0X3yv0hZ55PlqbYtDteK2AnraLPWaKmi5/2mkydOM9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbWLDtaRXyl812wlaL5LoLZoU0IuubZ2fJ/FGlT/PKfX/s0AFlZZTUHtahNMEaVKNZrc2eJHoL4fVlcYwa/3YXMSPB4B5Ie/8m5zuWM1zMCqK24OrAp8QJCE6P7md8tQvjJgchVAA2WGqttEvLQd5pLeegYu3pslfkiqAmeZVw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Yj6Bdk26; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=lG2YHRZn; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1742206885; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IEmi/ynGpDpsoOtjUMu1vlA6wMT0oyIrJ8R5wNUc9gBIcW5K1FCn8PP0oOg2Qegd2l
    PSpBoM9NgHv/a99l7Dq3ffk6f8EKXAe6V1nOn50u/lTGI9CnuX5VGfT7RCsFp009kUQZ
    P7N117StLF+tyCP+fVjGd5ObgHd0L3f2Hxb0zJfyP4XSIUn5ojChIAWSN9qH2lKUC4Wk
    HBJzKsuRZ5HDxvV4llLz4jzpJAAmhjKumHn0UUpOa76JW9HeF3uluUEMQqckGiOdfr55
    wXFV4Sr7idVikTQVQqAgbX6S7uGB0HvJN1NhzBY31oPv+sL8esAmkjc6uOSS1EXV/4rK
    T9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742206885;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=a5OHm9xNgUB+iqjWpR8D00bSzEYsOqXSddPeIyPosi4=;
    b=iOLlwwpn/1BDI6QdDYGCuRBb7LI2phPwSxugfcQFcXAe9BWpqObYaLhPlfQe7jz4uf
    j352XWdLOB5eGJl86mR3RYPyTPF7CjwG1q2dfmnb2jc+vFI9QLVnmsorYeAGyB3ijkfQ
    d1xhyiVn94NDhyTJOKXOmgrIfnBcwtI36dqkDPltjopLSR4MHcM1NIS15Hfm5EemKLFr
    7P5yErAwdSMmf6S28LMb8sDK6KztyO9VlMZOnesNQg8NzIo23Ql6f+DPO2Tl0QbjC2ol
    7+jiZ3+csmqj+9NGz0CpKwfsvMCH1KIOLgaMdHa5RTra0oAAoaKFzD9qDDoENPiUgXZa
    aNJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742206885;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=a5OHm9xNgUB+iqjWpR8D00bSzEYsOqXSddPeIyPosi4=;
    b=Yj6Bdk263IBnXugH6IBHVlkGuf7mRGd1dmNGJMJ6tWhjdBaYrwItUcIdFVo9he+NHM
    8AIOfqNBoSyiXUNjAAVlz8l+S1trqgcuuFgmnNlwXtyqR5uN82wWOci/7tc2Z26qcLUz
    GVBgj/bEzS7thd9mCky8ix0KH5A/UJR/SELo6caVvsO109Q9xEu1GzV53nsh38TH9L8+
    AK+xxfEsYk4TUEc1wWVqlKaaNBeEG5IQMEXKVhZLV7xmPirrIv60TLHa+4nyV3BcRmNC
    NwwzBJMJRq8rzjaUxNyBcwAknS2ktxN5uML6+PVQvi2yiRnBJ+K72ZIH+aN6/LQVXpTI
    0Q5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742206885;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=a5OHm9xNgUB+iqjWpR8D00bSzEYsOqXSddPeIyPosi4=;
    b=lG2YHRZnWdTtyTLay12zKYAf7arv6VjO8sY6y91IGSkaEjLAceyoCvN08GH/G6nnMX
    hz9JF0c4SF/32AY2t9Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e512HALPzx5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 11:21:25 +0100 (CET)
Message-ID: <fdcebcb4-f1d4-4fc8-82cf-62e1213538c0@hartkopp.net>
Date: Mon, 17 Mar 2025 11:21:25 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: add protocol counter for AF_CAN sockets
To: Davide Caratti <dcaratti@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
 <78951192-82b1-45bc-9903-d314c94cd182@hartkopp.net>
 <Z9f16MYRF_vlkkVY@dcaratti.users.ipa.redhat.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <Z9f16MYRF_vlkkVY@dcaratti.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Davide,

On 17.03.25 11:14, Davide Caratti wrote:
> thanks for reviewing!
> 
> On Sun, Mar 16, 2025 at 01:36:40PM +0100, Oliver Hartkopp wrote:
>> Hello Davide,
>>
>> thanks for your patch!
> 
> ouch, I forgot j1939. I had a selftest for that, but I could only
> test raw.
> 
>> But don't we need to take care on every place where sock_put() is called
>> where sock_prot_inuse_add() has to decrease the counter?
> 
> only the last call to sock_put() needs sock_prot_inuse_add(..., -1):

Right.
> 
> [...]
> 
>> ~/linux/net/can$ git grep sock_put .
>> af_can.c:               sock_put(sk);
> 
> 167         if (sk->sk_prot->init)
> 168                 err = sk->sk_prot->init(sk);
> 169
> 170         if (err) {
> 171                 /* release sk on errors */
> 172                 sock_orphan(sk);
> 173                 sock_put(sk);
> 174                 sock->sk = NULL;
> 175         } else {
> 176                 sock_prot_inuse_add(net, sk->sk_prot, 1);
> 177         }
> 
> ^^ this one does not need it because the 'in_use' counter is incremented
> in the else branch;

Right. That's how I understood it too.

>> af_can.c:               sock_put(sk);
> 
> 491 static void can_rx_delete_receiver(struct rcu_head *rp)
> 492 {
> 493         struct receiver *rcv = container_of(rp, struct receiver, rcu);
> 494         struct sock *sk = rcv->sk;
> 495
> 496         kmem_cache_free(rcv_cache, rcv);
> 497         if (sk)
> 498                 sock_put(sk);
> 499 }
> 
> this one comes from can_rx_unregister(), and it's called in RCU callback - so
> we can't tell if it happens before or after sock_put() in ->release().
> So we probably need something smarter in case we are not sure that ->release()
> is called at least once for each socket.

The can_rx_delete_receiver() might be called if the (e.g. USB) CAN 
interface is removed in the network notifier. So this is no gracefully 
socket termination from user space.
I think the need to decrease the prot-in-use counter here too.

> 
>> bcm.c:  sock_put(sk);
>> isotp.c:        sock_put(sk);
>> raw.c:  sock_put(sk);
> 
> this is  '->release()' of each protocol, that I aimed to cover in the
> patch...
> 
ACK

>> j1939/socket.c: sock_put(sk);
>> j1939/transport.c:      sock_put(session->sk);
> 
> ... except this one, that I forgot :)
> 

Things happen ;)

> I will send a follow-up patch soon.
> Thanks!

Thanks!

Best regards,
Oliver


