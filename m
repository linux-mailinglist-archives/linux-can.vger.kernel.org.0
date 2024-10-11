Return-Path: <linux-can+bounces-1632-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A899A6A9
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7ED1C21C6F
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 14:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA68121F;
	Fri, 11 Oct 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD3OJ9/s"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831A405FB;
	Fri, 11 Oct 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657797; cv=none; b=GIQvSyCKcu+uceMNlITwyNoMRFyHQgtZIC0PoLJsBrXv2RPP0sj+zy3slJV5YVAspDDhtO+4rA0qlgcCDD0NC7h4Bm+gtdyGgjFmxyGHcQfMC5NdzQHr442BJOGWbzO1D1difO07rgHKrA9yieD8kqKIeCmKlU+lXs37vz1T1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657797; c=relaxed/simple;
	bh=gLtu5AZpGZcbTycLCtaJUcwPuMObUTXBrj/CeTpBl64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTGcsGidEPOXgVou1WjrPyPUSv+25ZOGGKLvl472IIh9VYsanM5IpyW1ncx6WAmhBH3N4fVSF0Co6mr9Ofd/f0oiQcsJNcRDZqCkyABiPHRMKbAG9fEfNLjQ20dhZPwARKVeeHuY+PdNfDxGfC2rKJ9gWPf8jIKggxP25SpDMDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD3OJ9/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BE7C4CEC3;
	Fri, 11 Oct 2024 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728657797;
	bh=gLtu5AZpGZcbTycLCtaJUcwPuMObUTXBrj/CeTpBl64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JD3OJ9/ssGzEV5F6hwF1sPqaa8FV/FQhLnvPSl0++2YkU0KMrETL2YnFM2wsrM+do
	 0/QEtWg3sNSzY1YwSwcr3M25UPF6AviGEsPodHdIrLefhJSU9kVtE0E5tY/S9FM47Q
	 ktwgmK55xZpPtssCXwbP17jc3MvAmrZWWXlP0ow0TsJuBIxFdLEzDqJ3YI8vfdJAve
	 omJcqOtTanFnoLGpIUiSSTjpEeeWGYAhG0pvpWTUFHK6zMmy4XXtazh+xHJkgikpiv
	 /kRyAcOY6BJOlOLuca5pFyLPaxfV4E3ROPPzkPC4R6bwbRzxZpOyyUACnRmbVPzj+j
	 mJybp63U3J8MQ==
Date: Fri, 11 Oct 2024 16:43:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 1/9] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <ffatirswspolq67yg3vlxptslkkdaa3ufd7n2b2scaaqcf6hvw@r4jy55rmfsmy>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
 <20241011-topic-mcan-wakeup-source-v6-12-v3-1-9752c714ad12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-1-9752c714ad12@baylibre.com>

On Fri, Oct 11, 2024 at 03:16:38PM +0200, Markus Schneider-Pargmann wrote:
> m_can can be a wakeup source on some devices. Especially on some of the
> am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
> the SoC.
> 
> The wakeup-source property defines on which devices m_can can be used
> for wakeup.
> 
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC. This configuration is described in the wakeup
> pinctrl state while the default state describes the default
> configuration.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/bosch,m_can.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


