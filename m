Return-Path: <linux-can+bounces-2612-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13103A0B893
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 14:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D6B1888DC3
	for <lists+linux-can@lfdr.de>; Mon, 13 Jan 2025 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAA2045AE;
	Mon, 13 Jan 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpoFxUAl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD41C1F00;
	Mon, 13 Jan 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775997; cv=none; b=G+U8ROh21Z1lyXgWQ0g7w53kwhxB4zHTMfvPy1HT7jRGiQlTQb3dbgFVd1fGhLSgKw46jdkxQbAOJpoyiFE85Z/gI6ImrR9eASUxZkTz3vhiavlQ8w61ZxhY/EKpBlRxTX7EmWeXp+qFB07rz+W2t98kmBzxly3YL4T92wMgkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775997; c=relaxed/simple;
	bh=+ULchO1dlEiPG1n1irm64Uk7BvvpY6z6dRe6G2yo6t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a06abdGi5I9XvwdxTg6x0LR0Qb2jf8Tm/AYVOug5EdvNC2NT7DhQo4ZqsJWsCVUXsCupDyRzMr7P2EWPNiStwIBErtIPVJ/jNapD61XfATChK4KAy2Com93mrvQjbaS4dmUrLszHKDE05P8NNi5KQNYvEPeiqexh7hUJ8czb1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpoFxUAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BBCC4CED6;
	Mon, 13 Jan 2025 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736775997;
	bh=+ULchO1dlEiPG1n1irm64Uk7BvvpY6z6dRe6G2yo6t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpoFxUAlo6dsfyUCsJuYdDPpKsVfnvoz/StRPnO0ffefY61a0CNrtdizOhj9FBS2v
	 8OXNnUjMFMzSqPiT7afXP568ZhD3OmV1nacl7k/OWVIAb1tQeD1RuG36c72owG3zM9
	 pA+tKrkCk27FoNl6HJGhFakceKYCKHR1q8OEJ02piuOtWgcmqPHzp1vyk7q+FIB92+
	 tiirJ5gRX5zQvyWMCTiNpOrpiWflKCQdM4eMYHdEC/AurabF6cDVhoVmGQET4QaQsF
	 V9qaDrNldFCJpK6laMK7gCdBKMGwDrxf53cS82ewl0gz4MoobSx+FFCQEtlkwrGUn+
	 dIdv2GzT1pvyA==
Date: Mon, 13 Jan 2025 07:46:36 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: devicetree@vger.kernel.org, linux-can@vger.kernel.org,
	Christophe Lizzi <clizzi@redhat.com>, imx@lists.linux.dev,
	Enric Balletbo <eballetb@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>, NXP S32 Linux <s32@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Alberto Ruiz <aruizrui@redhat.com>
Subject: Re: [PATCH v4 1/3 RESEND] dt-bindings: can: fsl,flexcan: add
 S32G2/S32G3 SoC support
Message-ID: <173677598052.1702137.6360834668377737017.robh@kernel.org>
References: <20250113120704.522307-1-ciprianmarian.costea@oss.nxp.com>
 <20250113120704.522307-2-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113120704.522307-2-ciprianmarian.costea@oss.nxp.com>


On Mon, 13 Jan 2025 14:07:02 +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add S32G2/S32G3 SoCs compatible strings.
> 
> A particularity for these SoCs is the presence of separate interrupts for
> state change, bus errors, MBs 0-7 and MBs 8-127 respectively.
> 
> Increase maxItems of 'interrupts' to 4 for S32G based SoCs and keep the
> same restriction for other SoCs.
> 
> Also, as part of this commit, move the 'allOf' after the required
> properties to make the documentation easier to read.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  .../bindings/net/can/fsl,flexcan.yaml         | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Conor Dooley <conor.dooley@microchip.com>




