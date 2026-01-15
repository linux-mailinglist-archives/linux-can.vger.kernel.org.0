Return-Path: <linux-can+bounces-6167-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB3D24B8A
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42FF430D04B9
	for <lists+linux-can@lfdr.de>; Thu, 15 Jan 2026 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107003A0B14;
	Thu, 15 Jan 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MrPXKIF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7ZcPlyp"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8374399A57;
	Thu, 15 Jan 2026 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483131; cv=none; b=RYja5nGw/xHGe4tIF801+i/p2uR9/z0piB7SpWiVXe0dIkMtn0TZ73c1s2L4yyhz16rUrMS5C2gu7X75VAliJDhlJeptWe8FQ/iexj1zGt34Z8a6UIvZXgGM78WXfpx0xKKgybGtScsyGKnO010hNWaHv2vWYUlJukBeUP+bBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483131; c=relaxed/simple;
	bh=VHwZdRNAq/HCN9OBsk1ddkklfpId8GqG8YA85LM3mZ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PEcz6zPLgvIpXc0Qp+PM7vP4QFnBOCcGvLc++3iGSe3JyUq6tR6PkQfQbeh9OgQ83UnMUf1E02Z463zfilTn5wl5RaS1zdPeTqKgXBc0l3c3a9I13N4s0cFadeapJvwMkb4FoWpBSRA+b/sYaNzuZRV9tzvnav0agA6wVl90Pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MrPXKIF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7ZcPlyp; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C95B17A0127;
	Thu, 15 Jan 2026 08:18:47 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 08:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768483127;
	 x=1768569527; bh=h6SVtFD03l+wX8xZD0IiiYLU2wweWH6ekxSfR9085ug=; b=
	MrPXKIF2NMfA3z2beZmGWxk+P2lB8VjKfPmi+ClLYGUC62DnQtNNdkJZU8OSGMT7
	LG7n5ORpkvk3TQZ8yK0azlQOO+6y4IH5UX4cyfdjuKYezyShXqC3xBQFy+6A0kT0
	YiX6AaXqybWMRy5Bf3J8JInzgiv5t7b1OYfGplIErpXUbBwEpD162/onvs0VPBxB
	VmPTuNIkTLdR3s3fcGrDeS7sV3yErfYLoX9FYRoSscw7LKMwwV+jETFnp06h99Ny
	iEAL8nORwdRJ3lfBoX8MRamXUUJDxmgUn9OwlRLgB6yL8wOckezbLC5tdSqtAb6I
	FazP8dAKhwPYBVN59mxvRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768483127; x=
	1768569527; bh=h6SVtFD03l+wX8xZD0IiiYLU2wweWH6ekxSfR9085ug=; b=F
	7ZcPlypD20cv2gDDdfngpVFqGXwrnVYTSFpeae2WGiHFUaM7qIImjtdJSynSr8E7
	gj5/ifRVs/+QNR8uCsF69bMAEAWdW5+E++1wjBZdM0ED6YzrEUqOYAE2jVGBpq4N
	T9FNMFADFLUXX12kFoO0JLVzo4h45nTPjkMCZW8fjNR8LLWz4HjGxSdoCb++m5nl
	1kfcXLHPBj1ffmXYfmVEo5e3Er3DdOSnNG4qlruVdLsIykIRzSA+CzDk64qwUisF
	5cK/7tEmGw8jWbUGTsLRA6TsajZ8hyCtfk0PB1v/MRPXU55iKqk99BHCc6OKFguF
	xDS39PsmXN1vNJV3ZLFRg==
X-ME-Sender: <xms:N-loaWZaihBdjOe0YxR2PdZYX1yQG_tubCdBoasFYshEaFEbxyZ2pg>
    <xme:N-loaUP1tv34rE5tuVd1TD72Pujrm7mr1rp94pT5eCiEYWebI2nUbqk8L3ehB72HK
    MHMqaINuTZuvJ1lNndHDWgALhlMjC8FSUBGqm8Wv9cDED2nHsVt0-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgeetjeelheeutdfhffehteduheeugfehhfekjeekleeiudehueefiedutdefheeg
    necuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepshhotghkvghttggrnheshhgrrhhtkhho
    phhprdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghilhhhohhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhes
    phgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonh
    higidruggvpdhrtghpthhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N-loaYbzXk0DSBqCDj6FChS5HLW_D56PoFUr7kB4haXQD2X8L1iWGA>
    <xmx:N-loafYReNTXEvgEaOAPQlSP1XVp3ZDSw6kyPX51tIdN6nNZTNiF8Q>
    <xmx:N-loaVL6zbzFd642LRHG9e1xlEh6-qVNRCJ-EGWNcCHILXMwMYgWmA>
    <xmx:N-loaTsh5YQuF-8r8aiO6nsSJn3pTuFA0Jf9cofX9Bc_A2l7IiM9ig>
    <xmx:N-loaYwdwJgllema-wEc7kaFH9uAOgsjB8R5cJUy49jrXlelGPBiGsi5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47079700065; Thu, 15 Jan 2026 08:18:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARILWzAaMLLJ
Date: Thu, 15 Jan 2026 14:18:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, linux-can@vger.kernel.org,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Oliver Hartkopp" <socketcan@hartkopp.net>,
 "Vincent Mailhol" <mailhol@kernel.org>
Message-Id: <563a78e6-e1b0-4bc7-abc1-0c87da53972d@app.fastmail.com>
In-Reply-To: <20260115090603.1124860-2-mkl@pengutronix.de>
References: <20260115090603.1124860-1-mkl@pengutronix.de>
 <20260115090603.1124860-2-mkl@pengutronix.de>
Subject: Re: [PATCH net 1/4] Revert "can: raw: instantly reject unsupported CAN frames"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 15, 2026, at 09:57, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>
> This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8
>
> and its follow-up fixes for the introduced dependency issues.
>
> commit 1a620a723853 ("can: raw: instantly reject unsupported CAN 
> frames")
> commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by 
> default")
> commit 6abd4577bccc ("can: fix build dependency")
> commit 5a5aff6338c0 ("can: fix build dependency")
>
> The entire problem was caused by the requirement that a new network layer
> feature needed to know about the protocol capabilities of the CAN devices.
> Instead of accessing CAN device internal data structures which caused the
> dependency problems a better approach has been developed which makes use of
> CAN specific ml_priv data which is accessible from both sides.
>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Link: https://patch.msgid.link/20260109144135.8495-2-socketcan@hartkopp.net
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

