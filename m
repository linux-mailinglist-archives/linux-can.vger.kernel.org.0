Return-Path: <linux-can+bounces-5168-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E0BD2ED9
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 14:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C01E634B6D1
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEB26E154;
	Mon, 13 Oct 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOyWdX+U"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CC24468D;
	Mon, 13 Oct 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357594; cv=none; b=OQHkrgIzx0K+NQypZe0zUxCbIxZ84oNkOch7ntWupsosSQtf8Gs4k1JnTE7iNKptproJm6qafEyOGTYe9ovUwk5v9e2vdlxgsYbWjv7GuO988IFGtrDA4BoxLQQSY7SW6NqrlYcLghpgUOdU/Az+/A8G1hksJMxDRMeilW9WGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357594; c=relaxed/simple;
	bh=Ve9/iWpbfn/kX74iNG2Ij6hQmnMR/JIdGPX40kr4Y6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+jxA33WH6ih0XuphT3XVDJ5uUKzxqnvK2lgpniZED8MGVUur7va4D3yzSHpi0i3e8WGN3u5xjH2SIzp/QAbQBV4CJ5nzvxavVK2/5O8iGMHFcPtPi6gN01xmjOPZV3TVSV2DBh0j2SvqdYRN4wjFNUO8uIgP7rzVKgGcuTEHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOyWdX+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1528C4CEE7;
	Mon, 13 Oct 2025 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760357594;
	bh=Ve9/iWpbfn/kX74iNG2Ij6hQmnMR/JIdGPX40kr4Y6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOyWdX+U00ecIVdoFM2BjCh5Fz7HURlWY4AqFsk/7lfbDVHgBICtfA/PoODLzRP4O
	 dD7+8DiiYmOWp3dBoZJZR9DV4S7fnR2KZ+yNTiJrK5mPvK1UgeUUuhAZS2KqwpHVy/
	 XboQtny2cW9/xwPPiPLRU6XcJcDTPIzuauwFSYhbfD4g51CEXHxv4Lcb/GhdX/K7JM
	 WJPAPCi2lmEA0i1kqEA8qZdgRTXMYcYIkQK2aLgAzl2VKYlZDGZRuSrPxyHt4xAPzY
	 vlVMU/fn/1DGRRLgB2Vl13fKMyb/Yf2jY95IquhezkSU5gxK0OOpvL5CgC3l10kNtA
	 +7YIxrhwnLKEg==
Date: Mon, 13 Oct 2025 13:13:09 +0100
From: Simon Horman <horms@kernel.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Message-ID: <aOzs1TjdaqZqNW8M@horms.kernel.org>
References: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
 <20251013-can-fd-doc-v2-2-5d53bdc8f2ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-can-fd-doc-v2-2-5d53bdc8f2ad@kernel.org>

On Mon, Oct 13, 2025 at 07:10:23PM +0900, Vincent Mailhol wrote:
> Back in 2021, support for CAN TDC was added to the kernel in series [1]
> and in iproute2 in series [2]. However, the documentation was never
> updated.
> 
> Add a new sub-section under CAN-FD driver support to document how to
> configure the TDC using the "ip tool".
> 
> [1] add the netlink interface for CAN-FD Transmitter Delay Compensation (TDC)
> Link: https://lore.kernel.org/all/20210918095637.20108-1-mailhol.vincent@wanadoo.fr/
> 
> [2] iplink_can: cleaning, fixes and adding TDC support
> Link: https://lore.kernel.org/all/20211103164428.692722-1-mailhol.vincent@wanadoo.fr/
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Changes in v2:
> 
>   - Fix below "make htmldocs" error:
> 
>       can.rst:1484: ERROR: Unexpected indentation. [docutils]

Thanks, I confirmed that "make htmldocs" is happy now.

> 
>   - Change from "Bullet lists" to "Definition lists" format.
> 
> Link to v1: https://lore.kernel.org/all/20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org/

...

