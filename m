Return-Path: <linux-can+bounces-969-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC792F263
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2024 00:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAED1F2261E
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2024 22:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8500E1A0719;
	Thu, 11 Jul 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAzubktz"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A2119EEDB;
	Thu, 11 Jul 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738753; cv=none; b=nXFHsKVBI+84Ek8+7nRGU7cAJT2pZyKFhTp43u3F0L1GZM45mG+Ghg49oNbsWe6G9P4X6zFR7618Vj4TxDfZ0/WbG5AVJgFJdoYNANqb+mJLNv6GDv9fE02GA28+ZA8SDihhGD4O1xXG7kf5wn88Koua2hbGTNlPAGXbQHKMkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738753; c=relaxed/simple;
	bh=JTScuASev3UD4HhVwXVYcaqzHHMXKGxI2IxgIXOMk0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLcB1WLm/ZyvRm8gWlwYv7r3s7HtLYElSgS4GmMhgI1cuLajqzJMZPsSfEcG6l5ASYz0KqvMfGKTkdeTUdIe9rAcI3xIHLr6bGndJLFSqjaOQ4uDLoqdxMrgdzQMPCTsEkB8j0y2rJ3d8tv8wIPa8gVwWn1lF7gMaPLwSmR8ZcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAzubktz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E82BC116B1;
	Thu, 11 Jul 2024 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720738752;
	bh=JTScuASev3UD4HhVwXVYcaqzHHMXKGxI2IxgIXOMk0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAzubktzz+oAnOrFEeN1a1r6JNq1oqyBeOng/TE9Q3EI6Vkl8fjURQlbXslMYTbpl
	 0QaAH0+G5mRQ4RUcaE54F47Ph7DGs4RsNMWUPwNg5UlACr4rlQR6pb7nf630IDVdHD
	 ly6A/XVq1T/vZp0aFV8CbHv2IjoAp8qwiUeg0ufOqZ5u3Bs5BgIDyyjUAdLC0D5vgU
	 9vfXiVzmBSPjx6CkAlSP9Q2V+RHUP73LCnJEoqWdmgPUYvTp4LR0KhBnA2QbLS8W2N
	 1fwwaBf6aM96Ew63Vfk3escebZ/XDqDIE3/b7/ZE/j7ugHJEOVS2U3vdz/nLhIU7de
	 8mWAq516R3vVQ==
Date: Thu, 11 Jul 2024 16:59:11 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, haibo.chen@nxp.com,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, han.xu@nxp.com,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: can: fsl,flexcan: add compatible string
 fsl,s32v234-flexcan
Message-ID: <172073875084.3277772.10395862803760186870.robh@kernel.org>
References: <20240711-flexcan-v1-0-d5210ec0a34b@nxp.com>
 <20240711-flexcan-v1-1-d5210ec0a34b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-flexcan-v1-1-d5210ec0a34b@nxp.com>


On Thu, 11 Jul 2024 14:20:00 -0400, Frank Li wrote:
> Add compatible string fsl,s32v234-flexcan for s32 chips.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


