Return-Path: <linux-can+bounces-64-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719647FFBD8
	for <lists+linux-can@lfdr.de>; Thu, 30 Nov 2023 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B42CB20FCA
	for <lists+linux-can@lfdr.de>; Thu, 30 Nov 2023 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219E53E05;
	Thu, 30 Nov 2023 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="D+IO13YK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="uUggUW2a"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897DC4;
	Thu, 30 Nov 2023 11:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701374193; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HqcA8hYqJ/KSJCB+62HO5Z4+k4Y/IrNdyTR61JwGRbuCeBIBZ1AFgRsFPF5Xy23GQc
    3VvI+5x2bwlD/gTxKWuEg86IK+CEga2Rz6pB2NdWhbmUkO44exhyW2JU+Ycym4SSU/by
    YoHrY9ElJ7UUe3V6KH70qmlicAc/QbHing8sHHBYJ6+duR6lP03kl1UHGl7OUL6k/+S/
    nuiL98vhlFTevq0UW+LTlhaN/eZ70pBUHgfoLQ+cXcJrKzS8CQBpolRVqGswLLI1WxBt
    ZDrDHq8xxLriShNUHncEBsynqcwqa81iWxxic4N709M1wEsG1CM5WQXuiZhZRk2SBoYG
    LLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701374193;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aF7Ufp8/2p0lMnNdfIv9ae5Tkbo4WI7OPVRUBxBWjEU=;
    b=q9c8cUzlfU0H8thhj9T99IPWGOWPnx/JEa053VIjoB2PhEL0clsXps6C2PKwz39qex
    YhJCt/4x+vlvi1qskFjHRRMr5vonDhySErD7IenRN8NXPjcpaY6HIOH3VY2lxwiy4rI5
    XSxpUHfecumNAqs6+yUYRmQfiuuEOO8qbohna7eEeu1HrTROBvEvzvEJQQXb7yPJcvDf
    IZnS/o7EVAdbZw5D7cIe9z2hJwP3Z7p5cDbHnW/iuRq4hu/zpK/lkS2HnHBJ3udA0eaE
    Kf0FxfmfGW3JrQK3BwxSkKylX89Q4ypbB+i53mUcQzjNBAvx0JXCgOfvpEID/Jf8FaK0
    p/WA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701374193;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aF7Ufp8/2p0lMnNdfIv9ae5Tkbo4WI7OPVRUBxBWjEU=;
    b=D+IO13YKPU7cg1k+YeDX8RrxOtGr1QupMluZJVlAjzbs1ZQBQiq+tmtdhJjOVfPKpK
    MypKNFXv2WQok8Ub4VVIbY26lUeZijwWhBcQVaZC8Nn3aOsG9A9PVBqAfrYA6YzeRa/D
    Hj1agXdx9VajwkwqI2MoM9nkvr5HWaEowtVJplmVm4750mfaY2Sohzq2vdv2QYrpnBue
    HHX9OIj9rPIkxVU7vVhDSqlb5gftzZhRbTPe0Gbhi+4j89SSblOUOymWmVceJZ0m8ETR
    ZijjssXNVWcBuP4JOZQutR5GNLiAukoz0jy5E2sHTtZ6+rQB57tcegS+yU9oSabbBSXU
    6tdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701374193;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aF7Ufp8/2p0lMnNdfIv9ae5Tkbo4WI7OPVRUBxBWjEU=;
    b=uUggUW2aO97mSRqEm2Ndb6p8NyoRu/4nIs8Hp7KZlyz98BAMFnt3/n5D2gwGOdsMU9
    B2WQCBICnjB26oDuBCBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USPMTysFDTHpecLTS0tHtv4ev04ww=="
Received: from [IPV6:2a00:6020:4a8e:5000:1d72:9f4b:e0ff:4c6c]
    by smtp.strato.de (RZmta 49.9.7 AUTH)
    with ESMTPSA id Kba53bzAUJuX248
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 30 Nov 2023 20:56:33 +0100 (CET)
Message-ID: <94c27fa1-bf19-48ae-bc20-7530d97bbd5f@hartkopp.net>
Date: Thu, 30 Nov 2023 20:56:26 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
 <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
 <20231031165245.-pTSiGsg@linutronix.de>
 <20231130164330.bYbMzPz7@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20231130164330.bYbMzPz7@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 30.11.23 17:43, Sebastian Andrzej Siewior wrote:
> On 2023-10-31 17:52:47 [+0100], To Oliver Hartkopp wrote:

>> The point is to replace/ update cf_mod at runtime while following RCU
>> rules so always either new or the old object is observed. Never an
>> intermediate step.
> 
> Do you want me to take care of it?

Yes, sorry.

In fact I've searched some time what would fit best without getting a 
clear picture.

As the changes triggered by the netlink update should come into action 
with the next processed CAN frame I have thought about adding a shadow 
'mod' structure which is written instantly.
And then a flag could be set, that is switched by the next incoming CAN 
frame.

I just would have a problem with performing some memory allocation for 
the 'mod' updates which might take some unpredictable time.

If you have some cool ideas please let me know. I'm unsure what is the 
most effective and performant approach for this use case.

Many thanks,
Oliver

