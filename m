Return-Path: <linux-can+bounces-5980-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3971CED018
	for <lists+linux-can@lfdr.de>; Thu, 01 Jan 2026 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804253005FFA
	for <lists+linux-can@lfdr.de>; Thu,  1 Jan 2026 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8882D279794;
	Thu,  1 Jan 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mEsOrxpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kU3CutFb"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC223E325
	for <linux-can@vger.kernel.org>; Thu,  1 Jan 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767270715; cv=none; b=g1P0JY55+OfwRJfRT8WZUq7oCUA9wyFCKGQfwlNSovB/aRGvaMTAcI2f+7VM52QPVjVCBLFaTpH2g6lh/bUZFX5/HxplNNhsonEP6B9FrxA9Ltzr83iD3XXFjSJZIr7rCRTfB+piOfHFxikDVQh+Xch3XluT/K9SN5cANkD92Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767270715; c=relaxed/simple;
	bh=rlcTrbRsG8DXS/2xLIKAdvd1EMInhs8s5Azoies6+CM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N64ZHifrXK8o+Gwm786wdMrmlo7v34VZOkDYmbURJsuej3+OFQaZej8liEAeiJZZmBaTztlztYbLOex4UFvEcSSaKLworDa1nF6m4dNlnKJiF/81xbfd6faOkLd83kLCtYbs+tVIH92/QMKm0M+3yXaN33E/vFttO1F5y+qSPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mEsOrxpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kU3CutFb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 156737A0061;
	Thu,  1 Jan 2026 07:31:52 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 01 Jan 2026 07:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767270711;
	 x=1767357111; bh=S9FkUitqGAyHRmPX7gN2eSlZgnu+LEHtfh2OO9B09EA=; b=
	mEsOrxpeedQjkeovxrmK4mPhFucIcNAdqZwZm8D3zygl30pN7QcWEF6MiqcDLgM6
	+bMUL36pl4ZgMPP6reAzjT6RxaR2zAUj+q+zOdyAbOiW6jUMvB9BaHwrstA5HkcJ
	vQYlgIJyWc+4hugAlwyrGuj0flTKbuJkCS8bpT56TVsZaICmYg+yyWYQqVPaRC0f
	ZVYMW8dq/UMxsorxXAqboLtgG/vkJFlNlBMqoD9Z337X5Tqv8k7fWRrcRGv+4mui
	4qj2BDsRXsVmmuknpgVFLVjYsyDi5AhRuuaptSFGFQ5egZyzEnzLkXXIIKN8Qg+s
	jT9v6Lwp6R2OUmamk3YX/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767270711; x=
	1767357111; bh=S9FkUitqGAyHRmPX7gN2eSlZgnu+LEHtfh2OO9B09EA=; b=k
	U3CutFbnOzAz+ZQkF2ArYhLNtnSKnHt3xVS/ZpFv9v2d6tiiUJqEhxS09o/tMquC
	0EAu1lIKh0n80N6YK80OuF6LL8HHNtKY3DCNa9TPuvZIg5kRr2EOiOm7+ghhwxj5
	/e4Hdw2q4IuZ3NGoNzQt6S0dImMZhkhlvQli9OG/XkyhR50NryUs9sUpHIWgDzMS
	Uqry6HFij9ef/MYEo0QLsYVusA/E7bAB9uCgRBQJBcOWlOwMzNlWeIeGLCwwWwSR
	YpZkLlh1ZdZ0AuRa2wdvQGJ6kO6BFECq2BPQ/Oc4DeHfFx041xDznCSWVPJS6y9U
	H1s+RfFz5Z+NczUHLp9xg==
X-ME-Sender: <xms:N2lWacj2_jHWhWj-LvWVC6H9Gha8kf9k6YmioOQWdQUPOD3ERhuGIw>
    <xme:N2lWaf2WNSe8TYukQ_eTLhRr1955ApopY1CRdbZKJ632j25GHj3JMLRAWZPF1egw6
    OOtE8bjX6XZP5xOJMft939VRLA9wHra0dSYnBXtN8CIvRTAuV6JxCY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehsohgtkhgvthgtrghnsehhrghrthhkohhpphdrnhgvthdprhgtphhtth
    hopehmrghilhhhohhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlsehpvghn
    ghhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdgtrghnsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:N2lWaQ-YeIfAek_FcL10vt1LMdOQwbhEflcysCuKYD62hE1f66VNfw>
    <xmx:N2lWaSJuC-QR3ZEQ5bhjqawBwu_PAyU1n0-y9fZ4Csc4wOHgl3iGNA>
    <xmx:N2lWaVm-vq9dBVi2sW8P8Frz5K6vY_AL7Ic7T8OYZXHE78fi8d-tsg>
    <xmx:N2lWaWMVMmOlDn050NaS4SjGrDpXpFH6ezHwkHd67GkzaDQXYXn9WQ>
    <xmx:N2lWaTe6XuxVjOKXO1EBYVmtwrrl6dIyEHpVY7w0vnh9sVZhn7epYTw1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 619F5700065; Thu,  1 Jan 2026 07:31:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUHPsCL5hUD3
Date: Thu, 01 Jan 2026 13:31:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>,
 "Vincent Mailhol" <mailhol@kernel.org>
Message-Id: <b5fce247-12b8-4a2f-bad4-c20ea4ed0811@app.fastmail.com>
In-Reply-To: <20251231165127.4206-1-socketcan@hartkopp.net>
References: <20251231165127.4206-1-socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: propagate CAN device capabilities via ml_priv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 31, 2025, at 17:51, Oliver Hartkopp wrote:
> Commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> caused a sequence of dependency and linker fixes starting with commit
> cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default").
>
> The entire problem was caused by the requirement that a new network layer
> feature needed to know about the protocol capabilities of the CAN devices.
> Instead of accessing CAN device internal data structures which caused the
> dependency problems this patch introduces capabilty information into the
> CAN specific ml_priv data which is accessible from both sides.
>
> With this change the CAN network layer can check the required features and
> the decoupling of the driver layer and network layer is restored.
> Therefore the Kconfig and Makefile changes/fixes are reverted too.
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN 
> frames")
> Fixes: cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by 
> default")
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

No objections to the patch, but I don't understand from your
description here if there is a remaining regression in the current
upstream version after the 5a5aff6338c0 ("can: fix build dependency")
fixup, or if this is meant as a cleanup that can wait until the
next merge window.

    Arnd

