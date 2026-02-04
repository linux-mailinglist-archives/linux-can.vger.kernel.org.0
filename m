Return-Path: <linux-can+bounces-6486-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFhtJcxRg2mJlQMAu9opvQ
	(envelope-from <linux-can+bounces-6486-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 15:03:56 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A0E6CED
	for <lists+linux-can@lfdr.de>; Wed, 04 Feb 2026 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8928C3066892
	for <lists+linux-can@lfdr.de>; Wed,  4 Feb 2026 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DF40B6EE;
	Wed,  4 Feb 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="juX23pFm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478A27A123;
	Wed,  4 Feb 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213468; cv=none; b=r6dpF2rbneJFLbxAGN2BS24i6dAhY0ct5uYHajsGEkMN4joiDVxFfD6BnoLvmex9V/ZJrsGfY2kdA+FyuYlpJBPE3MRepKZV5SJqUBKGIEPurC3kKeu5m5z0c4hXeHKzGsANzu6HSsCtNbU+kHilKpYt8xwCI8u9dK5iu9VJkBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213468; c=relaxed/simple;
	bh=Mum4HbAn7Ll6KSVlzso/PZMTI0uDHN4IxKvPtX8u3Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTIjDUtTZfHXrRJNbkvzAozaKE6hU6Z1dpOus6W4p4IuYgxpLqEhgV8OsCKJZJBJD+Z84C1feYtbESvMGtjP4CfMqN0rV/kN9j+ciUZalDIo5cbpGKhBF4H+zGN89iq4qQOyQYib01Uv3IvwlK4WJ84AfNz850DJvSK99jP1F7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=juX23pFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCEEC4CEF7;
	Wed,  4 Feb 2026 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770213468;
	bh=Mum4HbAn7Ll6KSVlzso/PZMTI0uDHN4IxKvPtX8u3Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juX23pFmbxJsjTZ9gIDwTPg6vJuLQopfptyoBiB6sfsg0jmxfgeer+qbdPZOBVceP
	 WZZLDab+tZlLijkLICf7+Wg1UF0BEYCRdlyvl6FXGOJvhYfexuK8MwXfgprqrrYoj3
	 i0FjTXDIw/ThJMHwjiHpTQssJ++px9fX1GB8MPX0=
Date: Wed, 4 Feb 2026 14:57:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@vger.kernel.org, linux-can@vger.kernel.org
Subject: Re: [PATCH 5.10.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix
 URB memory leak
Message-ID: <2026020436-sanded-captive-cfed@gregkh>
References: <2026012023-busily-bunkbed-12df@gregkh>
 <20260120132308.747061-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120132308.747061-1-mkl@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-6486-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 009A0E6CED
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 02:23:08PM +0100, Marc Kleine-Budde wrote:
> In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
> parent->rx_submitted anchor and submitted. In the complete callback
> gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
> gs_can_close() the URBs are freed by calling
> usb_kill_anchored_urbs(parent->rx_submitted).
> 
> However, this does not take into account that the USB framework unanchors
> the URB before the complete function is called. This means that once an
> in-URB has been completed, it is no longer anchored and is ultimately not
> released in gs_can_close().
> 
> Fix the memory leak by anchoring the URB in the
> gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> (cherry picked from commit 7352e1d5932a0e777e39fa4b619801191f57e603)
> ---
>  drivers/net/can/usb/gs_usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 58a7ac1d7c7f..a7a23e5b0835 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -401,6 +401,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  			  usbcan
>  			  );
>  
> +	usb_anchor_urb(urb, &parent->rx_submitted);

Also will break the build :(

