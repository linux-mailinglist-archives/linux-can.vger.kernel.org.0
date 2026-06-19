Return-Path: <linux-can+bounces-7887-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EV0ZDYUrNWptnwYAu9opvQ
	(envelope-from <linux-can+bounces-7887-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 13:44:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9925E6A5796
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 13:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7887-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7887-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 907DF301D4DF
	for <lists+linux-can@lfdr.de>; Fri, 19 Jun 2026 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674483803DA;
	Fri, 19 Jun 2026 11:44:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8637FF54;
	Fri, 19 Jun 2026 11:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869440; cv=none; b=DQx7nnYqpCCtr7ONrW/GPrcOgTNEpnmerm5bt2NvM1NMdkXXNEP/0f+rX1poT54+TFARImyeI8JmSWfsul7Wt1WCz6cpcxFWNo3GlqxcNn/S8oiBtutWht+AAd5+M9PDkK9+/AVVZEI4IbY6HVqrj/NJktDs3oogxqH3KLgMVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869440; c=relaxed/simple;
	bh=MuXb6n0JKh3/fgAumZU4hTkeLEPrsmPIMWfRp07wjgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsMprK4iEGSIwDOnoC03ltev4uEviE+fcVCMrMGsIsG5nHjG2J7rDvJUywxSiw3DV9xYKyhU1q/lkEn/pdP2jMw9R20kP5hDXNo6ZRmPYUSjh2Vjb5KcrotmM0DC+2DXB3vLZpyFuzq4NwTkZEmlZKI+jqLYmhWwiajz6COo5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6CDB220098F;
	Fri, 19 Jun 2026 13:43:48 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1waXdU-003b4t-18;
	Fri, 19 Jun 2026 13:43:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1waXdU-0000000G6j4-0yhm;
	Fri, 19 Jun 2026 13:43:48 +0200
Date: Fri, 19 Jun 2026 13:43:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?B?SMO2bHpsLA==?= Alexander <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Fix J1939 implementation not handling holds
 correctly
Message-ID: <ajUrdBVVMoGUTssm@pengutronix.de>
References: <20260525190948.42461-1-alexander.hoelzl@gmx.net>
 <aikxhGFiBbvdg3l2@pengutronix.de>
 <384691b4-0642-483c-a8eb-ff07c721288a@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <384691b4-0642-483c-a8eb-ff07c721288a@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7887-lists,linux-can=lfdr.de];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.hoelzl@gmx.net,m:robin@protonic.nl,m:linux-kernel@vger.kernel.org,m:kernel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9925E6A5796

Hi Alexander,

On Fri, Jun 19, 2026 at 01:13:00PM +0200, Hölzl, Alexander wrote:
> Hi Oleksij,
> 
> Am 10.06.2026 um 11:42 schrieb Oleksij Rempel:
> > Hi Alexander,
> > 
> > Sorry I lost the track of this patches.
> 
> No worries!
> 
> > Can you please take a look here:
> > https://sashiko.dev/#/patchset/20260525190948.42461-1-alexander.hoelzl%40gmx.net
> > 
> > You can ignore the warning in net/can/j1939/transport.c
> > I guess it is protocol specific issue (potentially can be commented in
> > the source code), if you have other opinion, please share :)
> > 
> 
> The bot is right and after looking through the specs once again
> there are requirements mentioned regarding retransmission
> requests. In 5.10.3.2 Connection Mode Clear to Send (CTS):
> ...
> When the CTS message is used to request the retransmission of data
> packet(s), it is recommended not to use more than two retransmit requests.
> When this limit is reached, a connection abort with abort reason 5 from
> Table 6 shall be sent.
> ...
> 
> This paragraph to me sounds more like a requirement for the responder to
> stop requesting retransmissions.
> 
> 
> Second there is also this:
> 5.12.3 Device Response Time and Timeout Defaults
> ...
> Number of request retries = 2 (3 requests total); this includes the
> situation where the CTS is used to request the retransmission of data
> packet(s). If the retransmit request limit is reached, then the connection
> abort shall be sent with abort reason 5 from Table 6.
> ...
> This sounds a bit more generic and not related specifically to responder or
> originator. I did not see a mention of in any of those requirements
> in the compliance spec J1939-82 however...
> 
> Do you think I should add a counter for retransmit requests?
> If yes should it also apply to holds?

Yes, otherwise it seems to bind system resources for no good reason.
Please also add comments in the code explaining this decision.

> > There are some typos in the tests, can you please address them.
> > 
> Sure!> On Mon, May 25, 2026 at 09:08:48PM +0200, Alexander Hölzl wrote:
> > > The J1939 protocol allows the receiver of directed segemented messages
> > > to hold the data transfer. The kernel implementation did not handle hold
> > > messages correctly was not able to resume from a hold.
> > > 
> > > To do so the behavior of j1939_xtp_rx_cts_one was modified to allow the
> > > handling of a hold. The previous sanity check was removed as it only
> > > guarded against a flood of consecutive CTS, but prevented the hold
> > > from working correctly. This patch changes this behavior to allow
> > > for consectuive CTS to enable holds. An additional sanity check
> > > has been added which prevents requsts of already transferred and
> > > acked packets. In this case the kernel will abort immediately
> > > instead of going into a timeout.
> > > 
> > > Fix J1939 RTS/CTS session not being able to resume from hold.
> > > Replace hardcoded timeout with define.
> > > Add CTS hold behavior tests.
> 
> ...
> In addition just want to mention this check I've introduced, which prevents
> requesting packets which the responder has already acknowledged in a
> previous CTS:>> -	/* set packet counters only when not CTS(0) */
> > > +	if (session->pkt.tx_acked >= pkt) {
> > > +		err = J1939_XTP_ABORT_DUP_SEQ;
> > > +		goto out_session_cancel;
> > > +	}
> > > +
> I couldn't find this requirement in J1939-21 but the compliance testing spec
> J1939-82 mentions it in table A7 row 6:
> 
> 	Verify DUT transmits a TP.Conn_Abort when 'Next packet number
> 	to be sent' in TP.CM_CTS message:
> 	- is less than the 'Next packet number to be sent' in 	
> 	  previous TP.CM_CTS
> 
> Should I add this as a comment as well?

Yes please. 

Thank you for your work!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

