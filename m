Return-Path: <linux-can+bounces-2242-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696619DAB7A
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 17:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B0AB20FE6
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EF20013A;
	Wed, 27 Nov 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MAmcOrP/"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CD433A0;
	Wed, 27 Nov 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723837; cv=none; b=rLumQBwswipcB301tWiHzcRD5TY0k+1muENTHrXMSBBEj3S7WCU+XM1N3dOPtFFlIQDC0EMWXhpX8BhmHfjN4MCZT7KMU3x9J2GHHVoXkwGrqhvYlNaN0cyHGjgPDMOUxHeZz6fcMiCJdlqTqJ5rAUPr7PwicLbE6dp4B5wxWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723837; c=relaxed/simple;
	bh=aF8y8jDrNVTWyWxYWWHKPR0m+BWC0LhmiCIkDAXDH3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOlmQ+nhO6nhfikpxBKVJ1ENczeTea9i/kQAI+zG6GQyQNbz0Hkh01frFLoqj6IKLkHa552AVJa1aeK0rvjiR7rJ+YiFu1uLYh1kyKkyH7V7TEUo5lxhMsAhoJsIBoEFiIpvVKXeICMjraQyXAMIOluNZzkN0ZZeYyG5g16vYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MAmcOrP/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=QglnmK8RtnosCN+O4T/C+Zb085pEA+FTmUjj4OXso1g=; b=MAmcOr
	P/nRM6WijD5YRZoUrkEPfjUkZ+hF+iTq+2pxVgwmfCDEUZ+gHPp1jdIPfMqiYghkq3YSf55Lo7khQ
	GLVv7Elnq+jwzjboMuWlYhJVPuAapUf+GS8a/zTLK9QaWT3RAJxAVXfGTA1APzRwj2uFUBbkC7GTw
	vm9fHa6nO06i19xmontb9lPA3gR+kmKWd8RoRqovtkfaulqhdxdq9OHePgc/GfIh7yGggT0v5l07K
	2bbUSKdAJANea8DDClPCenGZwEAJ9iyl8JKRTWQi4T5aFa77YhZMsQAp6xciZEKKsl8SZbfmXPgEK
	TDy/hofuhRcnFfsryPLwAXSCX97A==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGKca-000M8G-F2; Wed, 27 Nov 2024 17:10:32 +0100
Received: from [2a06:4004:10df:0:a116:6f2b:4c0f:adc0] (helo=Seans-MBP.snzone.dk)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGKcZ-000Ooy-2E;
	Wed, 27 Nov 2024 17:10:31 +0100
Date: Wed, 27 Nov 2024 17:10:31 +0100
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
Message-ID: <lmyugclgwb7txf3jxc3fsasp5fgu7fji5dxb2wjw4jji32omnt@rs27camphw7q>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
 <20241127-siberian-singular-c2b99a7fd370@spud>
 <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

On Wed, Nov 27, 2024 at 04:56:13PM +0100, Sean Nyekjaer wrote:
> Hi Conor,
> 
> On Wed, Nov 27, 2024 at 03:50:30PM +0100, Conor Dooley wrote:
> > On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> > > tcan4x5x requires an external clock called cclk, add it here.
> > 
> > That's not what this patch is doing, the clock input is already there,
> > so I don't know what this patch actually accomplishes? clock-names isn't
> > a required property, so you can't even use it in a driver.
> > 
> 
> Thanks for asking the right questions :)
> 
> I know the clock input is there, but it looks (to me) like the driver looks for the
> specific clock called cclk:
> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/m_can.c#L2299
> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/tcan4x5x-core.c#L396

Oh I really need to get my head around the dt jargon :)
Yes I'll add the clock-names to the required list for v2!

Br,
/Sean

