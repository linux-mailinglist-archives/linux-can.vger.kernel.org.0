Return-Path: <linux-can+bounces-557-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B88BB316
	for <lists+linux-can@lfdr.de>; Fri,  3 May 2024 20:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1991C2039F
	for <lists+linux-can@lfdr.de>; Fri,  3 May 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8EC15887C;
	Fri,  3 May 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="jcYIdUNN"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C8158866;
	Fri,  3 May 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760992; cv=none; b=P2g4v4HWxauRbZOBMXaGkCPAj1QQeTQBjU73a8sfL+cmlm/0sv5btBm70zHblscjF/e+GfzKTyLCL0bz+GnROBv3GnoPrUYhFQjtdFtJVkBsFXIPFgwAAaQEIo7HGYs12+2UamrQ2/z1uPcPakb/AIDCeOwuzp+SgHoAd8Yytkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760992; c=relaxed/simple;
	bh=e6ynbt8+QgxzbH/E73GTS+ubMG/h4wOsFbzFgj/kgyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhLfjdpv2NIJ+ouHl9mO+ny244RWGHNO25GhDAy2OzCQ4hZL0vCMkD1fyt9z8KFMUe9HrsanIyqtHBBR2XykkGmWiJCEut6cKIrPPDq7oEYRpXVCw+3Q5osLm28aa2OrHGfGluxWo0esAdUdsuB6cd4ujgOzbpl7o9w0doGvuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=jcYIdUNN; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gsmaW6yu2jr4Gxl/DMVyniBNsiaG9rH9ORl++Cua8YA=; b=jcYIdUNNrnGBnjJCd2kt159D5n
	GZ7PdVcmuvmeEJg3t72W8DVoPl6nrYUZFNktgbaSVxnYtzKwYLdZNCfGoMSzlE2DOk94SbiRWszL7
	+fMD4AhUVD2/UAwOZxo+Ub27B9PuY0a2SFGJ+8G5euEUsp6sbh7mbxXk7CwfGq3AFw/E=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2xep-001awL-0X;
	Fri, 03 May 2024 20:29:19 +0200
Message-ID: <a5b894f8dc2ab0cf087a5b4972d7f752e6c17c16.camel@hexdev.de>
Subject: Re: [PATCH v3 06/11] dt-bindings: net/can: Add serial (serdev) LIN
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Conor Dooley <conor@kernel.org>
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
Date: Fri, 03 May 2024 20:29:15 +0200
In-Reply-To: <20240503-fading-extruding-2105bbd8b479@spud>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
	 <20240502182804.145926-7-christoph.fritz@hexdev.de>
	 <20240503-fading-extruding-2105bbd8b479@spud>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hello Conor,

 thanks for having an eye on this, please see my answer below.

On Fri, 2024-05-03 at 18:12 +0100, Conor Dooley wrote:
> On Thu, May 02, 2024 at 08:27:59PM +0200, Christoph Fritz wrote:
> > Add dt-bindings for serial LIN bus adapters. These adapters are
> > basically just LIN transceivers that are hard-wired to serial devices.
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > new file mode 100644
> > index 0000000000000..c178eb9be1391
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/can/hexdev,lin-serdev.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Serial LIN Adapter
> > +
> > +description:
> > +  LIN transceiver, mostly hard-wired to a serial device, used for communication
> > +  on a LIN bus.
> > +  For more details on an adapter, visit <https://hexdev.de/hexlin#tty>.
> > +
> > +maintainers:
> > +  - Christoph Fritz <christoph.fritz@hexdev.de>
> > +
> > +properties:
> > +  compatible:
> > +    const: hexdev,lin-serdev
> 
> Maybe I've just missed something on earlier versions that I didn't
> read, but the name of the device on the website you link is "hexLIN",
> so why is "lin-serdev" used here instead?

The USB one is called hexLIN and has it's own HID driver.

This serial LIN adapter doesn't really have a product name. Currently
on our website it's generically called 'UART LIN Adapter'.

This LIN adapter is basically just a LIN transceiver and very generic,
so that one could solder it to any single-board computer with an uart.

I think 'lin-serdev' for LIN and serial device fits great, also serdev
is the name of the used kernel infrastructure (besides the LIN glue
driver).

If you still don't like it, I'm open to other names. What about
"hexlin-uart" or "linser"?

Thanks
  -- Christoph
> 

