Return-Path: <linux-can+bounces-6057-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB2D07FCA
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BA95306A0B6
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54F350D6B;
	Fri,  9 Jan 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isE8jCWy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D8350D57;
	Fri,  9 Jan 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948597; cv=none; b=ezfAoLssZbfr35fId2HDYXSkLuOc8PQz18mxnmEV2a0PSL2QA+uCEbPaCTE4w9sPLuaTm8MK7YZl94ZmhHOy7w+YMCxj+V7+/Z98P0a0yCrVX81YJ0zVMgLaQFMySF0TSQ4S33QThH4nNP/rJXRTY2pJZhto55DhDcBvpJZ112s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948597; c=relaxed/simple;
	bh=sVC9B4d/+KK3+vbZEw6LoEo1PkrQiiNB25XuDOpH3QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEaW4qy3t3lrwbDh1DvBwWITzki97Ik+1b+nhy4kBx/bMOQuWzb+lj7oyLKcVvsxMP96g+jifaPzy3g4/QxT0/39Y1sLJTDqzDgbSGqYZdt9ogcqGc3DxjPgWy7nb/jR9p3ZyMoFKXgzn4mj2eRpkUXVp1BPE5IvUptS6Y5rqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isE8jCWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23180C4CEF1;
	Fri,  9 Jan 2026 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767948596;
	bh=sVC9B4d/+KK3+vbZEw6LoEo1PkrQiiNB25XuDOpH3QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isE8jCWyGsG+gn0GX3GOJk6x7mEGHfOFrEac9MPyqQqOVoTiZIukOS6g8ui0nIFPg
	 MXomb3wWy5qBRUPFn/KXROc1xM6Bvj0pKzYeiscFERH5cbHV0zNOhJC5RDSmdp+9GN
	 Pvg9KhiK0ZK7W7OqAmzmg4dV1XIZzCJInHrTmG3Uc/HDSxdmyPSts/06Y8RHKsMxm8
	 D7d2GToeyCBJE6fr8foTHOhn6G6AzPbYNclEkzSberR/LNukNTgG4rEBm0bIz81enV
	 MSqh9oIiC5LyiBBjsPdrmIooG79S2zIptSsaehk1UNz+K3T3FEYL4dCEh2jbhB9HN7
	 hSSgOn1AA3NWQ==
Date: Fri, 9 Jan 2026 09:49:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: mkl@pengutronix.de, mani@kernel.org, thomas.kopp@microchip.com, 
	mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1 1/2] dt-bindings: can: microchip,mcp251xfd: allow
 gpio-hog child nodes
Message-ID: <20260109-successful-vegan-baboon-1b9ea7@quoll>
References: <20260108125200.2803112-1-viken.dadhaniya@oss.qualcomm.com>
 <20260108125200.2803112-2-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108125200.2803112-2-viken.dadhaniya@oss.qualcomm.com>

On Thu, Jan 08, 2026 at 06:21:59PM +0530, Viken Dadhaniya wrote:
> The MCP251XFD can expose two pins as GPIOs. The binding already declares
> gpio-controller and #gpio-cells for the device. Whitelist GPIO hog child
> nodes using patternProperties so boards can set default GPIO states at
> boot via DT, consistent with other GPIO controllers
> (e.g. microchip,mpfs-gpio).
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


