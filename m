Return-Path: <linux-can+bounces-1907-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A09BE2ED
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C1E1F2210A
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2024 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C261DA31D;
	Wed,  6 Nov 2024 09:43:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56381DAC95
	for <linux-can@vger.kernel.org>; Wed,  6 Nov 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886193; cv=none; b=L4Ezw9zA1ACHbKQaRjOs5Wzzq1OUDAKS6RU+uCDb6kIaUjufI2/rL55siPb9+h+DohQTT2jUduuc6ReYLa5HST1eGhUPosBO7znzteqhDJqFhoq7TyEpq0vIdTwxoKbP0FEum6sTgeLkxUiMIGcl40yIsf0V9OaBJFuPjthESYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886193; c=relaxed/simple;
	bh=o5WzC5wKDT7nrFSU25/Vr4sHvTQ+DRwdgVhghX0UrCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8MvilNxigbuZcSmHaGUUueCv3p8BfBf6Rzybqyw3jkTCLIZ1Gr0wJq5cktLCqChZfqBfIcgYah9/21F2Y1YVyFRNi2vKsOJ0+WHwO9Hhss4GyIL5msNWC2IIT/eoVCTXTbdztozhneCMTNKPI2jwsy05OX2EpidSNs6DlWYW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8cZ7-0003f5-95; Wed, 06 Nov 2024 10:43:05 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8cZ6-002HRH-0z;
	Wed, 06 Nov 2024 10:43:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8cZ6-00HAnb-0e;
	Wed, 06 Nov 2024 10:43:04 +0100
Date: Wed, 6 Nov 2024 10:43:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Message-ID: <Zys6KGmEWVnwidLb@pengutronix.de>
References: <20241105094823.2403806-1-dmantipov@yandex.ru>
 <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZypJ4ZnR0JkPedNz@nanopsycho.orion>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Tue, Nov 05, 2024 at 05:37:53PM +0100, Jiri Pirko wrote:
> Tue, Nov 05, 2024 at 10:48:23AM CET, dmantipov@yandex.ru wrote:
> >Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
> >new skb, I assume that the same should be done for an initial one
> 
> It is odd to write "I assume" for fix like this. You should know for
> sure, don't you?

Hm... looks the there is more then one refcounting problem at this
point. skb_queue is set from 3 different paths, with resulting 3 different
refcount states:

j1939_sk_send_loop()
  skb = j1939_sk_alloc_skb() // skb with refcount == 1
  if (!session) {
    session = j1939_tp_send(priv, skb, size)
       ... 
       session = j1939_session_new(priv, skb, size);
          skb_queue_tail(&session->skb_queue, skb); // skb refcount == 1
          
  } else {
    j1939_session_skb_queue(session, skb);
      // here, skb is refcounted
      skb_queue_tail(&session->skb_queue, skb_get(skb)); // skb refcount == 2
  }
  
  // at the end of function, skb refcount == 1 or 2
     
j1939_xtp_rx_rts_session_new()
  j1939_session_fresh_new()
    skb = alloc_skb() // skb with refcount == 1
    session = j1939_session_new(priv, skb, size);
       skb_queue_tail(&session->skb_queue, skb);
    skb_put(skb, size); // skb with refcount == 0

I agree with this patch, but there is missing skb_put() in j1939_sk_send_loop()

> 
> >in 'j1939_session_new()' just to avoid refcount underflow.
> >
> >Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
> >Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
> >Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> >Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> >---
> >v2: resend after hitting skb refcount underflow once again when looking
> >around https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
> >---
> > net/can/j1939/transport.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> >index 319f47df3330..95f7a7e65a73 100644
> >--- a/net/can/j1939/transport.c
> >+++ b/net/can/j1939/transport.c
> >@@ -1505,7 +1505,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
> > 	session->state = J1939_SESSION_NEW;
> > 
> > 	skb_queue_head_init(&session->skb_queue);
> >-	skb_queue_tail(&session->skb_queue, skb);
> >+	skb_queue_tail(&session->skb_queue, skb_get(skb));
> > 
> > 	skcb = j1939_skb_to_cb(skb);
> > 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
> >-- 
> >2.47.0
> >
> >
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

