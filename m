Return-Path: <linux-can+bounces-1869-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A725D9BB245
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CFA2827A3
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A71DD9BD;
	Mon,  4 Nov 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="YaZivBDM"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D91DD0CA;
	Mon,  4 Nov 2024 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717669; cv=none; b=NO0MHjVptgG63VkcCXkC3+rgbBke+2B1xUaNeXKRIXUybOv/d7iO/jK+KbI+PsyeYMoxvotltM+lAKtEojCV6G7IvwfFqTxDMoA8A72UpP78Jc7HbTqb9Wt6kbNQTO70y9wFHmrDrXtZ+LOcdNHiHfqeze7Ijdc5izc8xM+Lu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717669; c=relaxed/simple;
	bh=Xp2eMGFVn3MC7Z6tDGlp1OpvzHvkucWeksZagcdWn2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSC9iKZExqGNqs9xAB4kyNKZO0uP29SKgjp4Muksvb3Mwy3mL/ptW/AjL0naRxZIUEfW08dch6FkU1tm+9SQ5AL1uKudCrku0/mhBnn9K+ViBCkmTzP3zY9X3XmLxdONGA4PR0US/dRiSL8Alwh3ekYrA7EcyLLLyqQ/AERYQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=YaZivBDM; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=nMNE/O5pjFvv7Wgu/uX54LU5Iy2V038M4oyhx/Jj4sQ=; b=YaZivB
	DMGlKnQLkEMe+a6D8fVmFX+OfXql1QpCUKGtK8z4efyLkPDt6JyGiUtNxbLvY3haeEsuHbAjjnp+F
	VZoEQjUpDG9Or7zloFeoxbT6EwR6Ulin5w0FEfZW4Q+m3xoRc2Cms6EovBAv+u3fN8WWw8HgVd1Oz
	SborqZVFkPKYWUQrCqfjSel+QixgCWMXH/d3OGFS02XGo+X2rwl52eqfjhNzGy48TfTDqE7pjyVxM
	60KR9cpf/HBu7IVMke/knTnPS/RDYth3vUfS9eFJGt+V54E27rtkjC2rrdhqnRoKQmOdVjsmLrWlj
	/S9j2zy9eyw4WG3fn+EdQ+HK4G9g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t7uj1-0001pJ-4m; Mon, 04 Nov 2024 11:54:23 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t7uj0-0004BJ-1B;
	Mon, 04 Nov 2024 11:54:22 +0100
Date: Mon, 4 Nov 2024 11:54:21 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <2mx3fpwo5miho3tdhfbt7ogwnifnhe7qlvjs3zjb2y2iifgjwo@23mxoxvwsogy>
References: <20241104085616.469862-1-sean@geanix.com>
 <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee47c6d7-4197-4f5d-b39e-aab70a9337d6@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27448/Mon Nov  4 10:33:38 2024)

On Mon, Nov 04, 2024 at 10:27:04AM +0100, Krzysztof Kozlowski wrote:
> On 04/11/2024 09:56, Sean Nyekjaer wrote:
> > Convert binding doc tcan4x5x.txt to yaml.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > 
> > Can we somehow reference bosch,mram-cfg from the bosch,m_can.yaml?
> > I have searched for yaml files that tries the same, but it's usually
> > includes a whole node.
> > 
> > I have also tried:
> > $ref: /schema/bosch,m_can.yaml#/properties/bosch,mram-cfg
> 
> Yes, this would work just with full path, so /schemas/net/can/...
> 
> See:
> Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
> 
> But you can also just copy it. Ideally this should be moved to common
> schema or replaced with more generic property, but these do not have to
>be part of this conversion.


diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index 9ff52b8b3063..0fc37b10e899 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -50,7 +50,7 @@ properties:
     maxItems: 1

   bosch,mram-cfg:
-    $ref: bosch,m_can.yaml#
+    $ref: /schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg

   spi-max-frequency:
     description:

Still results in:
% make dt_binding_check DT_SCHEMA_FILES=ti,tcan4x5x.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   Documentation/devicetree/bindings
Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml: properties:bosch,mram-cfg: 'anyOf' conditional failed, one must be fixed:
        'description' is a dependency of '$ref'
        '/schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg' does not match 'types.yaml#/definitions/'
                hint: A vendor property needs a $ref to types.yaml
        '/schemas/net/can/bosch,m_can.yaml#/properties/bosch,mram-cfg' does not match '^#/(definitions|\\$defs)/'
                hint: A vendor property can have a $ref to a a $defs schema
        hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
        from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

> 
> > 
> > Any hints to share a property?
> > 
> >  .../devicetree/bindings/net/can/tcan4x5x.txt  | 48 ---------
> >  .../bindings/net/can/ti,tcan4x5x.yaml         | 97 +++++++++++++++++++
> >  2 files changed, 97 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> >  create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > 
> 
> ...
> 
> > diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > new file mode 100644
> > index 000000000000..62c108fac6b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments TCAN4x5x CAN Controller
> > +
> > +maintainers:
> > +  - Marc Kleine-Budde <mkl@pengutronix.de>
> > +
> > +allOf:
> > +  - $ref: can-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - ti,tcan4552
> > +          - ti,tcan4553
> > +          - ti,tcan4x5x
> 
> That's not really what old binding said.
> 
> It said for example:
> "ti,tcan4552", "ti,tcan4x5x"
> 
> Which is not allowed above. You need list. Considering there are no
> in-tree users of ti,tcan4x5x alone, I would allow only lists followed by
> ti,tcan4x5x. IOW: disallow ti,tcan4x5x alone.
> 
> Mention this change to the binding in the commit message.
> 
> 

I would prefer to not change anything other that doing the conversion to
DT schema.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: Regulator that powers the CAN controller.
> > +
> > +  xceiver-supply:
> > +    description: Regulator that powers the CAN transceiver.
> 
> You need to mention all changes done to the binding in the commit msg.
> 
Is this a change? It existed in the old doc aswell...

> > +
> > +  reset-gpios:
> > +    description: Hardwired output GPIO. If not defined then software reset.
> > +    maxItems: 1
> > +
> > +  device-state-gpios:
> > +    description: Input GPIO that indicates if the device is in a sleep state or if the device is active.
> > +      Not available with tcan4552/4553.
> > +    maxItems: 1
> > +
> > +  device-wake-gpios:
> > +    description: Wake up GPIO to wake up the TCAN device. Not available with tcan4552/4553.
> > +    maxItems: 1
> > +
> > +  bosch,mram-cfg:
> > +    $ref: bosch,m_can.yaml#
> > +
> > +  spi-max-frequency:
> > +    description:
> > +      Must be half or less of "clocks" frequency.
> > +    maximum: 10000000
> 
> Old binding said 18 MHz?
> 

Good catch.

> > +
> > +  wakeup-source:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Enable CAN remote wakeup.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - bosch,mram-cfg
> > +
> 
> Missing allOf: with $ref to spi-peripheral-props. See other SPI devices.
> 
> 

Added for v2.

> > +additionalProperties: false
> 
> And this becomes unevaluatedProperties: false
> 
> Best regards,
> Krzysztof
> 

Added for v2.

Br,
/Sean

