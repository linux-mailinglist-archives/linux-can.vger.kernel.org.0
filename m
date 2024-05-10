Return-Path: <linux-can+bounces-628-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855228C26FC
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70631C22A95
	for <lists+linux-can@lfdr.de>; Fri, 10 May 2024 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236D170893;
	Fri, 10 May 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdOtKAb5"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB2170842;
	Fri, 10 May 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351819; cv=none; b=l7fCUcGdV1ovGfuNXd8mJw+34M4gsdgOYuotfjgyYb5X4NvBGApybED5McoS/U1HqBkPnwevAJQ33DvMyAgapwf21lVlfUSK/JmVO2rlf5t1zafzy+TxCWVly61dYQYFi9nBoFQEt7m7x+7hoZConwol6ZnT3GHkF/m5y9RDcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351819; c=relaxed/simple;
	bh=v5SUYvQhGivk1xpYESPgvGUhWkl2K6c7X+yyha3GgBA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XXFatCaOaviuu3ckSjR6GQu2XuWuUJu5aMo818LS9L+Lt8eDSCnCj5nJWjdrVHPq5NVry92J0wYH+gYwCgu8gaSso9s4CnlyoTpv8MgcOTd+NZdDj71F3okFKtSLlYJ0CRw+C2IwP3lZmu4MOvsBfRSJcSyDDfWZU57qF9VgfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdOtKAb5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351818; x=1746887818;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v5SUYvQhGivk1xpYESPgvGUhWkl2K6c7X+yyha3GgBA=;
  b=jdOtKAb5FCH8F6JpuZvTJj40B+qz30cO7NOBlvnLmQ9jBMZ59/vrfL6r
   GeCdxglRLxjf4c9v5PUmeZRcz32LhDekbTe40E7ESebtVsAsKyisE7ZyL
   Yeh/IHOeLNp29ATzENw/tDHpQoPFzAh3C2ZoJwvpJEO25gyVI3K2BrRt/
   HBJrTOn14uNMUBGWqvQyWSTn3nyQWeg/2mx7w9m9s3RsZ5qVUvSnAjTfJ
   9PGvENenMcnTB5SBK+jeSnF0JedyYp1nM7nUm4M9pAPpIfYYo2JbnU9eX
   UMXeHxJLiDIp8Nf44ssSnW758UbYNDwKT1B+KPzn36k9UU8+KAQEhLkn1
   Q==;
X-CSE-ConnectionGUID: J7OBnIFlRdaKRVh0sUlAOA==
X-CSE-MsgGUID: GRMHc71JRAy1CSmXFFntkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11497143"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11497143"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:36:57 -0700
X-CSE-ConnectionGUID: PeCdhXC8SPqAcDo3IBZxGw==
X-CSE-MsgGUID: ffy7z0hjR26fDCsCFRv8aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30185232"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:36:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 17:36:43 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, Simon Horman <horms@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v4 09/11] can: lin: Handle rx offload config frames
In-Reply-To: <20240509171736.2048414-10-christoph.fritz@hexdev.de>
Message-ID: <48b00721-c341-4706-f2f5-af0fcff548aa@linux.intel.com>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de> <20240509171736.2048414-10-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 9 May 2024, Christoph Fritz wrote:

> The CAN Broadcast Manager now has the capability to dispatch CANFD
> frames marked with the id LINBUS_RXOFFLOAD_ID.
> 
> Introduce functionality to interpret these specific frames, enabling the
> configuration of RX offloading within the LIN driver.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/net/can/lin.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
> index a22768c17e3f8..f77abd7d7d21c 100644
> --- a/drivers/net/can/lin.c
> +++ b/drivers/net/can/lin.c
> @@ -185,6 +185,27 @@ static const struct attribute_group lin_sysfs_group = {
>  	.attrs = lin_sysfs_attrs,
>  };
>  
> +static int lin_setup_rxoffload(struct lin_device *ldev,
> +			       struct canfd_frame *cfd)
> +{
> +	struct lin_responder_answer answ;
> +
> +	if (!(cfd->flags & CANFD_FDF))
> +		return -EINVAL;
> +
> +	BUILD_BUG_ON(sizeof(answ) > sizeof(cfd->data));
> +	memcpy(&answ, cfd->data, sizeof(answ));
> +
> +	answ.lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
> +			LINBUS_ENHANCED : LINBUS_CLASSIC;
> +
> +	if (answ.lf.lin_id > LIN_ID_MASK ||
> +	    answ.event_associated_id > LIN_ID_MASK)
> +		return -EINVAL;

These can be reverse so that error check occur before the checksum_mode 
assignment? It would feel more natural that way.

...Even better, if the error check could be done before the memcpy().

-- 
 i.


> +	return ldev->ldev_ops->update_responder_answer(ldev, &answ);
> +}
> +
>  static void lin_tx_work_handler(struct work_struct *ws)
>  {
>  	struct lin_device *ldev = container_of(ws, struct lin_device,
> @@ -197,6 +218,14 @@ static void lin_tx_work_handler(struct work_struct *ws)
>  	ldev->tx_busy = true;
>  
>  	cfd = (struct canfd_frame *)ldev->tx_skb->data;
> +
> +	if (cfd->can_id & LIN_RXOFFLOAD_DATA_FLAG) {
> +		ret = lin_setup_rxoffload(ldev, cfd);
> +		if (ret < 0)
> +			netdev_err(ndev, "setting up rx failed %d\n", ret);
> +		goto lin_tx_out;
> +	}
> +
>  	lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
>  			   LINBUS_ENHANCED : LINBUS_CLASSIC;
>  	lf.lin_id = cfd->can_id & LIN_ID_MASK;
> 

