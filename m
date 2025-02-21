Return-Path: <linux-can+bounces-2931-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A87A40364
	for <lists+linux-can@lfdr.de>; Sat, 22 Feb 2025 00:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF3586337E
	for <lists+linux-can@lfdr.de>; Fri, 21 Feb 2025 23:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D1A2063ED;
	Fri, 21 Feb 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5NmGB6C"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5817CA17;
	Fri, 21 Feb 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179939; cv=none; b=WJLofZ7iWTzw4cXp6jHFY2967uJyvsnOU01lu7aNkhDnNUwIvQ0fAs05Mgp1WQPHwb8RdJtYGnm9I5XrRWLtqCOQtgC8e7NIxKanlPOFMh/xey5Kp792SZf8sW4kZiKvUqbjKzNMk9rMim5RyvDSXYssL1UIQ8ymuqB43xVTLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179939; c=relaxed/simple;
	bh=mOjCz5Z+97KXw/e/UsA4XXKnPRsyNXee7uFPtX/itT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n28PzM+1qUXYtNe3fkFmgHNMPCce447IDyKezAtOE6wQrnASHhwwpLB5Ym8WC5R894h3phBbsaQrSCS7hiUx5uf/f6EyGNaSCpbauGdjT7B26lUzY6VQdabZ/NybHyi3DpjRWmtpnuvA9fiBVuT/mikGhFH/sYzj5LueXYE/z38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5NmGB6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED6CC4CED6;
	Fri, 21 Feb 2025 23:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179939;
	bh=mOjCz5Z+97KXw/e/UsA4XXKnPRsyNXee7uFPtX/itT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5NmGB6CzcmZRDMPyrL7hr9LYcuK6c3+euQLG3zNV43MYPo4emiILmqWDdd/DzCFf
	 3L+Z7Jk2xlAWDqCbNaUT8pc5T3ZKy6ksDnx4GF2SMPDxVcoz7322ls6K8zXJv9CmiI
	 doY8BTUGSX2Zc95YsqJwhfq8vIhRuLvtg4PeEhYRf51OcgrWlbSgPIVEV5enWZAYpr
	 vOpFApjeg6RCCYzpVLUx4fkGwemhwtmnt3Y/6KwUYygI+2QUEYd3qaA76taziFX3/Q
	 9UWvk/X1eeZpaa08lnbKf9UEKRrrDDvtTUuELz+ORQZxrtQEuLjM/06tl9BDjlpnyb
	 soJaO4X1Z2z+A==
Date: Fri, 21 Feb 2025 17:18:56 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3E support
Message-ID: <20250221231856.GA329615-robh@kernel.org>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
 <20250220130427.217342-3-biju.das.jz@bp.renesas.com>
 <20250221-childlike-deepen-8daa4513d5b5@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-childlike-deepen-8daa4513d5b5@spud>

On Fri, Feb 21, 2025 at 05:53:43PM +0000, Conor Dooley wrote:
> On Thu, Feb 20, 2025 at 01:04:18PM +0000, Biju Das wrote:
> > Document support for the CAN-FD Interface on the RZ/G3E (R9A09G047) SoC,
> > which supports up to six channels.
> > 
> > The CAN-FD module on RZ/G3E is very similar to the one on both R-Car V4H
> > and RZ/G2L, but differs in some hardware parameters:
> >  * No external clock, but instead has ram clock.
> >  * Support up to 6 channels.
> >  * 20 interrupts.
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * No change.
> > ---
> >  .../bindings/net/can/renesas,rcar-canfd.yaml  | 67 +++++++++++++++++--
> >  1 file changed, 62 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > index f87f90f431e5..189d5303ad75 100644
> > --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> > @@ -42,6 +42,8 @@ properties:
> >                - renesas,r9a07g054-canfd    # RZ/V2L
> >            - const: renesas,rzg2l-canfd     # RZ/G2L family
> >  
> > +      - const: renesas,r9a09g047-canfd     # RZ/G3E
> > +
> >    reg:
> >      maxItems: 1
> >  
> > @@ -59,6 +61,19 @@ properties:
> >            - description: CAN1 error interrupt
> >            - description: CAN1 transmit interrupt
> >            - description: CAN1 transmit/receive FIFO receive completion interrupt
> > +          - description: CAN2 error interrupt
> > +          - description: CAN2 transmit interrupt
> > +          - description: CAN2 transmit/receive FIFO receive completion interrupt
> > +          - description: CAN3 error interrupt
> > +          - description: CAN3 transmit interrupt
> > +          - description: CAN3 transmit/receive FIFO receive completion interrupt
> > +          - description: CAN4 error interrupt
> > +          - description: CAN4 transmit interrupt
> > +          - description: CAN4 transmit/receive FIFO receive completion interrupt
> > +          - description: CAN5 error interrupt
> > +          - description: CAN5 transmit interrupt
> > +          - description: CAN5 transmit/receive FIFO receive completion interrupt
> > +        minItems: 8
> >  
> >    interrupt-names:
> >      oneOf:
> > @@ -74,15 +89,33 @@ properties:
> >            - const: ch1_err
> >            - const: ch1_rec
> >            - const: ch1_trx
> > +          - const: ch2_err
> > +          - const: ch2_rec
> > +          - const: ch2_trx
> > +          - const: ch3_err
> > +          - const: ch3_rec
> > +          - const: ch3_trx
> > +          - const: ch4_err
> > +          - const: ch4_rec
> > +          - const: ch4_trx
> > +          - const: ch5_err
> > +          - const: ch5_rec
> > +          - const: ch5_trx
> > +        minItems: 8
> >  
> >    clocks:
> >      maxItems: 3
> >  
> >    clock-names:
> > -    items:
> > -      - const: fck
> > -      - const: canfd
> > -      - const: can_clk
> > +    oneOf:
> > +      - items:
> > +          - const: fck
> > +          - const: canfd
> > +          - const: can_clk
> > +      - items:
> > +          - const: fck
> > +          - const: ram_clk
> > +          - const: can_clk
> >  
> >    power-domains:
> >      maxItems: 1
> > @@ -173,7 +206,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: renesas,rzg2l-canfd
> > +            enum:
> > +              - renesas,r9a09g047-canfd
> > +              - renesas,rzg2l-canfd
> >      then:
> >        properties:
> >          resets:
> > @@ -187,6 +222,19 @@ allOf:
> >        required:
> >          - reset-names
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,r9a09g047-canfd
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          maxItems: 20
> > +
> > +        interrupt-names:
> > +          maxItems: 20
> 
> Should these be minItems instead of maxItems? The list has 20 elements
> at the moment (right?) so you're not adding any restriction here.

And the existing platforms need to have 'maxItems: 8'.

