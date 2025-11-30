Return-Path: <linux-can+bounces-5793-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3DC952E7
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0573834234A
	for <lists+linux-can@lfdr.de>; Sun, 30 Nov 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0128C2BF;
	Sun, 30 Nov 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOe11aQZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BD2836F
	for <linux-can@vger.kernel.org>; Sun, 30 Nov 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764523779; cv=none; b=T4t3F/A5PATc156mzk20vB0sxq0TrO82gz4dlV5n2J2OSTJGYwgrXypRagIM5eFxcC+1zOxHkwdL9jAKExSZCvVotHUiFobI2UWezYrSL4+LsaL3wy+r2eK1Et+WvwrNOkBCEpq3Oh9A8kviAUkVXm8V8vbgzyyygiy3nHSCbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764523779; c=relaxed/simple;
	bh=Mu+DZaanwEBg4FEHkyAe6Mn64+PlLTqLU9xScAMTXNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNgqJi5trZ6M9ndLQlQelfViXYDAPKdc99iTx/epYAaYDXvDreC90PiTzhpLIGkaqbX/ybK7lnBPFjh3KbZrMuj5awl83EcwSsRsNaebAcZbTppFHdCr5f/41nfPV2JeZwWQmx+vhlneo1nQ0tfhwZ16dNdgznXiRYcG5XuNCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOe11aQZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34372216275so3510550a91.2
        for <linux-can@vger.kernel.org>; Sun, 30 Nov 2025 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764523777; x=1765128577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vf5Y6PF0mnQ0gDxdyhdlhJnQdfMfj542mYRZWiFpENU=;
        b=aOe11aQZkYQeFxL4I4A2kuWeWcFGaywEIirMnY1EnBfCNSYOLUMZSgozNL02Tz933T
         HZBX0k24UUMfWcxde3Av/S+dvrMAxrhwq1bPmOaFmIYwf3udOrjSQZX4QRTU5DwHNWm6
         zNBlIvY7lLlct9pdo4ilWlMZ553+wWIUQpCLY04HF31wFhULiBc+HsgEsYInMA1ftzsN
         9OdoIy+PZ3ojKa+9ZXNi8ssfO6yKslC/ZhKlva+e265b9YSNhNp94MArTxA+JTMQuWKX
         9v3WHGdPI3jvjEuOyiDW8+fL/7att5Se7udwCPVIqyBcbSwsaFulhVST5rAZ/MNCJjhC
         lhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764523777; x=1765128577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vf5Y6PF0mnQ0gDxdyhdlhJnQdfMfj542mYRZWiFpENU=;
        b=DDJoWlnB4NYiJvgXqsZdDtyD1w8smbsNwCK7xKkWjh0NLdTV4+djKohlJgL7GclACS
         ud09OnDLp96ePI37gDLXrnqADZLUCyBBWZqARz5Sbiof3AROkf4qs0z9poP2tk2zkWBL
         Uab/0PbY+PGBsEAPLgATtI5IZi1ftTJs2HNEgH+orIoJ4IYUR2HAqyg8F2vkxG1Qk8Py
         KhvrokRvm2ZdWNu0Mv8EIF++yqSthSbbqi3ouTwaQwx38JeQHJbLDZsY5Jxb6j72S/Y2
         TLUjoeEpTzdXDKXzkRVnu2AIj7iU4JyMzKbg8lMpmfvTKSrQ1KRPolDoQ3PSyWCHJACb
         e3IA==
X-Gm-Message-State: AOJu0Ywp4ivSJSwQ0jSq3bbSTWx29AUPn/UUZogUSqME1YhOPFZDdNWo
	DjF2aQaUqRQ6GwbDPXcyk9DVwX9YhOEY+onx+AmoPA/hU0J8vw7YUAxd
X-Gm-Gg: ASbGncuNAigL2iTXvmZzkxSYcb9K9oiLGB3TO6seVMTO6N3Vz0f/byEOiCbJ4HsSuLy
	fOmaHO+fTv17gFXfdBDHeMtkwX7+rDbeEpo+Sqtpu4Y7OUdHFov0BQXrdi9e3Iqpd9ygmHkOG+S
	lYYYWCpK8j7dHUjyKKcczF3v97fKquwFiqSFtOEtjQU/MCSfi/T+Yjt8nFO+61rfFsSB1r5PAXS
	aVqXugY0hk1Zr4GrxXfeBJDEkCffuRt5XkiXY6V+k3kC1PquRt4+qMqkmPfTCZJ7zCPWcpJqD6q
	Za7heFSsaJLsvF6WHdoboFVUzlRsTSPCCnoZcfpOlsPvF6iy0YvKVJfyuEdMcOHs3vRJG5ExGu9
	Ae6wfrwMvPniIlSmKRAcP13nzqBr6WLOKR2sPynz1R0SVhw1DwCbRJM1Bkk5znEdx51vTWfIEuY
	P3q0vYzw9nE8QfM6BNxdU6
X-Google-Smtp-Source: AGHT+IHYodHXs9x9NXGCPLYUYzvf/eA37WxLpZ6dYfV4pmUOmeNy3dSjPJJZM8NPqCP/wRPJleggCw==
X-Received: by 2002:a17:90b:510a:b0:340:f05a:3ec3 with SMTP id 98e67ed59e1d1-34733f5b79bmr34695562a91.33.1764523777428;
        Sun, 30 Nov 2025 09:29:37 -0800 (PST)
Received: from inspiron ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e9c3f23sm11016850b3a.36.2025.11.30.09.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 09:29:36 -0800 (PST)
Date: Sun, 30 Nov 2025 22:59:31 +0530
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, mkl@pungutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
Subject: Re: Question about to KMSAN: uninit-value in can_receive
Message-ID: <aSx++4VrGOm8zHDb@inspiron>
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>

On Sun, Nov 30, 2025 at 01:44:32PM +0100, Oliver Hartkopp wrote:
>
>
>On 29.11.25 18:04, Oliver Hartkopp wrote:
>>Hello Prithvi,
>>
>>thanks for picking up this topic!
>>
>>I had your mail in my open tabs and I was reading some code several 
>>times without having a really good idea how to continue.
>>
>>On 17.11.25 18:30, Prithvi Tambewagh wrote:
>>
>>>The call trace suggests that the bug appears to be due to effect 
>>>of change
>>>in headroom by pskb_header_expand(). The new headroom remains 
>>>uninitialized
>>>and when can_receive tries accessing can_skb_prv(skb)->skbcnt, indirectly
>>>skb->head is accessed which causes KMSAN uninitialized value read bug.
>>
>>Yes.
>>
>>If you take a look at the KMSAN message:
>>
>>https://lore.kernel.org/linux- 
>>can/68bae75b.050a0220.192772.0190.GAE@google.com/T/ 
>>#m0372e223746b9da19cbf39348ab1cda52a5cfadc
>>
>>I wonder why anybody is obviously fiddling with the with the 
>>skb->head here.
>>
>>When initially creating skb for the CAN subsystem we use 
>>can_skb_reserve() which does a
>>
>>skb_reserve(skb, sizeof(struct can_skb_priv));
>>
>>so that we get some headroom for struct can_skb_priv.
>>
>>Then we access this struct by referencing skb->head:
>>
>>static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>>{
>>     return (struct can_skb_priv *)(skb->head);
>>}
>>
>>If anybody is now extending the headroom skb->head will likely not 
>>pointing to struct can_skb_priv anymore, right?
>>
>>>To fix this bug, I think we can call can_dropped_invalid_skb() in 
>>>can_rcv()
>>>just before calling can_receive(). Further, we can add a condition 
>>>for these
>>>sk_buff with uninitialized headroom to initialize the skb, the way it had
>>>been done in the patch for an earlier packet injection case in a similar
>>>KMSAN bug:
>>>https://lore.kernel.org/linux-can/20191207183418.28868-1- 
>>>socketcan@hartkopp.net/
>>
>>No. This is definitely a wrong approach. You can not wildly poke 
>>values behind skb->head, when the correctly initialized struct 
>>can_skb_priv just sits somewhere else.
>>
>>In opposite to the case in your referenced patch we do not get a skb 
>>from PF_PACKET but we handle a skb that has been properly created in 
>>isotp_sendmsg(). Including can_skb_reserve() and an initialized 
>>struct can_skb_priv.
>>
>>>However, I am not getting on what basis can I filter the sk_buff so that
>>>only those with an uninitialized headroom will be initialized via 
>>>this path.
>>>Is this the correct approach?
>>
>>No.
>>
>>When we are creating CAN skbs with [can_]skb_reserve(), the struct 
>>can_skb_priv is located directly "before" the struct can_frame which 
>>is at skb->data.
>>
>>I'm therefore currently thinking in the direction of using skb->data 
>>instead of skb->head as reference to struct can_skb_priv:
>>
>>diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
>>index 1abc25a8d144..8822d7d2e3df 100644
>>--- a/include/linux/can/skb.h
>>+++ b/include/linux/can/skb.h
>>@@ -60,11 +60,11 @@ struct can_skb_priv {
>>         struct can_frame cf[];
>>  };
>>
>>  static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
>>  {
>>-       return (struct can_skb_priv *)(skb->head);
>>+       return (struct can_skb_priv *)(skb->data - sizeof(struct 
>>can_skb_priv));
>>  }
>>
>>  static inline void can_skb_reserve(struct sk_buff *skb)
>>  {
>>         skb_reserve(skb, sizeof(struct can_skb_priv));
>>
>>I have not checked what effect this might have to this patch
>>
>>https://lore.kernel.org/linux-can/20191207183418.28868-1- 
>>socketcan@hartkopp.net/
>>
>>when we initialize struct can_skb_priv inside skbs we did not create 
>>in the CAN subsystem. The difference would be that we access struct 
>>can_skb_priv via skb->data and not via skb->head. The effect to the 
>>system should be similar.
>>
>>What do you think about such approach?
>>
>>Best regards,
>>Oliver
>>
>
>Hello Prithvi,
>
>I'm answering in this mail thread as you answered on the other thread 
>which does not preserve the discussion above.

Hello Oliver,

Apologies for this, I was using git send-email and probably messed up with
the Message ID. I have just set up mutt, this should be correct now.

>
>On 30.11.25 13:04, Prithvi Tambewagh wrote:
>> Hello Oliver,
>>
>> Thanks for the feedback! I now understand how struct can_skb_priv is
>> reserved in the headroom, more clearly, given that I am relatively new
>> to kernel development. I agree on your patch.
>>
>> I tested it locally  using the reproducer program for this bug 
>provided by
>> syzbot and it didn't crash the kernel. Also, I checked the patch here
>>
>> https://lore.kernel.org/linux-can/20191207183418.28868-1-socketcan@hartkopp.net/
>>
>> looking at it, I think your patch will work fine with the above patch as
>> well, since data will be accessed at
>>
>> skb->data - sizeof(struct can_skb_priv)
>>
>> which is the intended place for it, according to te action of
>> can_skb_reserve() which increases headroom by length
>> sizeof(struct can_skb_priv), reserving the space just before skb->data.
>>
>> I think it solves this specific KMSAN bug. Kindly correct me if I am 
>wrong.
>
>Yes. It solves that specific bug. But IMO we need to fix the root 
>cause of this issue.
>
>The CAN skb is passed to NAPI and XDP code
>
> kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
> pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
> netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
> netif_receive_generic_xdp net/core/dev.c:5112 [inline]
> do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
> __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524
>
>which invoked pskb_expand_head() which manipulates skb->head and 
>therefore removes the reference to our struct can_skb_priv.
>> Would you like to fix this bug by sending your patch upstream? Or else
>> shall I send this patch upstream and mention your name in 
>Suggested-by tag?
>
>No. Neither of that - as it will not fix the root cause.
>
>IMO we need to check who is using the headroom in CAN skbs and for 
>what reason first. And when we are not able to safely control the 
>headroom for our struct can_skb_priv content we might need to find 
>another way to store that content.
>E.g. by creating this space behind skb->data or add new attributes to 
>struct sk_buff.

I will work in this direction. Just to confirm, what you mean is
that first it should be checked where the headroom is used while also
checking whether the data from region covered by struct can_skb_priv is 
intact, and if not then we need to ensure that it is intact by other 
measures, right? 

>
>Best regards,
>Oliver

Thank You,
Prithvi

