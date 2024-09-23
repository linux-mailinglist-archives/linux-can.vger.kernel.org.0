Return-Path: <linux-can+bounces-1548-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B121983A59
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 01:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C0AB224D9
	for <lists+linux-can@lfdr.de>; Mon, 23 Sep 2024 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746DF132106;
	Mon, 23 Sep 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="A8eMrtxp"
X-Original-To: linux-can@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0287126C1C
	for <linux-can@vger.kernel.org>; Mon, 23 Sep 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131274; cv=none; b=O4zJCtwnM6OARBHymB8zCr748aY9G06evWwaXVW2V3h7VlwbrCpFObTyJAYjokFvolm/EgPKx6gJp5pwdZ0GMzHxMOq36/9cUvuh0BZ2czGGDF+LeRNfWGk5xXahp0Zy6ZKPmlSk6SDYMgr2n53eE2IecsxIod9TmCxHVKxtKD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131274; c=relaxed/simple;
	bh=q7AY7G/iig7FqHckOxHB06eDt+9Up0hEYEy6EHjYcZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKz6F4naEK8HvyHF43qwb3sFq40IFixtvnbYIJXRczHeBtlwEeDtOE5NI9Jl8Xg/xTNEXuO3cVyBsB5oAqErA6E/sHtPLHxQBmxgvbfwJXI9sBo3rCYUgyIIS+8UVSOKU3ILpjR/vJKq1EgXEFjKscuXqExBHC0uQG7Fq7/HMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=A8eMrtxp; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 048A21F92A;
	Tue, 24 Sep 2024 00:41:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727131265;
	bh=XSqKHZeNwc907hzkElB9JAsGiYLtXxZrg8nQxm4T3EM=;
	h=Received:From:To:Subject;
	b=A8eMrtxp6EbJDQH4/Fc9PjXR0+LvgGvrFp0YvsfSLz9ctOsMfn7GKj409F+b3ormU
	 nQ/ar/V/IvpgPK5prHdCsnaup4WRyhDfVQbQqGc48u2NpPnoh0It9XxEXW6GseNswx
	 2dAFatkDjdxK1974GTCnin/BVMsFjDO+37f7N47TiECYkZVFuYPnGTnMiC1bQGjzqC
	 hDPG+c12IH8ud3OHKW20rJzkKU+13D5n8Lsl+ijgyBP9nQ4MX5qhYSVGPOIW9hv8/e
	 oNbL7VDlgxheLA1xjhYdf3MvEpcGoP9IgOb99DAekAi2FNdZJzO5n9BnnHmB97VqIV
	 Fu6HjPzLHHYRg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 974DA7F96B; Tue, 24 Sep 2024 00:41:04 +0200 (CEST)
Date: Tue, 24 Sep 2024 00:41:04 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: Oops on mcp251xfd open on 6.6.52
Message-ID: <ZvHugNKM-Ilu4K3K@gaggiata.pivistrello.it>
References: <20240923115310.GA138774@francesco-nb>
 <20240923-spry-badger-of-perception-303c63-mkl@pengutronix.de>
 <20240923120027.GB138774@francesco-nb>
 <20240923-quixotic-okapi-of-rain-99ae09-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923-quixotic-okapi-of-rain-99ae09-mkl@pengutronix.de>

Hello Marc,

On Mon, Sep 23, 2024 at 04:36:16PM +0200, Marc Kleine-Budde wrote:
> On 23.09.2024 14:00:27, Francesco Dolcini wrote:
> > On Mon, Sep 23, 2024 at 01:57:07PM +0200, Marc Kleine-Budde wrote:
> > > On 23.09.2024 13:53:10, Francesco Dolcini wrote:
> > > > I got the following Oops on doing a simple ip link set canX up, running
> > > > on an i.MX8MM SoC.
> > > > 
> > > > This was reproduced with some automated testing, I have not tried to
> > > > reproduce it so far. Any idea or hint? It seems systematic, introduced
> > > > around 12th september on the v6.6.y branch.
> > > 
> > > Which Kernel version are you using?
> > 
> > v6.6.52 is reproducing the issue, I guess it started on some previous
> > v6.6.x kernel (with x < 52), but I was not able to dig out the logs
> > running on older kernel from our automated testing (yet).
> > 
> > I was not able to test mainline (yet).
> 
> Can you cherry-pick these and see if it fixes your problem?
> 
> 51b2a7216122 ("can: mcp251xfd: properly indent labels")
> a7801540f325 ("can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()")

Yes, these 2 commits fix the issue.
In addition I noticed that also 6.1.111 is affected by the exact same Oops.

Thanks!

BTW, to reproduce, just

  ip link set can0 type can bitrate 1000000
  ip link set can0 up 

How to we move forward now? Would you ask greg to backport to stable kernel also
these 2 patches (I assume that something was backported that broke the
functionality at some point)? 

Francesco



