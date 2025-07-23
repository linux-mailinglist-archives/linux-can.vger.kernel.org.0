Return-Path: <linux-can+bounces-4063-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF0B0F235
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96044188690C
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4B210F4A;
	Wed, 23 Jul 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qJgZy68P"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE827A928
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273664; cv=none; b=q9Red7G2rXlgoKBFWnKRuQbVmcra2Pg74wLQVIdrRTHup30hTpLvH1GdyqomH9GHKAUJk/tIPuojhYJ+FvW5jToICLPpmUIFuRYxeG6pSN0t+bHYF7rX7/NXYVUh2Tc9lAZvo1hWI9SpldN3YjFykBrlo6sHkc9Q7j4Mb4UmhHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273664; c=relaxed/simple;
	bh=yN7LiF3pXtSRldj1j3XnfzAELp4PwgvNtR6X6IzoR/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNa7zueZHfp99VznWeo3kdSlufwSh9ReeMbElfrj/p/rWrqtE4pqeoc0YCzmt/oNXtkGVnOLNjk8uLwt+Qr64fCXxaRkv5thlR5ImDov9fr4h/ONetdlDCFOqo9mks7oVqy0nt0cqBR85SzA4gHmkmOLH6xA8EDPATt0n3IPQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qJgZy68P; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYZEuoUhzQ4MmeYZFuW3fo; Wed, 23 Jul 2025 14:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753273651;
	bh=id5Bn3NPZmaQCry4LSsJQhDPNeNVLe5QXHeUBUuHF+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qJgZy68PiZwmG7SkiUbsFc3CT0jdGsdgfiD3ogRPXiVZjJiNytvLgVq8by1uR7rFB
	 F3mWqQVAOZSIJtg7DiZpQNec6kRP/XOJC5SwqvvvqIQn4IjIdF/xN597NhgBL5WIpU
	 MJFUs0BNrpaN/beyKZfgg/z7DSeyzL+BcnXNmLH7sEDJrqYTdglp1ZX2Te4YtAKFy9
	 pSNJLeG4z16CxUmUkdNdtmrNYGEHcG63SuuBucIgsJIS/rsEPNIEQ+Cw74tou2L5Bk
	 CEoCaLXKYdxFfKoP2Iyid2FXl6ehrcBxKPXtx/+0LJ7Ua0V4laj7WZQ+AsYCQsXhpv
	 08vTiXNqDUK3g==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:27:31 +0200
X-ME-IP: 124.33.176.97
Message-ID: <64db0624-d267-4ec5-ba2e-fdff0023fb21@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:27:28 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] can: kvaser_pciefd: Store device channel index
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-6-extja@kvaser.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250723083236.9-6-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Store device channel index in netdev.dev_id.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index eba19819ca43..7feece6d1d41 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -1030,6 +1030,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>  		can->completed_tx_bytes = 0;
>  		can->bec.txerr = 0;
>  		can->bec.rxerr = 0;
> +		can->can.dev->dev_id = i;

Isn't dev_port a better fit here?

See the description here:

  https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-net

  What:		/sys/class/net/<iface>/dev_id
  Date:		April 2008
  KernelVersion:	2.6.26
  Contact:	netdev@vger.kernel.org
  Description:
  		Indicates the device unique identifier. Format is an hexadecimal
  		value. This is used to disambiguate interfaces which might be
  		stacked (e.g: VLAN interfaces) but still have the same MAC
  		address as their parent device.

  What:		/sys/class/net/<iface>/dev_port
  Date:		February 2014
  KernelVersion:	3.15
  Contact:	netdev@vger.kernel.org
  Description:
  		Indicates the port number of this network device, formatted
  		as a decimal value. Some NICs have multiple independent ports
  		on the same PCI bus, device and function. This attribute allows
  		userspace to distinguish the respective interfaces.

  		Note: some device drivers started to use 'dev_id' for this
  		purpose since long before 3.15 and have not adopted the new
  		attribute ever since. To query the port number, some tools look
  		exclusively at 'dev_port', while others only consult 'dev_id'.
  		If a network device has multiple client adapter ports as
  		described in the previous paragraph and does not set this
  		attribute to its port number, it's a kernel bug.

Also, not populating dev_port is a kernel bug, meaning that you should probably
add a fix tag.

>  		init_completion(&can->start_comp);
>  		init_completion(&can->flush_comp);


Yours sincerely,
Vincent Mailhol


