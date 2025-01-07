Return-Path: <linux-can+bounces-2553-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33525A04082
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 14:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737B83A1311
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3C1F12ED;
	Tue,  7 Jan 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkNBqjpf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2F1DF252;
	Tue,  7 Jan 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255452; cv=none; b=tAFiIHtfcK3duN0Hnoo+h1YCtMqcbRB6wKIGTDWgpgjVi/oC+VQNNjJ70p9RGnxC1meIwj8/Sn6+GSkP9yXprYuXLOwdNTmPGiGq/mUUKPdRUQOPeGiqLAE52quQUpqbFUydCy2Ij7o4RP4iUVnlR727f5Ipags2gn5FTcd6Jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255452; c=relaxed/simple;
	bh=fLby7RmtqFgkq0hZnNCEPuxeUfnBSBSrwvZ237HZbOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dSsDjk4uP8T49jQSFOe/ZWwVnTd+Rke5HLxtW4aPm/qCmuiTZ1lKSrj2yygOvyBSNVglrRHLQy0ZMGZj5xvoXdoxfHvOuZrcze/jRu1Eqnmx4iBccNJ2Mwn4w23MT+PC35ebePd1qnf3SuHgjwQpY842cKG2T/dt39YZe86wvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkNBqjpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9AC4CEDD;
	Tue,  7 Jan 2025 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736255452;
	bh=fLby7RmtqFgkq0hZnNCEPuxeUfnBSBSrwvZ237HZbOs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WkNBqjpfT7KKhM/f78qZQIFRDy+o42B9Af5XsAHCztHXmckom/t0fkGKdrYbmRfAN
	 +7IIRSchHVmfgB2O/dnady+xriNeJ8GnYZmkaMqmMElfKeVn+W99hKsulP28dDYHY1
	 rbtkoSk+FHuEiEDaKFGutWYq6dne4rkp19x7avvI7Rol7WV9Fln8Itfh3sOKYDmIO8
	 DBzDRxHIdmg2C9dOosm5sz/bp+6Wb0RwbC8H5Strg/UNgVyrK6dZD5Pg1Kf61/xZb/
	 YYR5luvVGVQ4iaNdl1BExAlfGcBnZ/9E2upQ1mym/8nMhW7B1in2N/hPz59gxWiL4b
	 0yRxnP2vAomFA==
Message-ID: <f4686d25-76d5-41b9-b82e-2787917deb89@kernel.org>
Date: Tue, 7 Jan 2025 15:10:34 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Correct indentation and style
 in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Kalle Valo <kvalo@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Dario Binacchi <dariobin@libero.it>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Brian Norris <briannorris@chromium.org>, Frank Li <Frank.Li@nxp.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-wireless@vger.kernel.org
References: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 07/01/2025 14:56, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---


>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 20 ++--
>  .../bindings/net/ti,k3-am654-cpts.yaml        | 36 +++----

Reviewed-by: Roger Quadros <rogerq@kernel.org>	# for ti,k3-am654-*

-- 
cheers,
-roger


