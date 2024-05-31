Return-Path: <linux-can+bounces-693-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA358D65EC
	for <lists+linux-can@lfdr.de>; Fri, 31 May 2024 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D491F23946
	for <lists+linux-can@lfdr.de>; Fri, 31 May 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B971770FC;
	Fri, 31 May 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGX2c9r0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D124211;
	Fri, 31 May 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170042; cv=none; b=G7ItL1LzEbK7Tz6xHWxAtKXShdh0eIk8Ei07s3oyA1e3Um32HzutC1GbYXtDfvR4gUi+wvGix15WiuiFdcdLlUaOu3hujSqPoj6iQBKcLYZY+xiVJhakAqVnJAB6lfXNummcTDXGUe1Fm+HcIRqH4DRj6JSGSWB9uFAIfZ+AqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170042; c=relaxed/simple;
	bh=2iHYKfuL3l56RbZBaOU3Nr5MMok8DdbaiiXFP7i97zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqKbVJrqi0S44YLXcdipBq6wPh4F/+jLfCRVPSWDhp5BBYXIIrM7s5uVesRnvSbuZjBHXTKatGq37uvjin04qQH6xw2e866tLmIqkX/sKaBVR5xrFxc4MiqV3yIHidX+1Sv4tge1TJXXEwZmuwlzKASmDRBgZg2ZZEZ2kNjMN0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGX2c9r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044E4C116B1;
	Fri, 31 May 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717170041;
	bh=2iHYKfuL3l56RbZBaOU3Nr5MMok8DdbaiiXFP7i97zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGX2c9r0XXAXJKeHeYKqs0Y3aZ4y1EI1bYwLiyF78CiOrwThrUdl1+Lfr33Ubye98
	 Np27t7EgmGMCtFOew9mrU/eToiY+pIA2RkvPg9B1EgwKzPIdYvxL0GvntMdhpp8UsO
	 1MINWfnxJiESZeguZMwwV7TflmZbWHs0Q21ZBQDqWpmxjlao87oaJKtkR4nN/6Kn3L
	 +yZ9Carl+qWubZsdQNrgZ0IfPvgs+bqGt3Pnkae/4tlllQrCL16QPzPl98xZwbYYqA
	 0zXgNRlA7Uyef1w0Y73CUFMXCQGP41cprnQqgbYrWs00EpglDMPRhP9UgSxAbxN3ly
	 1DEi2cG1VwuXw==
Date: Fri, 31 May 2024 16:40:38 +0100
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
	linux-can@vger.kernel.org, netdev@vger.kernel.org, wsa@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: mscan: remove unused struct 'mscan_state'
Message-ID: <20240531154038.GB491852@kernel.org>
References: <20240525232509.191735-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525232509.191735-1-linux@treblig.org>

On Sun, May 26, 2024 at 12:25:09AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'mscan_state' is unused since the original
> commit afa17a500a36 ("net/can: add driver for mscan family &
> mpc52xx_mscan").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


