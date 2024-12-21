Return-Path: <linux-can+bounces-2482-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE599FA15B
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987D81888BD2
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9101FA8CA;
	Sat, 21 Dec 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YdRNNcyy"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAD1BCA0F;
	Sat, 21 Dec 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734794533; cv=none; b=hnbWZrRfgdStZ2aZBiIdCZGWmS7qFvQwtmc06f8zd+4iVrjTIFAR0nnJXPi2Krty2V36go1Nb7gPmIrnyA6RJChxoVBNs1RkzznxBeVI5TG7P6cQaYOmW7s+QfYg0ZH0wNDY7xs/2Jmdz2yLpouxasYD8/IqK+uotBXOXETc2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734794533; c=relaxed/simple;
	bh=dWV7QpT1MkssZtoO7Vd7/Fo2wC2sKS0EPXfsZYtSlLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzN8NH/OIPfRoDisg6bc9T3xQ7/VKMm1aoMzBCHVBCbYtvCq8ZmAx3M7Ydr3mrXchBEsK5CMu72kdIXU+7LN6ginDBj8fmqCZ54CCr7jIU5hmI5swrx24/4vW5jFPdCU6at6mM4oU6FyhP31HV9r7mCUP/kdPeWA+ZOthgCI+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YdRNNcyy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uLE/FMM2CopcBAaw+i5BPoQ8Oav6ZVj6eheOBwHanNM=; b=YdRNNcyyVlzGCsI5hSDQyoTc/4
	ZgnOQuDiBc49CBvHGOuPr5IGKUMwkuaP1a/Shq0O86q9T4wSDY8dhRrhYG6br/LmsjyzDFS3Pzp2m
	5n4MPQpCKhUvhm+/2fLc4hdwNgf7m2MDeFiq7wmZ2+Ax3WwAX1xVC652+R6lutF+ntqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tP1Is-002KUK-Gg; Sat, 21 Dec 2024 16:22:06 +0100
Date: Sat, 21 Dec 2024 16:22:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2 0/3] broadcom, ethernet/marvell,cx231xx,can/dev:
 Remove unused values and dead code
Message-ID: <f6453f4c-5b9f-466f-b1f2-f7ab31df4e5e@lunn.ch>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221111454.1074285-1-ariel.otilibili-anieli@eurecom.fr>

On Sat, Dec 21, 2024 at 12:06:46PM +0100, Ariel Otilibili wrote:
> Hello,
> 
> This series clears out the Coverity IDs 1487817, 1561102, 1497123,
> & 1269153.

Always start a new thread for a new version of a patch series.

Also, please wait at least 24 hours before new revisions:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

netdev is also closed to patches until the beginning of the new year.


    Andrew

---
pw-bot: cr

