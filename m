Return-Path: <linux-can+bounces-5842-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73723CB314D
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76C0230065A4
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C7325705;
	Wed, 10 Dec 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="iMURItam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvLfdPZy"
X-Original-To: linux-can@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1D2ECD37;
	Wed, 10 Dec 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765375163; cv=none; b=f8GFBF2jDqMsNQjVtv4U25i5HbUmEm3SfdP4nJT/3YSuGo9NhVbN4aN6ZhtZjAbWiPBJohdJskCkXEGugvas75bpE2D18OrDmpTFyLJCe8vfJJWhjGcwoJSh93Ii4ndvjYuTq8YNWzRq7VeelX8xJjHwYZDAgDhdDxydzazEG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765375163; c=relaxed/simple;
	bh=WAHiFF953bWyfm5HZ/kQ0QRldmhiYWOrB0CofiCJODc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qHtVcoi+P0zPGDV2hDRgvRV266CAjKNfXtJjyajumG5+dq5pr5GHYijm5vHtwOQLneQMqkYJB0WAIyZBPiz/mhYElmJgVsDZApgMzuA+Z/MhfBhOfYMR4bGJu3awYCM9WjPYsbGXISJlDvZ05IZM2c3lh+33qanuzB8JMjMGpEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=iMURItam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RvLfdPZy; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 8260F1380279;
	Wed, 10 Dec 2025 08:59:19 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 08:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765375159;
	 x=1765382359; bh=gGWK/uk/mw80+EiOrvNa3Hy0tfAppOavi7ny1IYsVkY=; b=
	iMURItam/J+0llRRSc9nm2ajWuyj/juFn97I+2Cm1nXkg/0eN6hBE7BC0imSTfVM
	PQnVHvZ1o0j6DQjCm85d0WPYy+q7sG97cjsa/nb+Z7yE0zxvQ+F5s8kZHFvT2tHl
	n+wR7IknfZMZbi+ZP159LiP4U/4kvc9fzRsp8TLQv+rfQ88G6ygOmYGchI6dxoqp
	9/sBmkyOzsYdx/AqaDpBBO5SFRBAYmZ0fgHAvjslMhxx5fDr84asKv2+gDKGQf3T
	yv8RrVT0UF+Zupv0fDpaMmu2Em26X3NjWUUPo2FqFC2cwECAYvsrWvhvD39ajqIn
	Mff0K4WmANpGWCC2lYCrfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765375159; x=
	1765382359; bh=gGWK/uk/mw80+EiOrvNa3Hy0tfAppOavi7ny1IYsVkY=; b=R
	vLfdPZy4GB1fUhccwvLELOFZ3k1Np/5ifd8XEyT1G4lgMcmKUaKWTOfut4aiBfNq
	KP0yM6dsxlEACQ4SN2PRSA05KBWr3OVDLqJOkHYF76ocaf2Z1QXIfxYcaXkpMRQA
	WNETlLiVRywemP15iR+eMM3qFpr+rHqaXWO4nxamN5PKUemkhPetF+kXdr4duU/U
	akz3b4oNxOP/UoLnhJxJ4Sex688HQoRZTQs/wcZ+zy2sWtyQ58fntkEaZq6ap3C+
	zVzKpGrff8XQAYCvtxjsT+htAScMSB0uZurMSMi95rlI4Cj9unJwhe0E7FEn8Qvi
	9s+ZUw4W/SEJBkfSO//Ow==
X-ME-Sender: <xms:t3w5aSjEv3KyG0a_zG5gZc6Wbc5flDFHD7gl6-K4jFcLvv0qDWKrIA>
    <xme:t3w5ad1IUYZEZgfEWbVsO0MCvUf9QI_s2_alyQTzUDdHEhjSx7wA_QOfyl7Kx7qh6
    dNOeeZ4BVUwIn32Y4uggyhXuz7CJXZzRC911pxEKU4R1_zyHiTuBIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsohgtkhgvthgtrghnsehhrghrthhkohhpphdrnhgvthdprhgtphhtth
    hopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlhhholheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepvgigthhjrgeskhhvrghsvghrrdgtohhmpdhrtg
    hpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhu
    gidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t3w5aYIUz8-gDDoNRS5CXDHY7Iing-LkF2aZ9r_vHkZqVNa6sXndzw>
    <xmx:t3w5aSPnvX1RhF_3qsctkdCt1BSHl7XZS1eoS-zR_v8kK7SDZvXqrQ>
    <xmx:t3w5aYk3owncI5tTU-D71Mwkb5jGQOsWHWLt9SUbSG3kx78hQNcu8g>
    <xmx:t3w5aW62GE1H8I2o4ubJHtUoC64pd89nA0TE0pgJe8hp3f1BXbMpdQ>
    <xmx:t3w5aTGlIKczBVoi7jT456P5BX-8rrOSc7FA0dVUgRiTQb9VQeXwxdPM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00887C40054; Wed, 10 Dec 2025 08:59:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7rUDe6_ZBCR
Date: Wed, 10 Dec 2025 14:58:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Jimmy Assarsson" <extja@kvaser.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <d2f80c97-55ab-4aac-a546-2d53ce29dd42@app.fastmail.com>
In-Reply-To: <20251210-sassy-apricot-toad-239179-mkl@pengutronix.de>
References: <20251204100015.1033688-1-arnd@kernel.org>
 <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
 <20251210-imported-pelican-from-tartarus-c1084f-mkl@pengutronix.de>
 <7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com>
 <20251210-sassy-apricot-toad-239179-mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: fix build dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 10, 2025, at 10:38, Marc Kleine-Budde wrote:
> On 10.12.2025 10:10:27, Arnd Bergmann wrote:
>> On Wed, Dec 10, 2025, at 09:16, Marc Kleine-Budde wrote:
>>
>> Sorry I forgot to reply here: the '&& CAN' is absolutely
>> required here, otherwise you can configure CAN device drivers
>> as built-in with CAN_DEV=y CAN=m, and that results in a
>> link failure.
>
> You mean:
>
> | $ grep ^CONFIG_CAN .config
> | CONFIG_CAN=m
> | CONFIG_CAN_RAW=m
> | CONFIG_CAN_BCM=m
> | CONFIG_CAN_GW=m
> | CONFIG_CAN_DEV=y
> | CONFIG_CAN_VXCAN=y
> | CONFIG_CAN_NETLINK=y
> | CONFIG_CAN_CALC_BITTIMING=y
> | CONFIG_CAN_RX_OFFLOAD=y
> | CONFIG_CAN_DUMMY=y
> | CONFIG_CAN_GS_USB=y

Yes, I'm pretty sure I saw link failures with configurations
like this one.

> ...which works for me.

Looking at a random exported symbol from can_dev.ko, I see

obj-$(CONFIG_CAN) += can-dev.o
drivers/net/can/dev/dev.c:EXPORT_SYMBOL(can_hwtstamp_get);
drivers/net/can/usb/gs_usb.c:           return can_hwtstamp_get(netdev, cfg);

so in the configuration you list above, can-dev.ko is a
loadable module that exports can_hwtstamp_get, while gs_usb.o
is built-in and unable to link to that symbol.

       Arnd

