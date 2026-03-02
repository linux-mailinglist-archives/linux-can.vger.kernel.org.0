Return-Path: <linux-can+bounces-6665-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPlwJjuJpWmWDQYAu9opvQ
	(envelope-from <linux-can+bounces-6665-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:31 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5F1D949C
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777933067FEB
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11EA33B951;
	Mon,  2 Mar 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYtwKtX+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7745175A8E;
	Mon,  2 Mar 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455791; cv=none; b=n9BN7h3G6DFp+z85lt80IMaBE64uojyOcYv1MX4cJY++30gADZl1gfIt1L/doiVckjjyImONGRXjn9xQ2Hef+XTluuuq4DLLgHhfp1FnsOIkqyxWZu6OLN9hUyPh1yHvTFbb2eOk9mN/IxUBgSDLzcl7Is/tFIZ8PEg/LAHrgX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455791; c=relaxed/simple;
	bh=UnszqAjGYkiZ1xp/72C+QqRU23TspLWxc6FjpSF9fSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG+TvUY5b6kKhQAlglcOxG721esSDH+r6o+3PtiT3p9l+XHWwXuEYFG44gj/UIFbfVKq7wsjrHV2VSsIK/ADLSG2wuKjevs9Qo8PeT0TPtkMKvv8+JVAwpBuKepRaUrWp1ctuatq8fZeaCnPQsc7l8pyuzgnP+mU1IhYfZDSlh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYtwKtX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A06C2BC86;
	Mon,  2 Mar 2026 12:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772455791;
	bh=UnszqAjGYkiZ1xp/72C+QqRU23TspLWxc6FjpSF9fSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYtwKtX+EiQTIxn8o++c4d5ac9Ukhgfd0TV3BK3KfY/5jtaGPK+Va/TVLiUzDCg5K
	 UCtt5Lj+i1l8DBSRC5KuMfAcUS7IsttiMiwBE0AjUdGNznu43UCt1ckx5SknhmS5xN
	 E/owxFKJW5GiKNexH6nfVcS/4Pod8Eb0z89cml9s=
Date: Mon, 2 Mar 2026 07:49:39 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the
 proper length of a message
Message-ID: <2026030253-lather-pulse-3bb5@gregkh>
References: <2026022316-answering-strainer-a5db@gregkh>
 <20260302-slick-important-polecat-41d2b6-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-slick-important-polecat-41d2b6-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6665-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.204];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EAF5F1D949C
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:18:58AM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> I've applied the patch, but the nipa/ai-review bot found some more problem:
> 
> | https://netdev-ai.bots.linux.dev/ai-review.html?id=8aebbd0a-af1c-4caf-8659-03fcf827f060
> 
> commit 0b9cf350a2d2eab647de28210e8eaf2a56d5d624
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
> 
> When looking at the data in a USB urb, the actual_length is the size of
> the buffer passed to the driver, not the transfer_buffer_length which is
> set by the driver as the max size of the buffer.  This commit adds
> validation at the beginning of message parsing and corrects the
> validation after incrementing the start pointer to use actual_length
> instead of transfer_buffer_length.
> 
> > diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> > index 4c219a5b139b..9b25dda7c183 100644
> > --- a/drivers/net/can/usb/ems_usb.c
> > +++ b/drivers/net/can/usb/ems_usb.c
> > @@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
> >  		start = CPC_HEADER_SIZE;
> >
> >  		while (msg_count) {
> > +			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
> > +				netdev_err(netdev, "format error\n");
> > +				break;
> > +			}
> > +
> 
> The new bounds check here validates that CPC_MSG_HEADER_LEN (11 bytes)
> fits within the buffer, but does this protect against reading beyond the
> buffer when accessing the message payload?
> 
> Looking at the structure usage:
> 
>     msg = (struct ems_cpc_msg *)&ibuf[start];
> 
> The ems_cpc_msg structure has a variable-length payload indicated by
> msg->length.  After this line, the code calls ems_usb_rx_can_msg() or
> ems_usb_rx_err() which access fields in the payload region.
> 
> In ems_usb_rx_can_msg(), the code reads:
> 
>     msg->msg.can_msg.msg[i]
> 
> for up to cf->len bytes from the payload.
> 
> In ems_usb_rx_err(), the code reads:
> 
>     msg->msg.error.cc.regs.sja1000.ecc
> 
> and other union members from the payload.
> 
> Since only the header length is validated here, can a malicious USB
> device send a packet with a large msg->length value that causes
> out-of-bounds reads when these functions access the payload data?
> 
> Would it be more complete to validate the full message size before the
> switch statement:
> 
>     if (start + CPC_MSG_HEADER_LEN + msg->length > urb->actual_length)
> 
> The commit message mentions checking "the size both at the beginning of
> parsing the message to make sure it is big enough for the expected
> structure," but the current check only validates the header size, not
> the complete structure including the payload that will be accessed by
> the processing functions.

Ah, tricky, gotta love variable length messages...

I'll review this next week when I get back from my conference trips and
make a v2, thanks for letting me know it's output.

greg k-h

