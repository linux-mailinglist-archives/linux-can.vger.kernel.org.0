Return-Path: <linux-can+bounces-4907-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF58B96EFD
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11744A0710
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586752727E0;
	Tue, 23 Sep 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qZtmTof3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F812264CB;
	Tue, 23 Sep 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647321; cv=none; b=Y4VfehRuCUYRexbBIlMCaYljQHu2kkE+09jES6euwAEfL0hjU9b7O5vEIV3G2v2kYfmsXok7taDnciyO0zn7VEqLOYOnElHD5dwFzmBdf/40Rt9tfCPkvWZUEt8ftFVchPCr/NXMxEewCGm1GoCKvayBbc5+84ZXx1AU7hmhbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647321; c=relaxed/simple;
	bh=5JNnuErNb62RSBxzxg5gxanRkxI9fzxF9VbAIKyO7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjGZiyqA2KxIB59q39sRQk/BWtOlu0XvdKsUZAa0/1JZdeh23hiJHd4wQhs1Uw1WdbTd7fToi4YxhY5rybzz2/V2whga+4n5hPIpBmtvRImoxB5W9auqGWE+zKUMULi/K3dM9oLeVPBxxqXGljhat1WM3B8ApFTDXH6CjJhf5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qZtmTof3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F098C4CEF5;
	Tue, 23 Sep 2025 17:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758647320;
	bh=5JNnuErNb62RSBxzxg5gxanRkxI9fzxF9VbAIKyO7EA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZtmTof3LNGP4knkmBwn3ZqRYeuUy93C0KUsT+hjJEHokmI41ILYvbgTlxMX6i0g+
	 eYlwMA+9wTRBcqK3dNf8Y9O2T+KqZKy19I6ogEuh+A7w8L9/Ke5xVf1F+fwSf1P54r
	 q5G6OSSwyadeC39hMDS+jZLVUFN638vaUC8LUYTU=
Date: Tue, 23 Sep 2025 13:08:39 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, 
	=?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@hms-networks.com>, Robert Nawrath <mbro1689@gmail.com>, 
	Minh Le <minh.le.aj@renesas.com>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/20] can: netlink: preparation before introduction
 of CAN XL step 3/3
Message-ID: <20250923-rose-shellfish-of-wealth-c8dee7@lemur>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
 <13f98eed-b535-4360-a545-0a11dbc8aa12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13f98eed-b535-4360-a545-0a11dbc8aa12@kernel.org>

On Tue, Sep 23, 2025 at 03:02:49PM +0900, Vincent Mailhol wrote:
> > base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
> > change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d
> > prerequisite-change-id: 20250915-can-fix-mtu-050a94b563a0:v2
> > prerequisite-patch-id: 03836ed1e416f9ea221e149842cc075ac174dd3a
> > prerequisite-patch-id: dac8f6d20f91cf996553905f08c629ca3e61d86f

...

> So, when sending, I was based on Linus tree instead of net-next. I guess this is
> why all those prerequisite-patch-id are showing up...

No, I think something else went wrong here. You did list
prerequisite-change-id, but it's only a 4-patch series. I'm not sure where the
other ones came from. Can you push your b4 branch somewhere where I can take a
look at it?

-K

