Return-Path: <linux-can+bounces-4065-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1BB0F25E
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E955F1AA7720
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05C243378;
	Wed, 23 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kHepfVIl"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-66.smtpout.orange.fr [193.252.22.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1B221555
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274113; cv=none; b=gOgccJ5/hFV2aLVUXr1bMN6ll+8+GJ6AAg6xy0zPWw/QQ86/5YHcTK2/dqRaqgdByOC41u/BQdO7Ip4fvpQqdGCjhUhQlaVUz32NK0hHfVOGPxRGV3dc9MBrogsYJQ45vexXQOgcsyEub5mccM+Ai5lrxghwDCFVRvwozTFE7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274113; c=relaxed/simple;
	bh=KIBGj5k+LZ+Ke2Uh+06yXzaEY04/CJ/HTbuo8h1sfB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnpMaE1WtJ1XM9nEc8SniL6laOFVergo0/0M0PjcI4BWjg1+6QVMqABRgjDowy8YTamDBrYpP78fb9NY+D0htfg0rap7lzivbEnfQ7H9GZjn41fKE2aFiiR+sO+0Xe2QEAazZDFqv5UaulPILZWKXTUKQoyB20iouoC9alGxc8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kHepfVIl; arc=none smtp.client-ip=193.252.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYfSuBGbS01DqeYfTu3q9s; Wed, 23 Jul 2025 14:33:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753274037;
	bh=pHWd85Em/Q/RgMD8EhN/CmjEl21qKUzvUx2FqKvrzjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kHepfVIlljbmkXKP9fDFzTDEsyHWDkNkvLmYtbxMhhFclBg2CX/qRf+/GIxD3q/tl
	 PNhcyyA/9a1x0ZBNm0YoTfNSqGHoIGfinB0hwGLDJnPm2epH2F3oaaA0BD3zhu2x8S
	 77Q5QIbveVDogz4LIlyfVLnIrT7re+EEJmfYjtdqYRQpv4pV82RTZbzq7eaIwazBqc
	 kDFlykzbyQu3bOUsadx/6B5/zUKj+kE+baO41m9O2xN6Zs0OSfc02IAKMN40Lsljtb
	 aTU7NtNOv8xBauOXMIEimztq0Tr8/8eU/4cWBO1DcZwpu16QXWsCk3fVS2+Iuw4wXX
	 83SaJe+eF5nIQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:33:57 +0200
X-ME-IP: 124.33.176.97
Message-ID: <f070e064-769e-458b-a196-61bf5feb76c6@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:33:53 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] can: kvaser_pciefd: Expose device firmware version
 via devlink info_get()
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-9-extja@kvaser.com>
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
In-Reply-To: <20250723083236.9-9-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Expose device firmware version via devlink info_get().
> 
> Example output:
> $ devlink dev
> pci/0000:07:00.0
> pci/0000:08:00.0
> pci/0000:09:00.0
> 
> $ devlink dev info
> pci/0000:07:00.0:
>   driver kvaser_pciefd
>   versions:
>       running:
>         fw 1.3.75
> pci/0000:08:00.0:
>   driver kvaser_pciefd
>   versions:
>       running:
>         fw 2.4.29
> pci/0000:09:00.0:
>   driver kvaser_pciefd
>   versions:
>       running:
>         fw 1.3.72
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  .../can/kvaser_pciefd/kvaser_pciefd_devlink.c | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> index 8145d25943de..b6d3745089d4 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> @@ -4,7 +4,33 @@
>   * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
>   */
>  
> +#include "kvaser_pciefd.h"
> +
>  #include <net/devlink.h>
>  
> +static int kvaser_pciefd_devlink_info_get(struct devlink *devlink,
> +					  struct devlink_info_req *req,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct kvaser_pciefd *pcie = devlink_priv(devlink);
> +	char buf[14]; /* xxx.xxx.xxxxx */

Nitpick:

  char buf[] = "xxx.xxx.xxxxx";

This way, you do not have to count the characters :)

> +	int ret;
> +
> +	if (pcie->fw_version.major) {
> +		snprintf(buf, sizeof(buf), "%u.%u.%u",
> +			 pcie->fw_version.major,
> +			 pcie->fw_version.minor,
> +			 pcie->fw_version.build);
> +		ret = devlink_info_version_running_put(req,
> +						       DEVLINK_INFO_VERSION_GENERIC_FW,
> +						       buf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  const struct devlink_ops kvaser_pciefd_devlink_ops = {
> +	.info_get = kvaser_pciefd_devlink_info_get,
>  };

Yours sincerely,
Vincent Mailhol


