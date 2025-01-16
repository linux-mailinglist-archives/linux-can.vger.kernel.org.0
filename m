Return-Path: <linux-can+bounces-2661-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D1A13585
	for <lists+linux-can@lfdr.de>; Thu, 16 Jan 2025 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E4F1884366
	for <lists+linux-can@lfdr.de>; Thu, 16 Jan 2025 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549021B3955;
	Thu, 16 Jan 2025 08:38:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB2197A8B
	for <linux-can@vger.kernel.org>; Thu, 16 Jan 2025 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016685; cv=none; b=Lx+bov9xD9oNcBQkZk3Of0CCCiUsFjVfUWyPMEi8xTZZhSK1uY6aRHlIji/fDwcEWdltijdOmJ/8cI+zOrGWg9eoRoXp6lJQ/VtbOmvU23wlwT1xnn5noPi1P+Y1S2ow6At/GAIiNd6ZuzQN5D3xnjDH7jP8cDhn5Bponto0A+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016685; c=relaxed/simple;
	bh=CzcD19z1PwqabXL9eo/BSkqXo0BLqjLdjhS84IHTCf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaKbI5w/5fNPXjVe8fcFeUmeOfSbCFFc7R/6eL23VEsSwZP0quIPlZuCluGTi8Vq4pmDdlhEI7BwVYQ+mwC6Hleo8KQsTtQaYrMEJLIgDq5pOp2J+qlH13T50Eb9EzlfQrizeYvYAPkuOgbK0UNuUMFn3wt1zSRz+t/9yQUF/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tYLNy-000235-2I; Thu, 16 Jan 2025 09:37:54 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tYLNx-000Ds2-0J;
	Thu, 16 Jan 2025 09:37:53 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tYLNw-00Dfur-3C;
	Thu, 16 Jan 2025 09:37:53 +0100
Date: Thu, 16 Jan 2025 09:37:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, robin@protonic.nl,
	socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] j1939: fix unable to send messages with data length zero
Message-ID: <Z4jFYFLbIyUzA62W@pengutronix.de>
References: <20250107133217.119646-1-alexander.hoelzl@gmx.net>
 <20250107-conscious-daring-lemming-c63aa8-mkl@pengutronix.de>
 <8412e625-6033-4ea2-84f1-209c82ae5866@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8412e625-6033-4ea2-84f1-209c82ae5866@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Alexander,

On Tue, Jan 07, 2025 at 06:17:13PM +0100, Alexander Hölzl wrote:
> On 1/7/25 14:48, Marc Kleine-Budde wrote:
> > On 07.01.2025 14:32:17, Alexander Hölzl wrote:
> > > The J1939 standard requires the transmission of messages of length 0.
> > > For example the proprietary messages are specified with a data length
> > > of 0 to 1785. The transmission of such messages was not possible.
> > > Sending such a message resulted in no error being returned but no
> > > corresponding can frame being generated.
> > 
> > What does your patch do? Please describe it here.
> > 
> > Marc
> The patch enables the transmission of zero length J1939 messages.
> In order to facilitate this two changes were necessary.
> 
> First when the transmission of a new message is requested from userspace
> the message is segmented in j1939_sk_send_loop. The segmentation did
> account for zero length messages and terminated immediately without
> queuing the corresponding skb.
> 
> Second when selecting the next skb in j1939_session_skb_get_by_offset to
> transmit for a session, it was not checked that there now might be a
> zero length skb in the queue.
> 
> Also as this is my first real patch I'm submitting please don't hesitate
> to tell me if I'm doing something wrong.

Please resend this patch with updated, more detailed, commit message.

> > > Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

