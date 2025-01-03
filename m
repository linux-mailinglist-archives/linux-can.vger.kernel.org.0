Return-Path: <linux-can+bounces-2530-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE1A00954
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 13:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38FD91882B4F
	for <lists+linux-can@lfdr.de>; Fri,  3 Jan 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F6F1F9EAB;
	Fri,  3 Jan 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="lakC+BPR"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723B1482E1;
	Fri,  3 Jan 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735907845; cv=none; b=BkPjVXYfI5xFhMeKevXlXI9au5N9KkSHIu7zRGIdvHmLr4wW0s1mGiWcIi4SsrJoSLLFISgJXiun64WIbAGJEHtBtXNccQ79wKQkhLRr7vUZHD+/TcR8uG+PEHGZlYbeBvOOOa85XNBp7ZS0dGaQ56lNs/2Zu9mQOOrdma7/4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735907845; c=relaxed/simple;
	bh=M2q2H4HVLPp05S3AUWhe5qC6Zkqrmb6kb2Y8TYY73SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtl2T30zpZL12sDKLwK2W//IMJRpxXPLFJGWzoZ1nxxXGADbIDvd4OQkhc0EKigSaZyddM7+wAEkb6ATzNX7G7quEbIBQgG6BFMWgyTpyUt2i0+XsTvtWqbFzdbiQYy1E9+b6RJpM2/nxCOOfsuvZCSF/O4eaiv8sSLc1KQmQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=lakC+BPR; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=KdSvTzjMSlxtuFI8v8B+aewxJFjYw1L+jAH+Jxt2Vkk=; b=lakC+B
	PRlutAWBZVZtCS9F3dpJmCO4juTQy688+cz0pPfOgTjWM+uKQny9r7Eclm328u/mLNpdrUce9hQvA
	Se92aeU8inmU6GhpwZdUL1QHipRzaLkXinrcIRAeUbl8XQZfLW1rKF+T8Trv8x0Ws/qfuubGT19nU
	Fspe99qDEoGtiWeqRzgRDu8iIRyNIkFvYHgB5arUToeZ+5r83IavF5SiqSpLOEXMDEQtCnyC9KhVC
	Ir1IoFsBbOCend3Tuh/Dmlx/SuHMDcYzZMqdvlgk58deGE6/pU/Dl46imd/hvWVtrsOJU4KIaYoRK
	HRoZmG8xxrO1IdITP22+tkWTBvwA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <sean@geanix.com>)
	id 1tTgvY-0003zq-1O;
	Fri, 03 Jan 2025 13:37:20 +0100
Received: from [2a06:4004:10df:0:9e0:2602:be72:b34a] (helo=Seans-MBP.snzone.dk)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tTgvX-000GPq-33;
	Fri, 03 Jan 2025 13:37:19 +0100
Date: Fri, 3 Jan 2025 13:37:19 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/3] can: tcan4x5x/m_can: use standby mode
 when down and in suspend
Message-ID: <xn36paqpsjld52s7tkpanyu5v5626vz6bglu76xe225a2y64fh@mz4jvy7avkeh>
References: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 1.0.7/27507/Fri Jan  3 10:40:57 2025)

On Fri, Nov 22, 2024 at 03:52:21PM +0100, Sean Nyekjaer wrote:
> When downing the tcan4x5x there is no reason to keep the tcan4x5x in
> "normal" mode and waste power.
> So set standby mode when the interface is down and normal mode when
> interface is up.
> 
> Also when going into suspend, set the tcan4x5x into standby mode. The
> tcan4x5x can still be used as a wake-source when in standby as low power
> rx is enabled.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes in v3:
> - Run deinit in m_can_stop() in any case even if m_can_cccr_update_bits() fails
> - Link to v2: https://lore.kernel.org/r/20241115-tcan-standby-v2-0-4eb02026b237@geanix.com
> 
> Changes in v2:
> - Reduced code in tcan4x5x_deinit()
> - Taken care of return values from deinit callback
> - Link to v1: https://lore.kernel.org/r/20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com
> 
> ---

Hi,

Anything needed from my side on this?

/Sean

