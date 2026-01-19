Return-Path: <linux-can+bounces-6227-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10CBD3B568
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 19:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50D183064C3D
	for <lists+linux-can@lfdr.de>; Mon, 19 Jan 2026 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4A2BEFEB;
	Mon, 19 Jan 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IavuXq8c"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1337405A;
	Mon, 19 Jan 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846746; cv=none; b=muZT7Km/h1iTd/24NYt06OzXO9jAMsSmakxhyw91Np6/e1Ek/SnxBSsgCnxiyypQUeSRdFtGd+ubF0Db1e3cS4EOGVOCZ+IygMvidDL6gZSdlpS4PdHMxa4nvoZqL+bn2R5yjWnKllZpDNTidFdPUnSojsbkiDRDHVPQlLXKKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846746; c=relaxed/simple;
	bh=HmPpNmlQBm5dHmjTPJMwAhTXAREvQqoHoP+T81cr63A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ps/kdUds3A3h04pBZ2XC2lwCDP5T7KdMOEDbfvFNTMIyozWktvRN4h/RBk1jQYdEBUwrri0ij6owZTMUmcmHAlGSp+Q686rBROzffCOUqhEFAbUaduhYkcTO3356PB87AWdT/TbfIpY2wDzQ9Hul3jcjtncQU1bBDiB6au3PQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IavuXq8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1109C116C6;
	Mon, 19 Jan 2026 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846746;
	bh=HmPpNmlQBm5dHmjTPJMwAhTXAREvQqoHoP+T81cr63A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IavuXq8c+OZrPxNxe6F3PKqrMA3cbihgPSMlx5UHslxl5rE7CGL2B8Rz10C1xqxvC
	 X/NKKsv9aoIKXCbBpRK20dy3WnrCYFrnDjIHwIQK5kdk6Dzn8yb7puWk1ivBolA7AK
	 x6xIMYKFdysLKWVtYaVijGsiRnUhTkYTw+GeCkoSWC4v/CDKUu8uObhgca9lHQVcK/
	 wa5ho8RtNi89g+ksvbtk0eT/2Uh7ThNlpO1mdSKI1JEZ/Q8MaexoJNjIlUxSHhKolJ
	 6F028EEbF6XFbBKhxX6Es8AgEvl15vROCWjb4EFxVjjaRtxfsMhTaOTvH7GfNFw4WX
	 v/N/pbJjD/ALQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net,2/7] can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error
Date: Mon, 19 Jan 2026 10:19:03 -0800
Message-ID: <20260119181904.1209979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116200323.366877-3-mkl@pengutronix.de>
References: <20260116200323.366877-3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
can: gs_usb: gs_usb_receive_bulk_callback(): unanchor URL on usb_submit_urb() error

This patch fixes an infinite loop in gs_can_close() by unanchoring the URB
when usb_submit_urb() fails after re-anchoring. It also adds an error
message for non-ENODEV/ESHUTDOWN failures.

Link: https://patch.msgid.link/20260116-can_usb-fix-reanchor-v1-1-9d74e7289225@pengutronix.de

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index d093babbc320..192338b481f2 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -754,6 +754,10 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
>  	usb_anchor_urb(urb, &parent->rx_submitted);
>
>  	rc = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (!rc)
> +		return;
> +
> +	usb_unanchor_urb(urb);
>
>  	/* USB failure take down all interfaces */
>  	if (rc == -ENODEV) {

[ ... ]

> +	} else if (rc != -ESHUTDOWN && net_ratelimit()) {
> +		netdev_info(netdev, "failed to re-submit IN URB: %pe\n",
> +			    ERR_PTR(urb->status));

Two issues with this error message:

1. The message prints urb->status, but shouldn't it print rc instead? The
   variable rc holds the actual error from usb_submit_urb(), while urb->status
   contains the completion status from the previous callback invocation (which
   would typically be 0 for success since we only reach resubmit_urb on
   successful URB completion). Other CAN USB drivers like usb_8dev print the
   return value from usb_submit_urb() in similar error paths.

2. The local variable netdev is uninitialized when gs_usb_receive_bulk_callback()
   reaches this code path via the short read case. The function declares netdev
   at the top without initialization, and the short read check at the beginning
   of the function jumps directly to resubmit_urb without ever assigning netdev.
   If usb_submit_urb() then fails with an error other than -ENODEV or -ESHUTDOWN,
   this code will pass the uninitialized netdev pointer to netdev_info().

>  	}
>  }

