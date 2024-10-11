Return-Path: <linux-can+bounces-1635-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756E99AC56
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 21:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C07B26C24
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACC1D04A4;
	Fri, 11 Oct 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJGjK7LX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB51991DB;
	Fri, 11 Oct 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673302; cv=none; b=VlxIv8GHYDUuHlrHbBE6XEmI35TXmKl/4IzxrPdcTcmQv+l6cXtgc/RGBWsCkYk/mOroHiovdkK4+vnf51KesihPUqf26GlmHD2UOxPKgEq5dR/Hdry3WjdKF72BSq7VIRBlcREBaft1UAlIc9le4Cpo8xgaLnQGLoVBxW2JwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673302; c=relaxed/simple;
	bh=cBNeIIWyAAvy0odt5J1sPJ66IzAhxQQAF1fH4TCwpgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1diIIXA/mj8eH91hVv1TgObcIBQelsNkzVlfzqxEUGSsHD7sEtSBVK55fRLc78q7lvuar94IH+9d+NIHqF51X1TFl5prOIj77ZxKJTpmv2hGX0uluAJo7FnvgFRvP6hHwWSux72QaYtaTwgv7nYTDLs5o0DdutXnaJZlJmaKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJGjK7LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA42BC4CEC3;
	Fri, 11 Oct 2024 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728673302;
	bh=cBNeIIWyAAvy0odt5J1sPJ66IzAhxQQAF1fH4TCwpgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJGjK7LX+qPL7gUvw7boYnQE82yIXLZy8l1huFSqka1YWSqGSZxbmUWLXQPW9WlGW
	 h0Ck6I7x68Tx6bcE9f/i7eQj6jNIlRt5NButI5i2QMHbqZpMJa86A7FmJjRQNEPRnT
	 TSdHPfhc0SdZeqA40U7qy+Dg7Ldq/3jNGW6N1JAa2+lohZic3+p9NXHnlaENoErfzZ
	 0IbMKXH2cegr0R4yDFM8d55VlSOzty2KPWTgjBOTD/w/ebqVVCU9SLKvtaSdeMQeEY
	 33OxLALPrSqycuWCCzEL1L4RK0QExycngmuOlqfo2OJ3HVzFr9JiTLT39Gn9bJgK85
	 +Qm45MG0iWy/w==
Date: Fri, 11 Oct 2024 20:01:35 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: can: m_can: Add vio-supply
Message-ID: <20241011190135.GB53629@kernel.org>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-2-9752c714ad12@baylibre.com>
 <bbz7h4vfbzusvdqtbfzxo5xdoddqp5nonoywvbrhtwukjus3pp@5amm37u22ehh>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbz7h4vfbzusvdqtbfzxo5xdoddqp5nonoywvbrhtwukjus3pp@5amm37u22ehh>

On Fri, Oct 11, 2024 at 04:44:00PM +0200, Krzysztof Kozlowski wrote:
> On Fri, Oct 11, 2024 at 03:16:39PM +0200, Markus Schneider-Pargmann wrote:
> > The m_can unit can be integrated in different ways. For AM62 the unit is
> > integrated in different parts of the system (MCU or Main domain) and can
> > be powered by different external power sources. For examle on am62-lp-sk
> > mcu_mcan0 and mcu_mcan1 are powered through VDDSHV_CANUART by an
> > external regulator. To be able to describe these relationships, add a
> > vio-supply property to this binding.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > index 0c1f9fa7371897d45539ead49c9d290fb4966f30..e35cabce92c658c1b548cbac0940e16f7c2504ee 100644
> > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > @@ -140,6 +140,10 @@ properties:
> >  
> >    wakeup-source: true
> >  
> > +  vio-supply:
> > +    description: |
> 
> If there is going to be new version: drop |

And likewise, correct the spelling of examle -> example.

