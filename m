Return-Path: <linux-can+bounces-1899-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720549BCCA6
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 13:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21B1B22A8D
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691A1D54DA;
	Tue,  5 Nov 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LdubQuJP"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85151D5172;
	Tue,  5 Nov 2024 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809475; cv=none; b=p2xzTy1HL6C5jC3Bp2v0cqUKo8EBicM8it1S0L0Iv7mc6UeQph5roXbiEkLdq1jBihlroEIHwi8p79t3O5f7Il7Vrw2+IwR609xUBbE+FZ+2sRduI0Hnfp9rHjEt+L6VBNNu8Ezn1Ehl06UFPGKA6p6YdVyEdwLmOrnfNKFsSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809475; c=relaxed/simple;
	bh=AwaaOCjl6IRNUdsw+L2crhsWw5WBqlJ+27riv3An4Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTBg0E35BF3ho5f3gOhbpfwr3GmmdLr+JFkiFsg2uYb+jNTmWLv1RFiOOrcBtL2PHJNQsVUUpFIW4vVEYx5X/fEe9JFf5Gru5hwHGtjqf+xeOq4mCpc9OcbCYtFzHN+sdntEunETv3rFU7AAnJduy7k3BhyWdSWOO7FeNJrwDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LdubQuJP; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=cu2xVfSJiTZUpr+7HBsp7d5hE0sRaCcgNm0WEpQ0UcM=; b=LdubQu
	JP7Qckf1aoNWCCsG3BPxr3v5ZILD7+yzvgAuY6ryz1Zzw3jCeiZENfnDvXWwMVe2lkzZWxdMb8OjU
	cfPMINGXPY5KutbdpD5B4OygtWy7ebZRl2lprhKiDKzsjGobSWyNVRLWAoMmSN074GRL6CW8SVFcp
	sNou+Vf9HuAnOBi02FNtfwrmEsdFuNHCxhIxHL53YNnVXHe5DftsPy6GbifHWws3L8SCKpQLtbDvP
	mWlNH773dG+LjkVuAPwKmCl2kZK4w/aVgz6GFshBTPmPHnEfLby29q1X70FkFPtHLnbtbQhBhR2SF
	6Op3toBDJf4iYPRRDgI7Fmmpq84g==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t8Ibl-000LUE-1r; Tue, 05 Nov 2024 13:24:29 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t8Ibk-0003XL-1P;
	Tue, 05 Nov 2024 13:24:28 +0100
Date: Tue, 5 Nov 2024 13:24:26 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <mtuev7pve5ltr6vvknp2bwtwg2m7mzxduzshzbr7y3i7mwbzy6@qjbdjyb56nrv>
References: <20241104125342.1691516-1-sean@geanix.com>
 <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
 <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
 <60901c39-b649-4a20-a06a-7faa7ddc9346@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60901c39-b649-4a20-a06a-7faa7ddc9346@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27449/Tue Nov  5 10:36:43 2024)

Hi Krzysztof,

On Tue, Nov 05, 2024 at 12:40:07PM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2024 11:33, Sean Nyekjaer wrote:
> > On Tue, Nov 05, 2024 at 10:16:30AM +0100, Krzysztof Kozlowski wrote:
> >> On Mon, Nov 04, 2024 at 01:53:40PM +0100, Sean Nyekjaer wrote:
> >>> Convert binding doc tcan4x5x.txt to yaml.

[...]

> > 
> > Gives:
> > /linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: ['ti,tcan4x5x'] is valid under each of {'items': [{'enum': ['ti,tcan4553', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'const': 'ti,tcan4x5x'}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'enum': ['ti,tcan4552', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}
> >         from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> > /linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: 'oneOf' conditional failed, one must be fixed:
> >         ['ti,tcan4552', 'ti,tcan4x5x'] is too long
> >         'ti,tcan4552' is not one of ['ti,tcan4553', 'ti,tcan4x5x']
> >         'ti,tcan4x5x' was expected
> >         from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> > 
> > I can understand the original binding is broken.
> > I kinda agree with Marc that we cannot break things for users of this.
> 
> Hm? Absolutely nothing would get broken for users. I don't understand
> these references or false claims.
> 

There are no users for this in-kernel, but out-of-tree there is :)

> > 

[...]

> > OK
> > 
> >>> +      Enable CAN remote wakeup.
> >>> +
> >>> +allOf:
> >>> +  - $ref: can-controller.yaml#
> >>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - ti,tcan4552
> >>> +              - ti,tcan4553
> >>> +    then:
> >>> +      properties:
> >>> +        device-state-gpios: false
> >>> +        device-wake-gpios: false
> >>
> >> Heh, this is a weird binding. It should have specific compatibles for
> >> all other variants because above does not make sense. For 4552 one could
> >> skip front compatible and use only fallback, right? And then add these
> >> properties bypassing schema check. I commented on this already that
> >> original binding is flawed and should be fixed, but no one cares then I
> >> also don't care.
> > 
> > To me it looks like the example you linked:
> > https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L223
> 
> Yes, it looks, that's not the point.
> 
> > 
> > If you use fallback for a 4552 then it would enable the use of the
> > optional pins device-state-gpios and device-wake-gpios. But the chip
> > doesn't have those so the hw guys would connect them and they won't
> > be in the DT.
> > 
> > Honestly I'm confused :/
> 
> What stops anyone to use tcan4x5x ALONE for 4552? Nothing. And that's
> the problem here.
> 
>

Schema check will fail, but driver wize it will work just fine.
Agree that is kinda broken.
If I have time I can try to fix that later.

Please explain one more time for me. Is this a comment on the if
sentence or the broken behavior of the driver?

> > 
> >>
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +  - interrupts
> >>> +  - clocks
> >>> +  - bosch,mram-cfg
> >>> +
> >>> +additionalProperties: false
> >>
> >> Implement feedback. Nothing changed here.
> >>
> > 
> > Uh? feedback?
> 
> Yeah, CAREFULLY previous review and respond to all comments or implement
> all of them (or any combination). If you leave one comment ignored, it
> will mean reviewer has to do same work twice. That's very discouraging
> and wasteful of my time.

Replaced with:
unevaluatedProperties: false

> 
> 
> Best regards,
> Krzysztof
> 

/Sean

