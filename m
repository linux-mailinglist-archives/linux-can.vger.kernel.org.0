Return-Path: <linux-can+bounces-5138-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD8BD042D
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44611893520
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDC27FB10;
	Sun, 12 Oct 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dasN7jn1"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071594502F;
	Sun, 12 Oct 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280467; cv=none; b=cs4l+E0yVxNL8n85nxCNrjhRhycdhgKWByTBUw6DTeJzojjsXu9p0+pu4h91gO9dvLN+zrll5umqbj/t1mjj32vwTTJtV3Ib14LatH09aSv6egBCWUb9X2dV/UnUYT6J7QaO1LsFVZ4eCRaZ0n5pdQp/+FeHGGs1EMSf7FTLZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280467; c=relaxed/simple;
	bh=ihc+tpb606q//94OiNEimFyArARuU0UuhAOgM5Ga4lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTovZHKnzkg9RDlzz8bBnxe9JMqhsWD1fo61eL3E96IVyS5Iy/5N/Zj2StR+RJVicwWF7jjE3TCcO6Mqio5I39FoqqvKUgSU1c//jSpO0tjF82NrgSuOVt/gbWouaRaIr+V2oCgq88xh2Hf29UmGutucWPta7krTmT11wqBlfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dasN7jn1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1mDmpetLfcmCLrx3e9s6mnKckfazX8FDZfhsC08rMO4=; b=dasN7jn1nmObOGthEs+V8nWAcM
	7eSj26kfkIRsDviBGcNcLGIxgAWSG2FCEaJ+xe5NyUqnqcwWKnWYmUZhquWsjMRxXF1FgKqZnAEda
	+Q6FRZfPFKjrkilBeShRwTCavpT+ky2wAeCARDLjaS6xPdPTukqRccLK2zKwW5ZgVPtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7xMC-00AiTb-MG; Sun, 12 Oct 2025 16:47:32 +0200
Date: Sun, 12 Oct 2025 16:47:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Message-ID: <1b53ea33-1c57-40e9-bc55-619d691e4c32@lunn.ch>
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
 <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>

On Sun, Oct 12, 2025 at 08:23:43PM +0900, Vincent Mailhol wrote:
> Back in 2021, support for CAN TDC was added to the kernel in series [1]
> and in iproute2 in series [2]. However, the documentation was never
> updated.

Hi Vincent

I also don't see anything in man ip-link, nor ip link help. Maybe you
can add this documentation as well?

	Andrew

