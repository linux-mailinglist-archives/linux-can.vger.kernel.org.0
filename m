Return-Path: <linux-can+bounces-4018-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DFB0C051
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D850418953A1
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39028C5D9;
	Mon, 21 Jul 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL6TYEpJ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422528C01A;
	Mon, 21 Jul 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090158; cv=none; b=LRZnJw74IxCwmiGzExlGUwFcN+K01aWjKXqEJpxBNU/rga9R4FMC6JTx4QQiRL8ZxWoY7Vk/GTqSbTQf7LaHgO4o7NxJnbFAwCBGxx8I9+Iq/Sgwh8Bvw1FAukj6Ws4igWCTvdzazRikaHr/5jIPzREyH6SfTgMinrdxtaMXy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090158; c=relaxed/simple;
	bh=ZUPX9/56qciF8ljplSj8t8hAK+EnNEdFH0QDtc3OeMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnjgdgzM3xyUsnbuVoGcj+sVadPRq1TUhFDVAe/C5XAqLBHihR2/FcPZsobU01Cvm/3jRQrA4DR0aWozk6DMOT1b9S/kbhQM+UI07z6Y45T9dKcRnfeKxCAHA3RIk/6WdFUblTj7Wvx6siOj0lURpkgJuZBtz1snwJU/cgtumTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL6TYEpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306BEC4CEED;
	Mon, 21 Jul 2025 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090157;
	bh=ZUPX9/56qciF8ljplSj8t8hAK+EnNEdFH0QDtc3OeMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL6TYEpJ7uSNuKC1ZJeyrQx7TbSzymdyGd5iASunIjZ9rSEzJyO8goCOmQF450BCw
	 MaBkCt1uqetzxqkGDyrorYNgpBYwuQTRyW8rPlmW9fuu65H1iYFpIe8LNsCL2uk7Cd
	 gk3G9rsyXbKjFn/vZ+fAu26DQbxhU3kW2UDzLtXbT5gdL3ME0kBxhpK7RMIztDjif1
	 2m0SYer94O8i+YzkvkiIuk5oFNVOnlVUXr87Cd8jOrG3RFbSHtGHaCiE+sZnshYdlm
	 1PDcMOcLcH+n5JIi2h+jImsgaNx5ENo8eXFONy47sPshrD02xPzcqGw2l0TpVcZXt5
	 ul8J2GWrC34rw==
Date: Mon, 21 Jul 2025 10:29:12 +0100
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"Andre B. Oliveira" <anbadeol@gmail.com>, linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] can: tscan1: CAN_TSCAN1 can depend on PC104
Message-ID: <20250721092912.GZ2459@horms.kernel.org>
References: <20250720000213.2934416-1-rdunlap@infradead.org>
 <9ce81806-3434-492f-b255-fad592be8904@wanadoo.fr>
 <c89c30af-e144-4bd1-892b-f97c41760016@infradead.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c89c30af-e144-4bd1-892b-f97c41760016@infradead.org>

On Sun, Jul 20, 2025 at 12:22:56PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/19/25 9:50 PM, Vincent Mailhol wrote:
> > On 20/07/2025 at 09:02, Randy Dunlap wrote:
> >> Add a dependency on PC104 to limit (restrict) this driver kconfig
> >> prompt to kernel configs that have PC104 set.
> >>
> >> Fixes: 2d3359f8b9e6 ("can: tscan1: add driver for TS-CAN1 boards")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Andre B. Oliveira <anbadeol@gmail.com>
> >> Cc: linux-can@vger.kernel.org
> >> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> >> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >>  drivers/net/can/sja1000/Kconfig |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- linux-next-20250718.orig/drivers/net/can/sja1000/Kconfig
> >> +++ linux-next-20250718/drivers/net/can/sja1000/Kconfig
> >> @@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
> >>  
> >>  config CAN_TSCAN1
> >>  	tristate "TS-CAN1 PC104 boards"
> >> -	depends on ISA
> >> +	depends on ISA && PC104
> > 
> > A bit unrelated but ISA depends on X86_32 so I would suggest to add a
> > COMPILE_TEST so that people can still do test builds on x86_64.
> > 
> >   depends on (ISA && PC104) || COMPILE_TEST
> 
> Sure, I can change that and see if any robots find problems with it.
> 
> I did a few x86_64 builds with PC104 not set, COMPILE_TEST set,
> and CAN_TSCAN1 = y / m. I didn't encounter any problems.

Thanks.

FWIIW, I agree that extending build coverage using COMPILE_TEST is a good idea.

