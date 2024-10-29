Return-Path: <linux-can+bounces-1840-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D29599B4911
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E251C237AA
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539BB205AD7;
	Tue, 29 Oct 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UOmyXc/G"
X-Original-To: linux-can@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA6205AB2;
	Tue, 29 Oct 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203615; cv=none; b=q3jAuO8YqDz4C2GGQboKAywOA8P9pvl9E20VK1lSqzJWJeGfW6tZj5RRcuobfsYjE1H01b4EAKAfDx7QdAMnsiZVOxa1lbCSYFNczhuqQjx+wbrFe6ZswTqLMA8CJl3UWGkd1vhL53FuZi6gntFlVEk1jtMKW4vry8V6fNPPYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203615; c=relaxed/simple;
	bh=BHaxvuzupAUywS45x6hNoKHGJhUElOw/2J8FlAxrbEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWmhZhV4iFPoNEQ31hW1Hn69yhN3gAhWRXvhJzfNtg0IrpGHSgUODVSx1goBbtA0dDuvx8HhjI16reJ686FEy5QZCDYwaEtAyW74pFb5M9gAwEzKEsr9NOB/pYDm7Qhln3a3GV1tvhd1vjo9gce+3F536kOJxltKthhCm9anoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UOmyXc/G; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TC6Jqr082788;
	Tue, 29 Oct 2024 07:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730203579;
	bh=vleHK3XScVNSHFgR+LQgkw0wFslG8DEdIFQYcAODAG8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UOmyXc/GjREFKZfz1gHByJxUVWMo2HvNObQIZCI486LO+0ivX0qa4lqwCWhX/5Nb/
	 V5nmHu83s6v+f179ZbbCKfypf/jlmjkb0k0famLNsMgegt7LJs6MnRGR6u2H5ETrfY
	 FNksVbPgJEhJudEmtX4iBQaUyrWXLjQ3txrlwgoA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TC6JVS001220
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 07:06:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 07:06:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 07:06:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TC6IVo130170;
	Tue, 29 Oct 2024 07:06:18 -0500
Date: Tue, 29 Oct 2024 07:06:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Chandrasekar Ramakrishnan
	<rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent
 Mailhol <mailhol.vincent@wanadoo.fr>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        Simon Horman <horms@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/9] dt-bindings: can: m_can: Add vio-supply
Message-ID: <20241029120618.swcxgr3lyv5r7ryi@stoplight>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
 <20241028-topic-mcan-wakeup-source-v6-12-v5-2-33edc0aba629@baylibre.com>
 <20241029065819.w6jc5nrputccuxjo@lcpd911>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029065819.w6jc5nrputccuxjo@lcpd911>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12:28-20241029, Dhruva Gole wrote:
> On Oct 28, 2024 at 18:38:08 +0100, Markus Schneider-Pargmann wrote:
> > The m_can unit can be integrated in different ways. For AM62 the unit is
> > integrated in different parts of the system (MCU or Main domain) and can
> > be powered by different external power sources. For example on am62-lp-sk
> > mcu_mcan0 and mcu_mcan1 are powered through VDDSHV_CANUART by an
> > external regulator. To be able to describe these relationships, add a
> > vio-supply property to this binding.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 0c1f9fa7371897d45539ead49c9d290fb4966f30..aac2add319e240f4f561b755f41bf267b807ebcd 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -140,6 +140,10 @@ properties:
> >  
> >    wakeup-source: true
> >  
> > +  vio-supply:
> > +    description:
> > +      Reference to the main power supply of the unit.
> > +
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>


Might want to conclude on the usage model discussed in [1]


[1] https://lore.kernel.org/all/20241029120302.3twkliytrn5hjufi@sleek/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

