Return-Path: <linux-can+bounces-5792-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70251C94F97
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 13:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289A93A391F
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA325B30D;
	Sun, 30 Nov 2025 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LW4yiazj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="WLzT4Y95"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95FE7E105;
	Sun, 30 Nov 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764506692; cv=pass; b=iGDje21CnUZxkyVAOts51MI3Xs0W/cFCOYnhq+JRzcxfEG/zyE1sbkRs77Pl5iGZaN00xwlEwCTnf/3zzhS2MIZ8S03iVbwY6RF4VqvWXiPwpHLbAaNViaCtOYQ9rUGD29gAtijiSyOmXMs7tt42mXzh1GOhw7HpWXNZwoBWi64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764506692; c=relaxed/simple;
	bh=BcG02mVkdv5Lnr8kgxjY0vgl3AlP4TUaj3jSKTffcws=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jj//b2zLHFXHVPl/4nPpGj5wcH6A24Q0nnaal569qbyhBQ7/Fjk7cuD/vv2ZGM6p//1rkg/clgK/lJ7nkdM0WU9lpfsYeO0UDmGb+NUvbF2O0zi7PGv4S1T/EtCpL1mx9ecnmJemiAWxEYWHbt5xSDoC1teve4cf2pflWfJ0ctI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LW4yiazj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=WLzT4Y95; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764506679; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lVNMjhoueHNyE5/po8qM8MoUD7pEHyc/xwpoa6chQfvafeZ4n72mv3OTPkdu1o6lwo
    oim2YzoO5rS/pZQ9rOZvTViuGsqujHiVfHuFlLRUkFK0vYwNHlEOk7lPV0bITjxKWA2U
    K8sjP459485X8EQV8EYToto6uDNnokgrjvgnKUHMka9/lUEwm13HO0j6vXo/FjzG4u8Z
    uzbYMvY2YhrY1SkabUyMbGjPpv14IKhr9lXwxKbP5FxvAzgi6MJ6IbbVrk9u8XV/fh3u
    CROkJkgXBm48PFf/aga5SWkLx6+ka4z7VHTmWu2Lzte6khwJD9UDVbKFaHqypupuyeHw
    Vmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764506679;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F+89cZKDAuAKRSUkLcSLux4W3P8rUbivw7sgJBVkpvQ=;
    b=KRfxmqr86o1cDa/Hmr0+eZ/DGkuoSR9dxR6jUv1suzHcMLArXdypNJqfmThAZaAhTD
    M5zArHSsveKyxysiFBS7R6VjbeHAenrNLXYVTN30SF9xNQYrJIxzppIIATHzC1vgJb5h
    71s8nuYDJpIDCkjumSLyR+17KxIOIwqLZX4k0shLp9KcFKjd3ThpWRyoSDqC8v2+lbqD
    YNPmsKmA0fMLFIb7ZJU5RNRilqhS4xznM9jbTsX0qEPt/reM2a9THH+ASChVrQbRC2ID
    93oKlj4e+LCxmZ8KfZXc2hcJid8JxApAtc0DD0nixIQQsg9Zdkc4xiubYtmhN54w5crX
    aEug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764506679;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F+89cZKDAuAKRSUkLcSLux4W3P8rUbivw7sgJBVkpvQ=;
    b=LW4yiazj9I/zuJSxSjFhR8hu1opXqEhmXgeA4WmybZjw7GFtINVZXHsjCF3pn7W237
    y8NNPgvaIMG1WHaEQVY4Q1BBX5TMTaIxDmOSwwmwfWD49y/AM8YtGj1J42bZDPTD9gpY
    F32s7v3MSaWhtiwqh48PDXlQzzQflWKfr/DnkbLG6v+ROBB3I3Nl4Tw5/OUkM+9DOrDs
    2cXCizg1tPGSTVBpwR806nKBYNvPnODLqWuU0puNFi3cR2CDp8/1Q6YIIP9koyCZtSmd
    qMkrLjbEfKjT0YN2sjT5nYn9Yqq/E6Rrw5c/Y595Ds9bSTYtRBWRsWjqYh1Sjx/htrXI
    HvGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764506679;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=F+89cZKDAuAKRSUkLcSLux4W3P8rUbivw7sgJBVkpvQ=;
    b=WLzT4Y955+0dQxY4fNfC1i4Dchs0VpvQC/PQAc99RqYe/dVt07tXtFSZIZzFNwDb3N
    HKqNhgBCe/VnDcL7jwBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AUCicm74
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 30 Nov 2025 13:44:38 +0100 (CET)
Message-ID: <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
Date: Sun, 30 Nov 2025 13:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about to KMSAN: uninit-value in can_receive
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Prithvi Tambewagh <activprithvi@gmail.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
Content-Language: en-US
In-Reply-To: <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.11.25 18:04, Oliver Hartkopp wrote:
> Hello Prithvi,
> 
> thanks for picking up this topic!
> 
> I had your mail in my open tabs and I was reading some code several 
> times without having a really good idea how to continue.
> 
> On 17.11.25 18:30, Prithvi Tambewagh wrote:
> 
>> The call trace suggests that the bug appears to be due to effect of 
>> change
>> in headroom by pskb_header_expand(). The new headroom remains 
>> uninitialized
>> and when can_receive tries accessing can_skb_prv(skb)->skbcnt, indirectly
>> skb->head is accessed which causes KMSAN uninitialized value read bug.
> 
> Yes.
> 
> If you take a look at the KMSAN message:
> 
> https://lore.kernel.org/linux- 
> can/68bae75b.050a0220.192772.0190.GAE@google.com/T/ 
> #m0372e223746b9da19cbf39348ab1cda52a5cfadc
> 
> I wonder why anybody is obviously fiddling with the with the skb->head 
> here.
> 
> When initially creating skb for the CAN subsystem we use 
> can_skb_reserve() which does a
> 
> skb_reserve(skb, sizeof(struct can_skb_priv));
> 
> so that we get some headroom for struct can_skb_priv.
> 
> Then we access this struct by referencing skb->head:
> 
> static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
> {
>      return (struct can_skb_priv *)(skb->head);
> }
> 
> If anybody is now extending the headroom skb->head will likely not 
> pointing to struct can_skb_priv anymore, right?
> 
>> To fix this bug, I think we can call can_dropped_invalid_skb() in 
>> can_rcv()
>> just before calling can_receive(). Further, we can add a condition for 
>> these
>> sk_buff with uninitialized headroom to initialize the skb, the way it had
>> been done in the patch for an earlier packet injection case in a similar
>> KMSAN bug:
>> https://lore.kernel.org/linux-can/20191207183418.28868-1- 
>> socketcan@hartkopp.net/
> 
> No. This is definitely a wrong approach. You can not wildly poke values 
> behind skb->head, when the correctly initialized struct can_skb_priv 
> just sits somewhere else.
> 
> In opposite to the case in your referenced patch we do not get a skb 
> from PF_PACKET but we handle a skb that has been properly created in 
> isotp_sendmsg(). Including can_skb_reserve() and an initialized struct 
> can_skb_priv.
> 
>> However, I am not getting on what basis can I filter the sk_buff so that
>> only those with an uninitialized headroom will be initialized via this 
>> path.
>> Is this the correct approach?
> 
> No.
> 
> When we are creating CAN skbs with [can_]skb_reserve(), the struct 
> can_skb_priv is located directly "before" the struct can_frame which is 
> at skb->data.
> 
> I'm therefore currently thinking in the direction of using skb->data 
> instead of skb->head as reference to struct can_skb_priv:
> 
> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 1abc25a8d144..8822d7d2e3df 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -60,11 +60,11 @@ struct can_skb_priv {
>          struct can_frame cf[];
>   };
> 
>   static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>   {
> -       return (struct can_skb_priv *)(skb->head);
> +       return (struct can_skb_priv *)(skb->data - sizeof(struct 
> can_skb_priv));
>   }
> 
>   static inline void can_skb_reserve(struct sk_buff *skb)
>   {
>          skb_reserve(skb, sizeof(struct can_skb_priv));
> 
> I have not checked what effect this might have to this patch
> 
> https://lore.kernel.org/linux-can/20191207183418.28868-1- 
> socketcan@hartkopp.net/
> 
> when we initialize struct can_skb_priv inside skbs we did not create in 
> the CAN subsystem. The difference would be that we access struct 
> can_skb_priv via skb->data and not via skb->head. The effect to the 
> system should be similar.
> 
> What do you think about such approach?
> 
> Best regards,
> Oliver
> 

Hello Prithvi,

I'm answering in this mail thread as you answered on the other thread 
which does not preserve the discussion above.

On 30.11.25 13:04, Prithvi Tambewagh wrote:
 > Hello Oliver,
 >
 > Thanks for the feedback! I now understand how struct can_skb_priv is
 > reserved in the headroom, more clearly, given that I am relatively new
 > to kernel development. I agree on your patch.
 >
 > I tested it locally  using the reproducer program for this bug 
provided by
 > syzbot and it didn't crash the kernel. Also, I checked the patch here
 >
 > 
https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/
 >
 > looking at it, I think your patch will work fine with the above patch as
 > well, since data will be accessed at
 >
 > skb->data - sizeof(struct can_skb_priv)
 >
 > which is the intended place for it, according to te action of
 > can_skb_reserve() which increases headroom by length
 > sizeof(struct can_skb_priv), reserving the space just before skb->data.
 >
 > I think it solves this specific KMSAN bug. Kindly correct me if I am 
wrong.

Yes. It solves that specific bug. But IMO we need to fix the root cause 
of this issue.

The CAN skb is passed to NAPI and XDP code

  kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
  netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
  netif_receive_generic_xdp net/core/dev.c:5112 [inline]
  do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
  __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524

which invoked pskb_expand_head() which manipulates skb->head and 
therefore removes the reference to our struct can_skb_priv.
 > Would you like to fix this bug by sending your patch upstream? Or else
 > shall I send this patch upstream and mention your name in 
Suggested-by tag?

No. Neither of that - as it will not fix the root cause.

IMO we need to check who is using the headroom in CAN skbs and for what 
reason first. And when we are not able to safely control the headroom 
for our struct can_skb_priv content we might need to find another way to 
store that content.
E.g. by creating this space behind skb->data or add new attributes to 
struct sk_buff.

Best regards,
Oliver

