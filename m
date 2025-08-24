Return-Path: <linux-can+bounces-4340-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8ACB332A3
	for <lists+linux-can@lfdr.de>; Sun, 24 Aug 2025 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6352047B1
	for <lists+linux-can@lfdr.de>; Sun, 24 Aug 2025 20:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5B1F099C;
	Sun, 24 Aug 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="fYqrfrFk";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="H/m0R0WD"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E31F95C
	for <linux-can@vger.kernel.org>; Sun, 24 Aug 2025 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756068538; cv=pass; b=XFW4j/Mg/OIzde4mXXbEcwHoSXabtchdQxM//DyAwL0+W0tIbRI4BwCKgSXWR2bZSKEjZ9NGNioxAqeTEM03tIMC3SecgnDmzguAXlYUw+x6sPubTX5ESOFKaA/TRW7qPfdqyQXo0r28h4ypBEUtFzNdBk6NrevUgw4K0l4FChc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756068538; c=relaxed/simple;
	bh=TqK5k08QsbCEd+gI0Wr96K+QpvxU+RDG0FQG6DiF9KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHS6rRs4pe8RTMpXy9owCvS5Ve8K7Rp/UBO3jJBIfPdFMH4WVNmkLiOrMmErCzg6OHIv5lg53/fAGNwDNav0Vvv59ZKqo3rJhnol3AMp4yU0s9zA0aWvvcaKVfkxxlgWkwm3C3aajCV1IxbepJRjl0gZXabGqGE30MziTAX0ZIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=fYqrfrFk; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=H/m0R0WD; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756067088; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z2X0xd4Z5/xItQUyKjLuHATkfqB0H4/EqAgux0iSLICCNMmOgEX8oz76dhBZTyRsdo
    6W2TVW2XPajSWUeyOeH84J0hHyrN91rlosHRCSUDYMmueQihUrW3bC3hnmpcvWS7IhuX
    hQGLeEacvm9ltvVPz5dboERJMaSWWDj936l6XfGzNbrA7uTcD4ggWGMQOyHaKQRWZLpK
    ZNaCvlQLm49PejloelFsOG564/9HGmRwupOGqguj/Wq4O5JbksDwANd38lmFHatHSJck
    WvSMgTveRPQGfyM08Ps/an/I8bQkWlQ+H8y+tjt/SFRNm/rxjYAeELJctfEsKC9t7KqB
    IACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756067088;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EKWa7hwTxYCdEwyWfTmsUaBcNPgdRXRS6dLQeghgYH4=;
    b=C5m5mvbbEoJo3aHxRWc0WxPXRJIV5DBrBxVnqW+2KJDvxNprC9fPf/h4HwEuYodrPm
    2SvQy/664y97QxmqMK0Wj+MXZSKKGzCPiP4VovZ9mns9Qw3sI6OG/vT6adSGT9JFec9Y
    GhCIp7KHXj16BdAapEplzb5bvvhlruCFJI89vjA2WrdGlG6MVMKHm9K7ZU0f9hKAbxak
    WsJSsVVZj+rH8iot0gqJLD9K5Hno0ICeJzwGIia/BAg3xRz5U2ltcdNwbKr2I/cJF9oQ
    vJED0v7qKu4Vv/s9Ft+f9qEU5ZypcBmSptaGdj43GTxf804BxHjtZFN7qxgjwwbdP1Uj
    mE0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756067088;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EKWa7hwTxYCdEwyWfTmsUaBcNPgdRXRS6dLQeghgYH4=;
    b=fYqrfrFk3/HwTEdavY/wgynQs6e5OJbsuPMJgZyhQ5/I+QWP9S/iDSNs/4HbdKBzX4
    x9slxrlabyCIQDQjzSgBMj8nbFq+LbvEkNYK2v7Ei7l9xgOu3oJRyydDSHUipQ9Z8Qyp
    aZF4LGEQULtT+UPaTWLKcXB7cL0QMWLeXhqbBvoNjlFNOmcsK5wtyktK1CJU7aHJlro8
    qtolLFvAdrT7icrs0/oQkAM08GxNP6bChGAEzBu5pSwITUyxKpuejAzNlrLN/W7qxEdO
    BS8poz2XaERDAivMHLYMjI3WoHnmmAkQok3f+zhLrZYam9ektVlObKWdbhOnI0udMhQG
    wukA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756067088;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=EKWa7hwTxYCdEwyWfTmsUaBcNPgdRXRS6dLQeghgYH4=;
    b=H/m0R0WD57iHBn3jk2ghriHCxzl7nyAFGK9rXlifnrVBhcYKJlD2rYq2jnBrEGDOpJ
    IRT1C8c142zN5Rtd5JBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36117OKOmfOR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 24 Aug 2025 22:24:48 +0200 (CEST)
Message-ID: <d2ce032e-cca5-4050-ae1a-6fe5f8a0b25f@hartkopp.net>
Date: Sun, 24 Aug 2025 22:24:42 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Robert Nawrath <mbro1689@gmail.com>
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
 <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
 <d2610541-ba04-4a80-b3e6-c9c75bb1a486@kernel.org>
 <a1a752e8-63ac-4a2c-998c-c88a223dd57a@hartkopp.net>
 <d73d326f-0c49-4e21-8d59-2f54e2be5f0e@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <d73d326f-0c49-4e21-8d59-2f54e2be5f0e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 21.08.25 17:47, Vincent Mailhol wrote:
> Hi Oliver,
> 
> On 18/08/2025 at 21:35, Oliver Hartkopp wrote:
>> Hi Vincent,
>>
>> On 30.07.25 16:15, Vincent Mailhol wrote:
>>> On Tue. 29 Jul. 2025 at 03:20, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>>>> Btw. while we are at it: I would suggest for a name change of
>>>>
>>>> CAN_CTRLMODE_XL_TRX
>>>>
>>>> to
>>>>
>>>> CAN_CTRLMODE_XL_TMS
>>>>
>>>> as it makes clear how the controller should manage the PWM mode.
>>>>
>>>> "CAN_CTRLMODE_XL_TRX" would mean "there is a CAN XL PWM enabled transceiver"
>>>> available which tells nothing about whether the PWM mode is used or not.
>>>
>>> Ack. I have the same opinion.
>>>
>>
>> We are already in 6.17-rc2 and I would definitely like to have the CAN XL driver
>> support finalized in this net-next merge window phase.
>>
>> What is your plan? Do you have an updated patch set to be posted for the
>> discussion?
> 
> I uploaded my current WIP here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/linux.git/log/?h=b4/canxl-netlink
> 
> As you will be able to see, most of the features are here. Now, I am trying to
> think of all the edge cases and make sure that any incorrect configuration is
> correctly rejected.
> 
> I am just sharing this to reassure everyone on the progress. The patches are not
> yet ready for discussion. You can have a look if you want, but no need to do a
> review as I am still making changes.

I upgraded my hardware test setup to 6.17-rc3 with the patches from your 
b4/canxl-netlink branch.

Most things were easy to adapt but the netlink PWM API.

Two questions:
1. Why did you make the PWM values u32 as the 6 bit will always fit into 
a u8 value?

2. Can you share some PWM code for the iproute2 package or do I need to 
adapt this code myself?

https://github.com/hartkopp/canxl-nl/blob/main/iproute2/0005-iplink_can-canxl-add-PWM-config-support.patch

Best regards,
Oliver


