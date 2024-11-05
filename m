Return-Path: <linux-can+bounces-1894-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661049BCA81
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 11:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB27F1F239E8
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA231D27AD;
	Tue,  5 Nov 2024 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="tuft6Ufj"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4C1CDA3E;
	Tue,  5 Nov 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802827; cv=none; b=BFwjFZxxHmXFSSMa0OATYQEweRz5RNq2yr/tz7UCMBpr3xaVYUu7cRh65CfWIKL+Pm5AIHPy1NQL5jXTU7h7SNFBwuXa51lkgrn6rqvAulo5ikmEp28Zg8uMRJhxKVdpf6it4mJl75VzJkDKIPKgei69SFkSxiToNsas2JU18Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802827; c=relaxed/simple;
	bh=/9OwNXT4wDtjPkJ6nX5NfwP0Hb8sxFz4gy3jIhzwrLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mprJOKgTMkWcBxon7Luwi7SQ71cRZ3jTnkHdKauuRUbG+BAsZx/gTjYh2+H9uhOxmAnB5ZlkIRtejDsRPaDQPTVp8m0maSC/lMTWq1iN4/PlsWJaNZIP+QmaD5XTxe1BpbQMqYD+pL65vibFRfZPZVSy2tC5XBFTAw4HkpO2VAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=tuft6Ufj; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=hLqN6GBp0XtIX0OeaoOad30FnloMkED96JI+4XREvMc=; b=tuft6U
	fjAfVfhulwwaoLYFKNBfLxs546+5iYfk0TMkb0Wta/KeIypynbmDI1nnzPOQ46F1nBl1PsALurCWI
	gbKdrTlzUSVjx8Dad/5ZRF4THx1JpVS0FNY9O1f3dg92sEBaT2FJ9y6LqZ2hgwdaZmBWHKocH0PHc
	+7Lt9hpQbMKQ1d1H3gpaUb+DR/FhiK8+eXm4cpmCL6y4D2oihd2mcvyLeYRNwRXplDCjXVqr1Nh9F
	DjCSuE7dnrMt2IEaKGc2LutmWLi+LLD39aadIL/9e5EWgB24cWg2HcjLrkQ7gt4ShnpxNCM1o3ExO
	CuRTzZOFNHpAPpj2glE0kaAvuRKg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t8GsQ-000Mkc-JR; Tue, 05 Nov 2024 11:33:34 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t8GsP-0005BF-2i;
	Tue, 05 Nov 2024 11:33:33 +0100
Date: Tue, 5 Nov 2024 11:33:33 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
References: <20241104125342.1691516-1-sean@geanix.com>
 <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27448/Mon Nov  4 10:33:38 2024)

On Tue, Nov 05, 2024 at 10:16:30AM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 04, 2024 at 01:53:40PM +0100, Sean Nyekjaer wrote:
> > Convert binding doc tcan4x5x.txt to yaml.
> > 
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes since rfc:
> 
> That's a v2. RFC was v1. *ALWAYS*.
> Try by yourself:
> b4 diff 20241104125342.1691516-1-sean@geanix.com
> 
> Works? No. Should work? Yes.
> 
> 

Ok. Good to know RFC cannot be used...
Next version would need to be? In order to fix this?

I have enrolled my patch into b4, next verison will be v2 ;)

> >   - Tried to re-add ti,tcan4x5x wildcard
> >   - Removed xceiver and vdd supplies (copy paste error)
> >   - Corrected max SPI frequency
> >   - Copy pasted bosch,mram-cfg from bosch,m_can.yaml
> >   - device-state-gpios and device-wake-gpios only available for tcan4x5x
> 
> ...
> 
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - ti,tcan4552
> > +          - const: ti,tcan4x5x
> > +      - items:
> > +          - enum:
> > +              - ti,tcan4553
> 
> Odd syntax. Combine these two into one enum.
> 
> > +          - const: ti,tcan4x5x
> > +      - items:
> 
> Drop items.
> 
> > +          - enum:
> 
> ... and drop enum. That's just const or do you already plan to add here
> entries?

Honestly I'm struggling a bit with the syntax and I feel the feedback is containing
a lot of implicit terms :)

Something like:
properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - ti,tcan4552
              - ti,tcan4x5x
      - items:
          - enum:
              - ti,tcan4553
              - ti,tcan4x5x
      - const: ti,tcan4x5x

Gives:
/linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: ['ti,tcan4x5x'] is valid under each of {'items': [{'enum': ['ti,tcan4553', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'const': 'ti,tcan4x5x'}], 'type': 'array', 'minItems': 1, 'maxItems': 1}, {'items': [{'enum': ['ti,tcan4552', 'ti,tcan4x5x']}], 'type': 'array', 'minItems': 1, 'maxItems': 1}
        from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
/linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: compatible: 'oneOf' conditional failed, one must be fixed:
        ['ti,tcan4552', 'ti,tcan4x5x'] is too long
        'ti,tcan4552' is not one of ['ti,tcan4553', 'ti,tcan4x5x']
        'ti,tcan4x5x' was expected
        from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#

I can understand the original binding is broken.
I kinda agree with Marc that we cannot break things for users of this.

> 
> > +              - ti,tcan4x5x
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: The GPIO parent interrupt.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description: Hardwired output GPIO. If not defined then software reset.
> > +    maxItems: 1
> > +
> > +  device-state-gpios:
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> Didn't you get this comment alerady?
> 

No, but I have removed the '|'

> > +      Input GPIO that indicates if the device is in a sleep state or if the
> > +      device is active. Not available with tcan4552/4553.
> > +    maxItems: 1
> > +
> > +  device-wake-gpios:
> > +    description: |
> > +      Wake up GPIO to wake up the TCAN device.
> > +      Not available with tcan4552/4553.
> > +    maxItems: 1
> > +
> > +  bosch,mram-cfg:
> > +    description: |
> > +      Message RAM configuration data.
> > +      Multiple M_CAN instances can share the same Message RAM
> > +      and each element(e.g Rx FIFO or Tx Buffer and etc) number
> > +      in Message RAM is also configurable, so this property is
> > +      telling driver how the shared or private Message RAM are
> > +      used by this M_CAN controller.
> > +
> > +      The format should be as follows:
> > +      <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems txe_elems txb_elems>
> > +      The 'offset' is an address offset of the Message RAM where
> > +      the following elements start from. This is usually set to
> > +      0x0 if you're using a private Message RAM. The remain cells
> > +      are used to specify how many elements are used for each FIFO/Buffer.
> > +
> > +      M_CAN includes the following elements according to user manual:
> > +      11-bit Filter	0-128 elements / 0-128 words
> > +      29-bit Filter	0-64 elements / 0-128 words
> > +      Rx FIFO 0		0-64 elements / 0-1152 words
> > +      Rx FIFO 1		0-64 elements / 0-1152 words
> > +      Rx Buffers	0-64 elements / 0-1152 words
> > +      Tx Event FIFO	0-32 elements / 0-64 words
> > +      Tx Buffers	0-32 elements / 0-576 words
> > +
> > +      Please refer to 2.4.1 Message RAM Configuration in Bosch
> > +      M_CAN user manual for details.
> > +    $ref: /schemas/types.yaml#/definitions/int32-array
> > +    items:
> > +      - description: The 'offset' is an address offset of the Message RAM where
> > +          the following elements start from. This is usually set to 0x0 if
> > +          you're using a private Message RAM.
> > +        default: 0
> > +      - description: 11-bit Filter 0-128 elements / 0-128 words
> > +        minimum: 0
> > +        maximum: 128
> > +      - description: 29-bit Filter 0-64 elements / 0-128 words
> > +        minimum: 0
> > +        maximum: 64
> > +      - description: Rx FIFO 0 0-64 elements / 0-1152 words
> > +        minimum: 0
> > +        maximum: 64
> > +      - description: Rx FIFO 1 0-64 elements / 0-1152 words
> > +        minimum: 0
> > +        maximum: 64
> > +      - description: Rx Buffers 0-64 elements / 0-1152 words
> > +        minimum: 0
> > +        maximum: 64
> > +      - description: Tx Event FIFO 0-32 elements / 0-64 words
> > +        minimum: 0
> > +        maximum: 32
> > +      - description: Tx Buffers 0-32 elements / 0-576 words
> > +        minimum: 0
> > +        maximum: 32
> > +    minItems: 1
> > +
> > +  spi-max-frequency:
> > +    description:
> > +      Must be half or less of "clocks" frequency.
> > +    maximum: 18000000
> > +
> > +  wakeup-source:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 

OK

> > +      Enable CAN remote wakeup.
> > +
> > +allOf:
> > +  - $ref: can-controller.yaml#
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - ti,tcan4552
> > +              - ti,tcan4553
> > +    then:
> > +      properties:
> > +        device-state-gpios: false
> > +        device-wake-gpios: false
> 
> Heh, this is a weird binding. It should have specific compatibles for
> all other variants because above does not make sense. For 4552 one could
> skip front compatible and use only fallback, right? And then add these
> properties bypassing schema check. I commented on this already that
> original binding is flawed and should be fixed, but no one cares then I
> also don't care.

To me it looks like the example you linked:
https://elixir.bootlin.com/linux/v5.19/source/Documentation/devicetree/bindings/example-schema.yaml#L223

If you use fallback for a 4552 then it would enable the use of the
optional pins device-state-gpios and device-wake-gpios. But the chip
doesn't have those so the hw guys would connect them and they won't
be in the DT.

Honestly I'm confused :/

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - bosch,mram-cfg
> > +
> > +additionalProperties: false
> 
> Implement feedback. Nothing changed here.
> 

Uh? feedback?

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        can@0 {
> > +            compatible = "ti,tcan4x5x";
> > +            reg = <0>;
> > +            clocks = <&can0_osc>;
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&can0_pins>;
> > +            spi-max-frequency = <10000000>;
> > +            bosch,mram-cfg = <0x0 0 0 16 0 0 1 1>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
> > +            device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +            device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> > +            reset-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
> > +            wakeup-source;
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        can@0 {
> > +            compatible = "ti,tcan4552","ti,tcan4x5x";
> 
> Missing space after ,.
> 

Added

Thanks for the review.

/Sean

