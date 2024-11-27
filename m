Return-Path: <linux-can+bounces-2241-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2079DAB2B
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 16:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14A9B22238
	for <lists+linux-can@lfdr.de>; Wed, 27 Nov 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFD200B83;
	Wed, 27 Nov 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mm+OsnDa"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E1200123;
	Wed, 27 Nov 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722983; cv=none; b=BxqqKLwYHfJRFafULzZPT9oSQTV32OIe1cjz+WJ+2UM3uCGyh8HLuuLftuZU+rr/NMN8WwRCUNJzEmlxE0Y/1A9rALG3kGD7bfkT/RIEwWYleCzsgUujldbGD6JGotE/Fxl6fYDhMnEvg/qhxC9gzA42XQ3xgxGYKYERdDVMaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722983; c=relaxed/simple;
	bh=KiI9tNUaujgguyPi9FWL1nVPIFIqCpWymO8Fl2keqfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azKKfKFxXgcFhM771UpQf0TvQXd90hjCaGONUy9UbWT0yu8I5UL13LqSTfuHhmSNdeLsRH5Yt6zqulPlMsO2m3LqDcYkuQoKGWU3mgiIM7PCkWl3QytYsd4ivBL7acNzaqTI0UC/CDSVLjDr/bJAiyFrfgfOC9hb6mxMLqUULBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mm+OsnDa; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=IAu5YOnV4NgimDh0XxsNPeTfaJsVkEY03YRoCEUUWAA=; b=mm+Osn
	DaksVa0ZWYox5yp4clieuy/ucbUGfGodG4uopWIs1YxRo1rHYPMh+GvOCzp5GzWumlJhjJ0N9Lk/f
	4l+aO31oIW8NFeMWcAqxL3YzWjDH6WFAQ2JyYgfSprc1JJewZttCiMkOAAtJeVI86tjMW1+sg52Kr
	xTb8QbTMD7arp8CTmFITDW2xwu1OOkKq9bushpaobLMCosPrXoUqpHC9swoOqw12RZ8rvC7VtV5UH
	GNSEjwlza6SOzgd9Mksvp1MkiJ7Oamh9/bVBOMmxqck16XrlhN5Yyu9sjYP1jsVCDBmkmdW1bBmPL
	B0LQYVdpVnPsY+v/FsBfGuo9b7sw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tGKOk-000Jie-9X; Wed, 27 Nov 2024 16:56:14 +0100
Received: from [2a06:4004:10df:0:a116:6f2b:4c0f:adc0] (helo=Seans-MBP.snzone.dk)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tGKOj-000IWi-1n;
	Wed, 27 Nov 2024 16:56:13 +0100
Date: Wed, 27 Nov 2024 16:56:12 +0100
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
Message-ID: <pl22u3ybv3ibnpzmgiskppz56vlvqhlz25h7s5ewunkks6ywtn@v6lgln7s536w>
References: <20241127-tcancclk-v1-1-5493d3f03db1@geanix.com>
 <20241127-siberian-singular-c2b99a7fd370@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127-siberian-singular-c2b99a7fd370@spud>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27470/Wed Nov 27 10:59:44 2024)

Hi Conor,

On Wed, Nov 27, 2024 at 03:50:30PM +0100, Conor Dooley wrote:
> On Wed, Nov 27, 2024 at 02:40:47PM +0100, Sean Nyekjaer wrote:
> > tcan4x5x requires an external clock called cclk, add it here.
> 
> That's not what this patch is doing, the clock input is already there,
> so I don't know what this patch actually accomplishes? clock-names isn't
> a required property, so you can't even use it in a driver.
> 

Thanks for asking the right questions :)

I know the clock input is there, but it looks (to me) like the driver looks for the
specific clock called cclk:
https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/m_can.c#L2299
https://elixir.bootlin.com/linux/v6.12/source/drivers/net/can/m_can/tcan4x5x-core.c#L396

Br,
/Sean

