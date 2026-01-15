Return-Path: <linux-can+bounces-6166-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33ED247EF
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DE530D9AAF
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1138A715;
	Thu, 15 Jan 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2Y19DpY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNhczbnX"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4E39525A
	for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480013; cv=none; b=GnKPKseUICnCY//fYpgWkfX4HyurBD5ZVf0O+FAnGeovMy9/HsKfLZ5P/prLkJugtoK2Rg1zCixxBgg1JXxteQfy+heQPMZaE93PG+Na9V4tYtcQGdr/Dgd/bahZozPiJAijMCZmgqTCM6ksR4s2E0COYVaFLJdtB9I/cZ0Km3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480013; c=relaxed/simple;
	bh=Yq5vpI/d/y4NRU9P2+aVKf5RFOa4W3Y9orH/MRQobz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH9mpMOtxrJmyOWfnndSDuNvDexeE6PykE4j4rLX+2gJm8mTg8K4dlC2CDzcDzOfIHjFdHel5l6fHVlk/Rd3LUrVoH3/q3EKE2OF0cdH0RE4sjzZmBhx85BRmDIXwWidjoT92WM6uVenH6uX7+ds1kMtP41+Ssjo8iPzI/lmyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2Y19DpY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNhczbnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768480011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
	b=B2Y19DpYSJgMbl11NWzRDOr+Q6Kq1Co6hFxuTk+uckO91ZUTLJv0MWLcUDxmftFX/hiYwm
	K2tl+oMZHA8IpT0Otb2J0iZ4XWO6F4PaX9Zh4m0pfXi/Fl5060n3Ox7R3nwLyImtmxLucm
	hw/feqxxwUb5X+ihdbz5ZmfgeSq0RGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-nAuNYiRzM3uem9t7fkSPTQ-1; Thu, 15 Jan 2026 07:26:50 -0500
X-MC-Unique: nAuNYiRzM3uem9t7fkSPTQ-1
X-Mimecast-MFC-AGG-ID: nAuNYiRzM3uem9t7fkSPTQ_1768480009
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-432db1a9589so925979f8f.0
        for <linux-can@vger.kernel.org>; Thu, 15 Jan 2026 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768480008; x=1769084808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
        b=iNhczbnXVtqT8plrD//9qOxY5s3Bys2OzOpGDcoNx5V2+jGRfVMEVFE0lR+c6KSpaA
         nlv/aKZTLth0gIrCoXvUapDwflI3d6ZAcX5r6ml8n5650pc04SMb+75hBYAeNicrQuLG
         6oEArNtRecGflLL81HKtyHfIg156XXB4vzbjE+9xntPG5TY0oxbZSsW9HVN1yFf8+MJG
         mFSFqljtyeZxOhxsemW8Pz+oZw9ZSzJJnvOCKBQlbPasFyVg7p5gBpEM9MbVFTSGNDZu
         tDTW9bMvx6S/LCbxJCuOTLGBySlrNQe9VODyUN6g4RVGeeEsH26pWLpLO5RPs7LK9cz8
         zuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480008; x=1769084808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGv9MHSU6a8Hwc4ePCKZ0lAw4KKwpWf9ybCPoSs7ryM=;
        b=LJPvCeIh3hyO2ess/wd7R84mqbp7u3mv8pzBLsVjGfKFxRg0QudukVzIRVC76qwpJI
         ditCCWAK+F9rH4gLxHKQsdCa7pufAZjrrbcsUbZxYK4oXRuhlfbt3SzcelXBU+YWwZex
         4ww6cn/135z22BDFiLXFc6UMreSpqH5JCPol+QU4t4cKR2nh8aNzjJs9u+LlQPM0uh1e
         ZWn/2CiWPxWrPomOUi7L1E0QL/zMTZdIzYiSK+yxX0exjpC4+2MkJ9DhKea42yz+Rido
         Kicf4qzsr0J6QDRsMjR5l5XlObarLshX1ruoIHYKHw3sOTCJ62J4qNMkZmpQKk2HdxCT
         8oNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Uk8qhYS5cr/7EGkSyszixLEPiPTnJ0ugWSKXWQtdgZguZKH+EgSYmTfqduXyEbM+xTJqP4rsdu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2WK4J49PR2q82nnN3/oriF/EdmQHPL7778+pol0PCmisEFfZ
	bSLfOSF6vyIgsHQcjGqSe4d2w6aSwITlZ/K98/RySpiQDxSUap1r1WH72Zol9OBY0uCvGuGIOVq
	Ar4knBDbtoYv6PnUE2Pe7N5mG1uoCjBlWD6jQPEU5puhRgqx6bZwiby90k38F5wxxwCp/Ww==
X-Gm-Gg: AY/fxX6hx3ElNZo6aB1+smZeCSMZ4s6Am/iaUdmTPOrMGRb2yNcinP0cE7wppfKS+5N
	FTcrHdrKptuY6Hu2KMjXVFZw1DsiPI+09XKVK5cTtwLJA6pHlwbvv9YdqLkpENamCLtvjH5I7K/
	S8TY4cTME36+Y4LYZtwGc2p4NZiSITaS9aWGPgw4LGFJIPZyMvobZct701QUo9stYuXR4m5RnES
	bwJ2wxfGtP2uxNYSSwW1v3cRNPlNwXv5Ol5TwS/VSNxI+lD5VwJqqGW11hYvGgZ6F7VXMuViHER
	9XAfwr4SYxA/UGhO5/J24RSXl29BZLV5kRDqjozo7FkErM8MsasAXPoMmWcvhkkATzFDqCL28VC
	vRFHJ6lw9SN4lCA==
X-Received: by 2002:a05:6000:1446:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-4342c5575dbmr6634598f8f.59.1768480007842;
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
X-Received: by 2002:a05:6000:1446:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-4342c5575dbmr6634570f8f.59.1768480007468;
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6fc8fbsm5424324f8f.39.2026.01.15.04.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 04:26:47 -0800 (PST)
Message-ID: <a315b18b-a9d5-4925-9e59-1b1596c28625@redhat.com>
Date: Thu, 15 Jan 2026 13:26:45 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] can: raw: instantly reject disabled CAN frames
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Arnd Bergmann <arnd@arndb.de>, Vincent Mailhol <mailhol@kernel.org>
References: <20260114105212.1034554-1-mkl@pengutronix.de>
 <20260114105212.1034554-4-mkl@pengutronix.de>
 <0636c732-2e71-4633-8005-dfa85e1da445@hartkopp.net>
 <20260115-cordial-conscious-warthog-aa8079-mkl@pengutronix.de>
 <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2b2b2049-644d-4088-812d-6a9d6f1b0fcc@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/26 10:18 AM, Oliver Hartkopp wrote:
> On 15.01.26 09:59, Marc Kleine-Budde wrote:
>> On 15.01.2026 08:55:33, Oliver Hartkopp wrote:
>>> Hello Marc,
>>>
>>> On 14.01.26 11:45, Marc Kleine-Budde wrote:
>>>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>>
>>>> @@ -944,6 +945,10 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>>>    	if (!dev)
>>>>    		return -ENXIO;
>>>> +	/* no sending on a CAN device in read-only mode */
>>>> +	if (can_cap_enabled(dev, CAN_CAP_RO))
>>>> +		return -EACCES;
>>>> +
>>>>    	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
>>>>    				  msg->msg_flags & MSG_DONTWAIT, &err);
>>>>    	if (!skb)
>>>
>>> At midnight the AI review from the netdev patchwork correctly identified a
>>> problem with the above code:
>>>
>>> https://netdev-ai.bots.linux.dev/ai-review.html?id=fb201338-eed0-488f-bb32-5240af254cf4
>>
>> Is the review sent exclusively in a direct email or available in a
>> mailing list?
> 
> No. I have checked the status of our PR in patchwork yesterday:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1042268
> 
> And I was wondering why my patch was marked "yellow"
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20260114105212.1034554-4-mkl@pengutronix.de/
> 
> The AI review marked the patch as "yellow" but the review result was not 
> accessible until midnight.
> 
> A direct feedback to the authors would be helpful.

The AI review is intentionally "revealed" in PW after a grace period to
avoid random people sending unreviewed/half-finished patches to the ML
just to get the AI review.

I insisted to raise such grace period to 24h to align with the maximum
re-submit rate, but I did not consider carefully the trusted PR cases.

/P


