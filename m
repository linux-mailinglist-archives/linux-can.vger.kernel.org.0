Return-Path: <linux-can+bounces-5147-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF3BD2565
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01A344EF588
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE82FE061;
	Mon, 13 Oct 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI7fvj74"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FFF2FDC37;
	Mon, 13 Oct 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348524; cv=none; b=LLPV7H08odDwD3BpY3wcR+fEcVqCQKkCZUbHYmFM6iKzwZpxD9ltvQprW3oqVx/jLjA5SoX3QAVH9jASgm4Lcw9kOMsUsGVxSyamA9O/TKXminhYgT5Gc3mph1XY4FNRsO3A/TroQCak89V8p9kb8fgaFXO9KbLigeQusAmaXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348524; c=relaxed/simple;
	bh=Dq6ZKmGKWvTKtvAhFBNYFdmRJyRHvn6MwrRh7IEywa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB11kHE3N9VVxmjZTF6y8Aa0q66lTKUzJKqghgU1tyIL7eHlqKr7mVDDR3mU/COEf2yLpZao7RVaQTU+z0+jSJe+GCrcLfRYCeiTK2hpbczKVkhFy9AvfvZOGTLxA0THtTBwCld0MI47IDiLxAhcdk5ozYb4tO0YgOsE43rjfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI7fvj74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C84C4CEF8;
	Mon, 13 Oct 2025 09:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348524;
	bh=Dq6ZKmGKWvTKtvAhFBNYFdmRJyRHvn6MwrRh7IEywa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fI7fvj74d18uSqd+s0VwIDsAqrArJ7M/vsIGRmKpuE8z/Ls93sfmKTOAOUq1VNZYw
	 3tX11HnVA5DW49jJS3u5QpH6teZoY8tIDr/WkE5N2GB5zYxiI9/iClcRZclFolXbtY
	 cGJcDBTDibstnd90rU7+yJoBkHv3W6nTyypmXnCNuqJV1IZL5vKASDL70Fo+PjoE2m
	 gtEU75M4aR9UAkCrbkxAcDgoS+IcMJY9eUaE/PWc57vuWj5iLKu3DV0Y1Z/nZL2gNr
	 Ls6JFBKNV209DkF0BNMsZu7/eQfFvCH6nrHuzPt33k9oUkhojdYEUkmKDIpf1niipf
	 f8coVV1hZfs5g==
Date: Mon, 13 Oct 2025 10:41:59 +0100
From: Simon Horman <horms@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Message-ID: <aOzJZ1NsKxNMvIzJ@horms.kernel.org>
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
 <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>

On Sun, Oct 12, 2025 at 08:23:43PM +0900, Vincent Mailhol wrote:

...

> @@ -1464,6 +1464,66 @@ Example when 'fd-non-iso on' is added on this switchable CAN FD adapter::
>     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>  
>  
> +Transmitter Delay Compensation
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +At high bit rates, the propagation delay from the TX pin to the RX pin of
> +the transceiver might become greater than the actual bit time causing
> +measurement errors: the RX pin would still be measuring the previous bit.
> +
> +The Transmitter Delay Compensation (thereafter, TDC) resolves this problem
> +by introducing a Secondary Sample Point (SSP) equal to the distance, in
> +minimum time quantum, from the start of the bit time on the TX pin to the
> +actual measurement on the RX pin. The SSP is calculated as the sum of two
> +configurable values: the TDC Value (TDCV) and the TDC offset (TDCO).
> +
> +TDC, if supported by the device, can be configured together with CAN-FD
> +using the ip tool's "tdc-mode" argument as follow::
> +
> +- **omitted**: when no "tdc-mode" option is provided, the kernel will

Hi Vincent,

I'm unsure why, but make htmldocs reports:

.../can.rst:1484: ERROR: Unexpected indentation. [docutils]

> +  automatically decide whether TDC should be turned on, in which case it
> +  will calculate a default TDCO and use the TDCV as measured by the
> +  device. This is the recommended method to use TDC.

...

