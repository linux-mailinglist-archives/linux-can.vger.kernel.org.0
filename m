Return-Path: <linux-can+bounces-1972-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0609C4FC5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 08:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24E01F23924
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D432141D6;
	Tue, 12 Nov 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="DB3s470d"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DE2141D3;
	Tue, 12 Nov 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397264; cv=none; b=iEcZebAfthmIgtPCAJHHQsiQl4S0PL4V0imwM4j7Fu11jrSOuL2T7aiaxGEBdbVV/mZrxmNO5IqZBDKnq7u02nApkSMytcydisk13srJ1pOmO0T6ps+GCUJ6bckfIhVGyK840vuh+xZAM4xDNjfvxAUmbHaTd+zmpnFKNyExWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397264; c=relaxed/simple;
	bh=HUPCstSJj8AxNTTkAfFfg8P+gOx/RYusqa+DP+nFCLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQihGP6oOre6pljqzBtcSraTbI9YIc9qwItA8QAj9kOo1ty+PoL4cpQQ6KOWZjMO4ziC2GKsJWuwKe/O0/yM1OzWpcI1z+U2ggvneNGYBV8vgc8uGzbV2qmgzMSflBGkcOu75idx5owLjyjsDMAfOYsvakW2wDsAn2i+qGpiej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=DB3s470d; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=GZ+O2Qi+eJgeGlb2DdaYSgi1qSIQP3nEYZ9DvcIGf+g=; b=DB3s47
	0dOw183BT2XDoM8tXijA5Qjpx3ck/RAx5DF/hyCmXrrCmcdOeng9dFmdXSuJxfzSk0aMzbcHAio7b
	womTtZxal7BPBNUnhrovxCTGYPrm7CGokOuXLXRj8bfmK3vG6ed21ZBB6TzQoRr+wXjqFpJuXcxWj
	OyUyTXyN8GWnVR40UGpiUxXSeaaMe622Hj418F2Kw2EEjPMKA+OhMAcivDk8/GI8eY3eRkG1hcUsO
	767HzJAk8kFd3x3ABX9/3APBXTHz84SeuTJumLNKDfKnyjtC1dPbBbGScsqMiQeVAWZige4BadQ0c
	fzj1FdLMOylWoq+yEjOFqWpShbRQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAlWD-0002iz-TU; Tue, 12 Nov 2024 08:40:57 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAlWD-000P1x-0c;
	Tue, 12 Nov 2024 08:40:57 +0100
Date: Tue, 12 Nov 2024 08:40:56 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-sel option
Message-ID: <jd5ausjx726rem4iscupwfxilc2fsfkshw3pim2ps3i5btstge@sz6qnqjfvwx2>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111-tcan-wkrqv-v2-2-9763519b5252@geanix.com>
 <20241112-sincere-warm-quetzal-e854ac-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112-sincere-warm-quetzal-e854ac-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

Hi Marc,

On Tue, Nov 12, 2024 at 08:35:43AM +0100, Marc Kleine-Budde wrote:
> On 11.11.2024 09:54:50, Sean Nyekjaer wrote:
> > nWKRQ supports an output voltage of either the internal reference voltage
> > (3.6V) or the reference voltage of the digital interface 0 - 6V.
> > Add the devicetree option ti,nwkrq-voltage-sel to be able to select
> > between them.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > index f1d18a5461e05296998ae9bf09bdfa1226580131..a77c560868d689e92ded08b9deb43e5a2b89bf2b 100644
> > --- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > @@ -106,6 +106,18 @@ properties:
> >        Must be half or less of "clocks" frequency.
> >      maximum: 18000000
> >  
> > +  ti,nwkrq-voltage-sel:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    description:
> > +      nWKRQ Pin GPO buffer voltage rail configuration.
> > +      The option of this properties will tell which
> > +      voltage rail is used for the nWKRQ Pin.
> > +    oneOf:
> > +      - description: Internal voltage rail
> > +        const: 0
> > +      - description: VIO voltage rail
> > +        const: 1
> 
> We usually don't want to put register values into the DT. Is 0, i.e. the
> internal voltage rail the default? Is using a boolean better here?
> 
> regards,
> Marc
> 

Thanks for the review :)

Can you come up with a sane naming?
A boolean that equals true when it's set to VIO voltage? Or the other
way around?

/Sean

