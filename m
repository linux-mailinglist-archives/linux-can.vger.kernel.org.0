Return-Path: <linux-can+bounces-5063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A355BABA6D
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 08:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACB01C612F
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CDF219A8D;
	Tue, 30 Sep 2025 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="ttu7SvgV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yzV+FFfg"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5822145B16;
	Tue, 30 Sep 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213206; cv=none; b=tY6xY67Gbp7JiihT0yleX4FhP9TRrfxvkqez9r+g0Xxt5aKNiFrF7HuWotuh/6SYZ/Vj8oh0JlMwsN/VyhhuzqGti6J5SQvtkGyBQAn+bffxGF0lTZrnY1ChRXjrQ6YXjUwIL1/KyQSOI5GIw0YDDUc/aWhNpgWnNCctHA9scgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213206; c=relaxed/simple;
	bh=+fOvrxmlq5Or0IYrnUZSVE6+5ipx5T1jWLQg6EwgnxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxbI3cSDXuYMqBflXeT6F2/On5JThrzftbSluvkmTc2LUYnzckn/wTkjRk4iTgiouK+Kw4ZUh2sNK6CTW7QolgUivl90juXSs7Qk8enQ+hW5dsBwGWP+6yJqVcQfM3wtuT9CdlhEjuxJdKa3W1e5n5VkXj4WpiZSPkKQWvz6e2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=ttu7SvgV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yzV+FFfg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A93581D000F6;
	Tue, 30 Sep 2025 02:20:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 30 Sep 2025 02:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1759213203; x=1759299603; bh=ge4hq/SFxg
	UzjxsHg+aQ10niqT2LXy5vgIQDGLng6fY=; b=ttu7SvgVBvS4An/9+E7TzBvLWg
	Jn01/OgJAPn/1gz8X9ZcLzYlV8b9VpHTnMthdMpT3GFP1TMZaNKnEpDLB2+xbM/5
	GWzD6mlrEue9C7EoxvySoBjfXdKLISsoKthC/hbmasoDBIETo42v6s4vZyZplb9J
	bqvRc2j3k/9PiPhSUqACVJaUoJMJlzXH8yEhuWfakgFZ40RGLk51n6+P+HGi4U4/
	PtYHTpCWjB9COXo6Pc2Nwdb9cfpoxESXiZuwK20KCLOSFcLj9kYmEussribQultF
	Uq3+nSGWG1oA8pGwX5y3N5O0DUVkGnPXLTdpSzMvtgmuFtY5aTVsWiWhXzcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759213203; x=
	1759299603; bh=ge4hq/SFxgUzjxsHg+aQ10niqT2LXy5vgIQDGLng6fY=; b=y
	zV+FFfgSvrgl70qhk1LYuJdmKLMWfx9fkUt0i3FHW78CcYOMIl6hpUENCpSr8pm+
	EJDmk3K4BW2uk4WOC8HfoWzaS/3y5aOzsFQFcCkhEWo5GoJ5d0uHFETAVB0JTw2w
	Sbf+6q9tGPP8Xy6bnGjiiGHyfIQwRkGb8/VsSYlbHXXo0VpEgF7YfIBam//7Ik/V
	gSaydMh6DtUvM1xyJ5i9K813ZKgVZ9t1mFtgUEH8blbb4T6RsvEhKRjO4Kv8rXVh
	UZWlk+H+/66IhMVpCqBAEi88/wYTNdPdiNeNbuot5LXH1whXdAba/F18wm2oNfoU
	SEOb+7SLjnNKDdMQaoxlw==
X-ME-Sender: <xms:knbbaBq6fKPo0uhIm5Wv9ZGqlfbLPfLGzmWeBmiLcEabeR9h4yCvxQ>
    <xme:knbbaC20EZeYgWTD27R3V0D4yW1epPu9diMIZ1nXj_JvTwZWM7nYmFRMz_SNi5Qvy
    k0XZEvIp-JdDsxNU580qujFUsX-Ap_JLXdBs6cdlbhtiH2q6haYUw4>
X-ME-Received: <xmr:knbbaA6QFxe5ajxI071s7mUfJuuBFzqsmjfccb-CvjpfDw0fr91XzJr0q60hElyO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvegvlhgvshht
    vgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeeftdetudehtdehgfelfefhfeffffffvedvtdetfedvveevhfeffeelhfeh
    veegtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehufihusegt
    ohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepmhgrihhlhhholheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfthdrnhgvthdprhgtphhtthhope
    hhvghnrhhikhessghrihigrghnuggvrhhsvghnrdgukhdprhgtphhtthhopeifghesghhr
    rghnuggvghhgvghrrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehruhhntghhvghnghdrlhhusehhphhmihgtrhhordgtohhm
X-ME-Proxy: <xmx:k3bbaGQjrrmwZKoMRHnWQTb8Tt6Ws5t3ArbIdTDY8X_eU0HtjhZnFw>
    <xmx:k3bbaNUmzw1oq-lx17Aj2hY-aF8T7A6SGswSOVZh1GC6gdGNLPVIig>
    <xmx:k3bbaDF9_cYqBBc18ySnHTQxb3JaOn0584YMDewKbrj-Wgx327ETYQ>
    <xmx:k3bbaIclk4oWCN__vR3cog4VrC7oJ_lTzMp6CfNZq4KOQAz-qlIZ0g>
    <xmx:k3bbaNWcMGP9274hm-Dpl2OxytJb05u48aFXgjvY2-vQmXv1qSyPhgZi>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 02:19:58 -0400 (EDT)
Message-ID: <63b1bd2d-fa5c-40f6-8e27-ada79dd196f2@coelacanthus.name>
Date: Tue, 30 Sep 2025 14:19:56 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/can/gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250930-gs-usb-max-if-v3-1-21d97d7f1c34@coelacanthus.name>
 <7d35d8ca-f711-41b2-b058-08a19a207160@kernel.org>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <7d35d8ca-f711-41b2-b058-08a19a207160@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-30 13:44, Vincent Mailhol wrote:
> On 9/30/25 12:06 PM, Celeste Liu wrote:
>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>> converter[1]. The original developers may have only 3 intefaces device to
>                                                         ^^^^^^^^^
> interfaces (missing "r")

Fixed in v4. Redundant typeof() was removed as well.

> 
>> test so they write 3 here and wait for future change.
>>
>> During the HSCanT development, we actually used 4 interfaces, so the
>> limitation of 3 is not enough now. But just increase one is not
>> future-proofed. Since the channel type in gs_host_frame is u8, just
>> increase interface number limit to max size of u8 safely.
>>
>> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>>
>> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
>> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> 
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> 
> The patch is good as-is. However, speaking of the interface numbers, there is
> another issue in this gs_usb driver: net_device->dev_port is not populated, and
> according to the documentation, this is a bug.
> 
> 
> See the description here:
> 
> 
> 
>   https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net
> 
> 
> 
>   What:		/sys/class/net/<iface>/dev_port
> 
>   Date:		February 2014
> 
>   KernelVersion:	3.15
> 
>   Contact:	netdev@vger.kernel.org
> 
>   Description:
> 
>   		Indicates the port number of this network device, formatted
> 
>   		as a decimal value. Some NICs have multiple independent ports
> 
>   		on the same PCI bus, device and function. This attribute allows
> 
>   		userspace to distinguish the respective interfaces.
> 
> 
> 
>   		Note: some device drivers started to use 'dev_id' for this
> 
>   		purpose since long before 3.15 and have not adopted the new
> 
>   		attribute ever since. To query the port number, some tools look
> 
>   		exclusively at 'dev_port', while others only consult 'dev_id'.
> 
>   		If a network device has multiple client adapter ports as
> 
>   		described in the previous paragraph and does not set this
> 
>   		attribute to its port number, it's a kernel bug.
> 
> 
> 
> Would you mind sending a separate patch (with a Fixes: tag) to resolve this?

Ok. I will send a patch for it later.

> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


