Return-Path: <linux-can+bounces-514-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC728B9437
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FA1C21121
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 05:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4BB1F95A;
	Thu,  2 May 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="UJCR0hkD"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ADA1CA81;
	Thu,  2 May 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627648; cv=none; b=iLcYAgyqKNARERkmNTbUyqIDaH+BuWG3/qBza3c+9n7Xaj/9enKurOEvBphOQ50cnP3gfPDv7te4CHpu0DZWzXi6PD7tMkslQ9yJp1sy35tlw+T3EDOPVQVmlKgJIp/v3UG+VH9MsWTRvkfiLns2QU9CUXfcDwAg7mAZw+zkg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627648; c=relaxed/simple;
	bh=ftHzH9qvJa3de0MGd82tHpZ8K22GEeMdMaS34WhIAiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hbdwWQwKTsF4fTdG1OiijVO42PWmTK8b0MmHYNoZiY0/u2k5jHRsr1Z3dOC422mv6JJge7kyCvfiY1wQGnP5DzgAAvY8hSzNmL+FCY8oX9+O4lRV2WLDdbmjokS2i0HZgp6FS8eGjTq0D2qm/jlg9oqPNtNzC+9mQViPvCVIfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=UJCR0hkD; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iw9sb5bPm/obi3rgls3+3/4K0A0MuMZb4NR+Kz+bqj0=; b=UJCR0hkDNdfxATyaw5BU3n50vf
	LphM+CQi668+Gn1auChFaligiaHZoThnzPncO/8TioOmvKhqkIbAUNFTdT1TKvKfRy38ufnVVwoiR
	JqIZea/fWsEufV4vr/rJVO7A54QkB8nM0dT8OVu7PSUMrMKyl2x5N6JeMPXdnkc8eb6A=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2OyD-001YZ2-2d;
	Thu, 02 May 2024 07:27:02 +0200
Message-ID: <77d0b2c62aad02c7c6f291676673b672ab35528a.camel@hexdev.de>
Subject: Re: [PATCH 05/11] dt-bindings: net: can: Add serdev LIN bus dt
 bindings
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: Krzysztof Kozlowski <krzk@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri
 Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>, Jonathan Corbet
	 <corbet@lwn.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-serial@vger.kernel.org
Date: Thu, 02 May 2024 07:26:59 +0200
In-Reply-To: <784d78a8-3809-4a53-a9f2-7d9682b82c58@kernel.org>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
	 <20240422065114.3185505-6-christoph.fritz@hexdev.de>
	 <784d78a8-3809-4a53-a9f2-7d9682b82c58@kernel.org>
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

Hello Krzysztof,

 thanks for your feedback, please see my answers below.

On Mon, 2024-04-22 at 09:54 +0200, Krzysztof Kozlowski wrote:
> On 22/04/2024 08:51, Christoph Fritz wrote:
> > Add documentation of device tree bindings for serdev UART LIN-Bus
> > devices equipped with LIN transceivers.
> 
> A nit, subject: drop second/last, redundant "dt bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

OK

> 
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  .../bindings/net/can/linux,lin-serdev.yaml    | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
> > new file mode 100644
> > index 0000000000000..cb4e932ff249c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/can/linux,lin-serdev.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Linux serdev LIN-Bus Support
> 
> This looks like Linux binding, but we expect here description of hardware.

OK


> > +
> > +description: |
> > +  LIN-Bus support for UART devices equipped with LIN transceivers,
> > +  utilizing the Serial Device Bus (serdev) interface.
> 
> serdev is Linux thingy, AFAIR. Please describe the hardware.

OK, in v2 it will get changed to:

"""
LIN transceiver, mostly hard-wired to a serial device, used for
communication on a LIN bus.
"""

> 
> > +
> > +  For more details on an adapter, visit: https://hexdev.de/hexlin#tty
> > +
> > +properties:
> > +  compatible:
> > +    const: linux,lin-serdev
> 
> Feels confusing. Your link describes real hardware, but you wrote
> bindings for software construct.
> 
> If you add this to DT, then it is hard-wired on the board, right?

Yes, it is hard-wired.

>  If so, how this could be a software construct?

It's not, but fairly generic, that's why I used 'linux,lin-serdev' as
compatible string. In v2 I'll change it to 'hexdev,lin-serdev'.

> > +
> > +required:
> > +  - compatible
> > +
> > +examples:
> > +  - |
> > +    &uart2 {
> 
> & does not make much sense here. I think you wanted it to be serial bus,
> so serial.

OK

> 
> > +      status = "okay";
> 
> Drop, it was not disabled anywhere.

OK

> 
> 
> > +      linbus {
> > +        compatible = "linux,lin-serdev";
> > +      };
> > +    };

Let me address these points, fix warnings from dt_binding_check and
reroll in v2.

Thanks
  -- Christoph


