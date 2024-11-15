Return-Path: <linux-can+bounces-2069-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426299CF330
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EB4B2D9F4
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB61D63C9;
	Fri, 15 Nov 2024 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnGPl7zu"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279A1D61A4;
	Fri, 15 Nov 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692278; cv=none; b=XorXiwyt05uG8XRIkIMn6ZIRDk1pppd8QbhIJT8DSqrUkIC7r/jreknxcbpWll8gKq5WIgDoKu5w7qbAD9J3qjS/GnTyZUwfaroSI6+4oqlYZ90BsxYjIecuYMO6NzYUo8FKCFgmJY2S5LlBDlkE4edeEf4dkidSb3ED0ibnzlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692278; c=relaxed/simple;
	bh=6+nVvbtdtzz+fSNZ2JXC4MDqsI77GIGKpN0z063gAP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eettAqaWubsS3ehU7R2eLVxt9yQPp1TTsxLKSZ+HQHLGGwPcCQbc+EsTIk6hGn3l/5wmceKpQo9Ye3bgkejYZL/Pc8vUHPP72xQXJ/tnln/akO6EjCxQflMpvJ9aiP7+BkB3RPxDnBMAdLhBZzDsokjSTJEPNvFbXfrzRrWWy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnGPl7zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA77CC4CECF;
	Fri, 15 Nov 2024 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731692277;
	bh=6+nVvbtdtzz+fSNZ2JXC4MDqsI77GIGKpN0z063gAP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnGPl7zuP1ZWk0xig9HRrOEvSbqDg5Lkq/bgde7py7HG7pFcOfDx+K+lPHnvSPmtl
	 +YN8C++1IcEUHSjfyh8CFqS7bj/TBjJ77s2CVmFKu0YYhOIvF8GnVPXNWOQ7Jpcpzk
	 Qv2Pgp4o194FIwkghm9GCPJyLrkUG/IS2ixcQsj+K0ur9NPqxN/xlU883nbv4Izpmr
	 QvpBqM6C/fPyD5z0qtQiSiVTvXuS9YPrctR0SYZpHEqHw+FOg+YnvJpIYPoBOxuThZ
	 l/A1oYNwwMTyjB93eDsqPT6lpM47RJb4KEhw1v/KHopwv77j76A13uB5+oMbLUlWC2
	 RxNIvp1rRWphw==
Date: Fri, 15 Nov 2024 11:37:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH can-next v5 1/2] dt-bindings: can: tcan4x5x: Document the
 ti,nwkrq-voltage-vio option
Message-ID: <173169227528.3443207.4824174918630075657.robh@kernel.org>
References: <20241114-tcan-wkrqv-v5-0-a2d50833ed71@geanix.com>
 <20241114-tcan-wkrqv-v5-1-a2d50833ed71@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-tcan-wkrqv-v5-1-a2d50833ed71@geanix.com>


On Thu, 14 Nov 2024 10:14:49 +0100, Sean Nyekjaer wrote:
> The nWKRQ pin supports an output voltage of either the internal reference
> voltage (3.6V) or the reference voltage of
> the digital interface 0-6V (VIO).
> Add the devicetree option ti,nwkrq-voltage-vio to set it to VIO.
> 
> If this property is omitted the reset default, the internal reference
> voltage, is used.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


