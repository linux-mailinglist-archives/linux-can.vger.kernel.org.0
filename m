Return-Path: <linux-can+bounces-7811-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id esD5GDY0KWpUSQMAu9opvQ
	(envelope-from <linux-can+bounces-7811-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:53:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D736668087
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 11:53:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7811-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-7811-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39E933050B84
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 09:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22A3BED79;
	Wed, 10 Jun 2026 09:42:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990B3BB9FC
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 09:42:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084560; cv=none; b=KUuKDo6D/E6rpAAblhtWBEscPKk4N4QyqwcFbEt4PiOAZDcy3m2PenUGTMpsT12HSL48cqCxlEv9ol/SVBwufv9de1iHx/Il5b1iaINcUhmVHPnQSvBdmWu9ReSPlNSCRmCAeFFlzLH5nnw39wGthS5PMK1aemzBt/riQI1z220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084560; c=relaxed/simple;
	bh=AQY3VjCHdRSftedK80WpH8O71zfcodVLscYuHEJ/cwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssCk0gM37zgPP+QxvI6TUJUtb23d2TSjeqAYwcEVD41uR+Me7g9fIJPMCPF0jNVFwdZVd6DLA+FBDSrfAJazBFxrvFdPD0jEC2B+DzhkfgicJbDViq6D911x0J81yXvpc81flgZcrScqgpEBhaBPIeMiI0kOHvY2C8IwlcpEDxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wXFS9-0005Qe-13; Wed, 10 Jun 2026 11:42:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wXFS8-0021yN-2I;
	Wed, 10 Jun 2026 11:42:28 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wXFS8-0000000BxcT-2Yqg;
	Wed, 10 Jun 2026 11:42:28 +0200
Date: Wed, 10 Jun 2026 11:42:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Fix J1939 implementation not handling holds
 correctly
Message-ID: <aikxhGFiBbvdg3l2@pengutronix.de>
References: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:robin@protonic.nl,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.net];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-7811-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D736668087

Hi Alexander,

Sorry I lost the track of this patches.

Can you please take a look here:
https://sashiko.dev/#/patchset/20260525190948.42461-1-alexander.hoelzl%40gmx.net

You can ignore the warning in net/can/j1939/transport.c
I guess it is protocol specific issue (potentially can be commented in
the source code), if you have other opinion, please share :)

There are some typos in the tests, can you please address them.

On Mon, May 25, 2026 at 09:08:48PM +0200, Alexander Hölzl wrote:
> The J1939 protocol allows the receiver of directed segemented messages
> to hold the data transfer. The kernel implementation did not handle hold
> messages correctly was not able to resume from a hold.
> 
> To do so the behavior of j1939_xtp_rx_cts_one was modified to allow the
> handling of a hold. The previous sanity check was removed as it only
> guarded against a flood of consecutive CTS, but prevented the hold
> from working correctly. This patch changes this behavior to allow
> for consectuive CTS to enable holds. An additional sanity check
> has been added which prevents requsts of already transferred and
> acked packets. In this case the kernel will abort immediately
> instead of going into a timeout.
> 
> Fix J1939 RTS/CTS session not being able to resume from hold.
> Replace hardcoded timeout with define.
> Add CTS hold behavior tests.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> ---
> I've integrated the comments you've send. In one of the comments you've 
> referenced a wrong section of the J1939 standard. For the hold message
> you've referenced SAE J1939-21 2001 - 5.10.2.4 Connection Closure,
> but it should have been SAE 5.102.2.3 Data Transfer. That I have
> changed. Otherwise everything should be according to your comments :)
> 
>  net/can/j1939/transport.c | 68 +++++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 17 deletions(-)
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da..e2c79df7b04e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -32,6 +32,13 @@
>  #define J1939_ETP_CMD_EOMA 0x17
>  #define J1939_ETP_CMD_ABORT 0xff
>  
> +/* Time until session invalidation upon reception of a hold message.
> + * Corresponds to T4 in the specification.
> + * See ISO 11783-3 2018 - 5.10.3.5 Connection closure
> + * and SAE J1939-21 2022 - 5.10.2.4 Connection Closure
> + */
> +#define J1939_CTS_HOLD_TIMEOUT_MS 1050
> +
>  enum j1939_xtp_abort {
>  	J1939_XTP_NO_ABORT = 0,
>  	J1939_XTP_ABORT_BUSY = 1,
> @@ -1428,6 +1435,16 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struct sk_buff *skb,
>  	j1939_session_put(session);
>  }
>  
> +/* See:
> + * SAE J1939-21 2022 - 5.10.2.3 Data Transfer
> + * ISO 11783-3 2018 - 5.11.5.4 Extended Connection Mode Clear To Send (ETP.CM_CTS)
> + * The number of packets to send can be set to 0 to hold the connection
> + */
> +static inline bool j1939_cts_is_hold(const struct sk_buff *skb)
> +{
> +	return (!skb->data[1]);
> +}
> +
>  static void
>  j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  {
> @@ -1442,9 +1459,28 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> -	if (session->last_cmd == dat[0]) {
> -		err = J1939_XTP_ABORT_DUP_SEQ;
> -		goto out_session_cancel;
> +	session->last_cmd = dat[0];
> +
> +	if (j1939_cts_is_hold(skb)) {
> +		/* The originator should abort the session after T4 (=< 1050ms):
> +		 *   SAE J1939-21 2022 - 5.10.2.4 Connection Closure
> +		 *   a lack of a CTS for more than (T4) seconds after a CTS (0) message to
> +		 *   hold the connection open" will all cause a connection closure to occur.
> +		 *
> +		 * The receiver should send followup CTS not later then Th (=< 500ms):
> +		 *   SAE J1939-21 2001 - C.1 Connection Mode Data Transfer
> +		 *   The responder station then issues a TP.CM_CTS indicating that it wants
> +		 *   to hold the connection open but cannot receive any packets right now. A
> +		 *   maximum of 500 ms later it must send another TP.CM_CTS message to hold
> +		 *   the connection.
> +		 *
> +		 */
> +		if (session->transmission)
> +			j1939_session_txtimer_cancel(session);
> +
> +		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);
> +		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __func__, session);
> +		return;
>  	}
>  
>  	if (session->skcb.addr.type == J1939_ETP)
> @@ -1457,7 +1493,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
>  
> -	/* set packet counters only when not CTS(0) */
> +	if (session->pkt.tx_acked >= pkt) {
> +		err = J1939_XTP_ABORT_DUP_SEQ;
> +		goto out_session_cancel;
> +	}
> +
>  	session->pkt.tx_acked = pkt - 1;
>  	j1939_session_skb_drop_old(session);
>  	session->pkt.last = session->pkt.tx_acked + dat[1];
> @@ -1467,19 +1507,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  	/* TODO: do not set tx here, do it in txtimer */
>  	session->pkt.tx = session->pkt.tx_acked;
>  
> -	session->last_cmd = dat[0];
> -	if (dat[1]) {
> -		j1939_tp_set_rxtimeout(session, 1250);
> -		if (session->transmission) {
> -			if (session->pkt.tx_acked)
> -				j1939_sk_errqueue(session,
> -						  J1939_ERRQUEUE_TX_SCHED);
> -			j1939_session_txtimer_cancel(session);
> -			j1939_tp_schedule_txtimer(session, 0);
> -		}
> -	} else {
> -		/* CTS(0) */
> -		j1939_tp_set_rxtimeout(session, 550);
> +	j1939_tp_set_rxtimeout(session, 1250);
> +	if (session->transmission) {
> +		if (session->pkt.tx_acked)
> +			j1939_sk_errqueue(session,
> +						J1939_ERRQUEUE_TX_SCHED);
> +		j1939_session_txtimer_cancel(session);
> +		j1939_tp_schedule_txtimer(session, 0);
>  	}
>  	return;
>  
> -- 
> 2.54.0
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

