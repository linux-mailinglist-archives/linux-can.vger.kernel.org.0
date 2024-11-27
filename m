Return-Path: <linux-can+bounces-2244-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF599DACDB
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61072282047
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028F2010E5;
	Wed, 27 Nov 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tBKyT34R"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74213BC35;
	Wed, 27 Nov 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732731218; cv=none; b=SI9tOSesHzzycAwXWA9SVQfF6hJ08MKO/fJLWrcpfTPQZPaCNpMwthN7b24lQDQvDWAcBan2jhlQo5nlqS0m4y+oX+BAZn+M6/ANfb5jARtILzM9CQy5OL0mmfA8eZIHaPX8owv+Nzmo5jWEe5RAcqGsK1txVdeNWA5zJU35H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732731218; c=relaxed/simple;
	bh=7Du12Eonp+FpH604SHJXR1zw2KF5NMbcbh6pl3RjatU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLBmHkAtKu1FCT7okgzrd8GTBhKfIqKzsmH9KYgbCodh+JPqR/wS73aGxSqELmc/doX+R5te2PacOVHM+ckk6qAnOYk6CfByOfWQqX4A1LO09m2YbpqgPNx30GDfShFA1gPCiHUNyX5OKJgub+K7hIv4PUPodV3N7fs13a4eE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tBKyT34R; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=DujE4TvkayLo2q+Ep7uPaDVDwwHO7DiHpZix41K98k8=; b=tBKyT3
	4RI+dB2q8dwOD/QXX0cwpbOKWw2/GX1+5GCEEDhd14V5GpDfjgsLk0VJu9S2HqEt5zHGXWS9fTVVe
	BK9kCC7Jb7kw0JOJP/+aiTM0d41M124D2r6itMuWV9Ai6hle1vt+pgLL35NxQdrJEPM6nTfQe7O87
	wEDnwVf8Y6lCOq41Wqs/uurMaUs5/ryBh0sQJ0wwfwNVMiFFCjCI3r0vgdzcLcw3MRma2CLJmepOu
	OooOW+bvkzsKsVVeYYqR4JwcoRO2PU2yYHxVH94LHPyA5KXDG/BEDNyqWbrPxitP5bUyxsNQf431+
	fbmTa6w17cTPHkiXHrrTKRA1kh6A==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGMXZ-000FkE-Ep; Wed, 27 Nov 2024 19:13:29 +0100
Received: from [2a06:4004:10df:0:cdf:30b9:9735:780b] (helo=Seans-MBP.snzone.dk)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGMXY-000J32-2F;
	Wed, 27 Nov 2024 19:13:28 +0100
Date: Wed, 27 Nov 2024 19:13:27 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next] dt-bindings: can: tcan4x5x: add missing
 required clock-names
Message-ID: <yndgosvrbdawcln2adxh6blypf4joejjd5vygogxq7ii5o3ifs@v25ai7joiutx>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
 <20241127-siberian-singular-c2b99a7fd370@spud>
 <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
 <lmyugclgwb7txf3jxc3fsasp5fgu7fji5dxb2wjw4jji32omnt@rs27camphw7q>
 <20241127-myth-lily-122b9839cc0b@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127-myth-lily-122b9839cc0b@spud>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

On Wed, Nov 27, 2024 at 04:18:59PM +0100, Conor Dooley wrote:
> On Wed, Nov 27, 2024 at 05:10:31PM +0100, Sean Nyekjaer wrote:
> > On Wed, Nov 27, 2024 at 04:56:13PM +0100, Sean Nyekjaer wrote:
> > > Hi Conor,
> > > 
> > > On Wed, Nov 27, 2024 at 03:50:30PM +0100, Conor Dooley wrote:
> > > > On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> > > > > tcan4x5x requires an external clock called cclk, add it here.
> > > > 
> > > > That's not what this patch is doing, the clock input is already there,
> > > > so I don't know what this patch actually accomplishes? clock-names isn't
> > > > a required property, so you can't even use it in a driver.
> > > > 
> > > 
> > > Thanks for asking the right questions :)
> > > 
> > > I know the clock input is there, but it looks (to me) like the driver looks for the
> > > specific clock called cclk:
> > > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/m_can.c#L2299
> > > https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/tcan4x5x-core.c#L396
> > 
> > Oh I really need to get my head around the dt jargon :)
> > Yes I'll add the clock-names to the required list for v2!
> 
> btw, where even is ti,tcan4x5x.yaml? I was gonna paste the fixes tag you
> should be using but I couldn't find the file in linux-next.

It's here:
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=testing&id=77400284f54b9a1f6b6127c08cb935fc05e5c3d2

Do you think the fixes tag is needed?

Fixes: 77400284f54b ("dt-bindings: can: convert tcan4x5x.txt to DT schema")

/Sean

