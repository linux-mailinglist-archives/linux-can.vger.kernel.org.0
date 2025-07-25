Return-Path: <linux-can+bounces-4115-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA35B11707
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 05:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BC0AE147E
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825B22F16E;
	Fri, 25 Jul 2025 03:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mHfa3fky"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFF2746A;
	Fri, 25 Jul 2025 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413850; cv=none; b=qlY0O/cxM60P2s2wuP24WwU4bJwrK6g9iXanNnVepOrq6jMjDogM9Fby1NEZLY5rN15m1eqsyCFAtWToMf+9DlxSxDJG+w0p/Ih16a6f7Lacp+oeXxtkwrXNAShbXS2xbvXhKsK1qy4W5j6D0UOiqR+5pEOg0KHbrwHkapj5zls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413850; c=relaxed/simple;
	bh=AbrAkSVCii03QhYqQNoKcjZoizojvO8K95JbaHV1zTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0sjE+EpRFj6yoh8J+q65ObvRBfTN+l8NR9HWF4iZpYTvWb+v4bbdJ5mHekVwFieDjL2v4nFu0BwO9ZcKpTfpO8x4Jet/nxRFYLws8yAGJwbkHL5C75MbhrP5rZrdBwF/QIA/RQJLzQ2npgz59CfWtmKlO7S/zo88bulCZS5pQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mHfa3fky; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id f92Ju16Sp8YBhf92Kuq3dP; Fri, 25 Jul 2025 05:23:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753413838;
	bh=D05ZA8JMJAPK/2rCnNobiZjP29Xv0N2cFtx1ceFhUXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=mHfa3fky4dR7HCzGvGh04NbSXOjKISCq+e16scXwI3lj7riW6pOtPJoX3H76Sdsro
	 EuqEHn/3JFEUs6fHmlqO7Vi8qQZsoxoTqf6tJSGStSyYQUMMBPTbhttyBZJzRLJ5HU
	 yJgI0Np4MgwRFzgdPzJ7L/c79S0s5rHi/uWHiHPg4NO4KXIuhIjGzNLbOJrC7Y1WKq
	 SN81Jm7/zwup9cCPB9pyYEjYrtFSigyoaFQmcMLC0qi6zUwnjP9wRVYK/314j4+jNO
	 sk/7S4FUYuC2OYnP0VDbkszSn8hPOSxqkhwVhFNsZioNIC2xJY9YS+rRoAYDVltRco
	 9N9tU0KFcjm9w==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Jul 2025 05:23:58 +0200
X-ME-IP: 124.33.176.97
Message-ID: <9ddd4560-cab2-451c-a024-54f525e064bf@wanadoo.fr>
Date: Fri, 25 Jul 2025 12:23:54 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] can: kvaser_usb: Expose device information via
 devlink info_get()
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20250724092505.8-1-extja@kvaser.com>
 <20250724092505.8-10-extja@kvaser.com>
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
In-Reply-To: <20250724092505.8-10-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+CC: Simon

On 24/07/2025 at 18:25, Jimmy Assarsson wrote:
> Expose device information via devlink info_get():
>   * Serial number
>   * Firmware version
>   * Hardware revision
>   * EAN (product number)
> 
> Example output:
>   $ devlink dev
>   usb/1-1.2:1.0
> 
>   $ devlink dev info
>   usb/1-1.2:1.0:
>     driver kvaser_usb
>     serial_number 1020
>     versions:
>         fixed:
>           board.rev 1
>           board.id 7330130009653
>         running:
>           fw 3.22.527
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
> Changes in v2:
>   - Add two space indentation to terminal output.
>     Suggested by Vincent Mailhol [1]
> 
> [1] https://lore.kernel.org/linux-can/20250723083236.9-1-extja@kvaser.com/T/#m31ee4aad13ee29d5559b56fdce842609ae4f67c5
> 
>  .../can/usb/kvaser_usb/kvaser_usb_devlink.c   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
> index 9a3a8966a0a1..3568485a3e84 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_devlink.c
> @@ -6,5 +6,58 @@
>  
>  #include <net/devlink.h>
>  
> +#include "kvaser_usb.h"

I guess this has the same issue as the one pointed by Simon here:

  https://lore.kernel.org/linux-can/20250724135224.GA1266901@horms.kernel.org/

> +#define KVASER_USB_EAN_MSB 0x00073301
> +
> +static int kvaser_usb_devlink_info_get(struct devlink *devlink,
> +				       struct devlink_info_req *req,
> +				       struct netlink_ext_ack *extack)
> +{
> +	struct kvaser_usb *dev = devlink_priv(devlink);
> +	char buf[] = "73301XXXXXXXXXX";
> +	int ret;
> +
> +	if (dev->serial_number) {
> +		snprintf(buf, sizeof(buf), "%u", dev->serial_number);
> +		ret = devlink_info_serial_number_put(req, buf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (dev->fw_version.major) {
> +		snprintf(buf, sizeof(buf), "%u.%u.%u",
> +			 dev->fw_version.major,
> +			 dev->fw_version.minor,
> +			 dev->fw_version.build);
> +		ret = devlink_info_version_running_put(req,
> +						       DEVLINK_INFO_VERSION_GENERIC_FW,
> +						       buf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (dev->hw_revision) {
> +		snprintf(buf, sizeof(buf), "%u", dev->hw_revision);
> +		ret = devlink_info_version_fixed_put(req,
> +						     DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,
> +						     buf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (dev->ean[1] == KVASER_USB_EAN_MSB) {
> +		snprintf(buf, sizeof(buf), "%x%08x", dev->ean[1], dev->ean[0]);
> +		ret = devlink_info_version_fixed_put(req,
> +						     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
> +						     buf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  const struct devlink_ops kvaser_usb_devlink_ops = {
> +	.info_get = kvaser_usb_devlink_info_get,
>  };

Yours sincerely,
Vincent Mailhol


