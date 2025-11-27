Return-Path: <linux-can+bounces-5748-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2FC8D1FC
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 08:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0926F3432D0
	for <lists+linux-can@lfdr.de>; Thu, 27 Nov 2025 07:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6831A553;
	Thu, 27 Nov 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+WudnWX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72C2318120;
	Thu, 27 Nov 2025 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228874; cv=none; b=vFBwQrR8c7MHQuRi9IdXXSo51EZC8gFzxrvPzQLKK0K3EnOWDH1W45as2amrRRgRtDHG/L+zRLIf8pRCZV3BJgPotryUBD9eoAKxDKOnOhjiOkXa22JF378o59XZLVcK2ivwdmCMzPvUyNyoVgmlPE577iKSMhhdInzlMLtEC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228874; c=relaxed/simple;
	bh=Ga+FJCbC00Akhz3GHnbVsaNaqYZYDlsC+n1uas0CBr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYM//GX6TuHkZkaYcdzrJP8PMNu/yC3PGzCltTmwwTtb1bxcjAnZ8q8rVthgd8hNv272Be1LYM5IN54t96iNySVIYJNnNFSXPeDMcIFWVAbi1Ktqn5aZ+06kbVLCPzKyV1MwkY+rPe/wzH/QbCY5eT/T1X8fuTnF1mPIcnWXJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+WudnWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB266C4CEF8;
	Thu, 27 Nov 2025 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764228872;
	bh=Ga+FJCbC00Akhz3GHnbVsaNaqYZYDlsC+n1uas0CBr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+WudnWXCAUiy4Q76XSwvHwSXKDlADqUmdKROPXmfj7NlBptdJwzSPVMxUs/cGEAT
	 qECTfmDoWy8+IST7Fs+x1fHL3vwsVQTPOI4JWItBax7mf7yqBru5926Uhh468Dwaay
	 9OJRS9ocDPR278GEUiy2kOdY/TybSkQDK/c/ucvFmsllN1hITJ5kl0gCHLKMLfw2XF
	 MhJWtNIIvi1t4CGyQ2aOA6aAVDgRFXiFf+nTWYySmwS+lQnFRnHgxtDCmA8fXkYHmc
	 WYbphBphy2/nVwBDsyRPW4WhvPvqFUqCRkrCbGcZaJJc0IsZIrOabnZrFISFvbinKm
	 lArmUNNccMm2w==
Date: Thu, 27 Nov 2025 08:34:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: can: renesas,rcar-canfd: Document
 renesas,fd-only property
Message-ID: <20251127-imported-colorful-wren-dfd4d5@kuoka>
References: <20251126155911.320563-1-biju.das.jz@bp.renesas.com>
 <20251126155911.320563-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126155911.320563-2-biju.das.jz@bp.renesas.com>

On Wed, Nov 26, 2025 at 03:59:06PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
> Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
> Classical CAN frame format is disabled. Document renesas,fd-only to handle
> this mode. As these SoCs support 3 modes, update the description of
> renesas,no-can-fd property and disallow it for R-Car Gen3.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


