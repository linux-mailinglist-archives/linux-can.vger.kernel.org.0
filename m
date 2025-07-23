Return-Path: <linux-can+bounces-4064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6173EB0F25D
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124607B9440
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6C286A1;
	Wed, 23 Jul 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MYNjgey4"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683A2E3706
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273909; cv=none; b=drd/cJu5vo9HPTvJ6MAwU0siTBfX0QVCCi8wtmdGr4vRuuZjjS/khIIjC1j86wu1KuX6bTOzlU9Ik9+LryvJ/A6nPCt/CzvAoT3DxpW8dmBsV+NlfLDT9h6pNGWz630yjMeVJCrvmYApnnan/Oaa9HzRz4DGN2AjoJmx6UK9rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273909; c=relaxed/simple;
	bh=KM2eckHkNUmFLHp/f8jXvtdXUp/FoBiWh8F7ndlan/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtsPdb6+8GYFMBwbAD2X/Q3PX7LfqhgCDKwFakFDrQF057GOGVNFn1yzW3SIkh+N6SMwpUw0xI3K4T16BQ//mmS2pDBvHvhSnaVYqi7ehlR4r7+nFK2W+L6F7QZim/vl8DXMJnen7xxDhTz5LEW55iNRfG+mAr5J6eyeQt2cY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MYNjgey4; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id eYdAuBo6a01KBeYdBuZEJ9; Wed, 23 Jul 2025 14:31:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1753273895;
	bh=jtv9qEiozDqA3n3wMTywvjVGe375EIgZqO5RP6EHFW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MYNjgey48zf1cyMg+xaMxB/iFmfD9Ut/9Hs9F3BBQH3yZkoXmrjxXtWaPMSoFm+py
	 AtAOcY8cOGIB6wRIqIiDK/AyBDyiQZB5JHXV2oPGCFImmMrljcVurgFWQCEidPprbj
	 JUWl5BdRCOljJFiUw81HF/aoCra69euZPCI9Qsqv0CBoYewVt3HXerq9PRk+G3A7fI
	 zmneUe0WewWrT65cvJ8Fc4QKnsTV1aD+rfSVKaJQ/u5N8WEKh2bNU7R1Im26TD0AY0
	 9APHmTja2Ch80MyBs4hva38iUO96oik0B5EAOxzEaVT5MaBnlPmdrFZ+kzO0e0x+fU
	 VbCRTR42IEeoA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jul 2025 14:31:35 +0200
X-ME-IP: 124.33.176.97
Message-ID: <642e30bc-b79f-4d14-b20f-141000939555@wanadoo.fr>
Date: Wed, 23 Jul 2025 21:31:31 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] can: kvaser_pciefd: Add devlink support
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250723083236.9-1-extja@kvaser.com>
 <20250723083236.9-8-extja@kvaser.com>
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
In-Reply-To: <20250723083236.9-8-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 at 17:32, Jimmy Assarsson wrote:
> Add devlink support at device level.
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
> pci/0000:08:00.0:
>   driver kvaser_pciefd
> pci/0000:09:00.0:
>   driver kvaser_pciefd

Nitpick: can you add two space indentation before the quoted terminal output?
Like this:

Example output:

  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
  pci/0000:08:00.0:
    driver kvaser_pciefd
  pci/0000:09:00.0:
    driver kvaser_pciefd

> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>  drivers/net/can/Kconfig                           |  1 +
>  drivers/net/can/kvaser_pciefd/Makefile            |  2 +-
>  drivers/net/can/kvaser_pciefd/kvaser_pciefd.h     |  2 ++
>  .../net/can/kvaser_pciefd/kvaser_pciefd_core.c    | 15 ++++++++++++---
>  .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c | 10 ++++++++++
>  5 files changed, 26 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index cf989bea9aa3..b37d80bf7270 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -154,6 +154,7 @@ config CAN_JANZ_ICAN3
>  config CAN_KVASER_PCIEFD
>  	depends on PCI
>  	tristate "Kvaser PCIe FD cards"
> +	select NET_DEVLINK
>  	help
>  	  This is a driver for the Kvaser PCI Express CAN FD family.
>  
> diff --git a/drivers/net/can/kvaser_pciefd/Makefile b/drivers/net/can/kvaser_pciefd/Makefile
> index ea1bf1000760..8c5b8cdc6b5f 100644
> --- a/drivers/net/can/kvaser_pciefd/Makefile
> +++ b/drivers/net/can/kvaser_pciefd/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CAN_KVASER_PCIEFD) += kvaser_pciefd.o
> -kvaser_pciefd-y = kvaser_pciefd_core.o
> +kvaser_pciefd-y = kvaser_pciefd_core.o kvaser_pciefd_devlink.o
> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
> index 55bb7e078340..34ba393d6093 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
> @@ -13,6 +13,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
> +#include <net/devlink.h>
>  
>  #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
>  #define KVASER_PCIEFD_DMA_COUNT 2U
> @@ -87,4 +88,5 @@ struct kvaser_pciefd {
>  	struct kvaser_pciefd_fw_version fw_version;
>  };
>  
> +extern const struct devlink_ops kvaser_pciefd_devlink_ops;

Nitpick: I would rather like to see a kvaser_pciefd_devlink.h instead of this.

>  #endif /* _KVASER_PCIEFD_H */
> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> index 7bdcc84bce21..b553fc1fc3d7 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> @@ -1757,14 +1757,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  			       const struct pci_device_id *id)
>  {
>  	int ret;
> +	struct devlink *devlink;
>  	struct device *dev = &pdev->dev;
>  	struct kvaser_pciefd *pcie;
>  	const struct kvaser_pciefd_irq_mask *irq_mask;
>  
> -	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> -	if (!pcie)
> +	devlink = devlink_alloc(&kvaser_pciefd_devlink_ops, sizeof(*pcie), dev);
> +	if (!devlink)
>  		return -ENOMEM;
>  
> +	pcie = devlink_priv(devlink);
>  	pci_set_drvdata(pdev, pcie);
>  	pcie->pci = pdev;
>  	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
> @@ -1772,7 +1774,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  
>  	ret = pci_enable_device(pdev);
>  	if (ret)
> -		return ret;
> +		goto err_free_devlink;
>  
>  	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
>  	if (ret)
> @@ -1836,6 +1838,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_free_irq;
>  
> +	devlink_register(devlink);
> +
>  	return 0;
>  
>  err_free_irq:
> @@ -1859,6 +1863,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
>  err_disable_pci:
>  	pci_disable_device(pdev);
>  
> +err_free_devlink:
> +	devlink_free(devlink);
> +
>  	return ret;
>  }
>  
> @@ -1882,6 +1889,8 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
>  	for (i = 0; i < pcie->nr_channels; ++i)
>  		free_candev(pcie->can[i]->can.dev);
>  
> +	devlink_unregister(priv_to_devlink(pcie));
> +	devlink_free(priv_to_devlink(pcie));
>  	pci_iounmap(pdev, pcie->reg_base);
>  	pci_release_regions(pdev);
>  	pci_disable_device(pdev);
> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> new file mode 100644
> index 000000000000..8145d25943de
> --- /dev/null
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/* kvaser_pciefd devlink functions
> + *
> + * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
> + */
> +
> +#include <net/devlink.h>
> +
> +const struct devlink_ops kvaser_pciefd_devlink_ops = {
> +};

Yours sincerely,
Vincent Mailhol

