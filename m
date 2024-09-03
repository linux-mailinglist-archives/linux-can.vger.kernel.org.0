Return-Path: <linux-can+bounces-1302-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC196914E
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 04:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157411F22B50
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF61CCEDF;
	Tue,  3 Sep 2024 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVXnYHpI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5111581E5;
	Tue,  3 Sep 2024 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329304; cv=none; b=cC1iOSKM/7oJjxN/7x2SdNW4p8ZcwuRuqsbCwEn/bcPCVqixXEgKWqAQg+KcG/HI9g4eMbiW3mxrWMQnAmQGGiNPwZen6Wx1smgHCzDMtZky9EF6T9nv+MxSTAYSOiyoEXP1UTNOU/LTjCCD4Lv/PgUNX42oJ/PdxOMlEocrXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329304; c=relaxed/simple;
	bh=YuoiBm9tnK6cYgr6IKRwHLkIyMq3BYOGkD2HBUEN5Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2G6jSaM8ZvBjrwwc8ue1BVGKSLyBdOcKRZ1WYOs7DuyI1Kvjs3fUqHfoCTkQnxtXIiXA7I0Fn6l3r7CuyNHK0vebwsMBzfxhBWrJDvCL2hxIu5MdC/8oZcuL4GNknCpT27EAmTrI42YsOokMLuuRSalbIHsnrQX0mqFCIGFzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVXnYHpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE03AC4CEC7;
	Tue,  3 Sep 2024 02:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725329303;
	bh=YuoiBm9tnK6cYgr6IKRwHLkIyMq3BYOGkD2HBUEN5Aw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVXnYHpIXBEUovZLMA4gTQWSDfhW7XtNqHHGfuNn9YMxM+OhcxzNc+E1wkSGTSaOh
	 SHswQCC3cTmRq3yPaPk4x7K+bnXSkbog/29ifIuJ5QW8B+ruuUA9hJc4XNRdLg2gjI
	 anRs49tRqAqsCCU+SzOUdU74FrRmacMm+iERVPwQVfTM2aYdp3qy3mrhH1RSne6RYC
	 it/TkaXw2jdTCpgw6g2/uPOvyW4mIYrwqfVuYz72x3QjRo6OMQRMkqWGgMW3g1iP0S
	 nhjMtAHD48l8tjRD5IaM4PMm4C6+6P4/3jwOttbW9YvX4+a/IS+HQeqOKr6PzFqEb8
	 aCoi4CvOmNlwA==
Date: Mon, 2 Sep 2024 19:08:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/n] pull-request: can 2024-08-30
Message-ID: <20240902190822.65b45006@kernel.org>
In-Reply-To: <20240830215914.1610393-1-mkl@pengutronix.de>
References: <20240830215914.1610393-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 23:53:35 +0200 Marc Kleine-Budde wrote:
> The first patch is by Kuniyuki Iwashima for the CAN BCM protocol that
> adds a missing proc entry removal when a device unregistered.
> 
> Simon Horman fixes the cleanup in the error cleanup path of the m_can
> driver's open function.
> 
> Markus Schneider-Pargmann contributes 7 fixes for the m_can driver,
> all related to the recently added IRQ coalescing support.
> 
> The next 2 patches are by me, target the mcp251xfd driver and fix ring
> and coalescing configuration problems when switching from CAN-CC to
> CAN-FD mode.
> 
> Simon Arlott's patch fixes a possible deadlock in the mcp251x driver.
> 
> The last patch is by Martin Jocic for the kvaser_pciefd driver and
> fixes a problem with lost IRQs, which result in starvation, under high
> load situations.

Pulled, thanks!

