Return-Path: <linux-can+bounces-4369-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5EB34B8A
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 22:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C46A242BA4
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F82857FA;
	Mon, 25 Aug 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YpLwT2Xy";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pPoUNeno"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4099B22C355
	for <linux-can@vger.kernel.org>; Mon, 25 Aug 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152785; cv=pass; b=kAH7HcMAwHZwaT4oBzcDGheu+JWryW0FG2JNPE//fCh19PImDsx5dNDDiEqYjDHJU+iSIvsvJEUfwdSK4zrmFshurhpDsDtSMf0R4Vlsf7dNG1xSRyLMluhWFS1Eil7tL1hYaROfJQsDaL6oaLsWwcnQH4J+UdmUYcgjjzzyUiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152785; c=relaxed/simple;
	bh=YxNST9t2XpKerdjvYp+40HN+sQGlvZx+2ixyGt/b+DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSyhNBXFwdH4z5SWSQgULSHO//eblQVI6FW7778j86otQCaS2U9/39Y6YbFlO8ZJb8dV+63xLQjbMplKAX1W66ryYblaP4oHl4CqVloOIM2GV6igIXzHWL9gQobNb82WevX1LMz/hmmxxlcOszZyrM0ZE8/uQWbKzZryh8vtDs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=YpLwT2Xy; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pPoUNeno; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756152774; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FOVywtkvxheymfXspE7trIsSaLSqocSQO964BhTmFDTDzb+k1h9Z+iGbwymS+7Isd6
    i9eZ/nBNiig2ppGVbng4+mnsZwH+DXLmL2olPQybL+zrOxlZbPyVWo5qaqSizWfbRHEF
    IpW34pVVsPqPLJ4+Cof2LCor25iJSvo2FnKFH4uWXQFZcM3gwtvnVSY+W+unKuTvaP/M
    5+vDLZwWO4s6tyUplL6c1kul8nTLUzfU3SdmX0G6x1WZ3xaBOyPtOBQ0JhA/Pp8hGrVE
    k1Ie89cpqb1M2cIrtRg1mRhHCqzxk8mnkz8cHtcdBqWkGq9Ctza/Eo+hV9oZnFMC9h3g
    XR1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756152774;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9EgEaHQU69crZryEZDrDWsRL+xBuFguha8IWV2yfzAM=;
    b=EaO0MtmWlv1CFTvm2Oy0uxbuQ/vOu80kN8lKPNxr4KSSj9o1TNmzZIYvYgGWZjPVX2
    SpFH2MIfXgUNwBE8jxQQDMAPtjnqrf8YCbh0ZjUyhJgms6TRUpnBLF1AVRzCFe+JKzO4
    0tn6znwNRGN+IomFImc5Ik+2kH49ip8jglNv/rZWbdh8+2VCcpRY4ozpeQB2GOkqMHcJ
    wxKfAX5E7ilk8szH0/E5E3diQ3227uYzuIPS624VgWfCdClXJMDwZ4jH0tfCIY/Lvgsk
    A06yuMj7Uj6dBsqBaHXSvCGLsw/Lnj5yQAirNXZao0zpcEuPsM1TmbHtXyqjRd6tH1M/
    HCMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756152774;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9EgEaHQU69crZryEZDrDWsRL+xBuFguha8IWV2yfzAM=;
    b=YpLwT2XyY5U/yl6/EUbsDHkPZaq5DZEt5OR3ZDRG63RKAw690pOEPBVtwHS9HLikVW
    1NZJ/PXu60UYIxJGEELYjBfJYo+cE1tS6jtkmgU/dlu1ZHBYVUZvCWtMqBLdHOfJLd9B
    FpkLoiWILvz3B5IkIhKy5/Hnq4Z0wrZwpzGKAomRo03RhVwjb7pgtZ8LzKgmC/Rqazwb
    Dt5Vy134oPyOsQovw9VCgFBwNGyeDUafkkUF47FVu4Kt5nrSdtSbynyuzrqfIj03zFxi
    ChNn6pIqKXzc+bWHd3cGfJjqwHep7inBHL5tG/+lojU69A9CP+kUsIyATJEIx1VMiFMG
    UU6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756152774;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=9EgEaHQU69crZryEZDrDWsRL+xBuFguha8IWV2yfzAM=;
    b=pPoUNenolf3VgHzHfa1ujlj61oEcwRrveH7suI7B9QwJry77+C8kETaaTsWt24freR
    KugHpnVrsdkSDtXzAcDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36117PKCsj9A
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 25 Aug 2025 22:12:54 +0200 (CEST)
Message-ID: <d6f56321-0b9a-470c-90f2-d951ca919279@hartkopp.net>
Date: Mon, 25 Aug 2025 22:12:47 +0200
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
 <d2ce032e-cca5-4050-ae1a-6fe5f8a0b25f@hartkopp.net>
 <5db57860-05ad-4925-a9b3-18ce2d88ab0d@hartkopp.net>
 <d3cc9f51-e599-4c8d-b2b6-016fd160a081@kernel.org>
 <129e9fc4-c69e-48d5-b4be-e437184150b2@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <129e9fc4-c69e-48d5-b4be-e437184150b2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25.08.25 18:01, Vincent Mailhol wrote:
> On 25/08/2025 at 17:32, Vincent Mailhol wrote:
>> On 25/08/2025 at 16:17, Oliver Hartkopp wrote:
>>> On 24.08.25 22:24, Oliver Hartkopp wrote:
> 
> (...)
> 
>>>> 2. Can you share some PWM code for the iproute2 package or do I need to adapt
>>>> this code myself?
>>>>
>>>> https://github.com/hartkopp/canxl-nl/blob/main/iproute2/0005-iplink_can-
>>>> canxl-add-PWM-config-support.patch
>>
>> OK. I will upload the iproute2 later on. But same as the above, it will *not* be
>> ready for review. So, please, do not share comment for now.
> 
> And here it is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mailhol/iproute2-next.git/log/?h=canxl-netlink
> 
> This part is far from completion, but at least you have the PWM interface. I
> plan to finalize the iproute2 last once the kernel part is fully working.
> 
> One more time, this is a WIP which is *not* ready for review.

Thanks Vincent!

I gave it a try.

At least my setup can send all types of CAN CC/FD/XL frames without BRS 
and TMS. So I have something more to test.

Best regards,
Oliver


