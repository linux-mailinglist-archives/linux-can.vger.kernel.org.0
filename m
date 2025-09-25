Return-Path: <linux-can+bounces-4978-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC334B9CE45
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 02:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E69A2E62A5
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FDA27EFEB;
	Thu, 25 Sep 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyFg6W7f"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AC27E045;
	Thu, 25 Sep 2025 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760043; cv=none; b=iIV0NhloTm438EcKgmMO9qZ7VBTqGZe0da3pWnvq/lv3SuHXGzpVO/PW75iUn4q3veOp7pFhptt/sI8ag0MFzEIDUCptKc88kvWH5WJFFF/dik6wNaE8cLeZM0ox03geyhTsnXrvoz+yy+l8FhmYwZNCLKArMJwxCpZLfh1GWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760043; c=relaxed/simple;
	bh=yzijdUMwZWtcZ46AllUk63qHbY/oI/HyBrRXQabkwp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y63aauMHlqD2DKTzeX+apg6Sg+1Dl8xlb2tB9W82rrNMUKPMnJr4GUGX3sj+Hf+Q6uZOUcAdMo/R1gbwSEf6GNEILtMKOXZ1eCt3UmrBrov+NdtG8ekOoYlGuFt9w2RPjZ8YF4Uov2532Lu8KDCmfMFoLn/yVm8/ft6On/WEKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyFg6W7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62AC4CEE7;
	Thu, 25 Sep 2025 00:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758760042;
	bh=yzijdUMwZWtcZ46AllUk63qHbY/oI/HyBrRXQabkwp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lyFg6W7f2KBMN0+mhOYRlP4LSLR7fNq8osfaLIQkVwwjpqCmekGTkdRZzWaAf+jHb
	 kOJQRWR2Mk7aFKdnqUkiD1K3lzjEa1H3d1EwoKZuBRepxQGTLVcURFt7DmYoWnKOsx
	 HX7LM/mEGTwjKERJZfM5/n1mq1a0rt7xOOZr+x2vbKNxGqqOuJnAVbpbWYo9WIG1oJ
	 M9f2amPpfHe8dLbhX8em59O2qUHL57kkaAA0CNeLQpPoek21M9ZyrUyVn+2H8IkG6p
	 EH4ujT3bstIwCfRiPUOQLAQVf8BaNduJqB0yXxjvldE5KGxGO1282sRX4/VgxE+UTu
	 ioDyBC/1l3O8g==
Date: Wed, 24 Sep 2025 17:27:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Frank Jungclaus <frank.jungclaus@esd.eu>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 linux-can@vger.kernel.org, socketcan@esd.eu, "David S . Miller"
 <davem@davemloft.net>, Oliver Hartkopp <socketcan@hartkopp.net>, Simon
 Horman <horms@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/3] can: esd_usb: Add watermark handling for TX jobs
Message-ID: <20250924172720.028102e4@kernel.org>
In-Reply-To: <20250924173035.4148131-4-stefan.maetje@esd.eu>
References: <20250924173035.4148131-1-stefan.maetje@esd.eu>
	<20250924173035.4148131-4-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sep 2025 19:30:35 +0200 Stefan M=C3=A4tje wrote:
> The driver tried to keep as much CAN frames as possible submitted to the
> USB device (ESD_USB_MAX_TX_URBS). This has led to occasional "No free
> context" error messages in high load situations like with
> "cangen -g 0 -p 10 canX".

I grepped for "No free context" :) perhaps use the old message from
before the previous patch, so that users who see those in the logs
can correlate with this patch better?

> Now call netif_stop_queue() already if the number of active jobs
> reaches ESD_USB_TX_URBS_HI_WM which is < ESD_USB_MAX_TX_URBS. The
> netif_start_queue() is called in esd_usb_tx_done_msg() only if the
> number of active jobs is <=3D ESD_USB_TX_URBS_LO_WM.
>=20
> This change eliminates the occasional error messages and significantly
> reduces the number of calls to netif_start_queue() and
> netif_stop_queue().
>=20
> The watermark limits have been chosen with the CAN-USB/Micro in mind to
> not to compromise its TX throughput. This device is running on USB 1.1
> only with its 1ms USB polling cycle where a ESD_USB_TX_URBS_LO_WM
> value below 9 decreases the TX throughput.

> -	netif_wake_queue(netdev);
> +	if (atomic_read(&priv->active_tx_jobs) <=3D ESD_USB_TX_URBS_LO_WM)
> +		netif_wake_queue(netdev);
>  }

> -	/* Slow down tx path */
> -	if (atomic_read(&priv->active_tx_jobs) >=3D ESD_USB_MAX_TX_URBS)
> +	/* Slow down TX path */
> +	if (atomic_read(&priv->active_tx_jobs) >=3D ESD_USB_TX_URBS_HI_WM)
>  		netif_stop_queue(netdev);
> =20
>  	err =3D usb_submit_urb(urb, GFP_ATOMIC);

I don't know much about USB. Is there some locking that makes this not
racy? I recommend using the macros from net/netdev_queues.h like
netif_txq_maybe_stop() the re-checking on one side is key.

