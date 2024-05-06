Return-Path: <linux-can+bounces-588-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F88BD3B1
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28A51F22A9C
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C6815746B;
	Mon,  6 May 2024 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdPBQwlU"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC31156F38;
	Mon,  6 May 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015505; cv=none; b=Tgi09AAg0q01jvu51woce2rV9DvdYMBtEwNrWlGPayNGlJzfF0AMwanussWs5LWMJMIJttquD9elZ393OHgak9xFXdbpHbKPAsgXz1iR7mW66tYi9W/BY4ZdvPe8O2b6A6wTXgWKXax0Ef3oE78w+Ydi+zXk9zuYFW0Wg0yRcCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015505; c=relaxed/simple;
	bh=LGFYdoQCzAi5HsZnju8zdzQ4E+Uk80WyqMqgG7ChIFw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jEWSW+dvNp/qtFFDLYY8dFLUYtVHe9aaDnU+YSBgTxo50nF37K/Rszktpd1diH55dBCgzTRQ5ssir4gyW7Gq+aJcdRuLhtNk6qTskvr0DjGTP5wTpi6ETtHYIsm83w1CBmqCjm1R4HscuJIeFpmVjA0XlmvAlAwBiFIvHp/4U1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdPBQwlU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015503; x=1746551503;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LGFYdoQCzAi5HsZnju8zdzQ4E+Uk80WyqMqgG7ChIFw=;
  b=RdPBQwlUK5L48iqe7p/UIrNbq80RLAq/iJb8PD4UuJrWlXIwkSuCide2
   HubxPGdTozSbwnEnjLE0XH+d/DhCzSYJI8m40UsA2QLDU2iO/EJt3zKuq
   MIBi0JI8w12rIqGe3+yDamcBgkSQMkPH0HReOVh2++GyegUaaoYZkmH//
   DCsOFMi8u/kThr0fM7i9dRCvc1LiNnq8kmneNvFMOpJTbfol7zRPgY+IF
   YNZ6CyZCPp3JL03SK80ORNGfyvvXvb4gl0CBnfsR3D+g86HXPWWmjYZGy
   CwuFrv9/TzPqdRkGp4wgrz/35tnPgKnR5wTpl1K8doNqHL7MkT77AdCNg
   w==;
X-CSE-ConnectionGUID: ozx6vS5XQKS3gZl0M72bqQ==
X-CSE-MsgGUID: rCHn4wSYRdeU1GRf7KEsZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10649736"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10649736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:11:42 -0700
X-CSE-ConnectionGUID: tdGZxArMTJOh9yCIaQhkTA==
X-CSE-MsgGUID: ufIanFWhRTi4J6CQpim4EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="28814581"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.68])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:11:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 May 2024 20:11:30 +0300 (EEST)
To: Christoph Fritz <christoph.fritz@hexdev.de>
cc: Jiri Slaby <jirislaby@kernel.org>, 
    Oliver Hartkopp <socketcan@hartkopp.net>, 
    Marc Kleine-Budde <mkl@pengutronix.de>, 
    Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sebastian Reichel <sre@kernel.org>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
    Jonathan Corbet <corbet@lwn.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
    linux-can@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
    devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] can: lin: Handle rx offload config frames
In-Reply-To: <20240502182804.145926-10-christoph.fritz@hexdev.de>
Message-ID: <9cf35451-9d03-e487-c06b-580208ac3a3d@linux.intel.com>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de> <20240502182804.145926-10-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, Christoph Fritz wrote:

> The CAN Broadcast Manager now has the capability to dispatch CANFD
> frames marked with the id LINBUS_RXOFFLOAD_ID. This patch introduces
> functionality to interpret these specific frames, enabling the
> configuration of RX offloading within the LIN driver.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  drivers/net/can/lin.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/can/lin.c b/drivers/net/can/lin.c
> index 95906003666fb..ee2ebea2c865f 100644
> --- a/drivers/net/can/lin.c
> +++ b/drivers/net/can/lin.c
> @@ -194,6 +194,27 @@ static void lin_remove_sysfs_id_files(struct net_device *ndev)
>  	}
>  }
>  
> +static int lin_setup_rxoffload(struct lin_device *ldev,
> +			       struct canfd_frame *cfd)
> +{
> +	struct lin_responder_answer answ;
> +
> +	if (!(cfd->flags & CANFD_FDF))
> +		return -EMSGSIZE;

This seems a bit odd error code.

> +	BUILD_BUG_ON(sizeof(struct lin_responder_answer) > sizeof(cfd->data));
> +	memcpy(&answ, cfd->data, sizeof(struct lin_responder_answer));

2x sizeof(answ)

> +
> +	answ.lf.checksum_mode = (cfd->can_id & LIN_ENHANCED_CKSUM_FLAG) ?
> +			LINBUS_ENHANCED : LINBUS_CLASSIC;
> +
> +	if (answ.lf.lin_id > LIN_ID_MASK ||
> +	    answ.event_associated_id > LIN_ID_MASK)
> +		return -EINVAL;
> +
> +	return ldev->ldev_ops->update_responder_answer(ldev, &answ);
> +}
> +
>  static void lin_tx_work_handler(struct work_struct *ws)
>  {
>  	struct lin_device *ldev = container_of(ws, struct lin_device,
> @@ -206,6 +227,14 @@ static void lin_tx_work_handler(struct work_struct *ws)
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

-- 
 i.


