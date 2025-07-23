Return-Path: <linux-can+bounces-4061-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8002B0F204
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F641AA546E
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7845272E41;
	Wed, 23 Jul 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eserM3fG"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8EC4685
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272877; cv=none; b=SH/iHA/li3NcordF7EQAvzMz032c2MnKnV/OWcHMn3pDHjpxANGk9vp52y0jQnjgFkZ0pBqM1XROPNcmYwHA4Tf3i7wonnzQDw1vjgz28fx6ru94/tZHe0ZojlPM5RWoa+Gcu1AGNW7TZCiYA4ebMGe9/UR37MwNLQ5sIiNWqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272877; c=relaxed/simple;
	bh=b7hcSsdYDDZc3xP9WVOmBZQfURq7ozQ2DMIHh1cS8nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM43dF3aTPIBtQDO9aC3u9bJepQhdbs15E7zWE7Sc/QAoYaK94sQ6p82sLEw2zJAq4+ivzMozjov0ogI7GZrRqNYgAzMiYxKpnnd3QRYwyi7ccqfep/QZWtJRX30kg11FHPObuhiT8DCVWOkvYWX+3vTWbsXDlilSsPXMhvXU1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eserM3fG; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYMfuTWoLXbdFeYMfuwzbr; Wed, 23 Jul 2025 14:14:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753272872;
	bh=/jRslf9zZel2qSi7y7tEW+/PCAjtYfZWyCttrP/ip8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eserM3fGPH+JmlEJtqM7Xme/96+U7b268ZMOYYm4fXoDcuodt0S0vXCRZsg91tWcs
	 TZ4pqc2VmprZeN/haWL0P+kHcqA33uB/IlbzDrtCIsCfGP6+qEpBL8/ddoNUWseA6L
	 4KP4VLO0vDOTZQ4shmFbrvganSTOhoI1asE6AvAegQkO7SSIyBdHka88xQnE0SPH4l
	 7ZFaQFLLPJ7AO7eHNDY0lBFqeI6GDLXDUgWKbX25mOYO3FEWrZrCmyYpzsTEz21NBg
	 w+OzCe5DLz+34097oZ3dEdcyFbe09tjc2foK/d1vQjNCvqAN3g/y8+RsDXniAsdMQV
	 aOFOvXlVxIO8A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:14:32 +0200
X-ME-IP: 124.33.176.97
Message-ID: <9dafc2f2-324b-4d26-b654-0490cb015b5e@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:14:28 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] can: kvaser_pciefd: Add support for ethtool
 set_phys_id()
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Axel Forsman <axfo@kvaser.com>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-3-extja@kvaser.com>
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
In-Reply-To: <20250723083236.9-3-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Add support for ethtool set_phys_id(), to physically locate devices by
> flashing a LED on the device.
> 
> Reviewed-by: Axel Forsman <axfo@kvaser.com>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index c8f530ef416e..c0bfeafb31f5 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -968,8 +968,34 @@ static const struct net_device_ops kvaser_pciefd_netdev_ops = {
>  	.ndo_change_mtu = can_change_mtu,
>  };
>  
> +static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
> +				     enum ethtool_phys_id_state state)
> +{
> +	struct kvaser_pciefd_can *can = netdev_priv(netdev);
> +	int ret = 0;
> +
> +	switch (state) {
> +	case ETHTOOL_ID_ACTIVE:
> +		ret = 3; /* 3 On/Off cycles per second */
> +		break;
> +	case ETHTOOL_ID_ON:
> +		kvaser_pciefd_set_led(can, true);
> +		break;
> +	case ETHTOOL_ID_OFF:
> +	case ETHTOOL_ID_INACTIVE:
> +		kvaser_pciefd_set_led(can, false);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}

Nitpick, what about this?

  static int kvaser_pciefd_set_phys_id(struct net_device *netdev,
  				       enum ethtool_phys_id_state state)
  {
  	struct kvaser_pciefd_can *can = netdev_priv(netdev);

  	switch (state) {
  	case ETHTOOL_ID_ACTIVE:
  		return 3; /* 3 On/Off cycles per second */

  	case ETHTOOL_ID_ON:
  		kvaser_pciefd_set_led(can, true);
  		return 0;

  	case ETHTOOL_ID_OFF:
  	case ETHTOOL_ID_INACTIVE:
  		kvaser_pciefd_set_led(can, false);
  		return 0;

  	default:
  		return -EINVAL;
  	}
  }

Yours sincerely,
Vincent Mailhol

