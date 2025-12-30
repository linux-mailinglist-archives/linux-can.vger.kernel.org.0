Return-Path: <linux-can+bounces-5963-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F91CE8885
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 03:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A861E300E455
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 02:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EA72DC34D;
	Tue, 30 Dec 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mphcoT+i"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B901DFE22;
	Tue, 30 Dec 2025 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767061165; cv=none; b=crEquiJe6PqtBBjyPQrpBYkagzVhbU5odg81KO2NB0Q+R7GB+MUqalrXGJb/TsoMw+aRGyVrrg2EUcsZRA2E3iGacTdpnA4joLOXEvLqhIaO37Zgmfai+ci8rrIVDht19iatJdmlMYYlRJ/WR9zcaSnLq1cpUNiwhdRU9b2uh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767061165; c=relaxed/simple;
	bh=Ilr7GSu4zrUAhZexgta0DsArbPNkDY1dkZNMGP2k9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khnhRLEVIfmov6n7329VV6O7fNaRwD5FXLGl3vDu2f13VknKSo19GBqmR5214yXseZwIQayL+C6l7aGwW8fKcPOi044AbyG1VhYVtoiUPfoHSe9OA27mVjGNgcYTmvWi8reusWzz3azwcEZS/cJBfoKnwGQ/p+DkACvmfQXUl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mphcoT+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C410C4CEF7;
	Tue, 30 Dec 2025 02:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767061165;
	bh=Ilr7GSu4zrUAhZexgta0DsArbPNkDY1dkZNMGP2k9tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mphcoT+iQPF9dN9hTa+WZ7kDnSjo+m0zRjBxBowRuXTgtjFoIWY7oFkDn+NL35mMj
	 myVQFeJBPcj4mQhoNGm4v1uW0bQz+KJ1hH9X+fIXR56j3iKweIxvoeaF+cTu5G8irh
	 AComredWrZ6isfYNviHOvhsOJFZGztFI7JoMpyYoVL8J0ncwdxrh0sSHkimHP9Owv8
	 dlhcEgDxsAVHMxKkRLJDgdp5/FY5aJ4k/G/bBmoh98lTdljGTTvcvWlNM5aU3olzhb
	 eXCQHYS1wuOpaxVxgk4oi9DM4/K/fUclwQ39jmP+S9xS4VJh2KQNJaR+uLYxqLDVOC
	 GRSjWz5Q33iBA==
Date: Mon, 29 Dec 2025 20:19:24 -0600
From: Rob Herring <robh@kernel.org>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
	mailhol@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: net: can: grcan: Convert GRCAN CAN
 controllers binding from txt to YAML
Message-ID: <20251230021924.GA3176103-robh@kernel.org>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
 <20251223105604.12675-3-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223105604.12675-3-arun.muthusamy@gaisler.com>

On Tue, Dec 23, 2025 at 11:55:56AM +0100, Arun Muthusamy wrote:
> Migrate device tree bindings for Gaisler GRCAN, GRHCAN
> and GRCANFD CAN controllers from a text format to YAML format.

A more concise subject would be:

net: can: Convert gaisler,grcan to DT schema

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> 
> Additional changes:
>   - Remove stale systemid property
>     removed in commit 1e93ed26acf0 ("can: grcan: grcan_probe():
>     fix broken system id check for errata workaround needs")
>   - Make freq optional
>   - Add clocks
>   - Add compatible
>   - Add example
> 
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> ---
>  .../bindings/net/can/gaisler,grcan.yaml       | 62 +++++++++++++++++++
>  .../devicetree/bindings/net/can/grcan.txt     | 28 ---------
>  2 files changed, 62 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt

