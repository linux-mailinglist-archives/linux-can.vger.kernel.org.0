Return-Path: <linux-can+bounces-2279-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8379E9DE774
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 14:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE81EB21F82
	for <lists+linux-can@lfdr.de>; Fri, 29 Nov 2024 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770419CCEC;
	Fri, 29 Nov 2024 13:25:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB5188CDC
	for <linux-can@vger.kernel.org>; Fri, 29 Nov 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886717; cv=none; b=TgAHqstCT8DC1R+o8WDKLSlUwUW/0OZFpI6K/4O7pDOwObIwOg9fr9KhWKEDhyQSvq5ARoS6bCM8t7kUkRE/xkwlJo6vyE4rGlHnS4MOlsUNAHCq9BJL4z3O+zCx+0TAkF16Cst02D/Wnh61DZRNCSAtU6bxUzZy4NQEGOXtZFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886717; c=relaxed/simple;
	bh=5yt48QWNIfL64yX0ZfYRhJnto5V8232RaPH0nksldMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncAMWi6fVPO2VA3I5IBp1LTvNBKnryh3qig1+DJFle0Yy49Nk0Liv/r13Ir7pKT8YPVxgT8HrtmTeFdiqSVn4gJQRhcTg4C4Hom8s7kDYVY6zenbseTS8ioMrLOLUGoSFffXeLyF9Umkvi46lHT4frG7AQZ6TgZNR69+ixFbBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0ze-0007br-Pi; Fri, 29 Nov 2024 14:25:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0zc-000nNN-3D;
	Fri, 29 Nov 2024 14:25:09 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tH0zd-004qye-27;
	Fri, 29 Nov 2024 14:25:09 +0100
Date: Fri, 29 Nov 2024 14:25:09 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <Z0nAtXNSaVaJTiLu@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
 <Zys6KGmEWVnwidLb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zys6KGmEWVnwidLb@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Wed, Nov 06, 2024 at 10:43:04AM +0100, Oleksij Rempel wrote:
> On Tue, Nov 05, 2024 at 05:37:53PM +0100, Jiri Pirko wrote:
> > Tue, Nov 05, 2024 at 10:48:23AM CET, dmantipov@yandex.ru wrote:
> > >Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> > >new skb, I assume that the same should be done for an initial one
> > 
> > It is odd to write "I assume" for fix like this. You should know for
> > sure, don't you?
> 
> Hm... looks the there is more then one refcounting problem at this
> point. skb_queue is set from 3 different paths, with resulting 3 different
> refcount states:
> 
> j1939_sk_send_loop()
>   skb = j1939_sk_alloc_skb() // skb with refcount == 1
>   if (!session) {
>     session = j1939_tp_send(priv, skb, size)
>        ... 
>        session = j1939_session_new(priv, skb, size);
>           skb_queue_tail(&session->skb_queue, skb); // skb refcount == 1
>           
>   } else {
>     j1939_session_skb_queue(session, skb);
>       // here, skb is refcounted
>       skb_queue_tail(&session->skb_queue, skb_get(skb)); // skb refcount == 2
>   }
>   
>   // at the end of function, skb refcount == 1 or 2
>      
> j1939_xtp_rx_rts_session_new()
>   j1939_session_fresh_new()
>     skb = alloc_skb() // skb with refcount == 1
>     session = j1939_session_new(priv, skb, size);
>        skb_queue_tail(&session->skb_queue, skb);
>     skb_put(skb, size); // skb with refcount == 0
> 
> I agree with this patch, but there is missing skb_put() in j1939_sk_send_loop()

Please forget it, no skb_free is needed in the j1939_sk_send_loop().

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

