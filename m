Return-Path: <linux-can+bounces-4351-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650EB33A92
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 11:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E5B7A6C55
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3929BDBA;
	Mon, 25 Aug 2025 09:17:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9DF2C0F9E
	for <linux-can@vger.kernel.org>; Mon, 25 Aug 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113426; cv=none; b=u2ghm14Co8Vzw+C5kYOwGoWu8/iJjXGlH9cWLdWgBOUvAHvUT+u0F1eNgbspI9+66pck9BB2dmrEotIih8Ty3iGSOww9l9LlbnNtx4kENeqLPV/6+Zfaa+OcFZ+8/JLaNkRrysfQCFO+tAr3yc4mAB0JVpA45vVIy3N2Y1+8Vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113426; c=relaxed/simple;
	bh=hWlQwJf739nOZCZ47ZjgBgtWqVQ+WRTlDa9eNxq8WYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai8hrXBcfGx0AaiPiH4S/OO3Y0y3eP3sFb1tmWr8DnNkALUT73hQLaw2L/6cGgS08r01wtc/YGzaUrSZEXTGBgui1e2pCxDsKlxmTIRxebMrzVC4TIp0L511SRjsMzrxVZ6PCfYLcEjEFTe59uDtEjkB2P4ZdN2FXQvP8hIa9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTJz-00081g-Sk; Mon, 25 Aug 2025 11:16:59 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTJx-0022l3-2P;
	Mon, 25 Aug 2025 11:16:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTJx-00GI5h-25;
	Mon, 25 Aug 2025 11:16:57 +0200
Date: Mon, 25 Aug 2025 11:16:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
Message-ID: <aKwqCYaDf-zYzbtT@pengutronix.de>
References: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Tetsuo,

On Sun, Aug 24, 2025 at 07:30:09PM +0900, Tetsuo Handa wrote:
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But a refcount leak will
> happen when j1939_sk_bind() is called again after j1939_local_ecu_get()
>  from previous j1939_sk_bind() call returned an error. We need to call
> j1939_priv_put() before j1939_sk_bind() returns an error.
> 
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> The change made by commit 25fe97cb7620 might be relevant to my result
> 
>   As far as I tested, the only way that can drop the refcount to 1 is to
>   call j1939_sk_release() (which involves sock_put()) on all j1939 sockets
> 
> in https://lkml.kernel.org/r/bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp .

Thank you for your work!
Right now I'm on open source summit and can't quickly respond/test your
patches. I'll try to do my best ASAP next week. 

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

