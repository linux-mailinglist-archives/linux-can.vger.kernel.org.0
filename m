Return-Path: <linux-can+bounces-470-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A738AD369
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557D21F21EA4
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E7153BE7;
	Mon, 22 Apr 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="TXYn2Ks7";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mOgblIHN"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38A154440
	for <linux-can@vger.kernel.org>; Mon, 22 Apr 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807667; cv=pass; b=U7MIIThkNCeFqRq+fd//dD4LuqITdRr7ognaZjX55+Ny3/AJbbOEdg8o4RL/XeOs0u6Wi7tX3SWnFBDXT6JneELKrZjECZox7AqWt2ZyoVGI8DTD+eyQXGcKwI5cCSNBc6fOWbyz8o+2IhjpPlZIBwp9K00+rv/1HV1bMvViprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807667; c=relaxed/simple;
	bh=4DS4lAnwbE7kqiYHypNamZpbTYd4VtdNfs/qWQYFYsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MkYqYi3P/MVamgW30LzuPdASXyerKLJ0m/9qVF6WFb0d5Yc7EuEdyI1CHj1/t2obB1XSR//OcM36r98i5it2NBfTsZfYy31yZVIE8LAAA//MvlLGoyKBU9oe/82esTFtl3y5fhtpM6qnjpgLbP0UcUiO86xxEeX6yO/1aRIJavU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=TXYn2Ks7; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mOgblIHN; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713807655; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cfhbtv5Emy0B7iYMw9qXAqhivrP10lWMOFwpMAZNQAoRwP3NGzEBc3LFHW/gjk2Q2S
    goZUWcuADeRmzokHNCDmy+ugDnXXyyj1cvJKLkVKeG73FeH5gaMvrlwYzLQlgL0usmTx
    KTVerW6praCTL/g4FrBWtP3nkxCP+dSPVuXeaKk4ADLcn1QFNDE8ZRYhaQ+MNflXlTam
    9DYyD46Uxxo6eCytQ+PML0J8Cz8bCoMZxgz1cFaXwvtOUj/qgJgWftsrHiDLMeFHXXpG
    G2liZaZFGJdx7CEDOT1XZ0dfT/KRZV6/Q1VwgMsMr8Di+vfhVsXODeKi+TtW6znw92wJ
    IMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713807655;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n6N3F2iLe44QF/xdqQekCMxmg9ktN9153+H/5P/spwc=;
    b=UgndA+wf/id4fALO/QBtCWAW7C4/rRSqWwgPYloBRJHxfNILstk+O1W14vWg4mICF6
    JQxZpb6vv0LZ6jBopY1a/pfa5Mhb7D0jDw2kTg2BByIUrYHERz9QHS+CNWCruDpES4pm
    tCIKEVadla6rVJzbd6Zpu/qw12roXLrKidU7QYzS9EqLcwqRrHf3/In/lwfYTzyfnhHz
    XA1JXMmg+3PPTQJ/rfCyi5P8he50lG5Zt4WoiNZf+aczsrqWRxYlO8xaARv5eH5XikDo
    23vnXdeo/JzZFLk7C8TR90hHfF5cYhsM0+gfJniLUBgzVfpO8QD6ou0mLNe5L54kRVEK
    vhKw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713807655;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n6N3F2iLe44QF/xdqQekCMxmg9ktN9153+H/5P/spwc=;
    b=TXYn2Ks7muDdytPOUrfVmJ8/hg6ew+UQAqQF3sAWkaqmldCcu99kqFRjv9+rFkxH+t
    aURnZBdN7N3rOHuwTEtXyJVyFfqHDnPGRz+qKEAS7CUCjpOs8ArEbxi5LFW0DN2aLgPt
    ypplU93pWAjBJPXItUYN4ij/jOUMlCv+U1IL8cgQmhSX0sxabhTg8/b+0B9wrGOC4GXj
    aG9eV1ETgwFolZpVmxiQ3MdTREwjTis5r+RFIcf7o81ZB3h1GDVaYL1QIBAsSQQKnpPp
    UZsWaiFFstEGfl0dw1++f09WE7Y58d80+lax3H98DfNuUMVevx+FPFHoY0UY3ql3T6OF
    UopA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713807655;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=n6N3F2iLe44QF/xdqQekCMxmg9ktN9153+H/5P/spwc=;
    b=mOgblIHNUFk294nSJ9Sgpj8PQ1GNzstwx/nOC9QlV6KYJe3HYjPpCDM+0RrphHh4K7
    ZwNL/PXI0vy/ujChY2DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id K701d603MHetnZp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 22 Apr 2024 19:40:55 +0200 (CEST)
Message-ID: <2a787ef1-de8b-44b0-b1d4-9d52180b6440@hartkopp.net>
Date: Mon, 22 Apr 2024 19:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: isotp: remove ISO 15675-2 specification version
 where possible
To: Vincent Mailhol <vincent.mailhol@gmail.com>
Cc: linux-can@vger.kernel.org
References: <20240420194746.4885-1-socketcan@hartkopp.net>
 <CAMZ6Rq+3LJKcU5+nQmZ95AyLMqQe=y4_tCsBbuZ_j2cSuz9+3A@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6Rq+3LJKcU5+nQmZ95AyLMqQe=y4_tCsBbuZ_j2cSuz9+3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22.04.24 07:50, Vincent Mailhol wrote:
> On Sun. 21 Apr. 2024 at 04:48, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> With the new ISO 15765-2:2024 release the former documentation and comments
>> have to be reworked. This patch removes the ISO specification version/date
>> where possible.
> 
> The patch also renames "classical CAN" into "CAN CC", which is fine
> but maybe add one sentence in the patch description for that.

Hm, IMO this is an editorial update without any new information.

> Aside from that nitpick, one comment (see below). Meanwhile, I am
> giving my acknowledgement in advance:
> 
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Thank you.
> 
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/uapi/linux/can/isotp.h |  2 +-
>>   net/can/Kconfig                | 11 +++++------
>>   net/can/isotp.c                | 11 ++++++-----
>>   3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
>> index 6cde62371b6f..bd990917f7c4 100644
>> --- a/include/uapi/linux/can/isotp.h
>> +++ b/include/uapi/linux/can/isotp.h
>> @@ -1,10 +1,10 @@
>>   /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>>   /*
>>    * linux/can/isotp.h
>>    *
>> - * Definitions for isotp CAN sockets (ISO 15765-2:2016)
>> + * Definitions for ISO 15765-2 CAN transport protocol sockets
>>    *
>>    * Copyright (c) 2020 Volkswagen Group Electronic Research
>>    * All rights reserved.
>>    *
>>    * Redistribution and use in source and binary forms, with or without
>> diff --git a/net/can/Kconfig b/net/can/Kconfig
>> index cb56be8e3862..af64a6f76458 100644
>> --- a/net/can/Kconfig
>> +++ b/net/can/Kconfig
>> @@ -54,20 +54,19 @@ config CAN_GW
>>            by the netlink configuration interface known e.g. from iptables.
>>
>>   source "net/can/j1939/Kconfig"
>>
>>   config CAN_ISOTP
>> -       tristate "ISO 15765-2:2016 CAN transport protocol"
>> +       tristate "ISO 15765-2 CAN transport protocol"
>>          help
>>            CAN Transport Protocols offer support for segmented Point-to-Point
>>            communication between CAN nodes via two defined CAN Identifiers.
>> +         This protocol driver implements segmented data transfers for CAN CC
>> +         (aka Classical CAN, CAN 2.0B) and CAN FD frame types which were
>> +         introduced with ISO 15765-2:2016.
>>            As CAN frames can only transport a small amount of data bytes
>> -         (max. 8 bytes for 'classic' CAN and max. 64 bytes for CAN FD) this
>> +         (max. 8 bytes for CAN CC and max. 64 bytes for CAN FD) this
>>            segmentation is needed to transport longer Protocol Data Units (PDU)
>>            as needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN
>>            traffic.
>> -         This protocol driver implements data transfers according to
>> -         ISO 15765-2:2016 for 'classic' CAN and CAN FD frame types.
>> -         If you want to perform automotive vehicle diagnostic services (UDS),
>> -         say 'y'.
> 
> Not sure why that last sentence was removed. This is out of scope from
> this patch and I think this can be helpful for the audience not aware
> that UDS relies on ISO-TP. I suggest keeping that one.

This is a repetition of ...

"segmentation is needed to transport longer Protocol Data Units (PDU) as 
needed e.g. for vehicle diagnosis (UDS, ISO 14229) or IP-over-CAN traffic."

... one sentence before.

Therefore I thought it could be removed.

Best regards,
Oliver

