Return-Path: <linux-can+bounces-5068-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563FABACB48
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAFB3C30B6
	for <lists+linux-can@lfdr.de>; Tue, 30 Sep 2025 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5E22D78A;
	Tue, 30 Sep 2025 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="K96vLrFZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoHoEYs3"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18625179A;
	Tue, 30 Sep 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232198; cv=none; b=MBNxE53mJBXorjnTI+bxnzhdwDDxmAJml/xRSBt0BmNhaI2LK+F4SJPxMFfqtF2EOcnHBNLg7JucQPhWZ8VVNyBqrQKRDW46kpqoJTPFzMRXcTgxj/tB1UTZByxLe5qABrLe1Ah2Hl5uL4QufEGVP6FnnUiwUHM3fuKN7BHKtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232198; c=relaxed/simple;
	bh=aNJH8ytf/8f5a35uZcGvKW3v8d+yHBKYoAMNrtB/xxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgVfJAWqCYtNYA4zA36X9LTkN52mBS9uNT8RE24k4DYznP/RPn0HRudjK5rk87unM6vPZoiq2HC6RLx+R+voyOqwogso2STeYFaEbEadfCo9gHgXOZ9qJIb7jHc8j+6cRTwBZeTa0XSapMgpjvGDwVt2YfdomEwtRq7V6dZFSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=K96vLrFZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoHoEYs3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F4267A0031;
	Tue, 30 Sep 2025 07:36:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 30 Sep 2025 07:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1759232195; x=1759318595; bh=9ohbE1RORs
	QgX4rG86wrlkjIoX9+U0SluP3/evz0HJk=; b=K96vLrFZ4sk569Bk0XVDQXMlmU
	hzPHBvV9zLFxWQeOnn7zpd84drBJHxMWFayTGvI2qxqQ+edpwobS8JvDHuhhXSgj
	Chh1bUWGN+ZEyMt7A3fQDaDBWkvQs1fBPA0vRyqx3W4xu0+9+2RPmn+eUL+S4hCq
	RFY0ULcF2dLSiXJ76uL2M7lCnLq3Tz7TBoGO5nn3mzfwYbnP/3kwQ48uBmIqDvUk
	Zx04H4e0UWOAb2ztZYHeSmLAHwhgAbQymJA4uJQTcSMzsMT3QSh6g5Cw9OvqTA7P
	HgqnbjK26bdcEy9XjnYg2xf49HxO6VoZhq8NkZnTZocqCnVyZ0JEtnuXra3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759232195; x=
	1759318595; bh=9ohbE1RORsQgX4rG86wrlkjIoX9+U0SluP3/evz0HJk=; b=J
	oHoEYs3tqNwv2mLCU8Fq5dZFBeZPd26TkWLbogxhbyT89BnBkICfJmwlSDe7Sfzc
	s6v8QRIdOeaY401jn1gtbV2Mx3ah8jqPnTEekkbwTXYsmOw4b7dSJA/a0YtjwUMr
	dP/YUgnH+3C1MVRuvfEhFe6z99dRle+c6upAayCMUA78dCI9Qrk4UvTpK9v4fAxD
	tXFRU9cU2fXg6zC8ChQWp3wOFJgQkr39m3u41arADZhwSkK8e7dLo0dpaaqv/Yaq
	Lcuo8E0beegdxAbhMSOBegsEZNFRT83vZW43nlaUFc55i0A65jR37tXQqGCpPaPN
	te3/upHPrfEij3GlkIZew==
X-ME-Sender: <xms:w8DbaAD0ts6YqQXNwP8hi0CO3Cg2O09vvTMxhSdAmRFXT4JMjxOUjg>
    <xme:w8DbaKq1HH4QgEc7n51s7FAJNCfJhbGdZsdoGNmBrq9wr4s4tkxHyKIuSAq0KzXV7
    PtlF2wIp5JBjXoG09NOoYoIKhKoREX_cmHkjbLaWNgptN1aRyLdygg>
X-ME-Received: <xmr:w8DbaDEjwSsweplEvb_poAnB04cVKHk45RrcFk6L-jNGogiywsXyCocVU6tMT8Fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdektdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvegvlhgvshht
    vgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeefgfdvgfetveevkeehleffteekvdfhvedvheduueehkedvuedvhfeiieej
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigi
    druggvpdhrtghpthhtohepmhgrihhlhhholhdrvhhinhgtvghnthesfigrnhgrughoohdr
    fhhrpdhrtghpthhtohepmhgrgiesshgthhhnvghiuggvrhhsohhfthdrnhgvthdprhgtph
    htthhopehhvghnrhhikhessghrihigrghnuggvrhhsvghnrdgukhdprhgtphhtthhopeif
    ghesghhrrghnuggvghhgvghrrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehguhhsthgrvhhorghrsheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w8DbaGuAcGhM6_lAgL1vi8T1WiC9oZ32vIdDvIQ1fjk8RJxLKAjx3w>
    <xmx:w8DbaBbx2jQzchRLLpE7wsjKzS6fxNPV6f8XPPZiklGonpKOnaNkLw>
    <xmx:w8DbaO4JiO9itO9vZ4OOyH2Esx1NNDIlAQVp0bPLhYM4quulhbpxsg>
    <xmx:w8DbaB8ZKloGDHBj3BZuCO7RcVbuWwuoXOEFuClwjSeRBufq3f989Q>
    <xmx:w8DbaPNEVkWM-ltiTvGg7Vy4tFefbV-JEEVWTf_8no11pE6ZTa5nKQ52>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 07:36:31 -0400 (EDT)
Message-ID: <41fb9334-5778-4fc6-bfdd-be4778a4b883@coelacanthus.name>
Date: Tue, 30 Sep 2025 19:36:29 +0800
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net/can/gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Maximilian Schneider <max@schneidersoft.net>,
 Henrik Brix Andersen <henrik@brixandersen.dk>,
 Wolfgang Grandegger <wg@grandegger.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
References: <20250930-gs-usb-max-if-v4-1-8e163eb583da@coelacanthus.name>
 <20250930-fancy-dodo-of-chemistry-c92515-mkl@pengutronix.de>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <20250930-fancy-dodo-of-chemistry-c92515-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-30 16:13, Marc Kleine-Budde wrote:
> On 30.09.2025 14:15:47, Celeste Liu wrote:
>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>> converter[1]. The original developers may have only 3 interfaces device to
>> test so they write 3 here and wait for future change.
>>
>> During the HSCanT development, we actually used 4 interfaces, so the
>> limitation of 3 is not enough now. But just increase one is not
>> future-proofed. Since the channel type in gs_host_frame is u8, just
>> increase interface number limit to max size of u8 safely.
> 
> I really like the new approach you've implemented in this patch, but now
> the patch description doesn't match anymore.

The patch description has been reword in v5.

> 
> regards,
> Marc
> 


