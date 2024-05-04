Return-Path: <linux-can+bounces-558-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B698BBA34
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE90A1F2228C
	for <lists+linux-can@lfdr.de>; Sat,  4 May 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299213ACC;
	Sat,  4 May 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1sBN+Q5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA65221;
	Sat,  4 May 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714814058; cv=none; b=TDIu4epTzJVLl2vM/BlfNvC64NkQJHOlFPRIKkJAXfc4yarlyfd4W+S59JOnQtl3jPDhJLBhoU0V+Y+5fRhn+stuf9ofao0N9APf65dNDPhL3ScUaWyPnUFeZrsGRZVbRkVuQjURST5Q9+DUEg/Y09RVDncYmG30fqHqJQTIGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714814058; c=relaxed/simple;
	bh=lmwJ8e6v/rnWG8UvFfWKN89Gdz+WCDrr4/jNs9H5PeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8KKV6MU2DVeAspVKJx/bTZjwitaiuKjllo12wNAyLtWBOx+L9czVynGM+ZmDQSIs/sWQ47n7vdPdFYGe2KorasbHC6O3Ex0PR9wtJmaZlSxU3T6rQgSRIugBYlGX2jJbw4Y2mNgP+Ohk4lb+mkzWtqEmtax244AWj8H6sQtB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1sBN+Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A7C072AA;
	Sat,  4 May 2024 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714814057;
	bh=lmwJ8e6v/rnWG8UvFfWKN89Gdz+WCDrr4/jNs9H5PeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1sBN+Q5X99UoOqBmUsF8RafWcFlzX6xiicnM086S/yqIRgkKg77J6yVHHXgPTIkl
	 /piu/jJOimZ5H4JS3JHnsgudvpwE49zMCec1euFlVRKWkGC5uyt1VLwBp554sV+vMh
	 0qAlmsdMMHtiNkhnTtKJJyg5Lehu7NhNZNooYQxCC00fiMTvlTclWicSmdXuFJfz5y
	 RjfEL6jloNjieytSvxaB0Td1VxeGeLp68M4hN9oUd/OSjA6LtTjBY0LvqZZC9MLQHp
	 Kn65RzdZ8ijUSsYMXfSadiCErKCu0y8jvEZJxw2xfsFa78qzzkL8e/nL5/7ZGWWUnp
	 Up/id+l+bC/qw==
Date: Sat, 4 May 2024 10:14:13 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: sja1000: plx_pci: Reuse predefined
 CTI subvendor ID
Message-ID: <20240504091413.GC3167983@kernel.org>
References: <20240502123852.2631577-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502123852.2631577-1-andriy.shevchenko@linux.intel.com>

On Thu, May 02, 2024 at 03:38:52PM +0300, Andy Shevchenko wrote:
> There is predefined PCI_SUBVENDOR_ID_CONNECT_TECH, use it in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


