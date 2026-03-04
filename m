Return-Path: <linux-can+bounces-6867-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mF7ECMz3p2l2nAAAu9opvQ
	(envelope-from <linux-can+bounces-6867-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 10:13:48 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1111FD5E8
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 10:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D77312629C
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298538E13F;
	Wed,  4 Mar 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W7cHUyZ/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260C38425B;
	Wed,  4 Mar 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615271; cv=none; b=XEcWL5W/hM+FG86x3gcmmZHMeSKC5tD01ol1qRy55jb399uAKE8qJjqh/ExaRO1h+m2utqW8bpOrxBN0GQyjCtsawaMXLLvhLwSTIWetZWBnbvdWZVgHytMQufbD21SCrco5K4faEQgI46CxANde9RJL8Gh7YEopQXBG/cZ5f1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615271; c=relaxed/simple;
	bh=M9cKaidmKzUaDfN/PYBYqYOMIDoOd9BIx6xEWbAbzcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQSzEjdtbr70Te4RedTAgbwbP9W2ZEY61h256GERjEGZQsiSWbPQq7EXB1nF6ngqX5N/21S5LYL/6A0sDeZCRxB7+8xS10LCzOo1px7flroF+9mFD9tZ9N+XBbvxkFYjXicq/25yrcw7BEKKkiXLErV3L+qy3Og6MxBtfbma14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W7cHUyZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27101C19423;
	Wed,  4 Mar 2026 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615270;
	bh=M9cKaidmKzUaDfN/PYBYqYOMIDoOd9BIx6xEWbAbzcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7cHUyZ/msDVsDasJr/SfCGiCg6BUadDoPAKArXWzmG1S7ThEP0dGJ04yssSNroFo
	 Z+bwUiBSGuwUS4/DiKuGIq0Xjyw41kIIViDdRxvTSZqiFHGv70sgANqevCjSB1Rlr6
	 qGRGXfz208MVIEgUH+4vSOJXNOSIWJ+5d1C/t3ds=
Date: Wed, 4 Mar 2026 10:07:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net 08/12] can: usb: f81604: handle short interrupt urb
 messages properly
Message-ID: <2026030421-playoff-unashamed-593d@gregkh>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
 <20260302152755.1700177-9-mkl@pengutronix.de>
 <790d9b0e-cc3f-44e4-9ddc-b7f2ac3a3f8a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790d9b0e-cc3f-44e4-9ddc-b7f2ac3a3f8a@redhat.com>
X-Rspamd-Queue-Id: 7D1111FD5E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6867-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,pengutronix.de:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 03:23:19PM +0100, Paolo Abeni wrote:
> On 3/2/26 4:16 PM, Marc Kleine-Budde wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > If an interrupt urb is received that is not the correct length, properly
> > detect it and don't attempt to treat the data as valid.
> > 
> > Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Vincent Mailhol <mailhol@kernel.org>
> > Cc: stable@kernel.org
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Link: https://patch.msgid.link/2026022331-opal-evaluator-a928@gregkh
> > Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >  drivers/net/can/usb/f81604.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> > index 76578063ac82..c61bd30d1765 100644
> > --- a/drivers/net/can/usb/f81604.c
> > +++ b/drivers/net/can/usb/f81604.c
> > @@ -620,6 +620,12 @@ static void f81604_read_int_callback(struct urb *urb)
> >  		netdev_info(netdev, "%s: Int URB aborted: %pe\n", __func__,
> >  			    ERR_PTR(urb->status));
> >  
> > +	if (urb->actual_length < sizeof(*data)) {
> > +		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
> > +			    __func__, urb->actual_length, sizeof(*data));
> > +		goto resubmit_urb;
> > +	}
> > +
> >  	switch (urb->status) {
> >  	case 0: /* success */
> >  		break;
> 
> AI says:
> 
> ---
> Should the length check happen after the status check instead of before it?
> With the current ordering, if a URB completes with both a terminal error
> status (like -ESHUTDOWN, -ENOENT, -EPIPE, or -EPROTO) and insufficient
> data length, the code will jump to resubmit_urb instead of returning
> immediately.
> 
> Looking at the switch statement that follows:
> 
> >  	switch (urb->status) {
> >  	case 0: /* success */
> >  		break;
> >
> > 	case -ENOENT:
> > 	case -EPIPE:
> > 	case -EPROTO:
> > 	case -ESHUTDOWN:
> > 		return;
> 
> Terminal error codes should cause immediate return without resubmission,
> but the length check bypasses this. This could lead to inappropriate URB
> resubmissions when the device is shutting down or has been disconnected.
> ---
> 
> IDK if 'status' is valid in case of short URB, possibly the patch code
> is fine, but please have a look. Again, not blocking the PR.

status will be valid in case of a short URB, so all should be fine.

thanks,

greg k-h

