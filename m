Return-Path: <linux-can+bounces-5140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C4BD06B3
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0684E5EB7
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93854285CAC;
	Sun, 12 Oct 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ue6DSK4r"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895801EA65;
	Sun, 12 Oct 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760285056; cv=none; b=Pt3KjHMCuIX9GVmLuHlln/bal7zrCCDOhgqBRCuRciF2bIrnO7SVVLNTvHrIkMB8qsQKLUzvncdPz7I8Rpb+TkCWD4YgCOVWXToqnjIz3tCj1uRN/WLIoHrGssF6cMD5Zof0xUHQr89vh8AFLXj7/mYMtLYuV+kaDEEA59yqRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760285056; c=relaxed/simple;
	bh=WR6Q3tD7lH4W+kHrgpepvYWn+8m595V2I7douvy1Ac0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKfRcfvvCupoVu1zshZg4BcH+hyRyasqpCc304EDBWV7F32Y8Vb/v49VB10XL9oqIBAf6Fzpeg2MahxFMIu5qVEMS5hTVKfJBqkisILcoOQqAyuPYHUce0Up/Phy7B0BUUDs2eHdYZg9ExOweUBxNYYWLohqGvm4dh9vGRBy0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ue6DSK4r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dJjnzH6feA3Ear1JYajKel7MPI/xcKpnYIcZo5d2MMs=; b=Ue6DSK4rmi7deqKKCme1TCN7gi
	xIe9hp1FTYmjeZZip6a5kTqT+Y0Y09/thWURscQltK45iR1xqam6XwgfHtwiAtwPhA2vpm3uEyXr7
	sTWHMmQmjUgFGI+6ym3l91dfK8sUWJkesWNK3mpM2ca8sZMlSewDY8+9b1UGNArSfeWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7yYE-00Aist-5z; Sun, 12 Oct 2025 18:04:02 +0200
Date: Sun, 12 Oct 2025 18:04:02 +0200
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
Message-ID: <b3095bbe-81b5-4062-8662-c5fb1e0f2b4b@lunn.ch>
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
 <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>
 <1b53ea33-1c57-40e9-bc55-619d691e4c32@lunn.ch>
 <0c6045c9-67e1-4358-ae3a-d63c343eef79@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6045c9-67e1-4358-ae3a-d63c343eef79@kernel.org>

On Mon, Oct 13, 2025 at 01:01:15AM +0900, Vincent Mailhol wrote:
> Hi Andrew,
> 
> On 12/10/2025 at 23:47, Andrew Lunn wrote:
> > On Sun, Oct 12, 2025 at 08:23:43PM +0900, Vincent Mailhol wrote:
> >> Back in 2021, support for CAN TDC was added to the kernel in series [1]
> >> and in iproute2 in series [2]. However, the documentation was never
> >> updated.
> > 
> > Hi Vincent
> > 
> > I also don't see anything in man ip-link, nor ip link help. Maybe you
> > can add this documentation as well?
> 
> The help is indeed not directly visible. But I think this is intended
> because can is a sub type. The can is simply listed in man ip-link
> under the Link types enumeration.
> 
> The can help then be obtain by providing that can type:
> 
>   $ ip link help can
>   Usage: ip link set DEVICE type can
>   	[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
>   	[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
>    	  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]
>   	[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
>   	[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
>    	  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
>   	[ tdcv TDCV tdco TDCO tdcf TDCF ]

O.K. Great, thanks for pointing this out.

	Andrew

