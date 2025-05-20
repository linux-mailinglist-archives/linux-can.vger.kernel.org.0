Return-Path: <linux-can+bounces-3601-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04385ABDBF9
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 16:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F214E21E1
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0452472AF;
	Tue, 20 May 2025 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad2FcAZ8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315324C077;
	Tue, 20 May 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750123; cv=none; b=qLqw5O7qR+RicX5oHEkdnqmI8nDiqY0df/MYUrW1LKNRZNaQz8Vs2qXxC1d+NskBMWSdmLnBjlyxHck3e/44GW0FKhsPdsUqTjUZzKWKfgMWnHol/+0PKyOI2yWTcFauzdqnE1O0HdH89Lt83yQspPrEdZY0mEpPotGG8g1qpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750123; c=relaxed/simple;
	bh=kDqYJ+8EAAg/XFY22cAPfpziH/ybas4EgEuXb0O6qf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/osN14R8sCct0mNsaFYgE9VaTabm8GOsGegLTpG4/48jjuwB37wwxLocROSZ+2sdb60rJtLcPUbo/vvEoBsDx08GYIl2PFkTxalOtR0GNIHZwjD1vBCjrnpVxlw5nxExYXfv+zvVAlTb+YjbrZQwiM9RzmBeCtlt2R3SBRLdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad2FcAZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B97EC4CEEA;
	Tue, 20 May 2025 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750122;
	bh=kDqYJ+8EAAg/XFY22cAPfpziH/ybas4EgEuXb0O6qf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad2FcAZ8qdFha5kYqCIFkKsPWFqRdJxn2gtXhkl6WU40t25gKvBGY329A13bdPqlG
	 QJxjMYbUo0YOmMSIPydeSIULpV2MSyg0KlrVGd3rEUfI+LEQJGnL15ZWYTO//TfHB3
	 AJ8nycLMXyyjxls9PAtqULVnBVJVvSMqr/L1tZvQySljvistd9uWAKOnG3BPpOSmPX
	 tF55Lmb1AXRSzpB+wPKm54xCDsyq9L4G8UmNzf5n6l8XIYFsSUO2i4+6YI/iYL+TTI
	 KALQyPnB3PFdDvWcGryiQhz/IHUvdhwPUV5Ug7qdjh00RiepVaU0ejbn381GzuVmCw
	 IJ1OSH3fdjLaQ==
Date: Tue, 20 May 2025 10:08:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>, robin@protonic.nl,
	linux-can@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 624/642] can: fix missing decrement of
 j1939_proto.inuse_idx
Message-ID: <aCyM6SeKfnBV_KdF@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-624-sashal@kernel.org>
 <640538cd-d1b6-46aa-9ef8-76aaa0e05609@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <640538cd-d1b6-46aa-9ef8-76aaa0e05609@hartkopp.net>

On Tue, May 06, 2025 at 08:49:37AM +0200, Oliver Hartkopp wrote:
>Hi Sasha,
>
>this fix is needed for this commit
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can?id=6bffe88452dbe284747442f10a7ac8249d6495d7
>
>6bffe88452db ("can: add protocol counter for AF_CAN sockets")
>
>which has been introduced in 6.15
>
>It must not be applied to 6.14-stable.

I'll drop it, thanks!

-- 
Thanks,
Sasha

