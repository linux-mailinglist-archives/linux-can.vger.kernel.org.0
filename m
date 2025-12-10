Return-Path: <linux-can+bounces-5840-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD4CB2801
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 10:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFB973025418
	for <lists+linux-can@lfdr.de>; Wed, 10 Dec 2025 09:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FAB2F5A25;
	Wed, 10 Dec 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d0TaE5t/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPijtTlK"
X-Original-To: linux-can@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA62E229F;
	Wed, 10 Dec 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357851; cv=none; b=P+KVkrRsgtqrylmAQMvytuBNou4v0Y69QJn+PbPUHz8q+x9Vfba1EZvt5VQ11hf7fmJz6tfKVI6+EC22S/SGkU1BqZ6JeYaCXoE+fwGJQQtzqtr4IeC5QZUn0C+VKk1xXok1FRggYoR8fH0OAF2THbuTthEqf8WZsNhf+sINhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357851; c=relaxed/simple;
	bh=IMy+644D6GzznKl5SyK98WSeKQJv4NKWmvsjr8Zvb88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IHvhAmDAuo3SlEapz8RTYSF/mzrlB+T/uk+2+yn2Yz0yuopyV76Akgy+ZNMuGALSfJWpBSP2h7Dftvh09E5Blbgotl5oy28bdeiSKhgyC0NBm7hKo0z2s97Ll0A/CIVONh96tFSuClS5xyW9k9dQntFX3V3XCboNNtWDhUBgC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d0TaE5t/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPijtTlK; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 897881300979;
	Wed, 10 Dec 2025 04:10:47 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 04:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765357847;
	 x=1765365047; bh=XKk/mRH0B0YNo//tXqlC9vkADj3PDAWv8CZ+OAr52xk=; b=
	d0TaE5t/R4LuqxEm9D7uKQOtHWxUkFqPcPDN8STx137UPSg9xkrerCtoseq6ek+C
	9PaWMwP0nPQMBgkpsybCJHaVO+MLFqVTDr/DK4eOnIqDA8QZ7UXRxRI5f2h0Y7+H
	33Ijbb7cujPb+dPIhsiUNYw3hLcHDjEX5SZNyRoBpdsGN81mpH24ExzsGVMKmYvF
	4u9NBSyP3VN4Bqg6ZJII4EFENgjls76kkQj55+BW3RZvFSg9Ks5REcRahn8doX7B
	XSLhy6JK0IdHCTPpls2VlX65egax8dkR5K/sNHxuFIk/dU4Hok16liH9tNe4/o78
	3dW9TkI9XAQdYbqbW71tWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765357847; x=
	1765365047; bh=XKk/mRH0B0YNo//tXqlC9vkADj3PDAWv8CZ+OAr52xk=; b=o
	PijtTlKgWp8b7BvRweYNV7Cey1J0zK+lUU3Q6PX7jNq1uNUBX5I0qcDiTY7WHIaa
	TjiEe4YR0ETbENp682wqOeK15aicSvbvLFQHVbHb2Lgj0T/rhTJr0+K3WoBUtrCi
	J3+Maqe1fiXUQP/JEGwD+nm9RWcDvfLiwcbhgyLezLuTkI1oSpnAnMOOzph0xu+T
	MF36RW7/mA/AdIBihHlwCCkkHs0dIK+Mnsn6SZF0St8LNWF2TEQfJsTWs+aBxrei
	7lVOy3w4BXisysVtDncbU9MroJpJgCr9mGDs/65qFfydJBG5PU/5AZwh/GKoTZYV
	PeZlftS+tMtvGfXH7yOkg==
X-ME-Sender: <xms:Fzk5aWLhqHOCsxwh8t_nd_j5vD4IsBDcbfD1MG-tSr7Lm2NkZlLW7g>
    <xme:Fzk5aY_WTJdYmiDX1eiGtIsJpmrPkIBwQpZC8qkm_V4HB5b1ym7_XGAKHeQeUvQzr
    YbXmUlXzX6ZCgpLShr1hN3sciJLs96dSXucjrYJhFRP0RQtNleX4LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Fzk5aTxZnpH07bXcdIYYhsSZ7BTilryVU-Cb2uzQIaCoNcmYAaXM6w>
    <xmx:Fzk5aVVGNeKKgwjGle5WhsiEGlBNm2K7LmWrIcb0rrBLDzq60ElQMQ>
    <xmx:Fzk5adOrFS68XrSis16z0l-AbuZxREU1qDNJgutnE5rB3nTJ6WyOwg>
    <xmx:Fzk5afC1hgY58tvrgAoIfQdpSxxV0DH8ZtncJ-JZ2OpR4MeTzBJidA>
    <xmx:Fzk5aYMnV27v1oFzsUIpzqtdi3TXMYyIAFMM1oGEDJt9OqNe244q8UO_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2EEB7C40071; Wed, 10 Dec 2025 04:10:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7rUDe6_ZBCR
Date: Wed, 10 Dec 2025 10:10:27 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>,
 "Vincent Mailhol" <mailhol@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Jimmy Assarsson" <extja@kvaser.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <7427949a-ea7d-4854-9fe4-e01db7d878c7@app.fastmail.com>
In-Reply-To: 
 <20251210-imported-pelican-from-tartarus-c1084f-mkl@pengutronix.de>
References: <20251204100015.1033688-1-arnd@kernel.org>
 <5de9b33e-6129-4765-95a7-e3e12de1f8cd@kernel.org>
 <20251210-imported-pelican-from-tartarus-c1084f-mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: fix build dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 10, 2025, at 09:16, Marc Kleine-Budde wrote:
> On 05.12.2025 00:30:14, Vincent Mailhol wrote:

>> >  	  can-dev.> -if CAN_DEV
>> > +if CAN_DEV && CAN
>>               ^^^^^^
>> Is this needed? CAN_DEV depends on CAN, so the condition
>>
>>   CAN_DEV && !CAN
>>
>> should not be reachable.
>
> Removed the '&& CAN' while applying the patch.

Sorry I forgot to reply here: the '&& CAN' is absolutely
required here, otherwise you can configure CAN device drivers
as built-in with CAN_DEV=y CAN=m, and that results in a
link failure.

      Arnd

