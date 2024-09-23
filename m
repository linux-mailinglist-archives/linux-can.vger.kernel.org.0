Return-Path: <linux-can+bounces-1542-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB697EB2B
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61351C21488
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D71EB48;
	Mon, 23 Sep 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="P9LHlZhg"
X-Original-To: linux-can@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED7823AC
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092835; cv=none; b=cF9Rta/ASlBNMitDuHdnVbYmOaxxzKsSjIrZwsxqMTWRY9Xbif+p4OQEXSuLbQ0WAmHqN2R83Js/aE8d1aB5NhMzzRoE0/sU+udAnoyA5Q69LZvlmv4/q3LaBI2N5gq573m93ypzDTenR9kP2LJgTDwZB00WJbFBd0apm0eVpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092835; c=relaxed/simple;
	bh=+Ea8Bw2FuzoCiVoOWLnK2JG9tP3DswpDbZNA9O4enq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHP5dZ2KzXd9jdAs+pg1AoXxW6Oe8SOin0rHeGm92ze9zvqHhDMayBSjhrSyhMHCKUMoq4zE5SBzpKhYowceylHDfqABN4zuQ1uzdgJhq3Df6MTp8nAt9z6Z0CKoQw/Ns7TrXGbC5rqJDv0gRcNo4m1VDjYdBUIUfezibPZaZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=P9LHlZhg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8EE901F8F7;
	Mon, 23 Sep 2024 14:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727092828;
	bh=YcVqBs6HbunVYXLynNuUCYgouoEOslEdWbejJi1IjhE=; h=From:To:Subject;
	b=P9LHlZhgSsSfl8CQPu46DwqyPi5F8o6MYa66IUz8ERkPig61SLDouLvSXoBvDaZM2
	 XfjdAO/oH15Av3DoVuc8tOUGPIf2ukbiVwgl+jZp+U521yHOnVMMAQh3KfjybocySn
	 st+7NyknXXmfEIzBoCPCs9zZLmsBo72wLH8TVve/v/b1LvZVFg+cM5O67AksZIk/yl
	 exMaviaEUuVVXSEJ2Qcd3iky44dRBhfbOTEQsPkmX6pk6hNr4mhmL7uBpkuReu+fyZ
	 67hF4LaFFe4SLVLCBEJvAK+9THUA+pZCe2C0MRvLdd18b9M9nNYm79Z6I0SNjhwwNZ
	 DYE7Vui7ifPEA==
Date: Mon, 23 Sep 2024 14:00:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <20240923120027.GB138774@francesco-nb>
References: <20240923115310.GA138774@francesco-nb>
 <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>

Hello Marc,

On Mon, Sep 23, 2024 at 01:57:07PM +0200, Marc Kleine-Budde wrote:
> On 23.09.2024 13:53:10, Francesco Dolcini wrote:
> > I got the following Oops on doing a simple ip link set canX up, running
> > on an i.MX8MM SoC.
> > 
> > This was reproduced with some automated testing, I have not tried to
> > reproduce it so far. Any idea or hint? It seems systematic, introduced
> > around 12th september on the v6.6.y branch.
> 
> Which Kernel version are you using?

v6.6.52 is reproducing the issue, I guess it started on some previous
v6.6.x kernel (with x < 52), but I was not able to dig out the logs
running on older kernel from our automated testing (yet).

I was not able to test mainline (yet).

Francesco



