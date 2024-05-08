Return-Path: <linux-can+bounces-597-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D288BFC26
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2571F2195C
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2024 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246382481;
	Wed,  8 May 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="ARyzWnXk"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9888120A;
	Wed,  8 May 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168092; cv=none; b=oI4QXn+Nht2/7KbBYUINsVM7Hth0EDyQ+s+ZljMxQBx/E/AlJ+3BPSAY8mB/+ljayPb9CuQ/RURpx0AIaufHJg9VXM48eye0mC8COEVbzjlGn99g7s3OLJjKZg561xsLYUPWypU17fsl6/j8wydxzjFR8kqJSQD0X0otIj7kuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168092; c=relaxed/simple;
	bh=tixuWnWaApHZa88I9VH9uCSdEVSxkxdW1LaQ2M+1bwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZcMT3SdXXmWPoBwXfG2fOJHZGo3pUcyrDA3qS0V5CFoKOl8I69pon31IADkbfTXIKI0nleX2j53a0mPLSPOHUvw06xiCsY6d3l9XwWtHEdtchXDFKws1fnWgeyqbYSuzI7d4WgX94W9i7i85bd3Q7QrtwQ4jUaAXTS5GnJx1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=ARyzWnXk; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JT/pKnPhOXs9FuvMeUswkfzbqk7jg11xjzMVg++jEag=; b=ARyzWnXkp1DVrw7gVTuJiQcgnN
	cfynAutb8zVYBi3YJWPh/Qt4kzmN6krzwKNDrDKuTD0ZS9UI1W8OfIxAtRX4C1udDhwyO1ls7/TcF
	NLrrfGnoyF2qxjVtuz9qubprP0xl4p4bw29Re61gTZA2FPP35+JoCYKRNffXbQH+ADro=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s4fZD-001hfX-1W;
	Wed, 08 May 2024 13:34:35 +0200
Message-ID: <b716f34ce54dfed2595690d37c121d242a18ff64.camel@hexdev.de>
Subject: Re: [PATCH v3 06/11] dt-bindings: net/can: Add serial (serdev) LIN
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>,  Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Reichel <sre@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Andreas Lauser
 <andreas.lauser@mercedes-benz.com>,  Jonathan Corbet <corbet@lwn.net>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org,  linux-serial@vger.kernel.org
Date: Wed, 08 May 2024 13:34:34 +0200
In-Reply-To: <f1173a7c-f18b-47cc-8873-30347489d1be@kernel.org>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-7-christoph.fritz@hexdev.de>
	 <20240503-fading-extruding-2105bbd8b479@spud>
	 <a5b894f8dc2ab0cf087a5b4972d7f752e6c17c16.camel@hexdev.de>
	 <20240506-jaws-cheesy-bf94885651c1@spud>
	 <f1173a7c-f18b-47cc-8873-30347489d1be@kernel.org>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-06 at 20:50 +0200, Krzysztof Kozlowski wrote:
> On 06/05/2024 18:16, Conor Dooley wrote:
> > > > > +maintainers:
> > > > > +  - Christoph Fritz <christoph.fritz@hexdev.de>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: hexdev,lin-serdev
> > > > 
> > > > Maybe I've just missed something on earlier versions that I didn't
> > > > read, but the name of the device on the website you link is "hexLIN",
> > > > so why is "lin-serdev" used here instead?
> > > 
> > > The USB one is called hexLIN and has it's own HID driver.
> > > 
> > > This serial LIN adapter doesn't really have a product name. Currently
> > > on our website it's generically called 'UART LIN Adapter'.
> > > 
> > > This LIN adapter is basically just a LIN transceiver and very generic,
> > > so that one could solder it to any single-board computer with an uart.
> > > 
> > > I think 'lin-serdev' for LIN and serial device fits great, also serdev
> > > is the name of the used kernel infrastructure (besides the LIN glue
> > > driver).
> > > 
> > > If you still don't like it, I'm open to other names. What about
> > > "hexlin-uart" or "linser"?
> >
> > I dunno, I don't really care about it being called "hexlin,lin-serdev",
> > all that much, I just found it confusing that the link in the description
> > sent me to the ""Hello World" in LIN" section of your site. If it had
> > dropped me off at the "UART LIN adapter" section things woud've been less
> > confusing.

Hi Conor and Krzysztof,

I guess this is a chromium oddity, because browsing to

 https://hexdev.de/hexlin#hexLINSER

brings the user to another headline ("hexLIN" not "hexLINSER") as long
as headline "hexLINSER" can be also displayed.

When using firefox, the top headline is hexLINSER as expected (at least
I do).

> > 
> > That said, calling the compatible after a linux-ism is a bit odd to me
> > when the device seems to be called a "UART LIN adapter" on the page, not
> > a "serdev".
> > 
> 
> If there is no real, fixed model name, I would also propose to use
> whatever is on the website currently and avoid Linuxism.

OK, I changed it to hexLINSER on the website and in the upcoming v4
revision of this patchset. LINSER for LIN and serial, or like in
"Linsen & Spätzle" :)

Thanks
  -- Christoph 


