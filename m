Return-Path: <linux-can+bounces-5785-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9C8C9457C
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 18:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13C73A500B
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F220F067;
	Sat, 29 Nov 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ROc5xWZL";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="B2J6rlsM"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8976D531;
	Sat, 29 Nov 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435873; cv=pass; b=F9gp4qF030Uhpr2z2RM/UXxKqIyQccLSF4E7mHAYH1g6WH/fxvliUpSIE7qxFInONKAN3RdDqAt/qqQlO3EjzyGzIveKimVOABVOb7jNMJ7PVYOnuGfkHbY13ppcmA5QMETqUuwKO7nzHVoiQFLeD2ThT4Z0coEYCmLJ+XKkU3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435873; c=relaxed/simple;
	bh=Ek+53/WFExk8j+lqX0tO3Si+ktdF8V2tLN0MXtInEZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWiWINyqr03ZIzDLz031UvP+euvZtSReKssTNJCIPlaMfww/kMzSKzoJhEvRqgCC7bOL5Yuq4SQs1HfACjRgWCjlyoTjMAcF1MRErX8mGwwVdwO5odSI38rNJEJz9vZwk7AcHHOqprs8fLDIJqZO0o/xM5YUu7KLns+Q3UsEOmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ROc5xWZL; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=B2J6rlsM; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764435861; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kqRWKsB65UzMOYfxRsb4CVY21ZDJt3j2VT0HPI5dIVme5aBp6uA++pj6OhmwzWyrTd
    oCnJJEtKbBH4diFPCqhcnS/O3qdx13nMyD0ai3X5Mi1YqTglZzNdLFaS4LH9G1FpIB/5
    9xUsf8ETeYFCf8T/UId7Xc3TM2/rsgXBJFaw9jUDXuOoOMPTgqjFbhQRB3DqScwZqKUw
    f4y0XLBOpFKQm/fc3jhzBH1VkM76ZQ5s5SqFrLGttae6+uNUQGgMnzuyjj+/toQfbywT
    2obRI0pczYJtQHzZ0IgCGDqA6poKAkdCC9DOoosBBBcRAe8SPk4+YaTXYeE3GquBzHOS
    fjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764435861;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7I6du5593sFol3Crbkcx8oHVymKfimUVsRXkzCgKcc=;
    b=bBEwdSa1ZgFdbdY0BzbwhJ/DcLcamtWap+/p8gjQ2SQk/vLnXFgJNXEUGpw5VNSerP
    jiVUlX8ETcbIsn9Fdbqad7TBQiKSl+GhWpTMBxKjOh/qOHz23F1vEbumRE2dEx7CpkIh
    qILE0MWnA2GztKG18CQOD0Ab18VK0qK/D5YTnE6rtSxAERA26DesAAT7rmp1yOC4fUVU
    5vFsvq2nU1+3n59ZXJMp+jnzPzWjMPpgStzDgLIP7YSi1um+UImP6WAMhKkZUgKKH/oL
    GHx4ePMJcw/pUaMVPHCW9Fb5Rdl60LRjIuloqq9FTcZUuBKP1gj80YZiXR8S46Z+re1j
    Y/IA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764435861;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7I6du5593sFol3Crbkcx8oHVymKfimUVsRXkzCgKcc=;
    b=ROc5xWZL3v8PsTrhcZjqR+XMK7zUlwaz6B+IvgG75k8hsSUkaufiD+yahRJdb8sFYF
    kXrTDo6xZzIT40tSz8Y/Un+Rt92q6bzgX++TiW0/BHvQMW7tsJVfHBG1OQwgIflBi5yQ
    flXLVcqAH4S98D638YkEv0rHXU8zl9GYJD/sLG8YReA+Al5s2qIZjaywT9eaFiGT0q9W
    2QD920s8XgmxC9YdJ/kQg02O2zX7oRwb66q9FrJhxCScy51MAMagHFRImGJ7OuW6ITiU
    B7gjfGl5gNv1RP3hFC4s7TtQmPgkVw+7hsIeBD1SexhtsLYkfNp2hy+Vr5+erhipsWpT
    xGvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764435861;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U7I6du5593sFol3Crbkcx8oHVymKfimUVsRXkzCgKcc=;
    b=B2J6rlsMc7YjXt7mmB3aFsxNAovPnpUgAogHYwZaEs9pBOXpNtmd663qmXBB0Yf1IY
    3CGbqBk+sIJ93lnj56AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ATH4KjzT
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 18:04:20 +0100 (CET)
Message-ID: <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
Date: Sat, 29 Nov 2025 18:04:13 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about to KMSAN: uninit-value in can_receive
To: Prithvi Tambewagh <activprithvi@gmail.com>, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20251117173012.230731-1-activprithvi@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251117173012.230731-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Prithvi,

thanks for picking up this topic!

I had your mail in my open tabs and I was reading some code several 
times without having a really good idea how to continue.

On 17.11.25 18:30, Prithvi Tambewagh wrote:

> The call trace suggests that the bug appears to be due to effect of change
> in headroom by pskb_header_expand(). The new headroom remains uninitialized
> and when can_receive tries accessing can_skb_prv(skb)->skbcnt, indirectly
> skb->head is accessed which causes KMSAN uninitialized value read bug.

Yes.

If you take a look at the KMSAN message:

https://lore.kernel.org/linux-can/68bae75b.050a0220.192772.0190.GAE@google.com/T/#m0372e223746b9da19cbf39348ab1cda52a5cfadc

I wonder why anybody is obviously fiddling with the with the skb->head here.

When initially creating skb for the CAN subsystem we use 
can_skb_reserve() which does a

skb_reserve(skb, sizeof(struct can_skb_priv));

so that we get some headroom for struct can_skb_priv.

Then we access this struct by referencing skb->head:

static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
{
	return (struct can_skb_priv *)(skb->head);
}

If anybody is now extending the headroom skb->head will likely not 
pointing to struct can_skb_priv anymore, right?

> To fix this bug, I think we can call can_dropped_invalid_skb() in can_rcv()
> just before calling can_receive(). Further, we can add a condition for these
> sk_buff with uninitialized headroom to initialize the skb, the way it had
> been done in the patch for an earlier packet injection case in a similar
> KMSAN bug:
> https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/

No. This is definitely a wrong approach. You can not wildly poke values 
behind skb->head, when the correctly initialized struct can_skb_priv 
just sits somewhere else.

In opposite to the case in your referenced patch we do not get a skb 
from PF_PACKET but we handle a skb that has been properly created in 
isotp_sendmsg(). Including can_skb_reserve() and an initialized struct 
can_skb_priv.

> However, I am not getting on what basis can I filter the sk_buff so that
> only those with an uninitialized headroom will be initialized via this path.
> Is this the correct approach?

No.

When we are creating CAN skbs with [can_]skb_reserve(), the struct 
can_skb_priv is located directly "before" the struct can_frame which is 
at skb->data.

I'm therefore currently thinking in the direction of using skb->data 
instead of skb->head as reference to struct can_skb_priv:

diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 1abc25a8d144..8822d7d2e3df 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -60,11 +60,11 @@ struct can_skb_priv {
         struct can_frame cf[];
  };

  static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
  {
-       return (struct can_skb_priv *)(skb->head);
+       return (struct can_skb_priv *)(skb->data - sizeof(struct 
can_skb_priv));
  }

  static inline void can_skb_reserve(struct sk_buff *skb)
  {
         skb_reserve(skb, sizeof(struct can_skb_priv));

I have not checked what effect this might have to this patch

https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/

when we initialize struct can_skb_priv inside skbs we did not create in 
the CAN subsystem. The difference would be that we access struct 
can_skb_priv via skb->data and not via skb->head. The effect to the 
system should be similar.

What do you think about such approach?

Best regards,
Oliver


