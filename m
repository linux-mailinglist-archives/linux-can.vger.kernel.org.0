Return-Path: <linux-can+bounces-100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B281B69D
	for <lists+linux-can@lfdr.de>; Thu, 21 Dec 2023 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18DE3B21D3E
	for <lists+linux-can@lfdr.de>; Thu, 21 Dec 2023 12:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B6A74E1D;
	Thu, 21 Dec 2023 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="m+y+MMPN";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1PkUc/n9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952F745DA;
	Thu, 21 Dec 2023 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1703162606; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wq9ySTquNiMobs7AXzCSyDv0JLXJwKd2uBLFEIiy5nDC+iKcQMAkGkhGiAeito4dYI
    RCxFXozwpoaV8Llbi8BpJ1kQu65Ee1h0uEn80SO9oQFpHQpOiyUlrkxLno9khEuC+c9W
    NcoQZSuh8xuBxi8+O4nfKzfXxmI5uGbRcxRvE27ca4zl0YzVf0Zuh3yf755GY31RXyWP
    PQ+qq7xLfANUqyLb62QTu+3vp47MMPWl5Zn5Wulq5C38Z5UF+n6p8wEgnulPQVH5h3rP
    4eRrgu+w2qhJv98gLEiC754FgAOV2cRq/TeukYsQmnn6Tj67CmdYeocLAokV9QjYhlvD
    phbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1703162606;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OnJHWMr4vKk6XiP+r2QVT4TOIv0IyaSpezaB4ruSasQ=;
    b=LRmyhNWo4ueMoafgKUBUVF8n7YiQFmPUERRcZNBbFF0A1uhkOA3ZEHkJnSz+OQkamj
    Y5xWLwbiD9dACGXBaUVgR11mWlKTrWpig0xQJj5TPQ5J5q1FV9Ez9bp1RJ/1kC4b7Yo8
    nnY3vIG5t4NprKnB/u5x/Z5KDlRoBpWIF3fuSf+H4DjrDvHrX/lKVDcI7P35FmecM6Pf
    snuKsrjB8kHYdDQ7U7rkEALw81AmlkKwXCO2OTeuCGtDCZ2rVe8VKp9NNfaqvb/AKTGy
    wvm7HqsJcUskmI/1tvt44Y8ngQ/eaHBpnpVdO2YPNfBj/QGvOx8lEIkfOaYm/5IRDft0
    Nevw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1703162606;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OnJHWMr4vKk6XiP+r2QVT4TOIv0IyaSpezaB4ruSasQ=;
    b=m+y+MMPN1c6s50wYacRg/AdJVOFOE4fLj+Oj8B+ZXwwnES6hONFnt0RNR230qovwLt
    y2eoFp5u2X3k2A5oZ7Nsm0HFYXrtEOcpJuOSL+il4ZN1YtpbYyLBPkFSR636qy0Gk4AF
    x1LVLlu7x6B1PZMIpJknBrFEY282ALxtN8bKEARYooqx5P7sdgOTRifkbSwAScQnGHvl
    pfIfM2qD7VN8yyrAwGorpDd5BK8IvtSXa0TYaJxQn51brYHrgI6Pl6a6ahUrHp5VsBqa
    0w4gdSehYfBZMkUyX3ItKMNJInANGbn+fCzmJAMwM29nvHvmOCMYAdCXsIhHZgzcqsQt
    OP2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1703162606;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=OnJHWMr4vKk6XiP+r2QVT4TOIv0IyaSpezaB4ruSasQ=;
    b=1PkUc/n9l2QdJ0x4TRkT6IaD6mtyw4PdYlyRs7wjmbvoUmiirEAz8BctcRDO67WlYu
    FqArJUDaTqs9y3vVtYCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USKM1xaWml9uO48Qn+p+6Jpeor1RA=="
Received: from [IPV6:2a00:6020:4a8e:5010:4fcd:cedc:3d60:abc3]
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id Kf147azBLChQlHf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 21 Dec 2023 13:43:26 +0100 (CET)
Message-ID: <0338581d-89f0-4cca-a360-7693a27eba37@hartkopp.net>
Date: Thu, 21 Dec 2023 13:43:19 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Questionable RCU/BH usage in cgw_create_job().
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20231031112349.y0aLoBrz@linutronix.de>
 <ba5d5420-a3ef-4368-ba36-3a84ed1458cf@hartkopp.net>
 <20231031165245.-pTSiGsg@linutronix.de>
 <20231130164330.bYbMzPz7@linutronix.de>
 <94c27fa1-bf19-48ae-bc20-7530d97bbd5f@hartkopp.net>
Content-Language: en-US
In-Reply-To: <94c27fa1-bf19-48ae-bc20-7530d97bbd5f@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

I've sent a RFC patch to be reviewed here:

https://lore.kernel.org/linux-can/20231221123703.8170-1-socketcan@hartkopp.net/T/#u

I hope your suggestion to use rcu_replace_pointer()
in the implemented way fits the requirements.

Best regards,
Oliver

On 2023-11-30 20:56, Oliver Hartkopp wrote:
> Hi Sebastian,
> 
> On 30.11.23 17:43, Sebastian Andrzej Siewior wrote:
>> On 2023-10-31 17:52:47 [+0100], To Oliver Hartkopp wrote:
> 
>>> The point is to replace/ update cf_mod at runtime while following RCU
>>> rules so always either new or the old object is observed. Never an
>>> intermediate step.
>>
>> Do you want me to take care of it?
> 
> Yes, sorry.
> 
> In fact I've searched some time what would fit best without getting a 
> clear picture.
> 
> As the changes triggered by the netlink update should come into action 
> with the next processed CAN frame I have thought about adding a shadow 
> 'mod' structure which is written instantly.
> And then a flag could be set, that is switched by the next incoming CAN 
> frame.
> 
> I just would have a problem with performing some memory allocation for 
> the 'mod' updates which might take some unpredictable time.
> 
> If you have some cool ideas please let me know. I'm unsure what is the 
> most effective and performant approach for this use case.
> 
> Many thanks,
> Oliver
> 

