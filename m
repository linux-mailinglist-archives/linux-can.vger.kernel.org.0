Return-Path: <linux-can+bounces-5057-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23FBAB1E3
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93A81C2E25
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 03:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FD942056;
	Tue, 30 Sep 2025 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="4PnAcHtH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wUEmT2GY"
X-Original-To: linux-can@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863B282EB;
	Tue, 30 Sep 2025 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201409; cv=none; b=h3h4EhqnZL4CKI8o1oi9GkdGsHtJYleRfuhZhY++i79hlpgxOOAurjc7hz8ttctyqSX2xFfeuBJ0CFDB8GnKMvHygG5gHLBUKKMKA702CnRpKo78Pgpj/jh00fcZs/cNGz6LYBTxGJ+B2UdwjhcmGu6RViwp6jElb5Fgp70H2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201409; c=relaxed/simple;
	bh=mf586GUh+NpdyHV1/6884yShVWOwldy+geQxaO6BHAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRTeYVRB24tHfsxmIwL1zF8wtMZdEfhHZyZFOfturmkBpRX+fhw+XfWSZK3PiVLp/iY/iTNJiXNGqkO1Y9KhRiJY+8AgsqpZLlHC6TdOKdKgukcIH4B5uGs2MsuZN0AAdgoJuLai1vK0zGl+k1r6PTdMLGy7iwoWhVAQU51Uv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=4PnAcHtH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wUEmT2GY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A1C731D000BD;
	Mon, 29 Sep 2025 23:03:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Sep 2025 23:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1759201406; x=1759287806; bh=dEzNCETznF
	qw/mgsaW1+fAE1KQS0gfglI3FEKUvOQNk=; b=4PnAcHtHScrUg58MvKC3OPxf4X
	HMt6xKEjCqXV3G2xGUp+TF2KhSzcgmieo0w5eBGET0XVLGecvu9ljsZSmDrurJoE
	dGvoiPkTICF2sdpzakOZfoACqQZtTdQX2LzzfTqVuGnRd4DIDmlMq82YirFLbsvh
	Q7AN0ct5fYB8L8m4LdLFdNFMSFANFQAjhoDbRPa0EVBSUumhJRIWfgU0a6xtDev2
	D3ZQst4vvijwcHyolk5RKUPa5KG8tPcKUnhGQc4xR5i2/Z2jLHyPh9pD3z+sdyFw
	Ee2Ep/3Rm44ATPXPrpkaUlBCFfP57qHrjlJSmjJ7rJxZG3KjTehg+4YfnFug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759201406; x=
	1759287806; bh=dEzNCETznFqw/mgsaW1+fAE1KQS0gfglI3FEKUvOQNk=; b=w
	UEmT2GYrdXqbO5/0FKLJ+w+KGyAGCKN52g/5vglciyqGr1cSmlqLTWZkkoZYfJml
	mZ4yHasOklZDYT5EZHbDoG2hocq8u23renb2BWULwEDuh0LqLTibV0YbR0FOIqot
	kcCR/hCW9ZESaddlj7/hamCAfvp5fJIAitsG8P8ThNklWRwvzyBsjH03sI/RYV+l
	N6MOzyEyX3FtTTPQbubjzzBsQY+CNYuZgO4BJlOK6cHhtawvKe98W+0r+CKzlQ8J
	P2SVQumCmQus/PFo0Y07Hl2AwGSNrNoMDGgiK7x6u3RgdTRRwjXhiaTIYhMzFhU6
	xT2We0iA6SCQhCK4b7IfQ==
X-ME-Sender: <xms:fUjbaFobOmwkjSCL9euF-oU-x42clV689S5suLK0wbSjmSXqLLLnTw>
    <xme:fUjbaBqfMQF_dXHAP8vRB24dJ81cVOZ4YLqJkkjbI5QI7f8hgiGXDyiYkzFyv1hCH
    NlazPSxDw3hB4vMcdVC3431al5dSjzgNUTt3Clncp5pOueDVA-IgwVv>
X-ME-Received: <xmr:fUjbaI2oSHeWFwMghTRuUqET3nTPrvwaVZ02rvOWwBbJ_piY6-GxfFMVy5AkC5nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvegvlhgvshht
    vgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeeugfetgeeifedtteeuuddvgffgvedtffefueeutdegffdthfehleejvdej
    ffekleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhs
    rdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrihhlhhholheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhklhesphgv
    nhhguhhtrhhonhhigidruggvpdhrtghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsoh
    hfthdrnhgvthdprhgtphhtthhopehhvghnrhhikhessghrihigrghnuggvrhhsvghnrdgu
    khdprhgtphhtthhopeifghesghhrrghnuggvghhgvghrrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruh
    hntghhvghnghdrlhhusehhphhmihgtrhhordgtohhm
X-ME-Proxy: <xmx:fUjbaPFvEpryOcqBI6vIG-tmHSuU5o8JkojjDTd8Eh4SzeogEZ5VEQ>
    <xmx:fUjbaDGAW90QpCyUv3MLdahEp7sP4XsaDWV37Wc-UMDdl7GvMZo7rA>
    <xmx:fUjbaC57AVN7kQQlTlL5VJ78N6gSbzdVxukVZ3lDxz2a2VlMIG4EJw>
    <xmx:fUjbaIyb0qUAD2D27Dqpc6Ph3Kit57WGlVH1z7lNwoRU8kv8kMyTbQ>
    <xmx:fkjbaCmYDObU8h1Qp6jfDs8xbpWCESjeoJkJwhwxe22JcYOu6KONOzoD>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 23:03:22 -0400 (EDT)
Message-ID: <b12cd2aa-fc30-46ef-b748-def1b291f377@coelacanthus.name>
Date: Tue, 30 Sep 2025 11:03:18 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/can/gs_usb: increase max interface to 255
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>
References: <20250929-gs-usb-max-if-v1-1-e41b5c09133a@coelacanthus.name>
 <69a0a8fa-854c-4498-a0cb-6176d8d7dd98@kernel.org>
Content-Language: en-GB-large
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <69a0a8fa-854c-4498-a0cb-6176d8d7dd98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-29 22:52, Vincent Mailhol wrote:
> Hi Celeste,
> 
> Thank you for your patch. Here are my comments.
> 
> On 9/29/25 8:10 PM, Celeste Liu wrote:
>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>> converter[1]. The original developers may have only 3 intefaces device to
>> test so they write 3 here and wait for future change.
>>
>> During the HSCanT development, we actually used 4 interfaces, so the
>> limitation of 3 is not enough now. But just increase one is not
>> future-proofed. Since the channel type in gs_host_frame is u8, use 255
>> as max interface number should be safe.
>>
>> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>>
>> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> 
> If you have any links where Runcheng reported the issue, you can add it here as:
> 
>   Closes: <URL to the bug report>
> 
> (Ignore if such message does not exist).

Yeah. No report is public to Internet.

> 
> Also add a Fixes tag so that the fix can be backported to stable.

Added in v2.

> 
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> ---
>>  drivers/net/can/usb/gs_usb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
>> index c9482d6e947b0c7b033dc4f0c35f5b111e1bfd92..35fc257c19e57c1f33e03e7c86ea908d22400254 100644
>> --- a/drivers/net/can/usb/gs_usb.c
>> +++ b/drivers/net/can/usb/gs_usb.c
>> @@ -290,9 +290,9 @@ struct gs_host_frame {
>>  #define GS_NAPI_WEIGHT 32
>>  
>>  /* Maximum number of interfaces the driver supports per device.
>> - * Current hardware only supports 3 interfaces. The future may vary.
>> + * The channel number type of gs_host_frame is u8, so max interfaces can be 255.
>>   */
>> -#define GS_MAX_INTF 3
>> +#define GS_MAX_INTF 255
> 
> After doing this, you are left with an array of 255 pointers in struct gs_usb
> (which represents 2 kilobytes of memory on a 64 bits machine). You also have two
> loops iterating from 0 to 255. This is a bit of a waste of both space and
> processing power.
> 
> It is better to use a flexible array member, like this:

Has done in v2.

> 
> -----8<-----
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index c9482d6e947b..459a956ac0d9 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -324,7 +324,6 @@ struct gs_can {
> 
>  /* usb interface struct */
>  struct gs_usb {
> -       struct gs_can *canch[GS_MAX_INTF];
>         struct usb_anchor rx_submitted;
>         struct usb_device *udev;
> 
> @@ -336,9 +335,11 @@ struct gs_usb {
> 
>         unsigned int hf_size_rx;
>         u8 active_channels;
> +       u8 channel_cnt;
> 
>         unsigned int pipe_in;
>         unsigned int pipe_out;
> +       struct gs_can *canch[] __counted_by(channel_cnt);
>  };
> 
>  /* 'allocate' a tx context.
> ----->8-----
> 
> Then all the instances of GS_MAX_INTF are replaced by gs_usb->channel_cnt except
> from the check on dfconf.icount which can be replaced by a:
> 
>   type_max(typeof(gs_usb->channel_cnt))
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 


