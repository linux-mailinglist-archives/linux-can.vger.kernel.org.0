Return-Path: <linux-can+bounces-1994-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB179C5D73
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430F7281EC5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5120694D;
	Tue, 12 Nov 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQaYjSTz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81BE206067;
	Tue, 12 Nov 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429446; cv=none; b=cddvYETCXQGU3IeFIC0l0vS4a/1VAe1Jl0fqnYnVsBnOZUwZGU8gz9/xWJ+gFSHzulXx2o0TcSj//ba504zo8X/k0tCm2DxOAohgQ7EXMadm5LWgLtHSTbrwjF8OVDxrbckXfG8ZENGdCNj1DNE+rF1QmNxbUIviOWp9Hp2YN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429446; c=relaxed/simple;
	bh=0Gd9BBi3w/ks72jwpBlBm8kmgsSoikaY5omKdoods7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1ksTuZTtJES8BLbSMyn+qJ5ejhMyeJHRGULiMjWwJLnJhkY5mkd+QTWl8UNB3BaDkdG50PnbqESqOmX/r2hkR3gMdnrtPBZKfVOHi2Wp69I1UOA9uVRq4/HX5MqQkx58bYKwKwc4ox6q6IxAwQTtUJUZFYV3hdvSTyH7k8JK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQaYjSTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A6C4CECD;
	Tue, 12 Nov 2024 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731429445;
	bh=0Gd9BBi3w/ks72jwpBlBm8kmgsSoikaY5omKdoods7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQaYjSTzIUtruQCkG7i8elZIjAfPq4ts1dJGlR7iG79h43GhySj+6iV6f1SXmPzvQ
	 MbyYwKfjI7UJS0xmCwwO/0BSaeRSCXOU0NQTDdQCYNkGx6moa0+a8IMroSrbGn+Reu
	 O8SHQxW9s7O0cCMikyNjOaat2rdp4bl//t4FttqP4M84tRQZoYhheeGCGZ1XDCCZoZ
	 LvXsgbvkSB6Q9R6P56W6HB6vkOLuiB0r8alQxwjaAkRoSLdvTNmSrTHjYq7JjZ6uDq
	 4ROllXcc/6b2M8LW/q2WumWONLV9Gvh6D9wVFQVJNde6woJmiTBxbDQCKP9NwdMjZU
	 m36uFZe0dgUWw==
Date: Tue, 12 Nov 2024 10:37:23 -0600
From: Rob Herring <robh@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Message-ID: <20241112163723.GA1142553-robh@kernel.org>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-2-9763519b5252@geanix.com>
 <20241112-sincere-warm-quetzal-e854ac-mkl@pengutronix.de>
 <jd5ausjx726rem4iscupwfxilc2fsfkshw3pim2ps3i5btstge@sz6qnqjfvwx2>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jd5ausjx726rem4iscupwfxilc2fsfkshw3pim2ps3i5btstge@sz6qnqjfvwx2>

On Tue, Nov 12, 2024 at 08:40:56AM +0100, Sean Nyekjaer wrote:
> Hi Marc,
> 
> On Tue, Nov 12, 2024 at 08:35:43AM +0100, Marc Kleine-Budde wrote:
> > On 11.11.2024 09:54:50, Sean Nyekjaer wrote:
> > > nWKRQ supports an output voltage of either the internal reference voltage
> > > (3.6V) or the reference voltage of the digital interface 0 - 6V.
> > > Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> > > between them.
> > > 
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > > index f1d18a5461e05296998ae9bf09bdfa1226580131..a77c560868d689e92ded08b9deb43e5a2b89bf2b 100644
> > > --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > > +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > > @@ -106,6 +106,18 @@ properties:
> > >        Must be half or less of "clocks" frequency.
> > >      maximum: 18000000
> > >  
> > > +  ti,nwkrq-voltage-sel:
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description:
> > > +      nWKRQ Pin GPO buffer voltage rail configuration.
> > > +      The option of this properties will tell which
> > > +      voltage rail is used for the nWKRQ Pin.
> > > +    oneOf:
> > > +      - description: Internal voltage rail
> > > +        const: 0
> > > +      - description: VIO voltage rail
> > > +        const: 1
> > 
> > We usually don't want to put register values into the DT. Is 0, i.e. the
> > internal voltage rail the default? Is using a boolean better here?
> > 
> > regards,
> > Marc
> > 
> 
> Thanks for the review :)
> 
> Can you come up with a sane naming?
> A boolean that equals true when it's set to VIO voltage? Or the other
> way around?

Make the property named/present for the less common case if there is 
one. That might not be known here.

Rob

