Return-Path: <linux-can+bounces-5105-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EDABC5836
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 209C84EA428
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF4728641F;
	Wed,  8 Oct 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuBWEHLn"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56E20B81B;
	Wed,  8 Oct 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935984; cv=none; b=J1pQ9QufW7aZlEkL0ARipKqDHD9+70xirFoH7/PJ6ma3s5RM0uwwKOJSg9kcnE0RHC33m+wykD/hDjOQ6ByFmo04112o0rVvrz4stixujUEipGBJhYk+VO+TGK+/dJqaeK+J4NcnUEcCgKtsM+1zPu98VvzYsx4tF8oZ1oOkZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935984; c=relaxed/simple;
	bh=EdcTvE4rC9KCoDJGFEznudeEFcdoDAeMS+PBIVJ7tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYAy4PGqEFr6KoTmLl4YImmTaN7uzTeIgFvYxxpAGlrOoLJhAFltfpwIYkApDmS1oLLTxbhW0P0lwwXwmwj3uTwZAeLQxBaqavvWuR/Zntk1ORy9Wi8j9qQI8MnPTJ7VM7WIY4zbzgMEmF+O/+7IMY7vxaEQ0kbVaJeTRffyS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuBWEHLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D932AC4CEE7;
	Wed,  8 Oct 2025 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759935984;
	bh=EdcTvE4rC9KCoDJGFEznudeEFcdoDAeMS+PBIVJ7tjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuBWEHLno8xcpJy7mpc5cw6/DggxoZFKUm4/ETskRkhkteGtOzbADPuzH6A5v+lu7
	 E7VsZyubh0CAK+/HnmJyfgpt7FfWvmCMF6uOkZK5w7m/rErcl+weUEbCUak0kILWrK
	 pfo/7NDPqBHKasipo1kN25sjlmzqXXxbKQTLgaVnzzm8xxMZt6XIQfAGZFc2HlYSqy
	 /euQJvcN2Mtpu8cgrkBgng23Y36rlb5FJYMAGNCJGQ5kKZVV9CctFlB53v/2wkjnlX
	 cMCMjtrS0U1CowhZeVzovnIJcRK32A0l3VwTdjfckovDKRT20tS6k3nmHh+LHE3gDJ
	 gXej75pVFztcQ==
Date: Wed, 8 Oct 2025 10:06:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Dhruva Gole <d-gole@ti.com>, Vincent Mailhol <mailhol@kernel.org>,
	Simon Horman <horms@kernel.org>, Akashdeep Kaur <a-kaur@ti.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	Vishal Mahaveer <vishalm@ti.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebin Francis <sebin.francis@ti.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Kendall Willis <k-willis@ti.com>
Subject: Re: [PATCH v10 1/4] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <175993598226.3512549.5295923279078928995.robh@kernel.org>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
 <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>


On Wed, 01 Oct 2025 16:30:19 +0200, Markus Schneider-Pargmann (TI.com) wrote:
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC from some system states. This configuration is
> described in the wakeup pinctrl state while the default state describes
> the default configuration. Also add the sleep state which is already in
> use by some devicetrees.
> 
> Also m_can can be a wakeup-source if capable of wakeup.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


